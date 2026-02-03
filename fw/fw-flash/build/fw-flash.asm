
build/fw-flash.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <crtStart>:
.global crtStart
.global main
.global irqCallback

crtStart:
  j crtInit
       0:	0a00006f          	j	a0 <crtInit>
  nop
       4:	00000013          	nop
  nop
       8:	00000013          	nop
  nop
       c:	00000013          	nop

00000010 <trap_entry>:
// x0 is constant
// x2 is sp (always changing)
// x3-4 are gp, tp (fixed through program)
// x8-9, x18-27 are callee-saved registers
trap_entry:
  sw x1,  - 1*4(sp)
      10:	fe112e23          	sw	ra,-4(sp)
  sw x5,  - 2*4(sp)
      14:	fe512c23          	sw	t0,-8(sp)
  sw x6,  - 3*4(sp)
      18:	fe612a23          	sw	t1,-12(sp)
  sw x7,  - 4*4(sp)
      1c:	fe712823          	sw	t2,-16(sp)
  sw x10, - 5*4(sp)
      20:	fea12623          	sw	a0,-20(sp)
  sw x11, - 6*4(sp)
      24:	feb12423          	sw	a1,-24(sp)
  sw x12, - 7*4(sp)
      28:	fec12223          	sw	a2,-28(sp)
  sw x13, - 8*4(sp)
      2c:	fed12023          	sw	a3,-32(sp)
  sw x14, - 9*4(sp)
      30:	fce12e23          	sw	a4,-36(sp)
  sw x15, -10*4(sp)
      34:	fcf12c23          	sw	a5,-40(sp)
  sw x16, -11*4(sp)
      38:	fd012a23          	sw	a6,-44(sp)
  sw x17, -12*4(sp)
      3c:	fd112823          	sw	a7,-48(sp)
  sw x28, -13*4(sp)
      40:	fdc12623          	sw	t3,-52(sp)
  sw x29, -14*4(sp)
      44:	fdd12423          	sw	t4,-56(sp)
  sw x30, -15*4(sp)
      48:	fde12223          	sw	t5,-60(sp)
  sw x31, -16*4(sp)
      4c:	fdf12023          	sw	t6,-64(sp)
  addi sp,sp,-16*4
      50:	fc010113          	addi	sp,sp,-64
  call irqCallback
      54:	0c1020ef          	jal	ra,2914 <irqCallback>
  lw x1 , 15*4(sp)
      58:	03c12083          	lw	ra,60(sp)
  lw x5,  14*4(sp)
      5c:	03812283          	lw	t0,56(sp)
  lw x6,  13*4(sp)
      60:	03412303          	lw	t1,52(sp)
  lw x7,  12*4(sp)
      64:	03012383          	lw	t2,48(sp)
  lw x10, 11*4(sp)
      68:	02c12503          	lw	a0,44(sp)
  lw x11, 10*4(sp)
      6c:	02812583          	lw	a1,40(sp)
  lw x12,  9*4(sp)
      70:	02412603          	lw	a2,36(sp)
  lw x13,  8*4(sp)
      74:	02012683          	lw	a3,32(sp)
  lw x14,  7*4(sp)
      78:	01c12703          	lw	a4,28(sp)
  lw x15,  6*4(sp)
      7c:	01812783          	lw	a5,24(sp)
  lw x16,  5*4(sp)
      80:	01412803          	lw	a6,20(sp)
  lw x17,  4*4(sp)
      84:	01012883          	lw	a7,16(sp)
  lw x28,  3*4(sp)
      88:	00c12e03          	lw	t3,12(sp)
  lw x29,  2*4(sp)
      8c:	00812e83          	lw	t4,8(sp)
  lw x30,  1*4(sp)
      90:	00412f03          	lw	t5,4(sp)
  lw x31,  0*4(sp)
      94:	00012f83          	lw	t6,0(sp)
  addi sp,sp,16*4
      98:	04010113          	addi	sp,sp,64
  mret
      9c:	30200073          	mret

000000a0 <crtInit>:
  .text

crtInit:
  .option push
  .option norelax
  la gp, __global_pointer$
      a0:	40000197          	auipc	gp,0x40000
      a4:	76018193          	addi	gp,gp,1888 # 40000800 <__global_pointer$>
  .option pop
  la sp, _stack_start
      a8:	c1018113          	addi	sp,gp,-1008 # 40000410 <_stack_start>

# copy data section
  la a0, _sidata
      ac:	00003517          	auipc	a0,0x3
      b0:	c0450513          	addi	a0,a0,-1020 # 2cb0 <_etext>
  la a1, _sdata
      b4:	40000597          	auipc	a1,0x40000
      b8:	f4c58593          	addi	a1,a1,-180 # 40000000 <spi_flashio>
  la a2, _edata
      bc:	80418613          	addi	a2,gp,-2044 # 40000004 <i>
  bge a1, a2, end_init_data
      c0:	00c5dc63          	bge	a1,a2,d8 <bss_init>

000000c4 <loop_init_data>:
loop_init_data:
  lw a3, 0(a0)
      c4:	00052683          	lw	a3,0(a0)
  sw a3, 0(a1)
      c8:	00d5a023          	sw	a3,0(a1)
  addi a0, a0, 4
      cc:	00450513          	addi	a0,a0,4
  addi a1, a1, 4
      d0:	00458593          	addi	a1,a1,4
  blt a1, a2, loop_init_data
      d4:	fec5c8e3          	blt	a1,a2,c4 <loop_init_data>

000000d8 <bss_init>:
end_init_data:

bss_init:
  la a0, _bss_start
      d8:	40000517          	auipc	a0,0x40000
      dc:	f2c50513          	addi	a0,a0,-212 # 40000004 <i>
  la a1, _bss_end
      e0:	40000597          	auipc	a1,0x40000
      e4:	f2858593          	addi	a1,a1,-216 # 40000008 <_bss_end>

000000e8 <bss_loop>:
bss_loop:
  beq a0,a1,bss_done
      e8:	00b50863          	beq	a0,a1,f8 <bss_done>
  sw zero,0(a0)
      ec:	00052023          	sw	zero,0(a0)
  add a0,a0,4
      f0:	00450513          	addi	a0,a0,4
  j bss_loop
      f4:	ff5ff06f          	j	e8 <bss_loop>

000000f8 <bss_done>:
bss_done:

ctors_init:
  la a0, _ctors_start
      f8:	00003517          	auipc	a0,0x3
      fc:	bb850513          	addi	a0,a0,-1096 # 2cb0 <_etext>
  addi sp,sp,-4
     100:	ffc10113          	addi	sp,sp,-4

00000104 <ctors_loop>:
ctors_loop:
  la a1, _ctors_end
     104:	00003597          	auipc	a1,0x3
     108:	bac58593          	addi	a1,a1,-1108 # 2cb0 <_etext>
  beq a0,a1,ctors_done
     10c:	00b50e63          	beq	a0,a1,128 <ctors_done>
  lw a3,0(a0)
     110:	00052683          	lw	a3,0(a0)
  add a0,a0,4
     114:	00450513          	addi	a0,a0,4
  sw a0,0(sp)
     118:	00a12023          	sw	a0,0(sp)
  jalr  a3
     11c:	000680e7          	jalr	a3
  lw a0,0(sp)
     120:	00012503          	lw	a0,0(sp)
  j ctors_loop
     124:	fe1ff06f          	j	104 <ctors_loop>

00000128 <ctors_done>:
ctors_done:
  addi sp,sp,4
     128:	00410113          	addi	sp,sp,4

  call main
     12c:	470010ef          	jal	ra,159c <main>

00000130 <infinitLoop>:
infinitLoop:
  j infinitLoop
     130:	0000006f          	j	130 <infinitLoop>

00000134 <cmd_read_flash_id>:
int cmd_get_dspi() {
    return QSPI0->REG & QSPI_REG_DSPI;
}

void cmd_read_flash_id()
{
     134:	fe010113          	addi	sp,sp,-32
    return QSPI0->REG & QSPI_REG_DSPI;
     138:	810007b7          	lui	a5,0x81000
{
     13c:	00812c23          	sw	s0,24(sp)
    return QSPI0->REG & QSPI_REG_DSPI;
     140:	0007a403          	lw	s0,0(a5) # 81000000 <__global_pointer$+0x40fff800>
        QSPI0->REG &= ~QSPI_REG_DSPI;
     144:	0007a703          	lw	a4,0(a5)
     148:	ffc006b7          	lui	a3,0xffc00
     14c:	fff68693          	addi	a3,a3,-1 # ffbfffff <__global_pointer$+0xbfbff7ff>
     150:	00d77733          	and	a4,a4,a3
{
     154:	00112e23          	sw	ra,28(sp)
        QSPI0->REG &= ~QSPI_REG_DSPI;
     158:	00e7a023          	sw	a4,0(a5)
    int pre_dspi = cmd_get_dspi();

    cmd_set_dspi(0);

    uint8_t buffer[4] = { 0x9F, /* zeros */ };
    spi_flashio(buffer, 4, 0);
     15c:	400007b7          	lui	a5,0x40000
     160:	0007a783          	lw	a5,0(a5) # 40000000 <spi_flashio>
    uint8_t buffer[4] = { 0x9F, /* zeros */ };
     164:	09f00713          	li	a4,159
     168:	00e12623          	sw	a4,12(sp)
    spi_flashio(buffer, 4, 0);
     16c:	00000613          	li	a2,0
    return QSPI0->REG & QSPI_REG_DSPI;
     170:	00400737          	lui	a4,0x400
    spi_flashio(buffer, 4, 0);
     174:	00400593          	li	a1,4
     178:	00c10513          	addi	a0,sp,12
    return QSPI0->REG & QSPI_REG_DSPI;
     17c:	00e47433          	and	s0,s0,a4
    spi_flashio(buffer, 4, 0);
     180:	000780e7          	jalr	a5
    UART0->DATA = c;
     184:	02000793          	li	a5,32
     188:	83000637          	lui	a2,0x83000
     18c:	00f62023          	sw	a5,0(a2) # 83000000 <__global_pointer$+0x42fff800>

    for (int i = 1; i <= 3; i++) {
        putchar(' ');
        print_hex(buffer[i], 2);
     190:	00d14703          	lbu	a4,13(sp)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     194:	000037b7          	lui	a5,0x3
     198:	91878793          	addi	a5,a5,-1768 # 2918 <irqCallback+0x4>
     19c:	00475693          	srli	a3,a4,0x4
     1a0:	00d786b3          	add	a3,a5,a3
     1a4:	0006c683          	lbu	a3,0(a3)
    if (c == '\n')
     1a8:	00a00593          	li	a1,10
     1ac:	10b68863          	beq	a3,a1,2bc <cmd_read_flash_id+0x188>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     1b0:	00f77713          	andi	a4,a4,15
     1b4:	00e78733          	add	a4,a5,a4
     1b8:	00074703          	lbu	a4,0(a4) # 400000 <_etext+0x3fd350>
    UART0->DATA = c;
     1bc:	83000637          	lui	a2,0x83000
     1c0:	00d62023          	sw	a3,0(a2) # 83000000 <__global_pointer$+0x42fff800>
    if (c == '\n')
     1c4:	00a00693          	li	a3,10
     1c8:	10d70c63          	beq	a4,a3,2e0 <cmd_read_flash_id+0x1ac>
    UART0->DATA = c;
     1cc:	83000637          	lui	a2,0x83000
     1d0:	00e62023          	sw	a4,0(a2) # 83000000 <__global_pointer$+0x42fff800>
     1d4:	02000713          	li	a4,32
     1d8:	00e62023          	sw	a4,0(a2)
        print_hex(buffer[i], 2);
     1dc:	00e14703          	lbu	a4,14(sp)
    if (c == '\n')
     1e0:	00a00593          	li	a1,10
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     1e4:	00475693          	srli	a3,a4,0x4
     1e8:	00d786b3          	add	a3,a5,a3
     1ec:	0006c683          	lbu	a3,0(a3)
    if (c == '\n')
     1f0:	12b68063          	beq	a3,a1,310 <cmd_read_flash_id+0x1dc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     1f4:	00f77713          	andi	a4,a4,15
     1f8:	00e78733          	add	a4,a5,a4
     1fc:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
     200:	83000637          	lui	a2,0x83000
     204:	00d62023          	sw	a3,0(a2) # 83000000 <__global_pointer$+0x42fff800>
    if (c == '\n')
     208:	00a00693          	li	a3,10
     20c:	0ed70c63          	beq	a4,a3,304 <cmd_read_flash_id+0x1d0>
    UART0->DATA = c;
     210:	83000637          	lui	a2,0x83000
     214:	00e62023          	sw	a4,0(a2) # 83000000 <__global_pointer$+0x42fff800>
     218:	02000713          	li	a4,32
     21c:	00e62023          	sw	a4,0(a2)
        print_hex(buffer[i], 2);
     220:	00f14703          	lbu	a4,15(sp)
    if (c == '\n')
     224:	00a00593          	li	a1,10
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     228:	00475693          	srli	a3,a4,0x4
     22c:	00d786b3          	add	a3,a5,a3
     230:	0006c683          	lbu	a3,0(a3)
    if (c == '\n')
     234:	0cb68263          	beq	a3,a1,2f8 <cmd_read_flash_id+0x1c4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     238:	00f77713          	andi	a4,a4,15
     23c:	00e787b3          	add	a5,a5,a4
     240:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
     244:	830007b7          	lui	a5,0x83000
     248:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
    if (c == '\n')
     24c:	00a00693          	li	a3,10
     250:	08d70e63          	beq	a4,a3,2ec <cmd_read_flash_id+0x1b8>
    UART0->DATA = c;
     254:	830007b7          	lui	a5,0x83000
     258:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
     25c:	00d00713          	li	a4,13
     260:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
     264:	00a00713          	li	a4,10
     268:	00e7a023          	sw	a4,0(a5)
    if (on) {
     26c:	02040463          	beqz	s0,294 <cmd_read_flash_id+0x160>
        QSPI0->REG |= QSPI_REG_DSPI;
     270:	81000737          	lui	a4,0x81000
     274:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff800>
    }
    putchar('\n');

    cmd_set_dspi(pre_dspi);
}
     278:	01c12083          	lw	ra,28(sp)
     27c:	01812403          	lw	s0,24(sp)
        QSPI0->REG |= QSPI_REG_DSPI;
     280:	004006b7          	lui	a3,0x400
     284:	00d7e7b3          	or	a5,a5,a3
     288:	00f72023          	sw	a5,0(a4)
}
     28c:	02010113          	addi	sp,sp,32
     290:	00008067          	ret
        QSPI0->REG &= ~QSPI_REG_DSPI;
     294:	810006b7          	lui	a3,0x81000
     298:	0006a783          	lw	a5,0(a3) # 81000000 <__global_pointer$+0x40fff800>
     29c:	ffc00737          	lui	a4,0xffc00
}
     2a0:	01c12083          	lw	ra,28(sp)
     2a4:	01812403          	lw	s0,24(sp)
        QSPI0->REG &= ~QSPI_REG_DSPI;
     2a8:	fff70713          	addi	a4,a4,-1 # ffbfffff <__global_pointer$+0xbfbff7ff>
     2ac:	00e7f7b3          	and	a5,a5,a4
     2b0:	00f6a023          	sw	a5,0(a3)
}
     2b4:	02010113          	addi	sp,sp,32
     2b8:	00008067          	ret
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     2bc:	00f77713          	andi	a4,a4,15
     2c0:	00e78733          	add	a4,a5,a4
        UART0->DATA = '\r';
     2c4:	00d00593          	li	a1,13
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     2c8:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
     2cc:	00b62023          	sw	a1,0(a2)
    UART0->DATA = c;
     2d0:	83000637          	lui	a2,0x83000
     2d4:	00d62023          	sw	a3,0(a2) # 83000000 <__global_pointer$+0x42fff800>
    if (c == '\n')
     2d8:	00a00693          	li	a3,10
     2dc:	eed718e3          	bne	a4,a3,1cc <cmd_read_flash_id+0x98>
        UART0->DATA = '\r';
     2e0:	00d00693          	li	a3,13
     2e4:	00d62023          	sw	a3,0(a2)
     2e8:	ee5ff06f          	j	1cc <cmd_read_flash_id+0x98>
     2ec:	00d00693          	li	a3,13
     2f0:	00d7a023          	sw	a3,0(a5)
     2f4:	f61ff06f          	j	254 <cmd_read_flash_id+0x120>
     2f8:	00d00593          	li	a1,13
     2fc:	00b62023          	sw	a1,0(a2)
     300:	f39ff06f          	j	238 <cmd_read_flash_id+0x104>
     304:	00d00693          	li	a3,13
     308:	00d62023          	sw	a3,0(a2)
     30c:	f05ff06f          	j	210 <cmd_read_flash_id+0xdc>
     310:	00d00593          	li	a1,13
     314:	00b62023          	sw	a1,0(a2)
     318:	eddff06f          	j	1f4 <cmd_read_flash_id+0xc0>

0000031c <cmd_benchmark>:

// --------------------------------------------------------

