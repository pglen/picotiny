# Reconfigured for Linux detection (win support needs test)

PYTHON_NAME ?= python
MAKE		?= make

# Detect OS
ifeq ($(OS),Windows_NT)
    PLATFORM := windows
    RM = del /Q
    RISCV_NAME ?= riscv64-unknown-elf
    RISCV_PATH ?= D:/gnu-mcu-eclipse-riscv-none-gcc-8.2.0
    COMx	 	?= COM2
else
    PLATFORM := linux
    RM = rm -f
    RISCV_NAME  ?= riscv-none-embed
    RISCV_PATH 	?= /usr
    COMx	 	?= /dev/ttyUSB0
endif

FW_FILE 	 = fw/fw-flash/build/fw-flash.v

PROG_FILE	?= $(FW_FILE)

export PYTHON_NAME
export RISCV_NAME
export RISCV_PATH

.PHONY: brom flash clean program newfirm testcomp

help:
	@echo Targets: brom mkflash clean program newfirm putty testcomp
	@echo "        brom         -- creat boot rom"
	@echo "        newfirm      -- flash new firmware"
	@echo "        mkflash      -- make system flash / firmware "
	@echo "        program      -- program firmware"
	@echo "        putty        -- start putty with configured port"
	@echo "        testcomp     -- test RISC compile (. setenv.sh first)"
	@echo "        clean        -- clean temps and builds"

all: brom mkflash

newfirm:
	openFPGALoader -f project/impl/pnr/picotiny.fs

testcomp:
	@#$(RISCV_NAME)-gcc -nostdlib test.c
	$(RISCV_NAME)-gcc  test.c

$(FW_FILE): mkflash

brom:
	$(MAKE) -C fw/fw-brom

mkflash:
	$(MAKE) -C fw/fw-flash

clean:
	@$(MAKE) -C fw/fw-brom clean
	@$(MAKE) -C fw/fw-flash clean
	@$(RM) aa a.out

program: $(PROG_FILE)
	$(PYTHON_NAME) sw/pico-programmer.py $(PROG_FILE) $(COMx)

putty:
	putty -load tang_serial

git:
	git add .
	git commit -m "AutoCheck"

# EOF