uint32_t cmd_benchmark(bool verbose, uint32_t *instns_p)
{
     31c:	f0010113          	addi	sp,sp,-256
     320:	00050f93          	mv	t6,a0
     324:	00058e93          	mv	t4,a1

    uint32_t x32 = 314159265;

    uint32_t cycles_begin, cycles_end;
    uint32_t instns_begin, instns_end;
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
     328:	c00022f3          	rdcycle	t0
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
     32c:	c0202f73          	rdinstret	t5
    uint32_t x32 = 314159265;
     330:	12b9b7b7          	lui	a5,0x12b9b
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
     334:	01400e13          	li	t3,20
    uint32_t x32 = 314159265;
     338:	0a178793          	addi	a5,a5,161 # 12b9b0a1 <_etext+0x12b983f1>
     33c:	10010813          	addi	a6,sp,256
            x32 ^= x32 >> 17;
            x32 ^= x32 << 5;
            data[k] = x32;
        }

        for (int k = 0, p = 0; k < 256; k++)
     340:	10000313          	li	t1,256
        for (int k = 0; k < 256; k++)
     344:	00010613          	mv	a2,sp
{
     348:	00010693          	mv	a3,sp
            x32 ^= x32 << 13;
     34c:	00d79713          	slli	a4,a5,0xd
     350:	00f74733          	xor	a4,a4,a5
            x32 ^= x32 >> 17;
     354:	01175793          	srli	a5,a4,0x11
     358:	00e7c7b3          	xor	a5,a5,a4
            x32 ^= x32 << 5;
     35c:	00579713          	slli	a4,a5,0x5
     360:	00f747b3          	xor	a5,a4,a5
            data[k] = x32;
     364:	00f68023          	sb	a5,0(a3)
        for (int k = 0; k < 256; k++)
     368:	00168693          	addi	a3,a3,1
     36c:	fed810e3          	bne	a6,a3,34c <cmd_benchmark+0x30>
     370:	00010693          	mv	a3,sp
        for (int k = 0, p = 0; k < 256; k++)
     374:	00000593          	li	a1,0
     378:	00000713          	li	a4,0
        {
            if (data[k])
     37c:	0006c503          	lbu	a0,0(a3)
                data[p++] = k;
     380:	10010893          	addi	a7,sp,256
     384:	00b888b3          	add	a7,a7,a1
        for (int k = 0, p = 0; k < 256; k++)
     388:	00168693          	addi	a3,a3,1
            if (data[k])
     38c:	00050663          	beqz	a0,398 <cmd_benchmark+0x7c>
                data[p++] = k;
     390:	f0e88023          	sb	a4,-256(a7)
     394:	00158593          	addi	a1,a1,1
        for (int k = 0, p = 0; k < 256; k++)
     398:	00170713          	addi	a4,a4,1
     39c:	fe6710e3          	bne	a4,t1,37c <cmd_benchmark+0x60>
        }

        for (int k = 0, p = 0; k < 64; k++)
        {
            x32 = x32 ^ words[k];
     3a0:	00062703          	lw	a4,0(a2)
        for (int k = 0, p = 0; k < 64; k++)
     3a4:	00460613          	addi	a2,a2,4
            x32 = x32 ^ words[k];
     3a8:	00e7c7b3          	xor	a5,a5,a4
        for (int k = 0, p = 0; k < 64; k++)
     3ac:	ff061ae3          	bne	a2,a6,3a0 <cmd_benchmark+0x84>
    for (int i = 0; i < 20; i++)
     3b0:	fffe0e13          	addi	t3,t3,-1
     3b4:	f80e18e3          	bnez	t3,344 <cmd_benchmark+0x28>
        }
    }

    __asm__ volatile ("rdcycle %0" : "=r"(cycles_end));
     3b8:	c0002873          	rdcycle	a6
    __asm__ volatile ("rdinstret %0" : "=r"(instns_end));
     3bc:	c02025f3          	rdinstret	a1
    }

    if (instns_p)
        *instns_p = instns_end - instns_begin;

    return cycles_end - cycles_begin;
     3c0:	40580533          	sub	a0,a6,t0
    if (verbose)
     3c4:	460f8e63          	beqz	t6,840 <_stack_size+0x440>
    UART0->DATA = c;
     3c8:	83000737          	lui	a4,0x83000
     3cc:	04300693          	li	a3,67
     3d0:	00d72023          	sw	a3,0(a4) # 83000000 <__global_pointer$+0x42fff800>
        putchar(*(p++));
     3d4:	000036b7          	lui	a3,0x3
     3d8:	92d68693          	addi	a3,a3,-1747 # 292d <irqCallback+0x19>
    while (*p)
     3dc:	07900713          	li	a4,121
    if (c == '\n')
     3e0:	00a00893          	li	a7,10
    UART0->DATA = c;
     3e4:	83000637          	lui	a2,0x83000
        UART0->DATA = '\r';
     3e8:	00d00513          	li	a0,13
        putchar(*(p++));
     3ec:	00168693          	addi	a3,a3,1
    if (c == '\n')
     3f0:	4b170263          	beq	a4,a7,894 <_stack_size+0x494>
    UART0->DATA = c;
     3f4:	00e62023          	sw	a4,0(a2) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     3f8:	0006c703          	lbu	a4,0(a3)
     3fc:	fe0718e3          	bnez	a4,3ec <cmd_benchmark+0xd0>
        print_hex(cycles_end - cycles_begin, 8);
     400:	40580533          	sub	a0,a6,t0
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     404:	00003737          	lui	a4,0x3
     408:	91870713          	addi	a4,a4,-1768 # 2918 <irqCallback+0x4>
     40c:	01c55693          	srli	a3,a0,0x1c
     410:	00d706b3          	add	a3,a4,a3
     414:	0006c803          	lbu	a6,0(a3)
    if (c == '\n')
     418:	00a00693          	li	a3,10
     41c:	74d80463          	beq	a6,a3,b64 <_stack_size+0x764>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     420:	01855693          	srli	a3,a0,0x18
     424:	00f6f693          	andi	a3,a3,15
     428:	00d706b3          	add	a3,a4,a3
     42c:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     430:	830006b7          	lui	a3,0x83000
     434:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     438:	03000813          	li	a6,48
     43c:	01060663          	beq	a2,a6,448 <_stack_size+0x48>
    if (c == '\n')
     440:	00a00813          	li	a6,10
     444:	51060063          	beq	a2,a6,944 <_stack_size+0x544>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     448:	01455693          	srli	a3,a0,0x14
     44c:	00f6f693          	andi	a3,a3,15
     450:	00d706b3          	add	a3,a4,a3
     454:	0006c803          	lbu	a6,0(a3)
    UART0->DATA = c;
     458:	830006b7          	lui	a3,0x83000
     45c:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     460:	03000613          	li	a2,48
     464:	00c80663          	beq	a6,a2,470 <_stack_size+0x70>
    if (c == '\n')
     468:	00a00613          	li	a2,10
     46c:	50c80263          	beq	a6,a2,970 <_stack_size+0x570>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     470:	01055693          	srli	a3,a0,0x10
     474:	00f6f693          	andi	a3,a3,15
     478:	00d706b3          	add	a3,a4,a3
     47c:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     480:	830006b7          	lui	a3,0x83000
     484:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     488:	03000813          	li	a6,48
     48c:	01060663          	beq	a2,a6,498 <_stack_size+0x98>
    if (c == '\n')
     490:	00a00813          	li	a6,10
     494:	51060463          	beq	a2,a6,99c <_stack_size+0x59c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     498:	00c55693          	srli	a3,a0,0xc
     49c:	00f6f693          	andi	a3,a3,15
     4a0:	00d706b3          	add	a3,a4,a3
     4a4:	0006c803          	lbu	a6,0(a3)
    UART0->DATA = c;
     4a8:	830006b7          	lui	a3,0x83000
     4ac:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     4b0:	03000613          	li	a2,48
     4b4:	00c80663          	beq	a6,a2,4c0 <_stack_size+0xc0>
    if (c == '\n')
     4b8:	00a00613          	li	a2,10
     4bc:	50c80663          	beq	a6,a2,9c8 <_stack_size+0x5c8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     4c0:	00855693          	srli	a3,a0,0x8
     4c4:	00f6f693          	andi	a3,a3,15
     4c8:	00d706b3          	add	a3,a4,a3
     4cc:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     4d0:	830006b7          	lui	a3,0x83000
     4d4:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     4d8:	03000813          	li	a6,48
     4dc:	01060663          	beq	a2,a6,4e8 <_stack_size+0xe8>
    if (c == '\n')
     4e0:	00a00813          	li	a6,10
     4e4:	51060863          	beq	a2,a6,9f4 <_stack_size+0x5f4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     4e8:	00455693          	srli	a3,a0,0x4
     4ec:	00f6f693          	andi	a3,a3,15
     4f0:	00d706b3          	add	a3,a4,a3
     4f4:	0006c683          	lbu	a3,0(a3)
    UART0->DATA = c;
     4f8:	83000837          	lui	a6,0x83000
     4fc:	00c82023          	sw	a2,0(a6) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     500:	03000613          	li	a2,48
     504:	00c68663          	beq	a3,a2,510 <_stack_size+0x110>
    if (c == '\n')
     508:	00a00613          	li	a2,10
     50c:	50c68a63          	beq	a3,a2,a20 <_stack_size+0x620>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     510:	00f57613          	andi	a2,a0,15
     514:	00c70633          	add	a2,a4,a2
     518:	00064603          	lbu	a2,0(a2)
    UART0->DATA = c;
     51c:	83000837          	lui	a6,0x83000
     520:	00d82023          	sw	a3,0(a6) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     524:	03000693          	li	a3,48
     528:	00d60663          	beq	a2,a3,534 <_stack_size+0x134>
    if (c == '\n')
     52c:	00a00693          	li	a3,10
     530:	50d60c63          	beq	a2,a3,a48 <_stack_size+0x648>
    UART0->DATA = c;
     534:	830006b7          	lui	a3,0x83000
     538:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
     53c:	00d00613          	li	a2,13
     540:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
     544:	00a00613          	li	a2,10
     548:	00c6a023          	sw	a2,0(a3)
     54c:	04900613          	li	a2,73
     550:	00c6a023          	sw	a2,0(a3)
        putchar(*(p++));
     554:	00003637          	lui	a2,0x3
     558:	93960613          	addi	a2,a2,-1735 # 2939 <irqCallback+0x25>
    while (*p)
     55c:	06e00693          	li	a3,110
    if (c == '\n')
     560:	00a00313          	li	t1,10
    UART0->DATA = c;
     564:	83000837          	lui	a6,0x83000
        UART0->DATA = '\r';
     568:	00d00893          	li	a7,13
        putchar(*(p++));
     56c:	00160613          	addi	a2,a2,1
    if (c == '\n')
     570:	2e668263          	beq	a3,t1,854 <_stack_size+0x454>
    UART0->DATA = c;
     574:	00d82023          	sw	a3,0(a6) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     578:	00064683          	lbu	a3,0(a2)
     57c:	fe0698e3          	bnez	a3,56c <_stack_size+0x16c>
        print_hex(instns_end - instns_begin, 8);
     580:	41e586b3          	sub	a3,a1,t5
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     584:	01c6d613          	srli	a2,a3,0x1c
     588:	00c70633          	add	a2,a4,a2
     58c:	00064803          	lbu	a6,0(a2)
    if (c == '\n')
     590:	00a00613          	li	a2,10
     594:	60c80063          	beq	a6,a2,b94 <_stack_size+0x794>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     598:	0186d613          	srli	a2,a3,0x18
     59c:	00f67613          	andi	a2,a2,15
     5a0:	00c70633          	add	a2,a4,a2
     5a4:	00064883          	lbu	a7,0(a2)
    UART0->DATA = c;
     5a8:	83000637          	lui	a2,0x83000
     5ac:	01062023          	sw	a6,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     5b0:	03000813          	li	a6,48
     5b4:	01088663          	beq	a7,a6,5c0 <_stack_size+0x1c0>
    if (c == '\n')
     5b8:	00a00813          	li	a6,10
     5bc:	49088c63          	beq	a7,a6,a54 <_stack_size+0x654>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     5c0:	0146d613          	srli	a2,a3,0x14
     5c4:	00f67613          	andi	a2,a2,15
     5c8:	00c70633          	add	a2,a4,a2
     5cc:	00064803          	lbu	a6,0(a2)
    UART0->DATA = c;
     5d0:	83000637          	lui	a2,0x83000
     5d4:	01162023          	sw	a7,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     5d8:	03000893          	li	a7,48
     5dc:	01180663          	beq	a6,a7,5e8 <_stack_size+0x1e8>
    if (c == '\n')
     5e0:	00a00893          	li	a7,10
     5e4:	49180e63          	beq	a6,a7,a80 <_stack_size+0x680>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     5e8:	0106d613          	srli	a2,a3,0x10
     5ec:	00f67613          	andi	a2,a2,15
     5f0:	00c70633          	add	a2,a4,a2
     5f4:	00064883          	lbu	a7,0(a2)
    UART0->DATA = c;
     5f8:	83000637          	lui	a2,0x83000
     5fc:	01062023          	sw	a6,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     600:	03000813          	li	a6,48
     604:	01088663          	beq	a7,a6,610 <_stack_size+0x210>
    if (c == '\n')
     608:	00a00813          	li	a6,10
     60c:	4b088063          	beq	a7,a6,aac <_stack_size+0x6ac>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     610:	00c6d613          	srli	a2,a3,0xc
     614:	00f67613          	andi	a2,a2,15
     618:	00c70633          	add	a2,a4,a2
     61c:	00064803          	lbu	a6,0(a2)
    UART0->DATA = c;
     620:	83000637          	lui	a2,0x83000
     624:	01162023          	sw	a7,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     628:	03000893          	li	a7,48
     62c:	01180663          	beq	a6,a7,638 <_stack_size+0x238>
    if (c == '\n')
     630:	00a00893          	li	a7,10
     634:	4b180263          	beq	a6,a7,ad8 <_stack_size+0x6d8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     638:	0086d613          	srli	a2,a3,0x8
     63c:	00f67613          	andi	a2,a2,15
     640:	00c70633          	add	a2,a4,a2
     644:	00064883          	lbu	a7,0(a2)
    UART0->DATA = c;
     648:	83000637          	lui	a2,0x83000
     64c:	01062023          	sw	a6,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     650:	03000813          	li	a6,48
     654:	01088663          	beq	a7,a6,660 <_stack_size+0x260>
    if (c == '\n')
     658:	00a00813          	li	a6,10
     65c:	4b088463          	beq	a7,a6,b04 <_stack_size+0x704>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     660:	0046d613          	srli	a2,a3,0x4
     664:	00f67613          	andi	a2,a2,15
     668:	00c70633          	add	a2,a4,a2
     66c:	00064803          	lbu	a6,0(a2)
    UART0->DATA = c;
     670:	83000637          	lui	a2,0x83000
     674:	01162023          	sw	a7,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     678:	03000893          	li	a7,48
     67c:	01180663          	beq	a6,a7,688 <_stack_size+0x288>
    if (c == '\n')
     680:	00a00893          	li	a7,10
     684:	4b180663          	beq	a6,a7,b30 <_stack_size+0x730>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     688:	00f6f693          	andi	a3,a3,15
     68c:	00d706b3          	add	a3,a4,a3
     690:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     694:	830006b7          	lui	a3,0x83000
     698:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     69c:	03000813          	li	a6,48
     6a0:	01060663          	beq	a2,a6,6ac <_stack_size+0x2ac>
    if (c == '\n')
     6a4:	00a00813          	li	a6,10
     6a8:	4b060863          	beq	a2,a6,b58 <_stack_size+0x758>
    UART0->DATA = c;
     6ac:	830006b7          	lui	a3,0x83000
     6b0:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
     6b4:	00d00613          	li	a2,13
     6b8:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
     6bc:	00a00613          	li	a2,10
     6c0:	00c6a023          	sw	a2,0(a3)
     6c4:	04300613          	li	a2,67
     6c8:	00c6a023          	sw	a2,0(a3)
        putchar(*(p++));
     6cc:	00003637          	lui	a2,0x3
     6d0:	94560613          	addi	a2,a2,-1723 # 2945 <irqCallback+0x31>
    while (*p)
     6d4:	06800693          	li	a3,104
    if (c == '\n')
     6d8:	00a00313          	li	t1,10
    UART0->DATA = c;
     6dc:	83000837          	lui	a6,0x83000
        UART0->DATA = '\r';
     6e0:	00d00893          	li	a7,13
        putchar(*(p++));
     6e4:	00160613          	addi	a2,a2,1
    if (c == '\n')
     6e8:	18668c63          	beq	a3,t1,880 <_stack_size+0x480>
    UART0->DATA = c;
     6ec:	00d82023          	sw	a3,0(a6) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     6f0:	00064683          	lbu	a3,0(a2)
     6f4:	fe0698e3          	bnez	a3,6e4 <_stack_size+0x2e4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     6f8:	01c7d693          	srli	a3,a5,0x1c
     6fc:	00d706b3          	add	a3,a4,a3
     700:	0006c803          	lbu	a6,0(a3)
        if (c == '0' && i >= digits) continue;
     704:	03000693          	li	a3,48
     708:	00d80663          	beq	a6,a3,714 <_stack_size+0x314>
    if (c == '\n')
     70c:	00a00693          	li	a3,10
     710:	22d80263          	beq	a6,a3,934 <_stack_size+0x534>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     714:	0187d693          	srli	a3,a5,0x18
     718:	00f6f693          	andi	a3,a3,15
     71c:	00d706b3          	add	a3,a4,a3
     720:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     724:	830006b7          	lui	a3,0x83000
     728:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     72c:	03000813          	li	a6,48
     730:	01060663          	beq	a2,a6,73c <_stack_size+0x33c>
    if (c == '\n')
     734:	00a00813          	li	a6,10
     738:	1f060863          	beq	a2,a6,928 <_stack_size+0x528>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     73c:	0147d693          	srli	a3,a5,0x14
     740:	00f6f693          	andi	a3,a3,15
     744:	00d706b3          	add	a3,a4,a3
     748:	0006c803          	lbu	a6,0(a3)
    UART0->DATA = c;
     74c:	830006b7          	lui	a3,0x83000
     750:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     754:	03000613          	li	a2,48
     758:	00c80663          	beq	a6,a2,764 <_stack_size+0x364>
    if (c == '\n')
     75c:	00a00613          	li	a2,10
     760:	1ac80e63          	beq	a6,a2,91c <_stack_size+0x51c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     764:	0107d693          	srli	a3,a5,0x10
     768:	00f6f693          	andi	a3,a3,15
     76c:	00d706b3          	add	a3,a4,a3
     770:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     774:	830006b7          	lui	a3,0x83000
     778:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     77c:	03000813          	li	a6,48
     780:	01060663          	beq	a2,a6,78c <_stack_size+0x38c>
    if (c == '\n')
     784:	00a00813          	li	a6,10
     788:	19060463          	beq	a2,a6,910 <_stack_size+0x510>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     78c:	00c7d693          	srli	a3,a5,0xc
     790:	00f6f693          	andi	a3,a3,15
     794:	00d706b3          	add	a3,a4,a3
     798:	0006c803          	lbu	a6,0(a3)
    UART0->DATA = c;
     79c:	830006b7          	lui	a3,0x83000
     7a0:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     7a4:	03000613          	li	a2,48
     7a8:	00c80663          	beq	a6,a2,7b4 <_stack_size+0x3b4>
    if (c == '\n')
     7ac:	00a00613          	li	a2,10
     7b0:	14c80a63          	beq	a6,a2,904 <_stack_size+0x504>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     7b4:	0087d693          	srli	a3,a5,0x8
     7b8:	00f6f693          	andi	a3,a3,15
     7bc:	00d706b3          	add	a3,a4,a3
     7c0:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     7c4:	830006b7          	lui	a3,0x83000
     7c8:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     7cc:	03000813          	li	a6,48
     7d0:	01060663          	beq	a2,a6,7dc <_stack_size+0x3dc>
    if (c == '\n')
     7d4:	00a00813          	li	a6,10
     7d8:	13060063          	beq	a2,a6,8f8 <_stack_size+0x4f8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     7dc:	0047d693          	srli	a3,a5,0x4
     7e0:	00f6f693          	andi	a3,a3,15
     7e4:	00d706b3          	add	a3,a4,a3
     7e8:	0006c683          	lbu	a3,0(a3)
    UART0->DATA = c;
     7ec:	83000837          	lui	a6,0x83000
     7f0:	00c82023          	sw	a2,0(a6) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     7f4:	03000613          	li	a2,48
     7f8:	00c68663          	beq	a3,a2,804 <_stack_size+0x404>
    if (c == '\n')
     7fc:	00a00613          	li	a2,10
     800:	0ec68663          	beq	a3,a2,8ec <_stack_size+0x4ec>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     804:	00f7f793          	andi	a5,a5,15
     808:	00f70733          	add	a4,a4,a5
     80c:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
     810:	830007b7          	lui	a5,0x83000
     814:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     818:	03000693          	li	a3,48
     81c:	00d70663          	beq	a4,a3,828 <_stack_size+0x428>
    if (c == '\n')
     820:	00a00693          	li	a3,10
     824:	0ad70263          	beq	a4,a3,8c8 <_stack_size+0x4c8>
    UART0->DATA = c;
     828:	830007b7          	lui	a5,0x83000
     82c:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
     830:	00d00713          	li	a4,13
     834:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
     838:	00a00713          	li	a4,10
     83c:	00e7a023          	sw	a4,0(a5)
    if (instns_p)
     840:	000e8663          	beqz	t4,84c <_stack_size+0x44c>
        *instns_p = instns_end - instns_begin;
     844:	41e585b3          	sub	a1,a1,t5
     848:	00bea023          	sw	a1,0(t4)
}
     84c:	10010113          	addi	sp,sp,256
     850:	00008067          	ret
        UART0->DATA = '\r';
     854:	01182023          	sw	a7,0(a6)
    UART0->DATA = c;
     858:	00d82023          	sw	a3,0(a6)
    while (*p)
     85c:	00064683          	lbu	a3,0(a2)
     860:	d00696e3          	bnez	a3,56c <_stack_size+0x16c>
        print_hex(instns_end - instns_begin, 8);
     864:	41e586b3          	sub	a3,a1,t5
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     868:	01c6d613          	srli	a2,a3,0x1c
     86c:	00c70633          	add	a2,a4,a2
     870:	00064803          	lbu	a6,0(a2)
    if (c == '\n')
     874:	00a00613          	li	a2,10
     878:	d2c810e3          	bne	a6,a2,598 <_stack_size+0x198>
     87c:	3180006f          	j	b94 <_stack_size+0x794>
        UART0->DATA = '\r';
     880:	01182023          	sw	a7,0(a6)
    UART0->DATA = c;
     884:	00d82023          	sw	a3,0(a6)
    while (*p)
     888:	00064683          	lbu	a3,0(a2)
     88c:	e4069ce3          	bnez	a3,6e4 <_stack_size+0x2e4>
     890:	e69ff06f          	j	6f8 <_stack_size+0x2f8>
        UART0->DATA = '\r';
     894:	00a62023          	sw	a0,0(a2)
    UART0->DATA = c;
     898:	00e62023          	sw	a4,0(a2)
    while (*p)
     89c:	0006c703          	lbu	a4,0(a3)
     8a0:	b40716e3          	bnez	a4,3ec <cmd_benchmark+0xd0>
        print_hex(cycles_end - cycles_begin, 8);
     8a4:	40580533          	sub	a0,a6,t0
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     8a8:	00003737          	lui	a4,0x3
     8ac:	91870713          	addi	a4,a4,-1768 # 2918 <irqCallback+0x4>
     8b0:	01c55693          	srli	a3,a0,0x1c
     8b4:	00d706b3          	add	a3,a4,a3
     8b8:	0006c803          	lbu	a6,0(a3)
    if (c == '\n')
     8bc:	00a00693          	li	a3,10
     8c0:	b6d810e3          	bne	a6,a3,420 <_stack_size+0x20>
     8c4:	2a00006f          	j	b64 <_stack_size+0x764>
        UART0->DATA = '\r';
     8c8:	00d00693          	li	a3,13
     8cc:	00d7a023          	sw	a3,0(a5)
    UART0->DATA = c;
     8d0:	830007b7          	lui	a5,0x83000
     8d4:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
     8d8:	00d00713          	li	a4,13
     8dc:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
     8e0:	00a00713          	li	a4,10
     8e4:	00e7a023          	sw	a4,0(a5)
    return c;
     8e8:	f59ff06f          	j	840 <_stack_size+0x440>
        UART0->DATA = '\r';
     8ec:	00d00613          	li	a2,13
     8f0:	00c82023          	sw	a2,0(a6)
     8f4:	f11ff06f          	j	804 <_stack_size+0x404>
     8f8:	00d00813          	li	a6,13
     8fc:	0106a023          	sw	a6,0(a3)
     900:	eddff06f          	j	7dc <_stack_size+0x3dc>
     904:	00d00613          	li	a2,13
     908:	00c6a023          	sw	a2,0(a3)
     90c:	ea9ff06f          	j	7b4 <_stack_size+0x3b4>
     910:	00d00813          	li	a6,13
     914:	0106a023          	sw	a6,0(a3)
     918:	e75ff06f          	j	78c <_stack_size+0x38c>
     91c:	00d00613          	li	a2,13
     920:	00c6a023          	sw	a2,0(a3)
     924:	e41ff06f          	j	764 <_stack_size+0x364>
     928:	00d00813          	li	a6,13
     92c:	0106a023          	sw	a6,0(a3)
     930:	e0dff06f          	j	73c <_stack_size+0x33c>
     934:	830006b7          	lui	a3,0x83000
     938:	00d00613          	li	a2,13
     93c:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
     940:	dd5ff06f          	j	714 <_stack_size+0x314>
     944:	00d00813          	li	a6,13
     948:	0106a023          	sw	a6,0(a3)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     94c:	01455693          	srli	a3,a0,0x14
     950:	00f6f693          	andi	a3,a3,15
     954:	00d706b3          	add	a3,a4,a3
     958:	0006c803          	lbu	a6,0(a3)
    UART0->DATA = c;
     95c:	830006b7          	lui	a3,0x83000
     960:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     964:	03000613          	li	a2,48
     968:	b0c810e3          	bne	a6,a2,468 <_stack_size+0x68>
     96c:	b05ff06f          	j	470 <_stack_size+0x70>
        UART0->DATA = '\r';
     970:	00d00613          	li	a2,13
     974:	00c6a023          	sw	a2,0(a3)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     978:	01055693          	srli	a3,a0,0x10
     97c:	00f6f693          	andi	a3,a3,15
     980:	00d706b3          	add	a3,a4,a3
     984:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     988:	830006b7          	lui	a3,0x83000
     98c:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     990:	03000813          	li	a6,48
     994:	af061ee3          	bne	a2,a6,490 <_stack_size+0x90>
     998:	b01ff06f          	j	498 <_stack_size+0x98>
        UART0->DATA = '\r';
     99c:	00d00813          	li	a6,13
     9a0:	0106a023          	sw	a6,0(a3)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     9a4:	00c55693          	srli	a3,a0,0xc
     9a8:	00f6f693          	andi	a3,a3,15
     9ac:	00d706b3          	add	a3,a4,a3
     9b0:	0006c803          	lbu	a6,0(a3)
    UART0->DATA = c;
     9b4:	830006b7          	lui	a3,0x83000
     9b8:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     9bc:	03000613          	li	a2,48
     9c0:	aec81ce3          	bne	a6,a2,4b8 <_stack_size+0xb8>
     9c4:	afdff06f          	j	4c0 <_stack_size+0xc0>
        UART0->DATA = '\r';
     9c8:	00d00613          	li	a2,13
     9cc:	00c6a023          	sw	a2,0(a3)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     9d0:	00855693          	srli	a3,a0,0x8
     9d4:	00f6f693          	andi	a3,a3,15
     9d8:	00d706b3          	add	a3,a4,a3
     9dc:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     9e0:	830006b7          	lui	a3,0x83000
     9e4:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     9e8:	03000813          	li	a6,48
     9ec:	af061ae3          	bne	a2,a6,4e0 <_stack_size+0xe0>
     9f0:	af9ff06f          	j	4e8 <_stack_size+0xe8>
        UART0->DATA = '\r';
     9f4:	00d00813          	li	a6,13
     9f8:	0106a023          	sw	a6,0(a3)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     9fc:	00455693          	srli	a3,a0,0x4
     a00:	00f6f693          	andi	a3,a3,15
     a04:	00d706b3          	add	a3,a4,a3
     a08:	0006c683          	lbu	a3,0(a3)
    UART0->DATA = c;
     a0c:	83000837          	lui	a6,0x83000
     a10:	00c82023          	sw	a2,0(a6) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     a14:	03000613          	li	a2,48
     a18:	aec698e3          	bne	a3,a2,508 <_stack_size+0x108>
     a1c:	af5ff06f          	j	510 <_stack_size+0x110>
        UART0->DATA = '\r';
     a20:	00d00613          	li	a2,13
     a24:	00c82023          	sw	a2,0(a6)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     a28:	00f57613          	andi	a2,a0,15
     a2c:	00c70633          	add	a2,a4,a2
     a30:	00064603          	lbu	a2,0(a2)
    UART0->DATA = c;
     a34:	83000837          	lui	a6,0x83000
     a38:	00d82023          	sw	a3,0(a6) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     a3c:	03000693          	li	a3,48
     a40:	aed616e3          	bne	a2,a3,52c <_stack_size+0x12c>
     a44:	af1ff06f          	j	534 <_stack_size+0x134>
        UART0->DATA = '\r';
     a48:	00d00693          	li	a3,13
     a4c:	00d82023          	sw	a3,0(a6)
     a50:	ae5ff06f          	j	534 <_stack_size+0x134>
     a54:	00d00813          	li	a6,13
     a58:	01062023          	sw	a6,0(a2)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     a5c:	0146d613          	srli	a2,a3,0x14
     a60:	00f67613          	andi	a2,a2,15
     a64:	00c70633          	add	a2,a4,a2
     a68:	00064803          	lbu	a6,0(a2)
    UART0->DATA = c;
     a6c:	83000637          	lui	a2,0x83000
     a70:	01162023          	sw	a7,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     a74:	03000893          	li	a7,48
     a78:	b71814e3          	bne	a6,a7,5e0 <_stack_size+0x1e0>
     a7c:	b6dff06f          	j	5e8 <_stack_size+0x1e8>
        UART0->DATA = '\r';
     a80:	00d00893          	li	a7,13
     a84:	01162023          	sw	a7,0(a2)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     a88:	0106d613          	srli	a2,a3,0x10
     a8c:	00f67613          	andi	a2,a2,15
     a90:	00c70633          	add	a2,a4,a2
     a94:	00064883          	lbu	a7,0(a2)
    UART0->DATA = c;
     a98:	83000637          	lui	a2,0x83000
     a9c:	01062023          	sw	a6,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     aa0:	03000813          	li	a6,48
     aa4:	b70892e3          	bne	a7,a6,608 <_stack_size+0x208>
     aa8:	b69ff06f          	j	610 <_stack_size+0x210>
        UART0->DATA = '\r';
     aac:	00d00813          	li	a6,13
     ab0:	01062023          	sw	a6,0(a2)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     ab4:	00c6d613          	srli	a2,a3,0xc
     ab8:	00f67613          	andi	a2,a2,15
     abc:	00c70633          	add	a2,a4,a2
     ac0:	00064803          	lbu	a6,0(a2)
    UART0->DATA = c;
     ac4:	83000637          	lui	a2,0x83000
     ac8:	01162023          	sw	a7,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     acc:	03000893          	li	a7,48
     ad0:	b71810e3          	bne	a6,a7,630 <_stack_size+0x230>
     ad4:	b65ff06f          	j	638 <_stack_size+0x238>
        UART0->DATA = '\r';
     ad8:	00d00893          	li	a7,13
     adc:	01162023          	sw	a7,0(a2)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     ae0:	0086d613          	srli	a2,a3,0x8
     ae4:	00f67613          	andi	a2,a2,15
     ae8:	00c70633          	add	a2,a4,a2
     aec:	00064883          	lbu	a7,0(a2)
    UART0->DATA = c;
     af0:	83000637          	lui	a2,0x83000
     af4:	01062023          	sw	a6,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     af8:	03000813          	li	a6,48
     afc:	b5089ee3          	bne	a7,a6,658 <_stack_size+0x258>
     b00:	b61ff06f          	j	660 <_stack_size+0x260>
        UART0->DATA = '\r';
     b04:	00d00813          	li	a6,13
     b08:	01062023          	sw	a6,0(a2)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     b0c:	0046d613          	srli	a2,a3,0x4
     b10:	00f67613          	andi	a2,a2,15
     b14:	00c70633          	add	a2,a4,a2
     b18:	00064803          	lbu	a6,0(a2)
    UART0->DATA = c;
     b1c:	83000637          	lui	a2,0x83000
     b20:	01162023          	sw	a7,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     b24:	03000893          	li	a7,48
     b28:	b5181ce3          	bne	a6,a7,680 <_stack_size+0x280>
     b2c:	b5dff06f          	j	688 <_stack_size+0x288>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     b30:	00f6f693          	andi	a3,a3,15
     b34:	00d706b3          	add	a3,a4,a3
        UART0->DATA = '\r';
     b38:	00d00893          	li	a7,13
     b3c:	01162023          	sw	a7,0(a2)
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     b40:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     b44:	830006b7          	lui	a3,0x83000
     b48:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     b4c:	03000813          	li	a6,48
     b50:	b5061ae3          	bne	a2,a6,6a4 <_stack_size+0x2a4>
     b54:	b59ff06f          	j	6ac <_stack_size+0x2ac>
        UART0->DATA = '\r';
     b58:	00d00813          	li	a6,13
     b5c:	0106a023          	sw	a6,0(a3)
     b60:	b4dff06f          	j	6ac <_stack_size+0x2ac>
     b64:	830006b7          	lui	a3,0x83000
     b68:	00d00613          	li	a2,13
     b6c:	00c6a023          	sw	a2,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     b70:	01855693          	srli	a3,a0,0x18
     b74:	00f6f693          	andi	a3,a3,15
     b78:	00d706b3          	add	a3,a4,a3
     b7c:	0006c603          	lbu	a2,0(a3)
    UART0->DATA = c;
     b80:	830006b7          	lui	a3,0x83000
     b84:	0106a023          	sw	a6,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     b88:	03000813          	li	a6,48
     b8c:	8b061ae3          	bne	a2,a6,440 <_stack_size+0x40>
     b90:	8b9ff06f          	j	448 <_stack_size+0x48>
        UART0->DATA = '\r';
     b94:	83000637          	lui	a2,0x83000
     b98:	00d00893          	li	a7,13
     b9c:	01162023          	sw	a7,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     ba0:	0186d613          	srli	a2,a3,0x18
     ba4:	00f67613          	andi	a2,a2,15
     ba8:	00c70633          	add	a2,a4,a2
     bac:	00064883          	lbu	a7,0(a2)
    UART0->DATA = c;
     bb0:	83000637          	lui	a2,0x83000
     bb4:	01062023          	sw	a6,0(a2) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     bb8:	03000813          	li	a6,48
     bbc:	9f089ee3          	bne	a7,a6,5b8 <_stack_size+0x1b8>
     bc0:	a01ff06f          	j	5c0 <_stack_size+0x1c0>

00000bc4 <cmd_benchmark_all>:

void cmd_benchmark_all()
{
     bc4:	fe010113          	addi	sp,sp,-32
    UART0->DATA = c;
     bc8:	830007b7          	lui	a5,0x83000
     bcc:	06400713          	li	a4,100
{
     bd0:	00112e23          	sw	ra,28(sp)
     bd4:	00812c23          	sw	s0,24(sp)
     bd8:	00912a23          	sw	s1,20(sp)
    uint32_t instns = 0;
     bdc:	00012623          	sw	zero,12(sp)
    UART0->DATA = c;
     be0:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        putchar(*(p++));
     be4:	00003737          	lui	a4,0x3
     be8:	95170713          	addi	a4,a4,-1711 # 2951 <irqCallback+0x3d>
    while (*p)
     bec:	06500793          	li	a5,101
    if (c == '\n')
     bf0:	00a00613          	li	a2,10
    UART0->DATA = c;
     bf4:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     bf8:	00d00593          	li	a1,13
        putchar(*(p++));
     bfc:	00170713          	addi	a4,a4,1
    if (c == '\n')
     c00:	02c78ce3          	beq	a5,a2,1438 <cmd_benchmark_all+0x874>
    UART0->DATA = c;
     c04:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     c08:	00074783          	lbu	a5,0(a4)
     c0c:	fe0798e3          	bnez	a5,bfc <cmd_benchmark_all+0x38>
        QSPI0->REG &= ~QSPI_REG_DSPI;
     c10:	810007b7          	lui	a5,0x81000
     c14:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
     c18:	ffc006b7          	lui	a3,0xffc00
     c1c:	fff68693          	addi	a3,a3,-1 # ffbfffff <__global_pointer$+0xbfbff7ff>
     c20:	00d77733          	and	a4,a4,a3
     c24:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG &= ~QSPI_REG_CRM;
     c28:	0007a683          	lw	a3,0(a5)
     c2c:	fff00737          	lui	a4,0xfff00
     c30:	fff70713          	addi	a4,a4,-1 # ffefffff <__global_pointer$+0xbfeff7ff>
     c34:	00e6f6b3          	and	a3,a3,a4
     c38:	00d7a023          	sw	a3,0(a5)
        putchar(*(p++));
     c3c:	00003737          	lui	a4,0x3
    UART0->DATA = c;
     c40:	830007b7          	lui	a5,0x83000
     c44:	03a00693          	li	a3,58
     c48:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        putchar(*(p++));
     c4c:	b6d70493          	addi	s1,a4,-1171 # 2b6d <irqCallback+0x259>
    while (*p)
     c50:	02000793          	li	a5,32
        putchar(*(p++));
     c54:	b6d70713          	addi	a4,a4,-1171
    if (c == '\n')
     c58:	00a00613          	li	a2,10
    UART0->DATA = c;
     c5c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     c60:	00d00593          	li	a1,13
        putchar(*(p++));
     c64:	00170713          	addi	a4,a4,1
    if (c == '\n')
     c68:	7ac78e63          	beq	a5,a2,1424 <cmd_benchmark_all+0x860>
    UART0->DATA = c;
     c6c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     c70:	00074783          	lbu	a5,0(a4)
     c74:	fe0798e3          	bnez	a5,c64 <cmd_benchmark_all+0xa0>

    cmd_set_dspi(0);
    cmd_set_crm(0);

    print(": ");
    print_hex(cmd_benchmark(false, &instns), 8);
     c78:	00c10593          	addi	a1,sp,12
     c7c:	00000513          	li	a0,0
     c80:	e9cff0ef          	jal	ra,31c <cmd_benchmark>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     c84:	00003437          	lui	s0,0x3
     c88:	91840413          	addi	s0,s0,-1768 # 2918 <irqCallback+0x4>
     c8c:	01c55793          	srli	a5,a0,0x1c
     c90:	00f407b3          	add	a5,s0,a5
     c94:	0007c683          	lbu	a3,0(a5)
    if (c == '\n')
     c98:	00a00793          	li	a5,10
     c9c:	00f69863          	bne	a3,a5,cac <cmd_benchmark_all+0xe8>
        UART0->DATA = '\r';
     ca0:	830007b7          	lui	a5,0x83000
     ca4:	00d00713          	li	a4,13
     ca8:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     cac:	01855793          	srli	a5,a0,0x18
     cb0:	00f7f793          	andi	a5,a5,15
     cb4:	00f407b3          	add	a5,s0,a5
     cb8:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
     cbc:	830007b7          	lui	a5,0x83000
     cc0:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     cc4:	03000693          	li	a3,48
     cc8:	00d70663          	beq	a4,a3,cd4 <cmd_benchmark_all+0x110>
    if (c == '\n')
     ccc:	00a00693          	li	a3,10
     cd0:	0cd700e3          	beq	a4,a3,1590 <cmd_benchmark_all+0x9cc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     cd4:	01455793          	srli	a5,a0,0x14
     cd8:	00f7f793          	andi	a5,a5,15
     cdc:	00f407b3          	add	a5,s0,a5
     ce0:	0007c683          	lbu	a3,0(a5)
    UART0->DATA = c;
     ce4:	830007b7          	lui	a5,0x83000
     ce8:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     cec:	03000713          	li	a4,48
     cf0:	00e68663          	beq	a3,a4,cfc <cmd_benchmark_all+0x138>
    if (c == '\n')
     cf4:	00a00713          	li	a4,10
     cf8:	08e686e3          	beq	a3,a4,1584 <cmd_benchmark_all+0x9c0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     cfc:	01055793          	srli	a5,a0,0x10
     d00:	00f7f793          	andi	a5,a5,15
     d04:	00f407b3          	add	a5,s0,a5
     d08:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
     d0c:	830007b7          	lui	a5,0x83000
     d10:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     d14:	03000693          	li	a3,48
     d18:	00d70663          	beq	a4,a3,d24 <cmd_benchmark_all+0x160>
    if (c == '\n')
     d1c:	00a00693          	li	a3,10
     d20:	04d70ce3          	beq	a4,a3,1578 <cmd_benchmark_all+0x9b4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     d24:	00c55793          	srli	a5,a0,0xc
     d28:	00f7f793          	andi	a5,a5,15
     d2c:	00f407b3          	add	a5,s0,a5
     d30:	0007c683          	lbu	a3,0(a5)
    UART0->DATA = c;
     d34:	830007b7          	lui	a5,0x83000
     d38:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     d3c:	03000713          	li	a4,48
     d40:	00e68663          	beq	a3,a4,d4c <cmd_benchmark_all+0x188>
    if (c == '\n')
     d44:	00a00713          	li	a4,10
     d48:	02e682e3          	beq	a3,a4,156c <cmd_benchmark_all+0x9a8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     d4c:	00855793          	srli	a5,a0,0x8
     d50:	00f7f793          	andi	a5,a5,15
     d54:	00f407b3          	add	a5,s0,a5
     d58:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
     d5c:	830007b7          	lui	a5,0x83000
     d60:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     d64:	03000693          	li	a3,48
     d68:	00d70663          	beq	a4,a3,d74 <cmd_benchmark_all+0x1b0>
    if (c == '\n')
     d6c:	00a00693          	li	a3,10
     d70:	7ed70863          	beq	a4,a3,1560 <cmd_benchmark_all+0x99c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     d74:	00455793          	srli	a5,a0,0x4
     d78:	00f7f793          	andi	a5,a5,15
     d7c:	00f407b3          	add	a5,s0,a5
     d80:	0007c783          	lbu	a5,0(a5)
    UART0->DATA = c;
     d84:	830006b7          	lui	a3,0x83000
     d88:	00e6a023          	sw	a4,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     d8c:	03000713          	li	a4,48
     d90:	00e78663          	beq	a5,a4,d9c <cmd_benchmark_all+0x1d8>
    if (c == '\n')
     d94:	00a00713          	li	a4,10
     d98:	7ae78e63          	beq	a5,a4,1554 <cmd_benchmark_all+0x990>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     d9c:	00f57513          	andi	a0,a0,15
     da0:	00a40533          	add	a0,s0,a0
     da4:	00054703          	lbu	a4,0(a0)
    UART0->DATA = c;
     da8:	830006b7          	lui	a3,0x83000
     dac:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     db0:	03000793          	li	a5,48
     db4:	00f70663          	beq	a4,a5,dc0 <cmd_benchmark_all+0x1fc>
    if (c == '\n')
     db8:	00a00793          	li	a5,10
     dbc:	78f70663          	beq	a4,a5,1548 <cmd_benchmark_all+0x984>
    UART0->DATA = c;
     dc0:	830007b7          	lui	a5,0x83000
     dc4:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
     dc8:	00d00713          	li	a4,13
     dcc:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
     dd0:	00a00713          	li	a4,10
     dd4:	00e7a023          	sw	a4,0(a5)
     dd8:	06400713          	li	a4,100
     ddc:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     de0:	00003737          	lui	a4,0x3
     de4:	96170713          	addi	a4,a4,-1695 # 2961 <irqCallback+0x4d>
    while (*p)
     de8:	07300793          	li	a5,115
    if (c == '\n')
     dec:	00a00613          	li	a2,10
    UART0->DATA = c;
     df0:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     df4:	00d00593          	li	a1,13
        putchar(*(p++));
     df8:	00170713          	addi	a4,a4,1
    if (c == '\n')
     dfc:	60c78a63          	beq	a5,a2,1410 <cmd_benchmark_all+0x84c>
    UART0->DATA = c;
     e00:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     e04:	00074783          	lbu	a5,0(a4)
     e08:	fe0798e3          	bnez	a5,df8 <cmd_benchmark_all+0x234>
    UART0->DATA = c;
     e0c:	830007b7          	lui	a5,0x83000
     e10:	03000713          	li	a4,48
     e14:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
     e18:	02000713          	li	a4,32
     e1c:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     e20:	00003737          	lui	a4,0x3
     e24:	96970713          	addi	a4,a4,-1687 # 2969 <irqCallback+0x55>
    while (*p)
     e28:	02000793          	li	a5,32
    if (c == '\n')
     e2c:	00a00613          	li	a2,10
    UART0->DATA = c;
     e30:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     e34:	00d00593          	li	a1,13
        putchar(*(p++));
     e38:	00170713          	addi	a4,a4,1
    if (c == '\n')
     e3c:	5cc78063          	beq	a5,a2,13fc <cmd_benchmark_all+0x838>
    UART0->DATA = c;
     e40:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     e44:	00074783          	lbu	a5,0(a4)
     e48:	fe0798e3          	bnez	a5,e38 <cmd_benchmark_all+0x274>
        QSPI0->REG |= QSPI_REG_DSPI;
     e4c:	81000737          	lui	a4,0x81000
     e50:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff800>
     e54:	004006b7          	lui	a3,0x400
    if (c == '\n')
     e58:	00a00613          	li	a2,10
        QSPI0->REG |= QSPI_REG_DSPI;
     e5c:	00d7e7b3          	or	a5,a5,a3
     e60:	00f72023          	sw	a5,0(a4)
    UART0->DATA = c;
     e64:	830007b7          	lui	a5,0x83000
     e68:	03a00713          	li	a4,58
     e6c:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
     e70:	830006b7          	lui	a3,0x83000
        putchar(*(p++));
     e74:	00048713          	mv	a4,s1
    while (*p)
     e78:	02000793          	li	a5,32
        UART0->DATA = '\r';
     e7c:	00d00593          	li	a1,13
        putchar(*(p++));
     e80:	00170713          	addi	a4,a4,1
    if (c == '\n')
     e84:	56c78263          	beq	a5,a2,13e8 <cmd_benchmark_all+0x824>
    UART0->DATA = c;
     e88:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
     e8c:	00074783          	lbu	a5,0(a4)
     e90:	fe0798e3          	bnez	a5,e80 <cmd_benchmark_all+0x2bc>
    print("         ");

    cmd_set_dspi(1);

    print(": ");
    print_hex(cmd_benchmark(false, &instns), 8);
     e94:	00c10593          	addi	a1,sp,12
     e98:	00000513          	li	a0,0
     e9c:	c80ff0ef          	jal	ra,31c <cmd_benchmark>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     ea0:	01c55793          	srli	a5,a0,0x1c
     ea4:	00f407b3          	add	a5,s0,a5
     ea8:	0007c683          	lbu	a3,0(a5)
    if (c == '\n')
     eac:	00a00793          	li	a5,10
     eb0:	00f69863          	bne	a3,a5,ec0 <cmd_benchmark_all+0x2fc>
        UART0->DATA = '\r';
     eb4:	830007b7          	lui	a5,0x83000
     eb8:	00d00713          	li	a4,13
     ebc:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     ec0:	01855793          	srli	a5,a0,0x18
     ec4:	00f7f793          	andi	a5,a5,15
     ec8:	00f407b3          	add	a5,s0,a5
     ecc:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
     ed0:	830007b7          	lui	a5,0x83000
     ed4:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     ed8:	03000693          	li	a3,48
     edc:	00d70663          	beq	a4,a3,ee8 <cmd_benchmark_all+0x324>
    if (c == '\n')
     ee0:	00a00693          	li	a3,10
     ee4:	64d70c63          	beq	a4,a3,153c <cmd_benchmark_all+0x978>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     ee8:	01455793          	srli	a5,a0,0x14
     eec:	00f7f793          	andi	a5,a5,15
     ef0:	00f407b3          	add	a5,s0,a5
     ef4:	0007c683          	lbu	a3,0(a5)
    UART0->DATA = c;
     ef8:	830007b7          	lui	a5,0x83000
     efc:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     f00:	03000713          	li	a4,48
     f04:	00e68663          	beq	a3,a4,f10 <cmd_benchmark_all+0x34c>
    if (c == '\n')
     f08:	00a00713          	li	a4,10
     f0c:	62e68263          	beq	a3,a4,1530 <cmd_benchmark_all+0x96c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     f10:	01055793          	srli	a5,a0,0x10
     f14:	00f7f793          	andi	a5,a5,15
     f18:	00f407b3          	add	a5,s0,a5
     f1c:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
     f20:	830007b7          	lui	a5,0x83000
     f24:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     f28:	03000693          	li	a3,48
     f2c:	00d70663          	beq	a4,a3,f38 <cmd_benchmark_all+0x374>
    if (c == '\n')
     f30:	00a00693          	li	a3,10
     f34:	5ed70863          	beq	a4,a3,1524 <cmd_benchmark_all+0x960>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     f38:	00c55793          	srli	a5,a0,0xc
     f3c:	00f7f793          	andi	a5,a5,15
     f40:	00f407b3          	add	a5,s0,a5
     f44:	0007c683          	lbu	a3,0(a5)
    UART0->DATA = c;
     f48:	830007b7          	lui	a5,0x83000
     f4c:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     f50:	03000713          	li	a4,48
     f54:	00e68663          	beq	a3,a4,f60 <cmd_benchmark_all+0x39c>
    if (c == '\n')
     f58:	00a00713          	li	a4,10
     f5c:	5ae68e63          	beq	a3,a4,1518 <cmd_benchmark_all+0x954>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     f60:	00855793          	srli	a5,a0,0x8
     f64:	00f7f793          	andi	a5,a5,15
     f68:	00f407b3          	add	a5,s0,a5
     f6c:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
     f70:	830007b7          	lui	a5,0x83000
     f74:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     f78:	03000693          	li	a3,48
     f7c:	00d70663          	beq	a4,a3,f88 <cmd_benchmark_all+0x3c4>
    if (c == '\n')
     f80:	00a00693          	li	a3,10
     f84:	58d70463          	beq	a4,a3,150c <cmd_benchmark_all+0x948>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     f88:	00455793          	srli	a5,a0,0x4
     f8c:	00f7f793          	andi	a5,a5,15
     f90:	00f407b3          	add	a5,s0,a5
     f94:	0007c783          	lbu	a5,0(a5)
    UART0->DATA = c;
     f98:	830006b7          	lui	a3,0x83000
     f9c:	00e6a023          	sw	a4,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     fa0:	03000713          	li	a4,48
     fa4:	00e78663          	beq	a5,a4,fb0 <cmd_benchmark_all+0x3ec>
    if (c == '\n')
     fa8:	00a00713          	li	a4,10
     fac:	54e78a63          	beq	a5,a4,1500 <cmd_benchmark_all+0x93c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     fb0:	00f57513          	andi	a0,a0,15
     fb4:	00a40533          	add	a0,s0,a0
     fb8:	00054703          	lbu	a4,0(a0)
    UART0->DATA = c;
     fbc:	830006b7          	lui	a3,0x83000
     fc0:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
     fc4:	03000793          	li	a5,48
     fc8:	00f70663          	beq	a4,a5,fd4 <cmd_benchmark_all+0x410>
    if (c == '\n')
     fcc:	00a00793          	li	a5,10
     fd0:	52f70263          	beq	a4,a5,14f4 <cmd_benchmark_all+0x930>
    UART0->DATA = c;
     fd4:	830007b7          	lui	a5,0x83000
     fd8:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
     fdc:	00d00713          	li	a4,13
     fe0:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
     fe4:	00a00713          	li	a4,10
     fe8:	00e7a023          	sw	a4,0(a5)
     fec:	06400713          	li	a4,100
     ff0:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     ff4:	00003737          	lui	a4,0x3
     ff8:	97570713          	addi	a4,a4,-1675 # 2975 <irqCallback+0x61>
    while (*p)
     ffc:	07300793          	li	a5,115
    if (c == '\n')
    1000:	00a00613          	li	a2,10
    UART0->DATA = c;
    1004:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
    1008:	00d00593          	li	a1,13
        putchar(*(p++));
    100c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1010:	3cc78263          	beq	a5,a2,13d4 <cmd_benchmark_all+0x810>
    UART0->DATA = c;
    1014:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
    1018:	00074783          	lbu	a5,0(a4)
    101c:	fe0798e3          	bnez	a5,100c <cmd_benchmark_all+0x448>
    UART0->DATA = c;
    1020:	830007b7          	lui	a5,0x83000
    1024:	03000713          	li	a4,48
    1028:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
    102c:	02000713          	li	a4,32
    1030:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
    1034:	00003737          	lui	a4,0x3
    1038:	96d70713          	addi	a4,a4,-1683 # 296d <irqCallback+0x59>
    while (*p)
    103c:	02000793          	li	a5,32
    if (c == '\n')
    1040:	00a00613          	li	a2,10
    UART0->DATA = c;
    1044:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
    1048:	00d00593          	li	a1,13
        putchar(*(p++));
    104c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1050:	36c78863          	beq	a5,a2,13c0 <cmd_benchmark_all+0x7fc>
    UART0->DATA = c;
    1054:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
    1058:	00074783          	lbu	a5,0(a4)
    105c:	fe0798e3          	bnez	a5,104c <cmd_benchmark_all+0x488>
        QSPI0->REG |= QSPI_REG_CRM;
    1060:	81000737          	lui	a4,0x81000
    1064:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff800>
    1068:	001006b7          	lui	a3,0x100
    if (c == '\n')
    106c:	00a00613          	li	a2,10
        QSPI0->REG |= QSPI_REG_CRM;
    1070:	00d7e7b3          	or	a5,a5,a3
    1074:	00f72023          	sw	a5,0(a4)
    UART0->DATA = c;
    1078:	830007b7          	lui	a5,0x83000
    107c:	03a00713          	li	a4,58
    1080:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
    1084:	830006b7          	lui	a3,0x83000
        putchar(*(p++));
    1088:	00048713          	mv	a4,s1
    while (*p)
    108c:	02000793          	li	a5,32
        UART0->DATA = '\r';
    1090:	00d00593          	li	a1,13
        putchar(*(p++));
    1094:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1098:	30c78a63          	beq	a5,a2,13ac <cmd_benchmark_all+0x7e8>
    UART0->DATA = c;
    109c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
    10a0:	00074783          	lbu	a5,0(a4)
    10a4:	fe0798e3          	bnez	a5,1094 <cmd_benchmark_all+0x4d0>
    print("     ");

    cmd_set_crm(1);

    print(": ");
    print_hex(cmd_benchmark(false, &instns), 8);
    10a8:	00c10593          	addi	a1,sp,12
    10ac:	00000513          	li	a0,0
    10b0:	a6cff0ef          	jal	ra,31c <cmd_benchmark>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    10b4:	01c55793          	srli	a5,a0,0x1c
    10b8:	00f407b3          	add	a5,s0,a5
    10bc:	0007c683          	lbu	a3,0(a5)
    if (c == '\n')
    10c0:	00a00793          	li	a5,10
    10c4:	00f69863          	bne	a3,a5,10d4 <cmd_benchmark_all+0x510>
        UART0->DATA = '\r';
    10c8:	830007b7          	lui	a5,0x83000
    10cc:	00d00713          	li	a4,13
    10d0:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    10d4:	01855793          	srli	a5,a0,0x18
    10d8:	00f7f793          	andi	a5,a5,15
    10dc:	00f407b3          	add	a5,s0,a5
    10e0:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
    10e4:	830007b7          	lui	a5,0x83000
    10e8:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    10ec:	03000693          	li	a3,48
    10f0:	00d70663          	beq	a4,a3,10fc <cmd_benchmark_all+0x538>
    if (c == '\n')
    10f4:	00a00693          	li	a3,10
    10f8:	3ed70863          	beq	a4,a3,14e8 <cmd_benchmark_all+0x924>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    10fc:	01455793          	srli	a5,a0,0x14
    1100:	00f7f793          	andi	a5,a5,15
    1104:	00f407b3          	add	a5,s0,a5
    1108:	0007c683          	lbu	a3,0(a5)
    UART0->DATA = c;
    110c:	830007b7          	lui	a5,0x83000
    1110:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    1114:	03000713          	li	a4,48
    1118:	00e68663          	beq	a3,a4,1124 <cmd_benchmark_all+0x560>
    if (c == '\n')
    111c:	00a00713          	li	a4,10
    1120:	3ae68e63          	beq	a3,a4,14dc <cmd_benchmark_all+0x918>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1124:	01055793          	srli	a5,a0,0x10
    1128:	00f7f793          	andi	a5,a5,15
    112c:	00f407b3          	add	a5,s0,a5
    1130:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
    1134:	830007b7          	lui	a5,0x83000
    1138:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    113c:	03000693          	li	a3,48
    1140:	00d70663          	beq	a4,a3,114c <cmd_benchmark_all+0x588>
    if (c == '\n')
    1144:	00a00693          	li	a3,10
    1148:	38d70463          	beq	a4,a3,14d0 <cmd_benchmark_all+0x90c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    114c:	00c55793          	srli	a5,a0,0xc
    1150:	00f7f793          	andi	a5,a5,15
    1154:	00f407b3          	add	a5,s0,a5
    1158:	0007c683          	lbu	a3,0(a5)
    UART0->DATA = c;
    115c:	830007b7          	lui	a5,0x83000
    1160:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    1164:	03000713          	li	a4,48
    1168:	00e68663          	beq	a3,a4,1174 <cmd_benchmark_all+0x5b0>
    if (c == '\n')
    116c:	00a00713          	li	a4,10
    1170:	34e68a63          	beq	a3,a4,14c4 <cmd_benchmark_all+0x900>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1174:	00855793          	srli	a5,a0,0x8
    1178:	00f7f793          	andi	a5,a5,15
    117c:	00f407b3          	add	a5,s0,a5
    1180:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
    1184:	830007b7          	lui	a5,0x83000
    1188:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    118c:	03000693          	li	a3,48
    1190:	00d70663          	beq	a4,a3,119c <cmd_benchmark_all+0x5d8>
    if (c == '\n')
    1194:	00a00693          	li	a3,10
    1198:	32d70063          	beq	a4,a3,14b8 <cmd_benchmark_all+0x8f4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    119c:	00455793          	srli	a5,a0,0x4
    11a0:	00f7f793          	andi	a5,a5,15
    11a4:	00f407b3          	add	a5,s0,a5
    11a8:	0007c783          	lbu	a5,0(a5)
    UART0->DATA = c;
    11ac:	830006b7          	lui	a3,0x83000
    11b0:	00e6a023          	sw	a4,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    11b4:	03000713          	li	a4,48
    11b8:	00e78663          	beq	a5,a4,11c4 <cmd_benchmark_all+0x600>
    if (c == '\n')
    11bc:	00a00713          	li	a4,10
    11c0:	2ee78663          	beq	a5,a4,14ac <cmd_benchmark_all+0x8e8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    11c4:	00f57513          	andi	a0,a0,15
    11c8:	00a40533          	add	a0,s0,a0
    11cc:	00054703          	lbu	a4,0(a0)
    UART0->DATA = c;
    11d0:	830006b7          	lui	a3,0x83000
    11d4:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    11d8:	03000793          	li	a5,48
    11dc:	00f70663          	beq	a4,a5,11e8 <cmd_benchmark_all+0x624>
    if (c == '\n')
    11e0:	00a00793          	li	a5,10
    11e4:	2af70e63          	beq	a4,a5,14a0 <cmd_benchmark_all+0x8dc>
    UART0->DATA = c;
    11e8:	830007b7          	lui	a5,0x83000
    11ec:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        UART0->DATA = '\r';
    11f0:	00d00713          	li	a4,13
    11f4:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
    11f8:	00a00713          	li	a4,10
    11fc:	00e7a023          	sw	a4,0(a5)
    1200:	06900713          	li	a4,105
    1204:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
    1208:	00003737          	lui	a4,0x3
    120c:	98170713          	addi	a4,a4,-1663 # 2981 <irqCallback+0x6d>
    while (*p)
    1210:	06e00793          	li	a5,110
    if (c == '\n')
    1214:	00a00613          	li	a2,10
    UART0->DATA = c;
    1218:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
    121c:	00d00593          	li	a1,13
        putchar(*(p++));
    1220:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1224:	16c78a63          	beq	a5,a2,1398 <cmd_benchmark_all+0x7d4>
    UART0->DATA = c;
    1228:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
    122c:	00074783          	lbu	a5,0(a4)
    1230:	fe0798e3          	bnez	a5,1220 <cmd_benchmark_all+0x65c>
    putchar('\n');

    print("instns         : ");
    print_hex(instns, 8);
    1234:	00c12683          	lw	a3,12(sp)
    if (c == '\n')
    1238:	00a00793          	li	a5,10
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    123c:	01c6d713          	srli	a4,a3,0x1c
    1240:	00e40733          	add	a4,s0,a4
    1244:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    1248:	00f61863          	bne	a2,a5,1258 <cmd_benchmark_all+0x694>
        UART0->DATA = '\r';
    124c:	830007b7          	lui	a5,0x83000
    1250:	00d00713          	li	a4,13
    1254:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1258:	0186d793          	srli	a5,a3,0x18
    125c:	00f7f793          	andi	a5,a5,15
    1260:	00f407b3          	add	a5,s0,a5
    1264:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
    1268:	830007b7          	lui	a5,0x83000
    126c:	00c7a023          	sw	a2,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    1270:	03000613          	li	a2,48
    1274:	00c70663          	beq	a4,a2,1280 <cmd_benchmark_all+0x6bc>
    if (c == '\n')
    1278:	00a00613          	li	a2,10
    127c:	20c70c63          	beq	a4,a2,1494 <cmd_benchmark_all+0x8d0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1280:	0146d793          	srli	a5,a3,0x14
    1284:	00f7f793          	andi	a5,a5,15
    1288:	00f407b3          	add	a5,s0,a5
    128c:	0007c603          	lbu	a2,0(a5)
    UART0->DATA = c;
    1290:	830007b7          	lui	a5,0x83000
    1294:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    1298:	03000713          	li	a4,48
    129c:	00e60663          	beq	a2,a4,12a8 <cmd_benchmark_all+0x6e4>
    if (c == '\n')
    12a0:	00a00713          	li	a4,10
    12a4:	1ee60263          	beq	a2,a4,1488 <cmd_benchmark_all+0x8c4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    12a8:	0106d793          	srli	a5,a3,0x10
    12ac:	00f7f793          	andi	a5,a5,15
    12b0:	00f407b3          	add	a5,s0,a5
    12b4:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
    12b8:	830007b7          	lui	a5,0x83000
    12bc:	00c7a023          	sw	a2,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    12c0:	03000613          	li	a2,48
    12c4:	00c70663          	beq	a4,a2,12d0 <cmd_benchmark_all+0x70c>
    if (c == '\n')
    12c8:	00a00613          	li	a2,10
    12cc:	1ac70863          	beq	a4,a2,147c <cmd_benchmark_all+0x8b8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    12d0:	00c6d793          	srli	a5,a3,0xc
    12d4:	00f7f793          	andi	a5,a5,15
    12d8:	00f407b3          	add	a5,s0,a5
    12dc:	0007c603          	lbu	a2,0(a5)
    UART0->DATA = c;
    12e0:	830007b7          	lui	a5,0x83000
    12e4:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    12e8:	03000713          	li	a4,48
    12ec:	00e60663          	beq	a2,a4,12f8 <cmd_benchmark_all+0x734>
    if (c == '\n')
    12f0:	00a00713          	li	a4,10
    12f4:	16e60e63          	beq	a2,a4,1470 <cmd_benchmark_all+0x8ac>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    12f8:	0086d793          	srli	a5,a3,0x8
    12fc:	00f7f793          	andi	a5,a5,15
    1300:	00f407b3          	add	a5,s0,a5
    1304:	0007c703          	lbu	a4,0(a5)
    UART0->DATA = c;
    1308:	830007b7          	lui	a5,0x83000
    130c:	00c7a023          	sw	a2,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    1310:	03000613          	li	a2,48
    1314:	00c70663          	beq	a4,a2,1320 <cmd_benchmark_all+0x75c>
    if (c == '\n')
    1318:	00a00613          	li	a2,10
    131c:	14c70463          	beq	a4,a2,1464 <cmd_benchmark_all+0x8a0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1320:	0046d793          	srli	a5,a3,0x4
    1324:	00f7f793          	andi	a5,a5,15
    1328:	00f407b3          	add	a5,s0,a5
    132c:	0007c603          	lbu	a2,0(a5)
    UART0->DATA = c;
    1330:	830007b7          	lui	a5,0x83000
    1334:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    1338:	03000713          	li	a4,48
    133c:	00e60663          	beq	a2,a4,1348 <cmd_benchmark_all+0x784>
    if (c == '\n')
    1340:	00a00713          	li	a4,10
    1344:	10e60a63          	beq	a2,a4,1458 <cmd_benchmark_all+0x894>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1348:	00f6f793          	andi	a5,a3,15
    134c:	00f40433          	add	s0,s0,a5
    1350:	00044703          	lbu	a4,0(s0)
    UART0->DATA = c;
    1354:	830007b7          	lui	a5,0x83000
    1358:	00c7a023          	sw	a2,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        if (c == '0' && i >= digits) continue;
    135c:	03000693          	li	a3,48
    1360:	00d70663          	beq	a4,a3,136c <cmd_benchmark_all+0x7a8>
    if (c == '\n')
    1364:	00a00693          	li	a3,10
    1368:	0ed70263          	beq	a4,a3,144c <cmd_benchmark_all+0x888>
    UART0->DATA = c;
    136c:	830007b7          	lui	a5,0x83000
    1370:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
    putchar('\n');
}
    1374:	01c12083          	lw	ra,28(sp)
    1378:	01812403          	lw	s0,24(sp)
        UART0->DATA = '\r';
    137c:	00d00713          	li	a4,13
    1380:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
    1384:	00a00713          	li	a4,10
    1388:	00e7a023          	sw	a4,0(a5)
}
    138c:	01412483          	lw	s1,20(sp)
    1390:	02010113          	addi	sp,sp,32
    1394:	00008067          	ret
        UART0->DATA = '\r';
    1398:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    139c:	00f6a023          	sw	a5,0(a3)
    while (*p)
    13a0:	00074783          	lbu	a5,0(a4)
    13a4:	e6079ee3          	bnez	a5,1220 <cmd_benchmark_all+0x65c>
    13a8:	e8dff06f          	j	1234 <cmd_benchmark_all+0x670>
        UART0->DATA = '\r';
    13ac:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    13b0:	00f6a023          	sw	a5,0(a3)
    while (*p)
    13b4:	00074783          	lbu	a5,0(a4)
    13b8:	cc079ee3          	bnez	a5,1094 <cmd_benchmark_all+0x4d0>
    13bc:	cedff06f          	j	10a8 <cmd_benchmark_all+0x4e4>
        UART0->DATA = '\r';
    13c0:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    13c4:	00f6a023          	sw	a5,0(a3)
    while (*p)
    13c8:	00074783          	lbu	a5,0(a4)
    13cc:	c80790e3          	bnez	a5,104c <cmd_benchmark_all+0x488>
    13d0:	c91ff06f          	j	1060 <cmd_benchmark_all+0x49c>
        UART0->DATA = '\r';
    13d4:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    13d8:	00f6a023          	sw	a5,0(a3)
    while (*p)
    13dc:	00074783          	lbu	a5,0(a4)
    13e0:	c20796e3          	bnez	a5,100c <cmd_benchmark_all+0x448>
    13e4:	c3dff06f          	j	1020 <cmd_benchmark_all+0x45c>
        UART0->DATA = '\r';
    13e8:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    13ec:	00f6a023          	sw	a5,0(a3)
    while (*p)
    13f0:	00074783          	lbu	a5,0(a4)
    13f4:	a80796e3          	bnez	a5,e80 <cmd_benchmark_all+0x2bc>
    13f8:	a9dff06f          	j	e94 <cmd_benchmark_all+0x2d0>
        UART0->DATA = '\r';
    13fc:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    1400:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1404:	00074783          	lbu	a5,0(a4)
    1408:	a20798e3          	bnez	a5,e38 <cmd_benchmark_all+0x274>
    140c:	a41ff06f          	j	e4c <cmd_benchmark_all+0x288>
        UART0->DATA = '\r';
    1410:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    1414:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1418:	00074783          	lbu	a5,0(a4)
    141c:	9c079ee3          	bnez	a5,df8 <cmd_benchmark_all+0x234>
    1420:	9edff06f          	j	e0c <cmd_benchmark_all+0x248>
        UART0->DATA = '\r';
    1424:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    1428:	00f6a023          	sw	a5,0(a3)
    while (*p)
    142c:	00074783          	lbu	a5,0(a4)
    1430:	82079ae3          	bnez	a5,c64 <cmd_benchmark_all+0xa0>
    1434:	845ff06f          	j	c78 <cmd_benchmark_all+0xb4>
        UART0->DATA = '\r';
    1438:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
    143c:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1440:	00074783          	lbu	a5,0(a4)
    1444:	fa079c63          	bnez	a5,bfc <cmd_benchmark_all+0x38>
    1448:	fc8ff06f          	j	c10 <cmd_benchmark_all+0x4c>
        UART0->DATA = '\r';
    144c:	00d00693          	li	a3,13
    1450:	00d7a023          	sw	a3,0(a5)
    1454:	f19ff06f          	j	136c <cmd_benchmark_all+0x7a8>
    1458:	00d00713          	li	a4,13
    145c:	00e7a023          	sw	a4,0(a5)
    1460:	ee9ff06f          	j	1348 <cmd_benchmark_all+0x784>
    1464:	00d00613          	li	a2,13
    1468:	00c7a023          	sw	a2,0(a5)
    146c:	eb5ff06f          	j	1320 <cmd_benchmark_all+0x75c>
    1470:	00d00713          	li	a4,13
    1474:	00e7a023          	sw	a4,0(a5)
    1478:	e81ff06f          	j	12f8 <cmd_benchmark_all+0x734>
    147c:	00d00613          	li	a2,13
    1480:	00c7a023          	sw	a2,0(a5)
    1484:	e4dff06f          	j	12d0 <cmd_benchmark_all+0x70c>
    1488:	00d00713          	li	a4,13
    148c:	00e7a023          	sw	a4,0(a5)
    1490:	e19ff06f          	j	12a8 <cmd_benchmark_all+0x6e4>
    1494:	00d00613          	li	a2,13
    1498:	00c7a023          	sw	a2,0(a5)
    149c:	de5ff06f          	j	1280 <cmd_benchmark_all+0x6bc>
    14a0:	00d00793          	li	a5,13
    14a4:	00f6a023          	sw	a5,0(a3)
    14a8:	d41ff06f          	j	11e8 <cmd_benchmark_all+0x624>
    14ac:	00d00713          	li	a4,13
    14b0:	00e6a023          	sw	a4,0(a3)
    14b4:	d11ff06f          	j	11c4 <cmd_benchmark_all+0x600>
    14b8:	00d00693          	li	a3,13
    14bc:	00d7a023          	sw	a3,0(a5)
    14c0:	cddff06f          	j	119c <cmd_benchmark_all+0x5d8>
    14c4:	00d00713          	li	a4,13
    14c8:	00e7a023          	sw	a4,0(a5)
    14cc:	ca9ff06f          	j	1174 <cmd_benchmark_all+0x5b0>
    14d0:	00d00693          	li	a3,13
    14d4:	00d7a023          	sw	a3,0(a5)
    14d8:	c75ff06f          	j	114c <cmd_benchmark_all+0x588>
    14dc:	00d00713          	li	a4,13
    14e0:	00e7a023          	sw	a4,0(a5)
    14e4:	c41ff06f          	j	1124 <cmd_benchmark_all+0x560>
    14e8:	00d00693          	li	a3,13
    14ec:	00d7a023          	sw	a3,0(a5)
    14f0:	c0dff06f          	j	10fc <cmd_benchmark_all+0x538>
    14f4:	00d00793          	li	a5,13
    14f8:	00f6a023          	sw	a5,0(a3)
    14fc:	ad9ff06f          	j	fd4 <cmd_benchmark_all+0x410>
    1500:	00d00713          	li	a4,13
    1504:	00e6a023          	sw	a4,0(a3)
    1508:	aa9ff06f          	j	fb0 <cmd_benchmark_all+0x3ec>
    150c:	00d00693          	li	a3,13
    1510:	00d7a023          	sw	a3,0(a5)
    1514:	a75ff06f          	j	f88 <cmd_benchmark_all+0x3c4>
    1518:	00d00713          	li	a4,13
    151c:	00e7a023          	sw	a4,0(a5)
    1520:	a41ff06f          	j	f60 <cmd_benchmark_all+0x39c>
    1524:	00d00693          	li	a3,13
    1528:	00d7a023          	sw	a3,0(a5)
    152c:	a0dff06f          	j	f38 <cmd_benchmark_all+0x374>
    1530:	00d00713          	li	a4,13
    1534:	00e7a023          	sw	a4,0(a5)
    1538:	9d9ff06f          	j	f10 <cmd_benchmark_all+0x34c>
    153c:	00d00693          	li	a3,13
    1540:	00d7a023          	sw	a3,0(a5)
    1544:	9a5ff06f          	j	ee8 <cmd_benchmark_all+0x324>
    1548:	00d00793          	li	a5,13
    154c:	00f6a023          	sw	a5,0(a3)
    1550:	871ff06f          	j	dc0 <cmd_benchmark_all+0x1fc>
    1554:	00d00713          	li	a4,13
    1558:	00e6a023          	sw	a4,0(a3)
    155c:	841ff06f          	j	d9c <cmd_benchmark_all+0x1d8>
    1560:	00d00693          	li	a3,13
    1564:	00d7a023          	sw	a3,0(a5)
    1568:	80dff06f          	j	d74 <cmd_benchmark_all+0x1b0>
    156c:	00d00713          	li	a4,13
    1570:	00e7a023          	sw	a4,0(a5)
    1574:	fd8ff06f          	j	d4c <cmd_benchmark_all+0x188>
    1578:	00d00693          	li	a3,13
    157c:	00d7a023          	sw	a3,0(a5)
    1580:	fa4ff06f          	j	d24 <cmd_benchmark_all+0x160>
    1584:	00d00713          	li	a4,13
    1588:	00e7a023          	sw	a4,0(a5)
    158c:	f70ff06f          	j	cfc <cmd_benchmark_all+0x138>
    1590:	00d00693          	li	a3,13
    1594:	00d7a023          	sw	a3,0(a5)
    1598:	f3cff06f          	j	cd4 <cmd_benchmark_all+0x110>

0000159c <main>:

#define CLK_FREQ        25175000
#define UART_BAUD       115200

void main()
{
    159c:	e6010113          	addi	sp,sp,-416
    15a0:	18112e23          	sw	ra,412(sp)
    15a4:	18812c23          	sw	s0,408(sp)
    15a8:	18912a23          	sw	s1,404(sp)
    15ac:	19212823          	sw	s2,400(sp)
    15b0:	19312623          	sw	s3,396(sp)
    15b4:	19412423          	sw	s4,392(sp)
    15b8:	19512223          	sw	s5,388(sp)
    15bc:	19612023          	sw	s6,384(sp)
    15c0:	17712e23          	sw	s7,380(sp)
    15c4:	17812c23          	sw	s8,376(sp)
    15c8:	17912a23          	sw	s9,372(sp)
    15cc:	17a12823          	sw	s10,368(sp)
    15d0:	17b12623          	sw	s11,364(sp)
    UART0->CLKDIV = CLK_FREQ / UART_BAUD - 2;
    15d4:	830007b7          	lui	a5,0x83000
    15d8:	0d800713          	li	a4,216
    15dc:	00e7a223          	sw	a4,4(a5) # 83000004 <__global_pointer$+0x42fff804>

    GPIO0->OE = 0x3F;
    15e0:	820007b7          	lui	a5,0x82000
    15e4:	03f00713          	li	a4,63
    15e8:	00e7a423          	sw	a4,8(a5) # 82000008 <__global_pointer$+0x41fff808>
    GPIO0->OUT = 0x3F;
    15ec:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG |= QSPI_REG_CRM;
    15f0:	81000737          	lui	a4,0x81000
    15f4:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff800>
    15f8:	001006b7          	lui	a3,0x100
        QSPI0->REG |= QSPI_REG_DSPI;
    15fc:	00400637          	lui	a2,0x400
        QSPI0->REG |= QSPI_REG_CRM;
    1600:	00d7e7b3          	or	a5,a5,a3
    1604:	00f72023          	sw	a5,0(a4)
        QSPI0->REG |= QSPI_REG_DSPI;
    1608:	00072683          	lw	a3,0(a4)
    while (*p)
    160c:	00a00793          	li	a5,10
    if (c == '\n')
    1610:	00a00593          	li	a1,10
        QSPI0->REG |= QSPI_REG_DSPI;
    1614:	00c6e6b3          	or	a3,a3,a2
    1618:	00d72023          	sw	a3,0(a4)
    161c:	00003737          	lui	a4,0x3
    1620:	99470713          	addi	a4,a4,-1644 # 2994 <irqCallback+0x80>
    UART0->DATA = c;
    1624:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
    1628:	00d00613          	li	a2,13
        putchar(*(p++));
    162c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1630:	70b78c63          	beq	a5,a1,1d48 <main+0x7ac>
    UART0->DATA = c;
    1634:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
    1638:	00074783          	lbu	a5,0(a4)
    163c:	fe0798e3          	bnez	a5,162c <main+0x90>
    UART0->DATA = c;
    1640:	830007b7          	lui	a5,0x83000
    1644:	02000713          	li	a4,32
    1648:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        putchar(*(p++));
    164c:	00003737          	lui	a4,0x3
    1650:	99d70713          	addi	a4,a4,-1635 # 299d <irqCallback+0x89>
    while (*p)
    1654:	02000793          	li	a5,32
    if (c == '\n')
    1658:	00a00593          	li	a1,10
    UART0->DATA = c;
    165c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
    1660:	00d00613          	li	a2,13
        putchar(*(p++));
    1664:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1668:	6eb78a63          	beq	a5,a1,1d5c <main+0x7c0>
    UART0->DATA = c;
    166c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
    1670:	00074783          	lbu	a5,0(a4)
    1674:	fe0798e3          	bnez	a5,1664 <main+0xc8>
        UART0->DATA = '\r';
    1678:	830007b7          	lui	a5,0x83000
    167c:	00d00713          	li	a4,13
    1680:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
    UART0->DATA = c;
    1684:	00a00713          	li	a4,10
    1688:	00e7a023          	sw	a4,0(a5)
    //print(" |_|   |_|\\___\\___/____/ \\___/ \\____|\n");
    //print("\n");
    print("           On Lichee Tang Nano-9K by Peter Glen\n");
    print("\n");

    for ( i = 0 ; i < 10000; i++);
    168c:	400007b7          	lui	a5,0x40000
    1690:	00478793          	addi	a5,a5,4 # 40000004 <i>
    1694:	0007a023          	sw	zero,0(a5)
    1698:	0007a683          	lw	a3,0(a5)
    169c:	00002737          	lui	a4,0x2
    16a0:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    16a4:	00d74c63          	blt	a4,a3,16bc <main+0x120>
    16a8:	0007a683          	lw	a3,0(a5)
    16ac:	00168693          	addi	a3,a3,1
    16b0:	00d7a023          	sw	a3,0(a5)
    16b4:	0007a683          	lw	a3,0(a5)
    16b8:	fed758e3          	bge	a4,a3,16a8 <main+0x10c>
    GPIO0->OUT = 0x3F ^ 0x01;
    16bc:	82000737          	lui	a4,0x82000
    16c0:	03e00693          	li	a3,62
    16c4:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    16c8:	0007a023          	sw	zero,0(a5)
    16cc:	0007a683          	lw	a3,0(a5)
    16d0:	00002737          	lui	a4,0x2
    16d4:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    16d8:	00d74c63          	blt	a4,a3,16f0 <main+0x154>
    16dc:	0007a683          	lw	a3,0(a5)
    16e0:	00168693          	addi	a3,a3,1
    16e4:	00d7a023          	sw	a3,0(a5)
    16e8:	0007a683          	lw	a3,0(a5)
    16ec:	fed758e3          	bge	a4,a3,16dc <main+0x140>
    GPIO0->OUT = 0x3F ^ 0x02;
    16f0:	82000737          	lui	a4,0x82000
    16f4:	03d00693          	li	a3,61
    16f8:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    16fc:	0007a023          	sw	zero,0(a5)
    1700:	0007a683          	lw	a3,0(a5)
    1704:	00002737          	lui	a4,0x2
    1708:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    170c:	00d74c63          	blt	a4,a3,1724 <main+0x188>
    1710:	0007a683          	lw	a3,0(a5)
    1714:	00168693          	addi	a3,a3,1
    1718:	00d7a023          	sw	a3,0(a5)
    171c:	0007a683          	lw	a3,0(a5)
    1720:	fed758e3          	bge	a4,a3,1710 <main+0x174>
    GPIO0->OUT = 0x3F ^ 0x04;
    1724:	82000737          	lui	a4,0x82000
    1728:	03b00693          	li	a3,59
    172c:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1730:	0007a023          	sw	zero,0(a5)
    1734:	0007a683          	lw	a3,0(a5)
    1738:	00002737          	lui	a4,0x2
    173c:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1740:	00d74c63          	blt	a4,a3,1758 <main+0x1bc>
    1744:	0007a683          	lw	a3,0(a5)
    1748:	00168693          	addi	a3,a3,1
    174c:	00d7a023          	sw	a3,0(a5)
    1750:	0007a683          	lw	a3,0(a5)
    1754:	fed758e3          	bge	a4,a3,1744 <main+0x1a8>
    GPIO0->OUT = 0x3F ^ 0x08;
    1758:	82000737          	lui	a4,0x82000
    175c:	03700693          	li	a3,55
    1760:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1764:	0007a023          	sw	zero,0(a5)
    1768:	0007a683          	lw	a3,0(a5)
    176c:	00002737          	lui	a4,0x2
    1770:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1774:	00d74c63          	blt	a4,a3,178c <main+0x1f0>
    1778:	0007a683          	lw	a3,0(a5)
    177c:	00168693          	addi	a3,a3,1
    1780:	00d7a023          	sw	a3,0(a5)
    1784:	0007a683          	lw	a3,0(a5)
    1788:	fed758e3          	bge	a4,a3,1778 <main+0x1dc>
    GPIO0->OUT = 0x3F ^ 0x10;
    178c:	82000737          	lui	a4,0x82000
    1790:	02f00693          	li	a3,47
    1794:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1798:	0007a023          	sw	zero,0(a5)
    179c:	0007a683          	lw	a3,0(a5)
    17a0:	00002737          	lui	a4,0x2
    17a4:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    17a8:	00d74c63          	blt	a4,a3,17c0 <main+0x224>
    17ac:	0007a683          	lw	a3,0(a5)
    17b0:	00168693          	addi	a3,a3,1
    17b4:	00d7a023          	sw	a3,0(a5)
    17b8:	0007a683          	lw	a3,0(a5)
    17bc:	fed758e3          	bge	a4,a3,17ac <main+0x210>
    GPIO0->OUT = 0x3F ^ 0x20;
    17c0:	82000737          	lui	a4,0x82000
    17c4:	01f00693          	li	a3,31
    17c8:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    17cc:	0007a023          	sw	zero,0(a5)
    17d0:	0007a683          	lw	a3,0(a5)
    17d4:	00002737          	lui	a4,0x2
    17d8:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    17dc:	00d74c63          	blt	a4,a3,17f4 <main+0x258>
    17e0:	0007a683          	lw	a3,0(a5)
    17e4:	00168693          	addi	a3,a3,1
    17e8:	00d7a023          	sw	a3,0(a5)
    17ec:	0007a683          	lw	a3,0(a5)
    17f0:	fed758e3          	bge	a4,a3,17e0 <main+0x244>
    GPIO0->OUT = 0x3F;
    17f4:	82000737          	lui	a4,0x82000
    17f8:	03f00693          	li	a3,63
    17fc:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1800:	0007a023          	sw	zero,0(a5)
    1804:	0007a683          	lw	a3,0(a5)
    1808:	00002737          	lui	a4,0x2
    180c:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1810:	00d74c63          	blt	a4,a3,1828 <main+0x28c>
    1814:	0007a683          	lw	a3,0(a5)
    1818:	00168693          	addi	a3,a3,1
    181c:	00d7a023          	sw	a3,0(a5)
    1820:	0007a683          	lw	a3,0(a5)
    1824:	fed758e3          	bge	a4,a3,1814 <main+0x278>
    GPIO0->OUT = 0x00;
    1828:	82000737          	lui	a4,0x82000
    182c:	00072023          	sw	zero,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1830:	0007a023          	sw	zero,0(a5)
    1834:	0007a683          	lw	a3,0(a5)
    1838:	00002737          	lui	a4,0x2
    183c:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1840:	00d74c63          	blt	a4,a3,1858 <main+0x2bc>
    1844:	0007a683          	lw	a3,0(a5)
    1848:	00168693          	addi	a3,a3,1
    184c:	00d7a023          	sw	a3,0(a5)
    1850:	0007a683          	lw	a3,0(a5)
    1854:	fed758e3          	bge	a4,a3,1844 <main+0x2a8>
    GPIO0->OUT = 0x3F;
    1858:	82000737          	lui	a4,0x82000
    185c:	03f00693          	li	a3,63
    1860:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1864:	0007a023          	sw	zero,0(a5)
    1868:	0007a683          	lw	a3,0(a5)
    186c:	00002737          	lui	a4,0x2
    1870:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1874:	00d74c63          	blt	a4,a3,188c <main+0x2f0>
    1878:	0007a683          	lw	a3,0(a5)
    187c:	00168693          	addi	a3,a3,1
    1880:	00d7a023          	sw	a3,0(a5)
    1884:	0007a683          	lw	a3,0(a5)
    1888:	fed758e3          	bge	a4,a3,1878 <main+0x2dc>
    188c:	000039b7          	lui	s3,0x3
    1890:	9d198793          	addi	a5,s3,-1583 # 29d1 <irqCallback+0xbd>
    1894:	00f12a23          	sw	a5,20(sp)
    1898:	000037b7          	lui	a5,0x3
    189c:	a0578793          	addi	a5,a5,-1531 # 2a05 <irqCallback+0xf1>
    18a0:	00f12c23          	sw	a5,24(sp)
    18a4:	000037b7          	lui	a5,0x3
    18a8:	a1d78793          	addi	a5,a5,-1507 # 2a1d <irqCallback+0x109>
    18ac:	00f12e23          	sw	a5,28(sp)
    18b0:	000037b7          	lui	a5,0x3
    18b4:	a3578793          	addi	a5,a5,-1483 # 2a35 <irqCallback+0x121>
    18b8:	02f12023          	sw	a5,32(sp)
    18bc:	000037b7          	lui	a5,0x3
    18c0:	a4d78793          	addi	a5,a5,-1459 # 2a4d <irqCallback+0x139>
    18c4:	02f12223          	sw	a5,36(sp)
    18c8:	000037b7          	lui	a5,0x3
    18cc:	a6578793          	addi	a5,a5,-1435 # 2a65 <irqCallback+0x151>
    18d0:	02f12a23          	sw	a5,52(sp)
    18d4:	000037b7          	lui	a5,0x3
    18d8:	a7d78793          	addi	a5,a5,-1411 # 2a7d <irqCallback+0x169>
    18dc:	02f12c23          	sw	a5,56(sp)
    18e0:	000037b7          	lui	a5,0x3
    18e4:	a9578793          	addi	a5,a5,-1387 # 2a95 <irqCallback+0x181>
    18e8:	02f12e23          	sw	a5,60(sp)
    18ec:	000037b7          	lui	a5,0x3
    18f0:	aad78793          	addi	a5,a5,-1363 # 2aad <irqCallback+0x199>
    18f4:	04f12023          	sw	a5,64(sp)
    18f8:	000037b7          	lui	a5,0x3
    18fc:	ac978793          	addi	a5,a5,-1335 # 2ac9 <irqCallback+0x1b5>
    1900:	04f12223          	sw	a5,68(sp)
    1904:	000037b7          	lui	a5,0x3
    1908:	ae578793          	addi	a5,a5,-1307 # 2ae5 <irqCallback+0x1d1>
    190c:	04f12423          	sw	a5,72(sp)
    1910:	000037b7          	lui	a5,0x3
    1914:	afd78793          	addi	a5,a5,-1283 # 2afd <irqCallback+0x1e9>
    1918:	04f12623          	sw	a5,76(sp)
    191c:	000037b7          	lui	a5,0x3
    1920:	b1978793          	addi	a5,a5,-1255 # 2b19 <irqCallback+0x205>
    1924:	04f12823          	sw	a5,80(sp)
    1928:	000037b7          	lui	a5,0x3
    192c:	b4578793          	addi	a5,a5,-1211 # 2b45 <irqCallback+0x231>
    1930:	04f12a23          	sw	a5,84(sp)
    1934:	000037b7          	lui	a5,0x3
    1938:	b8978793          	addi	a5,a5,-1143 # 2b89 <irqCallback+0x275>
    193c:	000034b7          	lui	s1,0x3
    1940:	04f12c23          	sw	a5,88(sp)
    1944:	b9148793          	addi	a5,s1,-1135 # 2b91 <irqCallback+0x27d>
    1948:	00f12623          	sw	a5,12(sp)
    194c:	000037b7          	lui	a5,0x3
    1950:	b9d78793          	addi	a5,a5,-1123 # 2b9d <irqCallback+0x289>
    1954:	04f12e23          	sw	a5,92(sp)
    1958:	000037b7          	lui	a5,0x3
    195c:	92d78793          	addi	a5,a5,-1747 # 292d <irqCallback+0x19>
    1960:	02f12423          	sw	a5,40(sp)
    1964:	000037b7          	lui	a5,0x3
    1968:	93978793          	addi	a5,a5,-1735 # 2939 <irqCallback+0x25>
    196c:	02f12623          	sw	a5,44(sp)
    1970:	000037b7          	lui	a5,0x3
    1974:	94578793          	addi	a5,a5,-1723 # 2945 <irqCallback+0x31>
        QSPI0->REG &= ~QSPI_REG_CRM;
    1978:	fff00437          	lui	s0,0xfff00
    197c:	00003fb7          	lui	t6,0x3
    1980:	00003c37          	lui	s8,0x3
    1984:	00003cb7          	lui	s9,0x3
    1988:	00003d37          	lui	s10,0x3
    198c:	000032b7          	lui	t0,0x3
    1990:	00003937          	lui	s2,0x3
    1994:	02f12823          	sw	a5,48(sp)
    1998:	00003eb7          	lui	t4,0x3
    199c:	fff40793          	addi	a5,s0,-1 # ffefffff <__global_pointer$+0xbfeff7ff>
    19a0:	9e5f8f93          	addi	t6,t6,-1563 # 29e5 <irqCallback+0xd1>
    19a4:	918c0c13          	addi	s8,s8,-1768 # 2918 <irqCallback+0x4>
    19a8:	b71c8c93          	addi	s9,s9,-1167 # 2b71 <irqCallback+0x25d>
    19ac:	ba4d0d13          	addi	s10,s10,-1116 # 2ba4 <irqCallback+0x290>
    19b0:	b7d28293          	addi	t0,t0,-1155 # 2b7d <irqCallback+0x269>
    19b4:	b9590913          	addi	s2,s2,-1131 # 2b95 <irqCallback+0x281>
    19b8:	b65e8493          	addi	s1,t4,-1179 # 2b65 <irqCallback+0x251>
        UART0->DATA = '\r';
    19bc:	83000ab7          	lui	s5,0x83000
    19c0:	00d00b93          	li	s7,13
    UART0->DATA = c;
    19c4:	00a00b13          	li	s6,10
    19c8:	02000993          	li	s3,32
        QSPI0->REG &= ~QSPI_REG_CRM;
    19cc:	00f12823          	sw	a5,16(sp)
        UART0->DATA = '\r';
    19d0:	00d00793          	li	a5,13
    19d4:	00faa023          	sw	a5,0(s5) # 83000000 <__global_pointer$+0x42fff800>
        putchar(*(p++));
    19d8:	01412703          	lw	a4,20(sp)
    UART0->DATA = c;
    19dc:	05300793          	li	a5,83
    19e0:	016aa023          	sw	s6,0(s5)
    19e4:	00faa023          	sw	a5,0(s5)
    while (*p)
    19e8:	06500793          	li	a5,101
        putchar(*(p++));
    19ec:	00170713          	addi	a4,a4,1
    if (c == '\n')
    19f0:	35678ce3          	beq	a5,s6,2548 <main+0xfac>
    UART0->DATA = c;
    19f4:	00faa023          	sw	a5,0(s5)
    while (*p)
    19f8:	00074783          	lbu	a5,0(a4)
    19fc:	fe0798e3          	bnez	a5,19ec <main+0x450>
        UART0->DATA = '\r';
    1a00:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1a04:	016aa023          	sw	s6,0(s5)
    1a08:	013aa023          	sw	s3,0(s5)
        putchar(*(p++));
    1a0c:	000f8713          	mv	a4,t6
    while (*p)
    1a10:	02000793          	li	a5,32
        putchar(*(p++));
    1a14:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a18:	31678ee3          	beq	a5,s6,2534 <main+0xf98>
    UART0->DATA = c;
    1a1c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a20:	00074783          	lbu	a5,0(a4)
    1a24:	fe0798e3          	bnez	a5,1a14 <main+0x478>
        putchar(*(p++));
    1a28:	01812703          	lw	a4,24(sp)
    UART0->DATA = c;
    1a2c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a30:	02000793          	li	a5,32
        putchar(*(p++));
    1a34:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a38:	2f6784e3          	beq	a5,s6,2520 <main+0xf84>
    UART0->DATA = c;
    1a3c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a40:	00074783          	lbu	a5,0(a4)
    1a44:	fe0798e3          	bnez	a5,1a34 <main+0x498>
        putchar(*(p++));
    1a48:	01c12703          	lw	a4,28(sp)
    UART0->DATA = c;
    1a4c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a50:	02000793          	li	a5,32
        putchar(*(p++));
    1a54:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a58:	2b678ae3          	beq	a5,s6,250c <main+0xf70>
    UART0->DATA = c;
    1a5c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a60:	00074783          	lbu	a5,0(a4)
    1a64:	fe0798e3          	bnez	a5,1a54 <main+0x4b8>
        putchar(*(p++));
    1a68:	02012703          	lw	a4,32(sp)
    UART0->DATA = c;
    1a6c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a70:	02000793          	li	a5,32
        putchar(*(p++));
    1a74:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a78:	296780e3          	beq	a5,s6,24f8 <main+0xf5c>
    UART0->DATA = c;
    1a7c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a80:	00074783          	lbu	a5,0(a4)
    1a84:	fe0798e3          	bnez	a5,1a74 <main+0x4d8>
        putchar(*(p++));
    1a88:	02412703          	lw	a4,36(sp)
    UART0->DATA = c;
    1a8c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a90:	02000793          	li	a5,32
        putchar(*(p++));
    1a94:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a98:	256786e3          	beq	a5,s6,24e4 <main+0xf48>
    UART0->DATA = c;
    1a9c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1aa0:	00074783          	lbu	a5,0(a4)
    1aa4:	fe0798e3          	bnez	a5,1a94 <main+0x4f8>
        putchar(*(p++));
    1aa8:	03412703          	lw	a4,52(sp)
    UART0->DATA = c;
    1aac:	013aa023          	sw	s3,0(s5)
    while (*p)
    1ab0:	02000793          	li	a5,32
        putchar(*(p++));
    1ab4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1ab8:	21678ce3          	beq	a5,s6,24d0 <main+0xf34>
    UART0->DATA = c;
    1abc:	00faa023          	sw	a5,0(s5)
    while (*p)
    1ac0:	00074783          	lbu	a5,0(a4)
    1ac4:	fe0798e3          	bnez	a5,1ab4 <main+0x518>
        putchar(*(p++));
    1ac8:	03812703          	lw	a4,56(sp)
    UART0->DATA = c;
    1acc:	013aa023          	sw	s3,0(s5)
    while (*p)
    1ad0:	02000793          	li	a5,32
        putchar(*(p++));
    1ad4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1ad8:	1f6782e3          	beq	a5,s6,24bc <main+0xf20>
    UART0->DATA = c;
    1adc:	00faa023          	sw	a5,0(s5)
    while (*p)
    1ae0:	00074783          	lbu	a5,0(a4)
    1ae4:	fe0798e3          	bnez	a5,1ad4 <main+0x538>
        putchar(*(p++));
    1ae8:	03c12703          	lw	a4,60(sp)
    UART0->DATA = c;
    1aec:	013aa023          	sw	s3,0(s5)
    while (*p)
    1af0:	02000793          	li	a5,32
        putchar(*(p++));
    1af4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1af8:	1b6788e3          	beq	a5,s6,24a8 <main+0xf0c>
    UART0->DATA = c;
    1afc:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b00:	00074783          	lbu	a5,0(a4)
    1b04:	fe0798e3          	bnez	a5,1af4 <main+0x558>
        putchar(*(p++));
    1b08:	04012703          	lw	a4,64(sp)
    UART0->DATA = c;
    1b0c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b10:	02000793          	li	a5,32
        putchar(*(p++));
    1b14:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b18:	17678ee3          	beq	a5,s6,2494 <main+0xef8>
    UART0->DATA = c;
    1b1c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b20:	00074783          	lbu	a5,0(a4)
    1b24:	fe0798e3          	bnez	a5,1b14 <main+0x578>
        putchar(*(p++));
    1b28:	04412703          	lw	a4,68(sp)
    UART0->DATA = c;
    1b2c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b30:	02000793          	li	a5,32
        putchar(*(p++));
    1b34:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b38:	156784e3          	beq	a5,s6,2480 <main+0xee4>
    UART0->DATA = c;
    1b3c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b40:	00074783          	lbu	a5,0(a4)
    1b44:	fe0798e3          	bnez	a5,1b34 <main+0x598>
        putchar(*(p++));
    1b48:	04812703          	lw	a4,72(sp)
    UART0->DATA = c;
    1b4c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b50:	02000793          	li	a5,32
        putchar(*(p++));
    1b54:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b58:	11678ae3          	beq	a5,s6,246c <main+0xed0>
    UART0->DATA = c;
    1b5c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b60:	00074783          	lbu	a5,0(a4)
    1b64:	fe0798e3          	bnez	a5,1b54 <main+0x5b8>
        putchar(*(p++));
    1b68:	04c12703          	lw	a4,76(sp)
    UART0->DATA = c;
    1b6c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b70:	02000793          	li	a5,32
        putchar(*(p++));
    1b74:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b78:	0f6780e3          	beq	a5,s6,2458 <main+0xebc>
    UART0->DATA = c;
    1b7c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b80:	00074783          	lbu	a5,0(a4)
    1b84:	fe0798e3          	bnez	a5,1b74 <main+0x5d8>
        putchar(*(p++));
    1b88:	05012703          	lw	a4,80(sp)
    UART0->DATA = c;
    1b8c:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b90:	02000793          	li	a5,32
        putchar(*(p++));
    1b94:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b98:	0b6786e3          	beq	a5,s6,2444 <main+0xea8>
    UART0->DATA = c;
    1b9c:	00faa023          	sw	a5,0(s5)
    while (*p)
    1ba0:	00074783          	lbu	a5,0(a4)
    1ba4:	fe0798e3          	bnez	a5,1b94 <main+0x5f8>
        putchar(*(p++));
    1ba8:	05412703          	lw	a4,84(sp)
    UART0->DATA = c;
    1bac:	013aa023          	sw	s3,0(s5)
    while (*p)
    1bb0:	02000793          	li	a5,32
        putchar(*(p++));
    1bb4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1bb8:	07678ce3          	beq	a5,s6,2430 <main+0xe94>
    UART0->DATA = c;
    1bbc:	00faa023          	sw	a5,0(s5)
    while (*p)
    1bc0:	00074783          	lbu	a5,0(a4)
    1bc4:	fe0798e3          	bnez	a5,1bb4 <main+0x618>
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1bc8:	ffc00437          	lui	s0,0xffc00
    while (*p)
    1bcc:	00a00a13          	li	s4,10
    UART0->DATA = c;
    1bd0:	04900d93          	li	s11,73
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1bd4:	fff40413          	addi	s0,s0,-1 # ffbfffff <__global_pointer$+0xbfbff7ff>
        UART0->DATA = '\r';
    1bd8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1bdc:	016aa023          	sw	s6,0(s5)
    1be0:	01baa023          	sw	s11,0(s5)
        putchar(*(p++));
    1be4:	00048713          	mv	a4,s1
    while (*p)
    1be8:	04f00793          	li	a5,79
        putchar(*(p++));
    1bec:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1bf0:	75678863          	beq	a5,s6,2340 <main+0xda4>
    UART0->DATA = c;
    1bf4:	00faa023          	sw	a5,0(s5)
    while (*p)
    1bf8:	00074783          	lbu	a5,0(a4)
    1bfc:	fe0798e3          	bnez	a5,1bec <main+0x650>

        for (int rep = 10; rep > 0; rep--)
        {
            print("\n");
            print("IO State: ");
            print_hex(GPIO0->IN, 8);
    1c00:	820007b7          	lui	a5,0x82000
    1c04:	0047a783          	lw	a5,4(a5) # 82000004 <__global_pointer$+0x41fff804>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c08:	01c7d713          	srli	a4,a5,0x1c
    1c0c:	00ec0733          	add	a4,s8,a4
    1c10:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    1c14:	75660a63          	beq	a2,s6,2368 <main+0xdcc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c18:	0187d713          	srli	a4,a5,0x18
    1c1c:	00f77713          	andi	a4,a4,15
    1c20:	00ec0733          	add	a4,s8,a4
    1c24:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    1c28:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    1c2c:	75668c63          	beq	a3,s6,2384 <main+0xde8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c30:	0147d713          	srli	a4,a5,0x14
    1c34:	00f77713          	andi	a4,a4,15
    1c38:	00ec0733          	add	a4,s8,a4
    1c3c:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    1c40:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1c44:	75660e63          	beq	a2,s6,23a0 <main+0xe04>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c48:	0107d713          	srli	a4,a5,0x10
    1c4c:	00f77713          	andi	a4,a4,15
    1c50:	00ec0733          	add	a4,s8,a4
    1c54:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    1c58:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    1c5c:	77668063          	beq	a3,s6,23bc <main+0xe20>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c60:	00c7d713          	srli	a4,a5,0xc
    1c64:	00f77713          	andi	a4,a4,15
    1c68:	00ec0733          	add	a4,s8,a4
    1c6c:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    1c70:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1c74:	77660263          	beq	a2,s6,23d8 <main+0xe3c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c78:	0087d713          	srli	a4,a5,0x8
    1c7c:	00f77713          	andi	a4,a4,15
    1c80:	00ec0733          	add	a4,s8,a4
    1c84:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    1c88:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    1c8c:	77668463          	beq	a3,s6,23f4 <main+0xe58>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c90:	0047d713          	srli	a4,a5,0x4
    1c94:	00f77713          	andi	a4,a4,15
    1c98:	00ec0733          	add	a4,s8,a4
    1c9c:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    1ca0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1ca4:	77670663          	beq	a4,s6,2410 <main+0xe74>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1ca8:	00f7f793          	andi	a5,a5,15
    1cac:	00fc07b3          	add	a5,s8,a5
    1cb0:	0007c783          	lbu	a5,0(a5)
    UART0->DATA = c;
    1cb4:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    1cb8:	77678863          	beq	a5,s6,2428 <main+0xe8c>
    UART0->DATA = c;
    1cbc:	00faa023          	sw	a5,0(s5)
        UART0->DATA = '\r';
    1cc0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1cc4:	016aa023          	sw	s6,0(s5)
        UART0->DATA = '\r';
    1cc8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1ccc:	04300793          	li	a5,67
    1cd0:	016aa023          	sw	s6,0(s5)
    1cd4:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1cd8:	000c8713          	mv	a4,s9
    while (*p)
    1cdc:	06f00793          	li	a5,111
        putchar(*(p++));
    1ce0:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1ce4:	65678463          	beq	a5,s6,232c <main+0xd90>
    UART0->DATA = c;
    1ce8:	00faa023          	sw	a5,0(s5)
    while (*p)
    1cec:	00074783          	lbu	a5,0(a4)
    1cf0:	fe0798e3          	bnez	a5,1ce0 <main+0x744>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
    1cf4:	c00027f3          	rdcycle	a5
    while (c == -1) {
    1cf8:	fff00713          	li	a4,-1
        __asm__ volatile ("rdcycle %0" : "=r"(cycles_now));
    1cfc:	c00027f3          	rdcycle	a5
        c = UART0->DATA;
    1d00:	000aa783          	lw	a5,0(s5)
    while (c == -1) {
    1d04:	fee78ce3          	beq	a5,a4,1cfc <main+0x760>
            print("\n");
            print("\n");

            print("Command> ");
            char cmd = getchar();
            if (cmd > 32 && cmd < 127)
    1d08:	fdf78713          	addi	a4,a5,-33
    1d0c:	0ff77713          	andi	a4,a4,255
    1d10:	05d00693          	li	a3,93
    1d14:	0ff7f793          	andi	a5,a5,255
    1d18:	00e6e663          	bltu	a3,a4,1d24 <main+0x788>
    if (c == '\n')
    1d1c:	57678063          	beq	a5,s6,227c <main+0xce0>
    UART0->DATA = c;
    1d20:	00faa023          	sw	a5,0(s5)
        UART0->DATA = '\r';
    1d24:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1d28:	016aa023          	sw	s6,0(s5)
                putchar(cmd);
            print("\n");

            switch (cmd)
    1d2c:	fcf78793          	addi	a5,a5,-49
    1d30:	04200713          	li	a4,66
    1d34:	06f76063          	bltu	a4,a5,1d94 <main+0x7f8>
    1d38:	00279793          	slli	a5,a5,0x2
    1d3c:	00fd07b3          	add	a5,s10,a5
    1d40:	0007a783          	lw	a5,0(a5)
    1d44:	00078067          	jr	a5
        UART0->DATA = '\r';
    1d48:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1d4c:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1d50:	00074783          	lbu	a5,0(a4)
    1d54:	8c079ce3          	bnez	a5,162c <main+0x90>
    1d58:	8e9ff06f          	j	1640 <main+0xa4>
        UART0->DATA = '\r';
    1d5c:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1d60:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1d64:	00074783          	lbu	a5,0(a4)
    1d68:	8e079ee3          	bnez	a5,1664 <main+0xc8>
    1d6c:	90dff06f          	j	1678 <main+0xdc>
        QSPI0->REG &= ~QSPI_REG_CRM;
    1d70:	810007b7          	lui	a5,0x81000
    1d74:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1d78:	01012683          	lw	a3,16(sp)
    1d7c:	00d77733          	and	a4,a4,a3
        QSPI0->REG |= QSPI_REG_CRM;
    1d80:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG |= QSPI_REG_DSPI;
    1d84:	0007a703          	lw	a4,0(a5)
    1d88:	004006b7          	lui	a3,0x400
    1d8c:	00d76733          	or	a4,a4,a3
    1d90:	00e7a023          	sw	a4,0(a5)
        for (int rep = 10; rep > 0; rep--)
    1d94:	fffa0a13          	addi	s4,s4,-1
    1d98:	e40a10e3          	bnez	s4,1bd8 <main+0x63c>
    1d9c:	c35ff06f          	j	19d0 <main+0x434>
        UART0->DATA = '\r';
    1da0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1da4:	05300793          	li	a5,83
    1da8:	016aa023          	sw	s6,0(s5)
    1dac:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1db0:	00028713          	mv	a4,t0
    while (*p)
    1db4:	05000793          	li	a5,80
        putchar(*(p++));
    1db8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1dbc:	336788e3          	beq	a5,s6,28ec <main+0x1350>
    UART0->DATA = c;
    1dc0:	00faa023          	sw	a5,0(s5)
    while (*p)
    1dc4:	00074783          	lbu	a5,0(a4)
    1dc8:	fe0798e3          	bnez	a5,1db8 <main+0x81c>
        putchar(*(p++));
    1dcc:	05812703          	lw	a4,88(sp)
    UART0->DATA = c;
    1dd0:	013aa023          	sw	s3,0(s5)
    while (*p)
    1dd4:	02000793          	li	a5,32
        putchar(*(p++));
    1dd8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1ddc:	2b6786e3          	beq	a5,s6,2888 <main+0x12ec>
    UART0->DATA = c;
    1de0:	00faa023          	sw	a5,0(s5)
    while (*p)
    1de4:	00074783          	lbu	a5,0(a4)
    1de8:	fe0798e3          	bnez	a5,1dd8 <main+0x83c>
    return QSPI0->REG & QSPI_REG_DSPI;
    1dec:	810007b7          	lui	a5,0x81000
    1df0:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1df4:	00400737          	lui	a4,0x400
    1df8:	00e7f7b3          	and	a5,a5,a4
            case 'F':
            case 'f':
                print("\n");
                print("SPI State:\n");
                print("  DSPI ");
                if ( cmd_get_dspi() )
    1dfc:	2a0798e3          	bnez	a5,28ac <main+0x1310>
    UART0->DATA = c;
    1e00:	04f00793          	li	a5,79
    1e04:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1e08:	00090713          	mv	a4,s2
    while (*p)
    1e0c:	04600793          	li	a5,70
        putchar(*(p++));
    1e10:	00170713          	addi	a4,a4,1 # 400001 <_etext+0x3fd351>
    if (c == '\n')
    1e14:	2f6786e3          	beq	a5,s6,2900 <main+0x1364>
    UART0->DATA = c;
    1e18:	00faa023          	sw	a5,0(s5)
    while (*p)
    1e1c:	00074783          	lbu	a5,0(a4)
    1e20:	fe0798e3          	bnez	a5,1e10 <main+0x874>
        putchar(*(p++));
    1e24:	05c12703          	lw	a4,92(sp)
    UART0->DATA = c;
    1e28:	013aa023          	sw	s3,0(s5)
    while (*p)
    1e2c:	02000793          	li	a5,32
        putchar(*(p++));
    1e30:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1e34:	73678463          	beq	a5,s6,255c <main+0xfc0>
    UART0->DATA = c;
    1e38:	00faa023          	sw	a5,0(s5)
    while (*p)
    1e3c:	00074783          	lbu	a5,0(a4)
    1e40:	fe0798e3          	bnez	a5,1e30 <main+0x894>
    return QSPI0->REG & QSPI_REG_CRM;
    1e44:	810007b7          	lui	a5,0x81000
    1e48:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1e4c:	00100737          	lui	a4,0x100
    1e50:	00e7f7b3          	and	a5,a5,a4
                    print("ON\n");
                else
                    print("OFF\n");
                print("  CRM  ");
                if ( cmd_get_crm() )
    1e54:	72079663          	bnez	a5,2580 <main+0xfe4>
    UART0->DATA = c;
    1e58:	04f00793          	li	a5,79
    1e5c:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1e60:	00090713          	mv	a4,s2
    while (*p)
    1e64:	04600793          	li	a5,70
        putchar(*(p++));
    1e68:	00170713          	addi	a4,a4,1 # 100001 <_etext+0xfd351>
    if (c == '\n')
    1e6c:	01678c63          	beq	a5,s6,1e84 <main+0x8e8>
    UART0->DATA = c;
    1e70:	00faa023          	sw	a5,0(s5)
    while (*p)
    1e74:	00074783          	lbu	a5,0(a4)
    1e78:	f0078ee3          	beqz	a5,1d94 <main+0x7f8>
        putchar(*(p++));
    1e7c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1e80:	ff6798e3          	bne	a5,s6,1e70 <main+0x8d4>
        UART0->DATA = '\r';
    1e84:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1e88:	00faa023          	sw	a5,0(s5)
    while (*p)
    1e8c:	00074783          	lbu	a5,0(a4)
    1e90:	fc079ce3          	bnez	a5,1e68 <main+0x8cc>
        for (int rep = 10; rep > 0; rep--)
    1e94:	fffa0a13          	addi	s4,s4,-1
    1e98:	d40a10e3          	bnez	s4,1bd8 <main+0x63c>
    1e9c:	b35ff06f          	j	19d0 <main+0x434>
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1ea0:	810007b7          	lui	a5,0x81000
    1ea4:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
        QSPI0->REG &= ~QSPI_REG_CRM;
    1ea8:	01012683          	lw	a3,16(sp)
        for (int rep = 10; rep > 0; rep--)
    1eac:	fffa0a13          	addi	s4,s4,-1
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1eb0:	00877733          	and	a4,a4,s0
    1eb4:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG &= ~QSPI_REG_CRM;
    1eb8:	0007a703          	lw	a4,0(a5)
    1ebc:	00d77733          	and	a4,a4,a3
    1ec0:	00e7a023          	sw	a4,0(a5)
        for (int rep = 10; rep > 0; rep--)
    1ec4:	d00a1ae3          	bnez	s4,1bd8 <main+0x63c>
    1ec8:	b09ff06f          	j	19d0 <main+0x434>

                break;

            case 'I':
            case 'i':
                cmd_read_flash_id();
    1ecc:	a68fe0ef          	jal	ra,134 <cmd_read_flash_id>
                break;
    1ed0:	000037b7          	lui	a5,0x3
    1ed4:	9e578f93          	addi	t6,a5,-1563 # 29e5 <irqCallback+0xd1>
        for (int rep = 10; rep > 0; rep--)
    1ed8:	fffa0a13          	addi	s4,s4,-1
                break;
    1edc:	000037b7          	lui	a5,0x3
    1ee0:	b7d78293          	addi	t0,a5,-1155 # 2b7d <irqCallback+0x269>
        for (int rep = 10; rep > 0; rep--)
    1ee4:	ce0a1ae3          	bnez	s4,1bd8 <main+0x63c>
    1ee8:	ae9ff06f          	j	19d0 <main+0x434>
        QSPI0->REG |= QSPI_REG_CRM;
    1eec:	810007b7          	lui	a5,0x81000
    1ef0:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1ef4:	001006b7          	lui	a3,0x100
    1ef8:	00d76733          	or	a4,a4,a3
    1efc:	e85ff06f          	j	1d80 <main+0x7e4>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
    1f00:	c0002e73          	rdcycle	t3
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
    1f04:	c0202373          	rdinstret	t1
    uint32_t x32 = 314159265;
    1f08:	12b9b7b7          	lui	a5,0x12b9b
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
    1f0c:	01400893          	li	a7,20
    uint32_t x32 = 314159265;
    1f10:	0a178793          	addi	a5,a5,161 # 12b9b0a1 <_etext+0x12b983f1>
    1f14:	16010513          	addi	a0,sp,352
        for (int k = 0, p = 0; k < 256; k++)
    1f18:	10000813          	li	a6,256
        for (int k = 0; k < 256; k++)
    1f1c:	06010613          	addi	a2,sp,96
    while (*p)
    1f20:	00060693          	mv	a3,a2
    1f24:	00078713          	mv	a4,a5
            x32 ^= x32 << 13;
    1f28:	00d71793          	slli	a5,a4,0xd
    1f2c:	00e7c7b3          	xor	a5,a5,a4
            x32 ^= x32 >> 17;
    1f30:	0117d713          	srli	a4,a5,0x11
    1f34:	00e7c7b3          	xor	a5,a5,a4
            x32 ^= x32 << 5;
    1f38:	00579713          	slli	a4,a5,0x5
    1f3c:	00e7c733          	xor	a4,a5,a4
            data[k] = x32;
    1f40:	00e68023          	sb	a4,0(a3) # 100000 <_etext+0xfd350>
        for (int k = 0; k < 256; k++)
    1f44:	00168693          	addi	a3,a3,1
    1f48:	fed510e3          	bne	a0,a3,1f28 <main+0x98c>
    1f4c:	00070793          	mv	a5,a4
    1f50:	06010693          	addi	a3,sp,96
        for (int k = 0, p = 0; k < 256; k++)
    1f54:	00000e93          	li	t4,0
    1f58:	00000713          	li	a4,0
            if (data[k])
    1f5c:	0006c583          	lbu	a1,0(a3)
    1f60:	00058a63          	beqz	a1,1f74 <main+0x9d8>
                data[p++] = k;
    1f64:	16010593          	addi	a1,sp,352
    1f68:	01d585b3          	add	a1,a1,t4
    1f6c:	f0e58023          	sb	a4,-256(a1)
    1f70:	001e8e93          	addi	t4,t4,1
        for (int k = 0, p = 0; k < 256; k++)
    1f74:	00170713          	addi	a4,a4,1
    1f78:	00168693          	addi	a3,a3,1
    1f7c:	ff0710e3          	bne	a4,a6,1f5c <main+0x9c0>
            x32 = x32 ^ words[k];
    1f80:	00062703          	lw	a4,0(a2) # 400000 <_etext+0x3fd350>
        for (int k = 0, p = 0; k < 64; k++)
    1f84:	00460613          	addi	a2,a2,4
            x32 = x32 ^ words[k];
    1f88:	00e7c7b3          	xor	a5,a5,a4
        for (int k = 0, p = 0; k < 64; k++)
    1f8c:	fec51ae3          	bne	a0,a2,1f80 <main+0x9e4>
    for (int i = 0; i < 20; i++)
    1f90:	fff88893          	addi	a7,a7,-1
    1f94:	f80894e3          	bnez	a7,1f1c <main+0x980>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_end));
    1f98:	c00025f3          	rdcycle	a1
    __asm__ volatile ("rdinstret %0" : "=r"(instns_end));
    1f9c:	c0202673          	rdinstret	a2
        putchar(*(p++));
    1fa0:	02812683          	lw	a3,40(sp)
    UART0->DATA = c;
    1fa4:	04300713          	li	a4,67
    1fa8:	00eaa023          	sw	a4,0(s5)
    while (*p)
    1fac:	07900713          	li	a4,121
        putchar(*(p++));
    1fb0:	00168693          	addi	a3,a3,1
    if (c == '\n')
    1fb4:	61670a63          	beq	a4,s6,25c8 <main+0x102c>
    UART0->DATA = c;
    1fb8:	00eaa023          	sw	a4,0(s5)
    while (*p)
    1fbc:	0006c703          	lbu	a4,0(a3)
    1fc0:	fe0718e3          	bnez	a4,1fb0 <main+0xa14>
        print_hex(cycles_end - cycles_begin, 8);
    1fc4:	41c58e33          	sub	t3,a1,t3
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1fc8:	01ce5713          	srli	a4,t3,0x1c
    1fcc:	00ec0733          	add	a4,s8,a4
    1fd0:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    1fd4:	61668c63          	beq	a3,s6,25ec <main+0x1050>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1fd8:	018e5713          	srli	a4,t3,0x18
    1fdc:	00f77713          	andi	a4,a4,15
    1fe0:	00ec0733          	add	a4,s8,a4
    1fe4:	00074583          	lbu	a1,0(a4)
    UART0->DATA = c;
    1fe8:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1fec:	61658e63          	beq	a1,s6,2608 <main+0x106c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1ff0:	014e5713          	srli	a4,t3,0x14
    1ff4:	00f77713          	andi	a4,a4,15
    1ff8:	00ec0733          	add	a4,s8,a4
    1ffc:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2000:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2004:	63668063          	beq	a3,s6,2624 <main+0x1088>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2008:	010e5713          	srli	a4,t3,0x10
    200c:	00f77713          	andi	a4,a4,15
    2010:	00ec0733          	add	a4,s8,a4
    2014:	00074583          	lbu	a1,0(a4)
    UART0->DATA = c;
    2018:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    201c:	63658263          	beq	a1,s6,2640 <main+0x10a4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2020:	00ce5713          	srli	a4,t3,0xc
    2024:	00f77713          	andi	a4,a4,15
    2028:	00ec0733          	add	a4,s8,a4
    202c:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2030:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2034:	63668463          	beq	a3,s6,265c <main+0x10c0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2038:	008e5713          	srli	a4,t3,0x8
    203c:	00f77713          	andi	a4,a4,15
    2040:	00ec0733          	add	a4,s8,a4
    2044:	00074583          	lbu	a1,0(a4)
    UART0->DATA = c;
    2048:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    204c:	63658663          	beq	a1,s6,2678 <main+0x10dc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2050:	004e5713          	srli	a4,t3,0x4
    2054:	00f77713          	andi	a4,a4,15
    2058:	00ec0733          	add	a4,s8,a4
    205c:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2060:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2064:	63668863          	beq	a3,s6,2694 <main+0x10f8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2068:	00fe7e13          	andi	t3,t3,15
    206c:	01cc0733          	add	a4,s8,t3
    2070:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    2074:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2078:	63670a63          	beq	a4,s6,26ac <main+0x1110>
    UART0->DATA = c;
    207c:	00eaa023          	sw	a4,0(s5)
        UART0->DATA = '\r';
    2080:	017aa023          	sw	s7,0(s5)
        putchar(*(p++));
    2084:	02c12683          	lw	a3,44(sp)
    UART0->DATA = c;
    2088:	016aa023          	sw	s6,0(s5)
    208c:	01baa023          	sw	s11,0(s5)
    while (*p)
    2090:	06e00713          	li	a4,110
        putchar(*(p++));
    2094:	00168693          	addi	a3,a3,1
    if (c == '\n')
    2098:	61670e63          	beq	a4,s6,26b4 <main+0x1118>
    UART0->DATA = c;
    209c:	00eaa023          	sw	a4,0(s5)
    while (*p)
    20a0:	0006c703          	lbu	a4,0(a3)
    20a4:	fe0718e3          	bnez	a4,2094 <main+0xaf8>
        print_hex(instns_end - instns_begin, 8);
    20a8:	40660333          	sub	t1,a2,t1
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20ac:	01c35713          	srli	a4,t1,0x1c
    20b0:	00ec0733          	add	a4,s8,a4
    20b4:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    20b8:	63668063          	beq	a3,s6,26d8 <main+0x113c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20bc:	01835713          	srli	a4,t1,0x18
    20c0:	00f77713          	andi	a4,a4,15
    20c4:	00ec0733          	add	a4,s8,a4
    20c8:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    20cc:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    20d0:	63660263          	beq	a2,s6,26f4 <main+0x1158>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20d4:	01435713          	srli	a4,t1,0x14
    20d8:	00f77713          	andi	a4,a4,15
    20dc:	00ec0733          	add	a4,s8,a4
    20e0:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    20e4:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    20e8:	63668463          	beq	a3,s6,2710 <main+0x1174>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20ec:	01035713          	srli	a4,t1,0x10
    20f0:	00f77713          	andi	a4,a4,15
    20f4:	00ec0733          	add	a4,s8,a4
    20f8:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    20fc:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2100:	63660663          	beq	a2,s6,272c <main+0x1190>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2104:	00c35713          	srli	a4,t1,0xc
    2108:	00f77713          	andi	a4,a4,15
    210c:	00ec0733          	add	a4,s8,a4
    2110:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2114:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2118:	63668863          	beq	a3,s6,2748 <main+0x11ac>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    211c:	00835713          	srli	a4,t1,0x8
    2120:	00f77713          	andi	a4,a4,15
    2124:	00ec0733          	add	a4,s8,a4
    2128:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    212c:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2130:	63660a63          	beq	a2,s6,2764 <main+0x11c8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2134:	00435713          	srli	a4,t1,0x4
    2138:	00f77713          	andi	a4,a4,15
    213c:	00ec0733          	add	a4,s8,a4
    2140:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2144:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2148:	63668c63          	beq	a3,s6,2780 <main+0x11e4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    214c:	00f37313          	andi	t1,t1,15
    2150:	006c0733          	add	a4,s8,t1
    2154:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    2158:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    215c:	63670e63          	beq	a4,s6,2798 <main+0x11fc>
    UART0->DATA = c;
    2160:	00eaa023          	sw	a4,0(s5)
        UART0->DATA = '\r';
    2164:	017aa023          	sw	s7,0(s5)
        putchar(*(p++));
    2168:	03012683          	lw	a3,48(sp)
    UART0->DATA = c;
    216c:	04300713          	li	a4,67
    2170:	016aa023          	sw	s6,0(s5)
    2174:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2178:	06800713          	li	a4,104
        putchar(*(p++));
    217c:	00168693          	addi	a3,a3,1
    if (c == '\n')
    2180:	63670063          	beq	a4,s6,27a0 <main+0x1204>
    UART0->DATA = c;
    2184:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2188:	0006c703          	lbu	a4,0(a3)
    218c:	fe0718e3          	bnez	a4,217c <main+0xbe0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2190:	01c7d713          	srli	a4,a5,0x1c
    2194:	00ec0733          	add	a4,s8,a4
    2198:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    219c:	63660263          	beq	a2,s6,27c0 <main+0x1224>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21a0:	0187d713          	srli	a4,a5,0x18
    21a4:	00f77713          	andi	a4,a4,15
    21a8:	00ec0733          	add	a4,s8,a4
    21ac:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    21b0:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    21b4:	63668463          	beq	a3,s6,27dc <main+0x1240>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21b8:	0147d713          	srli	a4,a5,0x14
    21bc:	00f77713          	andi	a4,a4,15
    21c0:	00ec0733          	add	a4,s8,a4
    21c4:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    21c8:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    21cc:	63660663          	beq	a2,s6,27f8 <main+0x125c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21d0:	0107d713          	srli	a4,a5,0x10
    21d4:	00f77713          	andi	a4,a4,15
    21d8:	00ec0733          	add	a4,s8,a4
    21dc:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    21e0:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    21e4:	63668863          	beq	a3,s6,2814 <main+0x1278>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21e8:	00c7d713          	srli	a4,a5,0xc
    21ec:	00f77713          	andi	a4,a4,15
    21f0:	00ec0733          	add	a4,s8,a4
    21f4:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    21f8:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    21fc:	63660a63          	beq	a2,s6,2830 <main+0x1294>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2200:	0087d713          	srli	a4,a5,0x8
    2204:	00f77713          	andi	a4,a4,15
    2208:	00ec0733          	add	a4,s8,a4
    220c:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2210:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2214:	63668c63          	beq	a3,s6,284c <main+0x12b0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2218:	0047d713          	srli	a4,a5,0x4
    221c:	00f77713          	andi	a4,a4,15
    2220:	00ec0733          	add	a4,s8,a4
    2224:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    2228:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    222c:	63670e63          	beq	a4,s6,2868 <main+0x12cc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2230:	00f7f793          	andi	a5,a5,15
    2234:	00fc07b3          	add	a5,s8,a5
    2238:	0007c783          	lbu	a5,0(a5)
    UART0->DATA = c;
    223c:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    2240:	65678063          	beq	a5,s6,2880 <main+0x12e4>
    UART0->DATA = c;
    2244:	00faa023          	sw	a5,0(s5)
        UART0->DATA = '\r';
    2248:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    224c:	016aa023          	sw	s6,0(s5)
        for (int rep = 10; rep > 0; rep--)
    2250:	fffa0a13          	addi	s4,s4,-1
    2254:	980a12e3          	bnez	s4,1bd8 <main+0x63c>
    2258:	f78ff06f          	j	19d0 <main+0x434>
                cmd_benchmark(1, 0);
                break;

            case 'A':
            case 'a':
                cmd_benchmark_all();
    225c:	969fe0ef          	jal	ra,bc4 <cmd_benchmark_all>
                break;
    2260:	000037b7          	lui	a5,0x3
    2264:	9e578f93          	addi	t6,a5,-1563 # 29e5 <irqCallback+0xd1>
        for (int rep = 10; rep > 0; rep--)
    2268:	fffa0a13          	addi	s4,s4,-1
                break;
    226c:	000037b7          	lui	a5,0x3
    2270:	b7d78293          	addi	t0,a5,-1155 # 2b7d <irqCallback+0x269>
        for (int rep = 10; rep > 0; rep--)
    2274:	960a12e3          	bnez	s4,1bd8 <main+0x63c>
    2278:	f58ff06f          	j	19d0 <main+0x434>
        UART0->DATA = '\r';
    227c:	017aa023          	sw	s7,0(s5)
    2280:	aa1ff06f          	j	1d20 <main+0x784>
            case '5':
                GPIO0->OUT ^= 0x00000010;
                break;

            case '6':
                GPIO0->OUT ^= 0x00000020;
    2284:	82000737          	lui	a4,0x82000
    2288:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    228c:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000020;
    2290:	0207c793          	xori	a5,a5,32
    2294:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    2298:	940a10e3          	bnez	s4,1bd8 <main+0x63c>
    229c:	f34ff06f          	j	19d0 <main+0x434>
                GPIO0->OUT ^= 0x00000010;
    22a0:	82000737          	lui	a4,0x82000
    22a4:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    22a8:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000010;
    22ac:	0107c793          	xori	a5,a5,16
    22b0:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    22b4:	920a12e3          	bnez	s4,1bd8 <main+0x63c>
    22b8:	f18ff06f          	j	19d0 <main+0x434>
                GPIO0->OUT ^= 0x00000008;
    22bc:	82000737          	lui	a4,0x82000
    22c0:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    22c4:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000008;
    22c8:	0087c793          	xori	a5,a5,8
    22cc:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    22d0:	900a14e3          	bnez	s4,1bd8 <main+0x63c>
    22d4:	efcff06f          	j	19d0 <main+0x434>
                GPIO0->OUT ^= 0x00000004;
    22d8:	82000737          	lui	a4,0x82000
    22dc:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    22e0:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000004;
    22e4:	0047c793          	xori	a5,a5,4
    22e8:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    22ec:	8e0a16e3          	bnez	s4,1bd8 <main+0x63c>
    22f0:	ee0ff06f          	j	19d0 <main+0x434>
                GPIO0->OUT ^= 0x00000002;
    22f4:	82000737          	lui	a4,0x82000
    22f8:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    22fc:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000002;
    2300:	0027c793          	xori	a5,a5,2
    2304:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    2308:	8c0a18e3          	bnez	s4,1bd8 <main+0x63c>
    230c:	ec4ff06f          	j	19d0 <main+0x434>
                GPIO0->OUT ^= 0x00000001;
    2310:	82000737          	lui	a4,0x82000
    2314:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    2318:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000001;
    231c:	0017c793          	xori	a5,a5,1
    2320:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    2324:	8a0a1ae3          	bnez	s4,1bd8 <main+0x63c>
    2328:	ea8ff06f          	j	19d0 <main+0x434>
        UART0->DATA = '\r';
    232c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2330:	00faa023          	sw	a5,0(s5)
    while (*p)
    2334:	00074783          	lbu	a5,0(a4)
    2338:	9a0794e3          	bnez	a5,1ce0 <main+0x744>
    233c:	9b9ff06f          	j	1cf4 <main+0x758>
        UART0->DATA = '\r';
    2340:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2344:	00faa023          	sw	a5,0(s5)
    while (*p)
    2348:	00074783          	lbu	a5,0(a4)
    234c:	8a0790e3          	bnez	a5,1bec <main+0x650>
            print_hex(GPIO0->IN, 8);
    2350:	820007b7          	lui	a5,0x82000
    2354:	0047a783          	lw	a5,4(a5) # 82000004 <__global_pointer$+0x41fff804>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2358:	01c7d713          	srli	a4,a5,0x1c
    235c:	00ec0733          	add	a4,s8,a4
    2360:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    2364:	8b661ae3          	bne	a2,s6,1c18 <main+0x67c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2368:	0187d713          	srli	a4,a5,0x18
    236c:	00f77713          	andi	a4,a4,15
    2370:	00ec0733          	add	a4,s8,a4
    2374:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2378:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    237c:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2380:	8b6698e3          	bne	a3,s6,1c30 <main+0x694>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2384:	0147d713          	srli	a4,a5,0x14
    2388:	00f77713          	andi	a4,a4,15
    238c:	00ec0733          	add	a4,s8,a4
    2390:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2394:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2398:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    239c:	8b6616e3          	bne	a2,s6,1c48 <main+0x6ac>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    23a0:	0107d713          	srli	a4,a5,0x10
    23a4:	00f77713          	andi	a4,a4,15
    23a8:	00ec0733          	add	a4,s8,a4
    23ac:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    23b0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    23b4:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    23b8:	8b6694e3          	bne	a3,s6,1c60 <main+0x6c4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    23bc:	00c7d713          	srli	a4,a5,0xc
    23c0:	00f77713          	andi	a4,a4,15
    23c4:	00ec0733          	add	a4,s8,a4
    23c8:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    23cc:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    23d0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    23d4:	8b6612e3          	bne	a2,s6,1c78 <main+0x6dc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    23d8:	0087d713          	srli	a4,a5,0x8
    23dc:	00f77713          	andi	a4,a4,15
    23e0:	00ec0733          	add	a4,s8,a4
    23e4:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    23e8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    23ec:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    23f0:	8b6690e3          	bne	a3,s6,1c90 <main+0x6f4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    23f4:	0047d713          	srli	a4,a5,0x4
    23f8:	00f77713          	andi	a4,a4,15
    23fc:	00ec0733          	add	a4,s8,a4
    2400:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    2404:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2408:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    240c:	89671ee3          	bne	a4,s6,1ca8 <main+0x70c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2410:	00f7f793          	andi	a5,a5,15
    2414:	00fc07b3          	add	a5,s8,a5
    2418:	0007c783          	lbu	a5,0(a5)
        UART0->DATA = '\r';
    241c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2420:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    2424:	89679ce3          	bne	a5,s6,1cbc <main+0x720>
        UART0->DATA = '\r';
    2428:	017aa023          	sw	s7,0(s5)
    242c:	891ff06f          	j	1cbc <main+0x720>
    2430:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2434:	00faa023          	sw	a5,0(s5)
    while (*p)
    2438:	00074783          	lbu	a5,0(a4)
    243c:	f6079c63          	bnez	a5,1bb4 <main+0x618>
    2440:	f88ff06f          	j	1bc8 <main+0x62c>
        UART0->DATA = '\r';
    2444:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2448:	00faa023          	sw	a5,0(s5)
    while (*p)
    244c:	00074783          	lbu	a5,0(a4)
    2450:	f4079263          	bnez	a5,1b94 <main+0x5f8>
    2454:	f54ff06f          	j	1ba8 <main+0x60c>
        UART0->DATA = '\r';
    2458:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    245c:	00faa023          	sw	a5,0(s5)
    while (*p)
    2460:	00074783          	lbu	a5,0(a4)
    2464:	f0079863          	bnez	a5,1b74 <main+0x5d8>
    2468:	f20ff06f          	j	1b88 <main+0x5ec>
        UART0->DATA = '\r';
    246c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2470:	00faa023          	sw	a5,0(s5)
    while (*p)
    2474:	00074783          	lbu	a5,0(a4)
    2478:	ec079e63          	bnez	a5,1b54 <main+0x5b8>
    247c:	eecff06f          	j	1b68 <main+0x5cc>
        UART0->DATA = '\r';
    2480:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2484:	00faa023          	sw	a5,0(s5)
    while (*p)
    2488:	00074783          	lbu	a5,0(a4)
    248c:	ea079463          	bnez	a5,1b34 <main+0x598>
    2490:	eb8ff06f          	j	1b48 <main+0x5ac>
        UART0->DATA = '\r';
    2494:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2498:	00faa023          	sw	a5,0(s5)
    while (*p)
    249c:	00074783          	lbu	a5,0(a4)
    24a0:	e6079a63          	bnez	a5,1b14 <main+0x578>
    24a4:	e84ff06f          	j	1b28 <main+0x58c>
        UART0->DATA = '\r';
    24a8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24ac:	00faa023          	sw	a5,0(s5)
    while (*p)
    24b0:	00074783          	lbu	a5,0(a4)
    24b4:	e4079063          	bnez	a5,1af4 <main+0x558>
    24b8:	e50ff06f          	j	1b08 <main+0x56c>
        UART0->DATA = '\r';
    24bc:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24c0:	00faa023          	sw	a5,0(s5)
    while (*p)
    24c4:	00074783          	lbu	a5,0(a4)
    24c8:	e0079663          	bnez	a5,1ad4 <main+0x538>
    24cc:	e1cff06f          	j	1ae8 <main+0x54c>
        UART0->DATA = '\r';
    24d0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24d4:	00faa023          	sw	a5,0(s5)
    while (*p)
    24d8:	00074783          	lbu	a5,0(a4)
    24dc:	dc079c63          	bnez	a5,1ab4 <main+0x518>
    24e0:	de8ff06f          	j	1ac8 <main+0x52c>
        UART0->DATA = '\r';
    24e4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24e8:	00faa023          	sw	a5,0(s5)
    while (*p)
    24ec:	00074783          	lbu	a5,0(a4)
    24f0:	da079263          	bnez	a5,1a94 <main+0x4f8>
    24f4:	db4ff06f          	j	1aa8 <main+0x50c>
        UART0->DATA = '\r';
    24f8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24fc:	00faa023          	sw	a5,0(s5)
    while (*p)
    2500:	00074783          	lbu	a5,0(a4)
    2504:	d6079863          	bnez	a5,1a74 <main+0x4d8>
    2508:	d80ff06f          	j	1a88 <main+0x4ec>
        UART0->DATA = '\r';
    250c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2510:	00faa023          	sw	a5,0(s5)
    while (*p)
    2514:	00074783          	lbu	a5,0(a4)
    2518:	d2079e63          	bnez	a5,1a54 <main+0x4b8>
    251c:	d4cff06f          	j	1a68 <main+0x4cc>
        UART0->DATA = '\r';
    2520:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2524:	00faa023          	sw	a5,0(s5)
    while (*p)
    2528:	00074783          	lbu	a5,0(a4)
    252c:	d0079463          	bnez	a5,1a34 <main+0x498>
    2530:	d18ff06f          	j	1a48 <main+0x4ac>
        UART0->DATA = '\r';
    2534:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2538:	00faa023          	sw	a5,0(s5)
    while (*p)
    253c:	00074783          	lbu	a5,0(a4)
    2540:	cc079a63          	bnez	a5,1a14 <main+0x478>
    2544:	ce4ff06f          	j	1a28 <main+0x48c>
        UART0->DATA = '\r';
    2548:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    254c:	00faa023          	sw	a5,0(s5)
    while (*p)
    2550:	00074783          	lbu	a5,0(a4)
    2554:	c8079c63          	bnez	a5,19ec <main+0x450>
    2558:	ca8ff06f          	j	1a00 <main+0x464>
        UART0->DATA = '\r';
    255c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2560:	00faa023          	sw	a5,0(s5)
    while (*p)
    2564:	00074783          	lbu	a5,0(a4)
    2568:	8c0794e3          	bnez	a5,1e30 <main+0x894>
    return QSPI0->REG & QSPI_REG_CRM;
    256c:	810007b7          	lui	a5,0x81000
    2570:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    2574:	00100737          	lui	a4,0x100
    2578:	00e7f7b3          	and	a5,a5,a4
                if ( cmd_get_crm() )
    257c:	8c078ee3          	beqz	a5,1e58 <main+0x8bc>
        putchar(*(p++));
    2580:	00c12703          	lw	a4,12(sp)
    UART0->DATA = c;
    2584:	04f00793          	li	a5,79
    2588:	00faa023          	sw	a5,0(s5)
    while (*p)
    258c:	04e00793          	li	a5,78
        putchar(*(p++));
    2590:	00170713          	addi	a4,a4,1 # 100001 <_etext+0xfd351>
    if (c == '\n')
    2594:	01678c63          	beq	a5,s6,25ac <main+0x1010>
    UART0->DATA = c;
    2598:	00faa023          	sw	a5,0(s5)
    while (*p)
    259c:	00074783          	lbu	a5,0(a4)
    25a0:	fe078a63          	beqz	a5,1d94 <main+0x7f8>
        putchar(*(p++));
    25a4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    25a8:	ff6798e3          	bne	a5,s6,2598 <main+0xffc>
        UART0->DATA = '\r';
    25ac:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    25b0:	00faa023          	sw	a5,0(s5)
    while (*p)
    25b4:	00074783          	lbu	a5,0(a4)
    25b8:	fc079ce3          	bnez	a5,2590 <main+0xff4>
        for (int rep = 10; rep > 0; rep--)
    25bc:	fffa0a13          	addi	s4,s4,-1
    25c0:	e00a1c63          	bnez	s4,1bd8 <main+0x63c>
    25c4:	c0cff06f          	j	19d0 <main+0x434>
        UART0->DATA = '\r';
    25c8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    25cc:	00eaa023          	sw	a4,0(s5)
    while (*p)
    25d0:	0006c703          	lbu	a4,0(a3)
    25d4:	9c071ee3          	bnez	a4,1fb0 <main+0xa14>
        print_hex(cycles_end - cycles_begin, 8);
    25d8:	41c58e33          	sub	t3,a1,t3
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    25dc:	01ce5713          	srli	a4,t3,0x1c
    25e0:	00ec0733          	add	a4,s8,a4
    25e4:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    25e8:	9f6698e3          	bne	a3,s6,1fd8 <main+0xa3c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    25ec:	018e5713          	srli	a4,t3,0x18
    25f0:	00f77713          	andi	a4,a4,15
    25f4:	00ec0733          	add	a4,s8,a4
    25f8:	00074583          	lbu	a1,0(a4)
        UART0->DATA = '\r';
    25fc:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2600:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2604:	9f6596e3          	bne	a1,s6,1ff0 <main+0xa54>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2608:	014e5713          	srli	a4,t3,0x14
    260c:	00f77713          	andi	a4,a4,15
    2610:	00ec0733          	add	a4,s8,a4
    2614:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2618:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    261c:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2620:	9f6694e3          	bne	a3,s6,2008 <main+0xa6c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2624:	010e5713          	srli	a4,t3,0x10
    2628:	00f77713          	andi	a4,a4,15
    262c:	00ec0733          	add	a4,s8,a4
    2630:	00074583          	lbu	a1,0(a4)
        UART0->DATA = '\r';
    2634:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2638:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    263c:	9f6592e3          	bne	a1,s6,2020 <main+0xa84>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2640:	00ce5713          	srli	a4,t3,0xc
    2644:	00f77713          	andi	a4,a4,15
    2648:	00ec0733          	add	a4,s8,a4
    264c:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2650:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2654:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2658:	9f6690e3          	bne	a3,s6,2038 <main+0xa9c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    265c:	008e5713          	srli	a4,t3,0x8
    2660:	00f77713          	andi	a4,a4,15
    2664:	00ec0733          	add	a4,s8,a4
    2668:	00074583          	lbu	a1,0(a4)
        UART0->DATA = '\r';
    266c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2670:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2674:	9d659ee3          	bne	a1,s6,2050 <main+0xab4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2678:	004e5713          	srli	a4,t3,0x4
    267c:	00f77713          	andi	a4,a4,15
    2680:	00ec0733          	add	a4,s8,a4
    2684:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2688:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    268c:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2690:	9d669ce3          	bne	a3,s6,2068 <main+0xacc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2694:	00fe7e13          	andi	t3,t3,15
    2698:	01cc0733          	add	a4,s8,t3
    269c:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    26a0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    26a4:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    26a8:	9d671ae3          	bne	a4,s6,207c <main+0xae0>
        UART0->DATA = '\r';
    26ac:	017aa023          	sw	s7,0(s5)
    26b0:	9cdff06f          	j	207c <main+0xae0>
    26b4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    26b8:	00eaa023          	sw	a4,0(s5)
    while (*p)
    26bc:	0006c703          	lbu	a4,0(a3)
    26c0:	9c071ae3          	bnez	a4,2094 <main+0xaf8>
        print_hex(instns_end - instns_begin, 8);
    26c4:	40660333          	sub	t1,a2,t1
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    26c8:	01c35713          	srli	a4,t1,0x1c
    26cc:	00ec0733          	add	a4,s8,a4
    26d0:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    26d4:	9f6694e3          	bne	a3,s6,20bc <main+0xb20>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    26d8:	01835713          	srli	a4,t1,0x18
    26dc:	00f77713          	andi	a4,a4,15
    26e0:	00ec0733          	add	a4,s8,a4
    26e4:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    26e8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    26ec:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    26f0:	9f6612e3          	bne	a2,s6,20d4 <main+0xb38>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    26f4:	01435713          	srli	a4,t1,0x14
    26f8:	00f77713          	andi	a4,a4,15
    26fc:	00ec0733          	add	a4,s8,a4
    2700:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2704:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2708:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    270c:	9f6690e3          	bne	a3,s6,20ec <main+0xb50>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2710:	01035713          	srli	a4,t1,0x10
    2714:	00f77713          	andi	a4,a4,15
    2718:	00ec0733          	add	a4,s8,a4
    271c:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2720:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2724:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2728:	9d661ee3          	bne	a2,s6,2104 <main+0xb68>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    272c:	00c35713          	srli	a4,t1,0xc
    2730:	00f77713          	andi	a4,a4,15
    2734:	00ec0733          	add	a4,s8,a4
    2738:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    273c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2740:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2744:	9d669ce3          	bne	a3,s6,211c <main+0xb80>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2748:	00835713          	srli	a4,t1,0x8
    274c:	00f77713          	andi	a4,a4,15
    2750:	00ec0733          	add	a4,s8,a4
    2754:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2758:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    275c:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2760:	9d661ae3          	bne	a2,s6,2134 <main+0xb98>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2764:	00435713          	srli	a4,t1,0x4
    2768:	00f77713          	andi	a4,a4,15
    276c:	00ec0733          	add	a4,s8,a4
    2770:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2774:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2778:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    277c:	9d6698e3          	bne	a3,s6,214c <main+0xbb0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2780:	00f37313          	andi	t1,t1,15
    2784:	006c0733          	add	a4,s8,t1
    2788:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    278c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2790:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2794:	9d6716e3          	bne	a4,s6,2160 <main+0xbc4>
        UART0->DATA = '\r';
    2798:	017aa023          	sw	s7,0(s5)
    279c:	9c5ff06f          	j	2160 <main+0xbc4>
    27a0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    27a4:	00eaa023          	sw	a4,0(s5)
    while (*p)
    27a8:	0006c703          	lbu	a4,0(a3)
    27ac:	9c0718e3          	bnez	a4,217c <main+0xbe0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    27b0:	01c7d713          	srli	a4,a5,0x1c
    27b4:	00ec0733          	add	a4,s8,a4
    27b8:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    27bc:	9f6612e3          	bne	a2,s6,21a0 <main+0xc04>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    27c0:	0187d713          	srli	a4,a5,0x18
    27c4:	00f77713          	andi	a4,a4,15
    27c8:	00ec0733          	add	a4,s8,a4
    27cc:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    27d0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    27d4:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    27d8:	9f6690e3          	bne	a3,s6,21b8 <main+0xc1c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    27dc:	0147d713          	srli	a4,a5,0x14
    27e0:	00f77713          	andi	a4,a4,15
    27e4:	00ec0733          	add	a4,s8,a4
    27e8:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    27ec:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    27f0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    27f4:	9d661ee3          	bne	a2,s6,21d0 <main+0xc34>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    27f8:	0107d713          	srli	a4,a5,0x10
    27fc:	00f77713          	andi	a4,a4,15
    2800:	00ec0733          	add	a4,s8,a4
    2804:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2808:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    280c:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2810:	9d669ce3          	bne	a3,s6,21e8 <main+0xc4c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2814:	00c7d713          	srli	a4,a5,0xc
    2818:	00f77713          	andi	a4,a4,15
    281c:	00ec0733          	add	a4,s8,a4
    2820:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2824:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2828:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    282c:	9d661ae3          	bne	a2,s6,2200 <main+0xc64>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2830:	0087d713          	srli	a4,a5,0x8
    2834:	00f77713          	andi	a4,a4,15
    2838:	00ec0733          	add	a4,s8,a4
    283c:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2840:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2844:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2848:	9d6698e3          	bne	a3,s6,2218 <main+0xc7c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    284c:	0047d713          	srli	a4,a5,0x4
    2850:	00f77713          	andi	a4,a4,15
    2854:	00ec0733          	add	a4,s8,a4
    2858:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    285c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2860:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2864:	9d6716e3          	bne	a4,s6,2230 <main+0xc94>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2868:	00f7f793          	andi	a5,a5,15
    286c:	00fc07b3          	add	a5,s8,a5
    2870:	0007c783          	lbu	a5,0(a5)
        UART0->DATA = '\r';
    2874:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2878:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    287c:	9d6794e3          	bne	a5,s6,2244 <main+0xca8>
        UART0->DATA = '\r';
    2880:	017aa023          	sw	s7,0(s5)
    2884:	9c1ff06f          	j	2244 <main+0xca8>
    2888:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    288c:	00faa023          	sw	a5,0(s5)
    while (*p)
    2890:	00074783          	lbu	a5,0(a4)
    2894:	d4079263          	bnez	a5,1dd8 <main+0x83c>
    return QSPI0->REG & QSPI_REG_DSPI;
    2898:	810007b7          	lui	a5,0x81000
    289c:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    28a0:	00400737          	lui	a4,0x400
    28a4:	00e7f7b3          	and	a5,a5,a4
                if ( cmd_get_dspi() )
    28a8:	d4078c63          	beqz	a5,1e00 <main+0x864>
        putchar(*(p++));
    28ac:	00c12703          	lw	a4,12(sp)
    UART0->DATA = c;
    28b0:	04f00793          	li	a5,79
    28b4:	00faa023          	sw	a5,0(s5)
    while (*p)
    28b8:	04e00793          	li	a5,78
        putchar(*(p++));
    28bc:	00170713          	addi	a4,a4,1 # 400001 <_etext+0x3fd351>
    if (c == '\n')
    28c0:	01678c63          	beq	a5,s6,28d8 <main+0x133c>
    UART0->DATA = c;
    28c4:	00faa023          	sw	a5,0(s5)
    while (*p)
    28c8:	00074783          	lbu	a5,0(a4)
    28cc:	d4078c63          	beqz	a5,1e24 <main+0x888>
        putchar(*(p++));
    28d0:	00170713          	addi	a4,a4,1
    if (c == '\n')
    28d4:	ff6798e3          	bne	a5,s6,28c4 <main+0x1328>
        UART0->DATA = '\r';
    28d8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    28dc:	00faa023          	sw	a5,0(s5)
    while (*p)
    28e0:	00074783          	lbu	a5,0(a4)
    28e4:	fc079ce3          	bnez	a5,28bc <main+0x1320>
    28e8:	d3cff06f          	j	1e24 <main+0x888>
        UART0->DATA = '\r';
    28ec:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    28f0:	00faa023          	sw	a5,0(s5)
    while (*p)
    28f4:	00074783          	lbu	a5,0(a4)
    28f8:	cc079063          	bnez	a5,1db8 <main+0x81c>
    28fc:	cd0ff06f          	j	1dcc <main+0x830>
        UART0->DATA = '\r';
    2900:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2904:	00faa023          	sw	a5,0(s5)
    while (*p)
    2908:	00074783          	lbu	a5,0(a4)
    290c:	d0079263          	bnez	a5,1e10 <main+0x874>
    2910:	d14ff06f          	j	1e24 <main+0x888>

00002914 <irqCallback>:
    }
}

void irqCallback() {

    2914:	00008067          	ret
    2918:	3130                	fld	fa2,96(a0)
    291a:	3332                	fld	ft6,296(sp)
    291c:	3534                	fld	fa3,104(a0)
    291e:	3736                	fld	fa4,360(sp)
    2920:	3938                	fld	fa4,112(a0)
    2922:	6261                	lui	tp,0x18
    2924:	66656463          	bltu	a0,t1,2f8c <_etext+0x2dc>
    2928:	0000                	unimp
    292a:	0000                	unimp
    292c:	6c637943          	0x6c637943
    2930:	7365                	lui	t1,0xffff9
    2932:	203a                	fld	ft0,392(sp)
    2934:	7830                	flw	fa2,112(s0)
    2936:	0000                	unimp
    2938:	6e49                	lui	t3,0x12
    293a:	736e7473          	csrrci	s0,0x736,28
    293e:	203a                	fld	ft0,392(sp)
    2940:	7830                	flw	fa2,112(s0)
    2942:	0000                	unimp
    2944:	736b6843          	fmadd.d	fa6,fs6,fs6,fa4,unknown
    2948:	6d75                	lui	s10,0x1d
    294a:	203a                	fld	ft0,392(sp)
    294c:	7830                	flw	fa2,112(s0)
    294e:	0000                	unimp
    2950:	6564                	flw	fs1,76(a0)
    2952:	6166                	flw	ft2,88(sp)
    2954:	6c75                	lui	s8,0x1d
    2956:	2074                	fld	fa3,192(s0)
    2958:	2020                	fld	fs0,64(s0)
    295a:	2020                	fld	fs0,64(s0)
    295c:	2020                	fld	fs0,64(s0)
    295e:	0020                	addi	s0,sp,8
    2960:	7364                	flw	fs1,100(a4)
    2962:	6970                	flw	fa2,84(a0)
    2964:	002d                	c.nop	11
    2966:	0000                	unimp
    2968:	2020                	fld	fs0,64(s0)
    296a:	2020                	fld	fs0,64(s0)
    296c:	2020                	fld	fs0,64(s0)
    296e:	2020                	fld	fs0,64(s0)
    2970:	0020                	addi	s0,sp,8
    2972:	0000                	unimp
    2974:	7364                	flw	fs1,100(a4)
    2976:	6970                	flw	fa2,84(a0)
    2978:	632d                	lui	t1,0xb
    297a:	6d72                	flw	fs10,28(sp)
    297c:	002d                	c.nop	11
    297e:	0000                	unimp
    2980:	6e69                	lui	t3,0x1a
    2982:	736e7473          	csrrci	s0,0x736,28
    2986:	2020                	fld	fs0,64(s0)
    2988:	2020                	fld	fs0,64(s0)
    298a:	2020                	fld	fs0,64(s0)
    298c:	2020                	fld	fs0,64(s0)
    298e:	3a20                	fld	fs0,112(a2)
    2990:	0020                	addi	s0,sp,8
    2992:	0000                	unimp
    2994:	0a0a                	slli	s4,s4,0x2
    2996:	0a0a                	slli	s4,s4,0x2
    2998:	0a0a                	slli	s4,s4,0x2
    299a:	000a                	c.slli	zero,0x2
    299c:	2020                	fld	fs0,64(s0)
    299e:	2020                	fld	fs0,64(s0)
    29a0:	2020                	fld	fs0,64(s0)
    29a2:	2020                	fld	fs0,64(s0)
    29a4:	2020                	fld	fs0,64(s0)
    29a6:	4f20                	lw	s0,88(a4)
    29a8:	206e                	fld	ft0,216(sp)
    29aa:	694c                	flw	fa1,20(a0)
    29ac:	65656863          	bltu	a0,s6,2ffc <_etext+0x34c>
    29b0:	5420                	lw	s0,104(s0)
    29b2:	6e61                	lui	t3,0x18
    29b4:	614e2067          	0x614e2067
    29b8:	6f6e                	flw	ft10,216(sp)
    29ba:	392d                	jal	25f4 <main+0x1058>
    29bc:	7962204b          	fnmsub.s	ft0,ft4,fs6,fa5,rdn
    29c0:	5020                	lw	s0,96(s0)
    29c2:	7465                	lui	s0,0xffff9
    29c4:	7265                	lui	tp,0xffff9
    29c6:	4720                	lw	s0,72(a4)
    29c8:	656c                	flw	fa1,76(a0)
    29ca:	0a6e                	slli	s4,s4,0x1b
    29cc:	0000                	unimp
    29ce:	0000                	unimp
    29d0:	656c6553          	0x656c6553
    29d4:	61207463          	bgeu	zero,s2,2fdc <_etext+0x32c>
    29d8:	206e                	fld	ft0,216(sp)
    29da:	6361                	lui	t1,0x18
    29dc:	6974                	flw	fa3,84(a0)
    29de:	0a3a6e6f          	jal	t3,a9280 <_etext+0xa65d0>
    29e2:	0000                	unimp
    29e4:	2020                	fld	fs0,64(s0)
    29e6:	5b20                	lw	s0,112(a4)
    29e8:	5d30                	lw	a2,120(a0)
    29ea:	5220                	lw	s0,96(a2)
    29ec:	6e75                	lui	t3,0x1d
    29ee:	6d20                	flw	fs0,88(a0)
    29f0:	6961                	lui	s2,0x18
    29f2:	206e                	fld	ft0,216(sp)
    29f4:	7061                	c.lui	zero,0xffff8
    29f6:	2070                	fld	fa2,192(s0)
    29f8:	6b28                	flw	fa0,80(a4)
    29fa:	6f69                	lui	t5,0x1a
    29fc:	0a296b73          	csrrsi	s6,0xa2,18
    2a00:	0000                	unimp
    2a02:	0000                	unimp
    2a04:	2020                	fld	fs0,64(s0)
    2a06:	5b20                	lw	s0,112(a4)
    2a08:	5d31                	li	s10,-20
    2a0a:	5420                	lw	s0,104(s0)
    2a0c:	6c67676f          	jal	a4,790d2 <_etext+0x76422>
    2a10:	2065                	jal	2ab8 <irqCallback+0x1a4>
    2a12:	656c                	flw	fa1,76(a0)
    2a14:	2064                	fld	fs1,192(s0)
    2a16:	0a31                	addi	s4,s4,12
    2a18:	0000                	unimp
    2a1a:	0000                	unimp
    2a1c:	2020                	fld	fs0,64(s0)
    2a1e:	5b20                	lw	s0,112(a4)
    2a20:	5d32                	lw	s10,44(sp)
    2a22:	5420                	lw	s0,104(s0)
    2a24:	6c67676f          	jal	a4,790ea <_etext+0x7643a>
    2a28:	2065                	jal	2ad0 <irqCallback+0x1bc>
    2a2a:	656c                	flw	fa1,76(a0)
    2a2c:	2064                	fld	fs1,192(s0)
    2a2e:	0a32                	slli	s4,s4,0xc
    2a30:	0000                	unimp
    2a32:	0000                	unimp
    2a34:	2020                	fld	fs0,64(s0)
    2a36:	5b20                	lw	s0,112(a4)
    2a38:	54205d33          	0x54205d33
    2a3c:	6c67676f          	jal	a4,79102 <_etext+0x76452>
    2a40:	2065                	jal	2ae8 <irqCallback+0x1d4>
    2a42:	656c                	flw	fa1,76(a0)
    2a44:	2064                	fld	fs1,192(s0)
    2a46:	00000a33          	add	s4,zero,zero
    2a4a:	0000                	unimp
    2a4c:	2020                	fld	fs0,64(s0)
    2a4e:	5b20                	lw	s0,112(a4)
    2a50:	5d34                	lw	a3,120(a0)
    2a52:	5420                	lw	s0,104(s0)
    2a54:	6c67676f          	jal	a4,7911a <_etext+0x7646a>
    2a58:	2065                	jal	2b00 <irqCallback+0x1ec>
    2a5a:	656c                	flw	fa1,76(a0)
    2a5c:	2064                	fld	fs1,192(s0)
    2a5e:	0a34                	addi	a3,sp,280
    2a60:	0000                	unimp
    2a62:	0000                	unimp
    2a64:	2020                	fld	fs0,64(s0)
    2a66:	5b20                	lw	s0,112(a4)
    2a68:	5d35                	li	s10,-19
    2a6a:	5420                	lw	s0,104(s0)
    2a6c:	6c67676f          	jal	a4,79132 <_etext+0x76482>
    2a70:	2065                	jal	2b18 <irqCallback+0x204>
    2a72:	656c                	flw	fa1,76(a0)
    2a74:	2064                	fld	fs1,192(s0)
    2a76:	0a35                	addi	s4,s4,13
    2a78:	0000                	unimp
    2a7a:	0000                	unimp
    2a7c:	2020                	fld	fs0,64(s0)
    2a7e:	5b20                	lw	s0,112(a4)
    2a80:	5d36                	lw	s10,108(sp)
    2a82:	5420                	lw	s0,104(s0)
    2a84:	6c67676f          	jal	a4,7914a <_etext+0x7649a>
    2a88:	2065                	jal	2b30 <irqCallback+0x21c>
    2a8a:	656c                	flw	fa1,76(a0)
    2a8c:	2064                	fld	fs1,192(s0)
    2a8e:	0a36                	slli	s4,s4,0xd
    2a90:	0000                	unimp
    2a92:	0000                	unimp
    2a94:	2020                	fld	fs0,64(s0)
    2a96:	5b20                	lw	s0,112(a4)
    2a98:	5d46                	lw	s10,112(sp)
    2a9a:	4720                	lw	s0,72(a4)
    2a9c:	7465                	lui	s0,0xffff9
    2a9e:	6620                	flw	fs0,72(a2)
    2aa0:	616c                	flw	fa1,68(a0)
    2aa2:	6d206873          	csrrsi	a6,0x6d2,0
    2aa6:	0a65646f          	jal	s0,58b4c <_etext+0x55e9c>
    2aaa:	0000                	unimp
    2aac:	2020                	fld	fs0,64(s0)
    2aae:	5b20                	lw	s0,112(a4)
    2ab0:	5d49                	li	s10,-14
    2ab2:	5220                	lw	s0,96(a2)
    2ab4:	6165                	addi	sp,sp,112
    2ab6:	2064                	fld	fs1,192(s0)
    2ab8:	20495053          	0x20495053
    2abc:	6c66                	flw	fs8,88(sp)
    2abe:	7361                	lui	t1,0xffff8
    2ac0:	2068                	fld	fa0,192(s0)
    2ac2:	4449                	li	s0,18
    2ac4:	000a                	c.slli	zero,0x2
    2ac6:	0000                	unimp
    2ac8:	2020                	fld	fs0,64(s0)
    2aca:	5b20                	lw	s0,112(a4)
    2acc:	53205d53          	0x53205d53
    2ad0:	7465                	lui	s0,0xffff9
    2ad2:	5320                	lw	s0,96(a4)
    2ad4:	6e69                	lui	t3,0x1a
    2ad6:	20656c67          	0x20656c67
    2ada:	20495053          	0x20495053
    2ade:	6f6d                	lui	t5,0x1b
    2ae0:	6564                	flw	fs1,76(a0)
    2ae2:	000a                	c.slli	zero,0x2
    2ae4:	2020                	fld	fs0,64(s0)
    2ae6:	5b20                	lw	s0,112(a4)
    2ae8:	5d44                	lw	s1,60(a0)
    2aea:	5320                	lw	s0,96(a4)
    2aec:	7465                	lui	s0,0xffff9
    2aee:	4420                	lw	s0,72(s0)
    2af0:	20495053          	0x20495053
    2af4:	6f6d                	lui	t5,0x1b
    2af6:	6564                	flw	fs1,76(a0)
    2af8:	000a                	c.slli	zero,0x2
    2afa:	0000                	unimp
    2afc:	2020                	fld	fs0,64(s0)
    2afe:	5b20                	lw	s0,112(a4)
    2b00:	53205d43          	fmadd.d	fs10,ft0,fs2,fa0,unknown
    2b04:	7465                	lui	s0,0xffff9
    2b06:	4420                	lw	s0,72(s0)
    2b08:	2b495053          	0x2b495053
    2b0c:	204d5243          	fmadd.s	ft4,fs10,ft4,ft4,unknown
    2b10:	6f6d                	lui	t5,0x1b
    2b12:	6564                	flw	fs1,76(a0)
    2b14:	000a                	c.slli	zero,0x2
    2b16:	0000                	unimp
    2b18:	2020                	fld	fs0,64(s0)
    2b1a:	5b20                	lw	s0,112(a4)
    2b1c:	5d42                	lw	s10,48(sp)
    2b1e:	5220                	lw	s0,96(a2)
    2b20:	6e75                	lui	t3,0x1d
    2b22:	7320                	flw	fs0,96(a4)
    2b24:	6d69                	lui	s10,0x1a
    2b26:	6c70                	flw	fa2,92(s0)
    2b28:	7369                	lui	t1,0xffffa
    2b2a:	6974                	flw	fa3,84(a0)
    2b2c:	65622063          	0x65622063
    2b30:	636e                	flw	ft6,216(sp)
    2b32:	6d68                	flw	fa0,92(a0)
    2b34:	7261                	lui	tp,0xffff8
    2b36:	6556206b          	0x6556206b
    2b3a:	2072                	fld	ft0,280(sp)
    2b3c:	2e31                	jal	2e58 <_etext+0x1a8>
    2b3e:	2e30                	fld	fa2,88(a2)
    2b40:	0a30                	addi	a2,sp,280
    2b42:	0000                	unimp
    2b44:	2020                	fld	fs0,64(s0)
    2b46:	5b20                	lw	s0,112(a4)
    2b48:	5d41                	li	s10,-16
    2b4a:	4220                	lw	s0,64(a2)
    2b4c:	6e65                	lui	t3,0x19
    2b4e:	616d6863          	bltu	s10,s6,315e <_etext+0x4ae>
    2b52:	6b72                	flw	fs6,28(sp)
    2b54:	6120                	flw	fs0,64(a0)
    2b56:	6c6c                	flw	fa1,92(s0)
    2b58:	6320                	flw	fs0,64(a4)
    2b5a:	69666e6f          	jal	t3,691f0 <_etext+0x66540>
    2b5e:	000a7367          	0xa7367
    2b62:	0000                	unimp
    2b64:	4f49                	li	t5,18
    2b66:	5320                	lw	s0,96(a4)
    2b68:	6174                	flw	fa3,68(a0)
    2b6a:	6574                	flw	fa3,76(a0)
    2b6c:	203a                	fld	ft0,392(sp)
    2b6e:	0000                	unimp
    2b70:	6d6d6f43          	0x6d6d6f43
    2b74:	6e61                	lui	t3,0x18
    2b76:	3e64                	fld	fs1,248(a2)
    2b78:	0020                	addi	s0,sp,8
    2b7a:	0000                	unimp
    2b7c:	20495053          	0x20495053
    2b80:	74617453          	0x74617453
    2b84:	3a65                	jal	253c <main+0xfa0>
    2b86:	000a                	c.slli	zero,0x2
    2b88:	2020                	fld	fs0,64(s0)
    2b8a:	5344                	lw	s1,36(a4)
    2b8c:	4950                	lw	a2,20(a0)
    2b8e:	0020                	addi	s0,sp,8
    2b90:	000a4e4f          	fnmadd.s	ft8,fs4,ft0,ft0,rmm
    2b94:	0a46464f          	fnmadd.d	fa2,fa2,ft4,ft1,rmm
    2b98:	0000                	unimp
    2b9a:	0000                	unimp
    2b9c:	2020                	fld	fs0,64(s0)
    2b9e:	204d5243          	fmadd.s	ft4,fs10,ft4,ft4,unknown
    2ba2:	0020                	addi	s0,sp,8
    2ba4:	2310                	fld	fa2,0(a4)
    2ba6:	0000                	unimp
    2ba8:	22f4                	fld	fa3,192(a3)
    2baa:	0000                	unimp
    2bac:	22d8                	fld	fa4,128(a3)
    2bae:	0000                	unimp
    2bb0:	22bc                	fld	fa5,64(a3)
    2bb2:	0000                	unimp
    2bb4:	22a0                	fld	fs0,64(a3)
    2bb6:	0000                	unimp
    2bb8:	2284                	fld	fs1,0(a3)
    2bba:	0000                	unimp
    2bbc:	1d94                	addi	a3,sp,752
    2bbe:	0000                	unimp
    2bc0:	1d94                	addi	a3,sp,752
    2bc2:	0000                	unimp
    2bc4:	1d94                	addi	a3,sp,752
    2bc6:	0000                	unimp
    2bc8:	1d94                	addi	a3,sp,752
    2bca:	0000                	unimp
    2bcc:	1d94                	addi	a3,sp,752
    2bce:	0000                	unimp
    2bd0:	1d94                	addi	a3,sp,752
    2bd2:	0000                	unimp
    2bd4:	1d94                	addi	a3,sp,752
    2bd6:	0000                	unimp
    2bd8:	1d94                	addi	a3,sp,752
    2bda:	0000                	unimp
    2bdc:	1d94                	addi	a3,sp,752
    2bde:	0000                	unimp
    2be0:	1d94                	addi	a3,sp,752
    2be2:	0000                	unimp
    2be4:	225c                	fld	fa5,128(a2)
    2be6:	0000                	unimp
    2be8:	1f00                	addi	s0,sp,944
    2bea:	0000                	unimp
    2bec:	1eec                	addi	a1,sp,892
    2bee:	0000                	unimp
    2bf0:	1d70                	addi	a2,sp,700
    2bf2:	0000                	unimp
    2bf4:	1d94                	addi	a3,sp,752
    2bf6:	0000                	unimp
    2bf8:	1da0                	addi	s0,sp,760
    2bfa:	0000                	unimp
    2bfc:	1d94                	addi	a3,sp,752
    2bfe:	0000                	unimp
    2c00:	1d94                	addi	a3,sp,752
    2c02:	0000                	unimp
    2c04:	1ecc                	addi	a1,sp,884
    2c06:	0000                	unimp
    2c08:	1d94                	addi	a3,sp,752
    2c0a:	0000                	unimp
    2c0c:	1d94                	addi	a3,sp,752
    2c0e:	0000                	unimp
    2c10:	1d94                	addi	a3,sp,752
    2c12:	0000                	unimp
    2c14:	1d94                	addi	a3,sp,752
    2c16:	0000                	unimp
    2c18:	1d94                	addi	a3,sp,752
    2c1a:	0000                	unimp
    2c1c:	1d94                	addi	a3,sp,752
    2c1e:	0000                	unimp
    2c20:	1d94                	addi	a3,sp,752
    2c22:	0000                	unimp
    2c24:	1d94                	addi	a3,sp,752
    2c26:	0000                	unimp
    2c28:	1d94                	addi	a3,sp,752
    2c2a:	0000                	unimp
    2c2c:	1ea0                	addi	s0,sp,888
    2c2e:	0000                	unimp
    2c30:	1d94                	addi	a3,sp,752
    2c32:	0000                	unimp
    2c34:	1d94                	addi	a3,sp,752
    2c36:	0000                	unimp
    2c38:	1d94                	addi	a3,sp,752
    2c3a:	0000                	unimp
    2c3c:	1d94                	addi	a3,sp,752
    2c3e:	0000                	unimp
    2c40:	1d94                	addi	a3,sp,752
    2c42:	0000                	unimp
    2c44:	1d94                	addi	a3,sp,752
    2c46:	0000                	unimp
    2c48:	1d94                	addi	a3,sp,752
    2c4a:	0000                	unimp
    2c4c:	1d94                	addi	a3,sp,752
    2c4e:	0000                	unimp
    2c50:	1d94                	addi	a3,sp,752
    2c52:	0000                	unimp
    2c54:	1d94                	addi	a3,sp,752
    2c56:	0000                	unimp
    2c58:	1d94                	addi	a3,sp,752
    2c5a:	0000                	unimp
    2c5c:	1d94                	addi	a3,sp,752
    2c5e:	0000                	unimp
    2c60:	1d94                	addi	a3,sp,752
    2c62:	0000                	unimp
    2c64:	225c                	fld	fa5,128(a2)
    2c66:	0000                	unimp
    2c68:	1f00                	addi	s0,sp,944
    2c6a:	0000                	unimp
    2c6c:	1eec                	addi	a1,sp,892
    2c6e:	0000                	unimp
    2c70:	1d70                	addi	a2,sp,700
    2c72:	0000                	unimp
    2c74:	1d94                	addi	a3,sp,752
    2c76:	0000                	unimp
    2c78:	1da0                	addi	s0,sp,760
    2c7a:	0000                	unimp
    2c7c:	1d94                	addi	a3,sp,752
    2c7e:	0000                	unimp
    2c80:	1d94                	addi	a3,sp,752
    2c82:	0000                	unimp
    2c84:	1ecc                	addi	a1,sp,884
    2c86:	0000                	unimp
    2c88:	1d94                	addi	a3,sp,752
    2c8a:	0000                	unimp
    2c8c:	1d94                	addi	a3,sp,752
    2c8e:	0000                	unimp
    2c90:	1d94                	addi	a3,sp,752
    2c92:	0000                	unimp
    2c94:	1d94                	addi	a3,sp,752
    2c96:	0000                	unimp
    2c98:	1d94                	addi	a3,sp,752
    2c9a:	0000                	unimp
    2c9c:	1d94                	addi	a3,sp,752
    2c9e:	0000                	unimp
    2ca0:	1d94                	addi	a3,sp,752
    2ca2:	0000                	unimp
    2ca4:	1d94                	addi	a3,sp,752
    2ca6:	0000                	unimp
    2ca8:	1d94                	addi	a3,sp,752
    2caa:	0000                	unimp
    2cac:	1ea0                	addi	s0,sp,888
	...
