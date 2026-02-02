
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
      54:	085020ef          	jal	ra,28d8 <irqCallback>
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
      b0:	ba850513          	addi	a0,a0,-1112 # 2c54 <_etext>
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
      fc:	b5c50513          	addi	a0,a0,-1188 # 2c54 <_etext>
  addi sp,sp,-4
     100:	ffc10113          	addi	sp,sp,-4

00000104 <ctors_loop>:
ctors_loop:
  la a1, _ctors_end
     104:	00003597          	auipc	a1,0x3
     108:	b5058593          	addi	a1,a1,-1200 # 2c54 <_etext>
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
     198:	8dc78793          	addi	a5,a5,-1828 # 28dc <irqCallback+0x4>
     19c:	00475693          	srli	a3,a4,0x4
     1a0:	00d786b3          	add	a3,a5,a3
     1a4:	0006c683          	lbu	a3,0(a3)
    if (c == '\n')
     1a8:	00a00593          	li	a1,10
     1ac:	10b68863          	beq	a3,a1,2bc <cmd_read_flash_id+0x188>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
     1b0:	00f77713          	andi	a4,a4,15
     1b4:	00e78733          	add	a4,a5,a4
     1b8:	00074703          	lbu	a4,0(a4) # 400000 <_etext+0x3fd3ac>
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
     338:	0a178793          	addi	a5,a5,161 # 12b9b0a1 <_etext+0x12b9844d>
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
     3d8:	8f168693          	addi	a3,a3,-1807 # 28f1 <irqCallback+0x19>
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
     408:	8dc70713          	addi	a4,a4,-1828 # 28dc <irqCallback+0x4>
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
     558:	8fd60613          	addi	a2,a2,-1795 # 28fd <irqCallback+0x25>
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
     6d0:	90960613          	addi	a2,a2,-1783 # 2909 <irqCallback+0x31>
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
     8ac:	8dc70713          	addi	a4,a4,-1828 # 28dc <irqCallback+0x4>
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
     be8:	91570713          	addi	a4,a4,-1771 # 2915 <irqCallback+0x3d>
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
     c4c:	b1170493          	addi	s1,a4,-1263 # 2b11 <irqCallback+0x239>
    while (*p)
     c50:	02000793          	li	a5,32
        putchar(*(p++));
     c54:	b1170713          	addi	a4,a4,-1263
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
     c88:	8dc40413          	addi	s0,s0,-1828 # 28dc <irqCallback+0x4>
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
     de4:	92570713          	addi	a4,a4,-1755 # 2925 <irqCallback+0x4d>
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
     e24:	92d70713          	addi	a4,a4,-1747 # 292d <irqCallback+0x55>
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
     ff8:	93970713          	addi	a4,a4,-1735 # 2939 <irqCallback+0x61>
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
    1038:	93170713          	addi	a4,a4,-1743 # 2931 <irqCallback+0x59>
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
    120c:	94570713          	addi	a4,a4,-1723 # 2945 <irqCallback+0x6d>
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
    159c:	e7010113          	addi	sp,sp,-400
    15a0:	18112623          	sw	ra,396(sp)
    15a4:	18812423          	sw	s0,392(sp)
    15a8:	18912223          	sw	s1,388(sp)
    15ac:	19212023          	sw	s2,384(sp)
    15b0:	17312e23          	sw	s3,380(sp)
    15b4:	17412c23          	sw	s4,376(sp)
    15b8:	17512a23          	sw	s5,372(sp)
    15bc:	17612823          	sw	s6,368(sp)
    15c0:	17712623          	sw	s7,364(sp)
    15c4:	17812423          	sw	s8,360(sp)
    15c8:	17912223          	sw	s9,356(sp)
    15cc:	17a12023          	sw	s10,352(sp)
    15d0:	15b12e23          	sw	s11,348(sp)
    UART0->CLKDIV = CLK_FREQ / UART_BAUD - 2;
    15d4:	830006b7          	lui	a3,0x83000
    15d8:	0d800793          	li	a5,216
    15dc:	00f6a223          	sw	a5,4(a3) # 83000004 <__global_pointer$+0x42fff804>

    GPIO0->OE = 0x3F;
    15e0:	03f00713          	li	a4,63
    15e4:	820007b7          	lui	a5,0x82000
    15e8:	00e7a423          	sw	a4,8(a5) # 82000008 <__global_pointer$+0x41fff808>
    GPIO0->OUT = 0x3F;
    15ec:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG |= QSPI_REG_CRM;
    15f0:	810007b7          	lui	a5,0x81000
    15f4:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    15f8:	00100637          	lui	a2,0x100
    if (c == '\n')
    15fc:	00a00593          	li	a1,10
        QSPI0->REG |= QSPI_REG_CRM;
    1600:	00c76733          	or	a4,a4,a2
    1604:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG |= QSPI_REG_DSPI;
    1608:	0007a703          	lw	a4,0(a5)
    160c:	00400637          	lui	a2,0x400
    1610:	00c76733          	or	a4,a4,a2
    1614:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
    1618:	05c00793          	li	a5,92
        putchar(*(p++));
    161c:	00003737          	lui	a4,0x3
    UART0->DATA = c;
    1620:	00f6a023          	sw	a5,0(a3)
        putchar(*(p++));
    1624:	95970713          	addi	a4,a4,-1703 # 2959 <irqCallback+0x81>
    while (*p)
    1628:	06e00793          	li	a5,110
        UART0->DATA = '\r';
    162c:	00d00613          	li	a2,13
        putchar(*(p++));
    1630:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1634:	6eb78663          	beq	a5,a1,1d20 <main+0x784>
    UART0->DATA = c;
    1638:	00f6a023          	sw	a5,0(a3)
    while (*p)
    163c:	00074783          	lbu	a5,0(a4)
    1640:	fe0798e3          	bnez	a5,1630 <main+0x94>
    UART0->DATA = c;
    1644:	830007b7          	lui	a5,0x83000
    1648:	02000713          	li	a4,32
    164c:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
        putchar(*(p++));
    1650:	00003737          	lui	a4,0x3
    1654:	96170713          	addi	a4,a4,-1695 # 2961 <irqCallback+0x89>
    while (*p)
    1658:	02000793          	li	a5,32
    if (c == '\n')
    165c:	00a00593          	li	a1,10
    UART0->DATA = c;
    1660:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
    1664:	00d00613          	li	a2,13
        putchar(*(p++));
    1668:	00170713          	addi	a4,a4,1
    if (c == '\n')
    166c:	6cb78463          	beq	a5,a1,1d34 <main+0x798>
    UART0->DATA = c;
    1670:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff800>
    while (*p)
    1674:	00074783          	lbu	a5,0(a4)
    1678:	fe0798e3          	bnez	a5,1668 <main+0xcc>
        UART0->DATA = '\r';
    167c:	830007b7          	lui	a5,0x83000
    1680:	00d00713          	li	a4,13
    1684:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff800>
    UART0->DATA = c;
    1688:	00a00713          	li	a4,10
    168c:	00e7a023          	sw	a4,0(a5)
    //print(" |_|   |_|\\___\\___/____/ \\___/ \\____|\n");
    //print("\n");
    print("           On Lichee Tang Nano-9K by Peter Glen\n");
    print("\n");

    for ( i = 0 ; i < 10000; i++);
    1690:	400007b7          	lui	a5,0x40000
    1694:	00478793          	addi	a5,a5,4 # 40000004 <i>
    1698:	0007a023          	sw	zero,0(a5)
    169c:	0007a683          	lw	a3,0(a5)
    16a0:	00002737          	lui	a4,0x2
    16a4:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    16a8:	00d74c63          	blt	a4,a3,16c0 <main+0x124>
    16ac:	0007a683          	lw	a3,0(a5)
    16b0:	00168693          	addi	a3,a3,1
    16b4:	00d7a023          	sw	a3,0(a5)
    16b8:	0007a683          	lw	a3,0(a5)
    16bc:	fed758e3          	bge	a4,a3,16ac <main+0x110>
    GPIO0->OUT = 0x3F ^ 0x01;
    16c0:	82000737          	lui	a4,0x82000
    16c4:	03e00693          	li	a3,62
    16c8:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    16cc:	0007a023          	sw	zero,0(a5)
    16d0:	0007a683          	lw	a3,0(a5)
    16d4:	00002737          	lui	a4,0x2
    16d8:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    16dc:	00d74c63          	blt	a4,a3,16f4 <main+0x158>
    16e0:	0007a683          	lw	a3,0(a5)
    16e4:	00168693          	addi	a3,a3,1
    16e8:	00d7a023          	sw	a3,0(a5)
    16ec:	0007a683          	lw	a3,0(a5)
    16f0:	fed758e3          	bge	a4,a3,16e0 <main+0x144>
    GPIO0->OUT = 0x3F ^ 0x02;
    16f4:	82000737          	lui	a4,0x82000
    16f8:	03d00693          	li	a3,61
    16fc:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1700:	0007a023          	sw	zero,0(a5)
    1704:	0007a683          	lw	a3,0(a5)
    1708:	00002737          	lui	a4,0x2
    170c:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1710:	00d74c63          	blt	a4,a3,1728 <main+0x18c>
    1714:	0007a683          	lw	a3,0(a5)
    1718:	00168693          	addi	a3,a3,1
    171c:	00d7a023          	sw	a3,0(a5)
    1720:	0007a683          	lw	a3,0(a5)
    1724:	fed758e3          	bge	a4,a3,1714 <main+0x178>
    GPIO0->OUT = 0x3F ^ 0x04;
    1728:	82000737          	lui	a4,0x82000
    172c:	03b00693          	li	a3,59
    1730:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1734:	0007a023          	sw	zero,0(a5)
    1738:	0007a683          	lw	a3,0(a5)
    173c:	00002737          	lui	a4,0x2
    1740:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1744:	00d74c63          	blt	a4,a3,175c <main+0x1c0>
    1748:	0007a683          	lw	a3,0(a5)
    174c:	00168693          	addi	a3,a3,1
    1750:	00d7a023          	sw	a3,0(a5)
    1754:	0007a683          	lw	a3,0(a5)
    1758:	fed758e3          	bge	a4,a3,1748 <main+0x1ac>
    GPIO0->OUT = 0x3F ^ 0x08;
    175c:	82000737          	lui	a4,0x82000
    1760:	03700693          	li	a3,55
    1764:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1768:	0007a023          	sw	zero,0(a5)
    176c:	0007a683          	lw	a3,0(a5)
    1770:	00002737          	lui	a4,0x2
    1774:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1778:	00d74c63          	blt	a4,a3,1790 <main+0x1f4>
    177c:	0007a683          	lw	a3,0(a5)
    1780:	00168693          	addi	a3,a3,1
    1784:	00d7a023          	sw	a3,0(a5)
    1788:	0007a683          	lw	a3,0(a5)
    178c:	fed758e3          	bge	a4,a3,177c <main+0x1e0>
    GPIO0->OUT = 0x3F ^ 0x10;
    1790:	82000737          	lui	a4,0x82000
    1794:	02f00693          	li	a3,47
    1798:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    179c:	0007a023          	sw	zero,0(a5)
    17a0:	0007a683          	lw	a3,0(a5)
    17a4:	00002737          	lui	a4,0x2
    17a8:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    17ac:	00d74c63          	blt	a4,a3,17c4 <main+0x228>
    17b0:	0007a683          	lw	a3,0(a5)
    17b4:	00168693          	addi	a3,a3,1
    17b8:	00d7a023          	sw	a3,0(a5)
    17bc:	0007a683          	lw	a3,0(a5)
    17c0:	fed758e3          	bge	a4,a3,17b0 <main+0x214>
    GPIO0->OUT = 0x3F ^ 0x20;
    17c4:	82000737          	lui	a4,0x82000
    17c8:	01f00693          	li	a3,31
    17cc:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    17d0:	0007a023          	sw	zero,0(a5)
    17d4:	0007a683          	lw	a3,0(a5)
    17d8:	00002737          	lui	a4,0x2
    17dc:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    17e0:	00d74c63          	blt	a4,a3,17f8 <main+0x25c>
    17e4:	0007a683          	lw	a3,0(a5)
    17e8:	00168693          	addi	a3,a3,1
    17ec:	00d7a023          	sw	a3,0(a5)
    17f0:	0007a683          	lw	a3,0(a5)
    17f4:	fed758e3          	bge	a4,a3,17e4 <main+0x248>
    GPIO0->OUT = 0x3F;
    17f8:	82000737          	lui	a4,0x82000
    17fc:	03f00693          	li	a3,63
    1800:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1804:	0007a023          	sw	zero,0(a5)
    1808:	0007a683          	lw	a3,0(a5)
    180c:	00002737          	lui	a4,0x2
    1810:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1814:	00d74c63          	blt	a4,a3,182c <main+0x290>
    1818:	0007a683          	lw	a3,0(a5)
    181c:	00168693          	addi	a3,a3,1
    1820:	00d7a023          	sw	a3,0(a5)
    1824:	0007a683          	lw	a3,0(a5)
    1828:	fed758e3          	bge	a4,a3,1818 <main+0x27c>
    GPIO0->OUT = 0x00;
    182c:	82000737          	lui	a4,0x82000
    1830:	00072023          	sw	zero,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1834:	0007a023          	sw	zero,0(a5)
    1838:	0007a683          	lw	a3,0(a5)
    183c:	00002737          	lui	a4,0x2
    1840:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1844:	00d74c63          	blt	a4,a3,185c <main+0x2c0>
    1848:	0007a683          	lw	a3,0(a5)
    184c:	00168693          	addi	a3,a3,1
    1850:	00d7a023          	sw	a3,0(a5)
    1854:	0007a683          	lw	a3,0(a5)
    1858:	fed758e3          	bge	a4,a3,1848 <main+0x2ac>
    GPIO0->OUT = 0x3F;
    185c:	82000737          	lui	a4,0x82000
    1860:	03f00693          	li	a3,63
    1864:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff800>
    for ( i = 0 ; i < 10000; i++);
    1868:	0007a023          	sw	zero,0(a5)
    186c:	0007a683          	lw	a3,0(a5)
    1870:	00002737          	lui	a4,0x2
    1874:	70f70713          	addi	a4,a4,1807 # 270f <main+0x1173>
    1878:	00d74c63          	blt	a4,a3,1890 <main+0x2f4>
    187c:	0007a683          	lw	a3,0(a5)
    1880:	00168693          	addi	a3,a3,1
    1884:	00d7a023          	sw	a3,0(a5)
    1888:	0007a683          	lw	a3,0(a5)
    188c:	fed758e3          	bge	a4,a3,187c <main+0x2e0>
    1890:	000039b7          	lui	s3,0x3
    1894:	99598793          	addi	a5,s3,-1643 # 2995 <irqCallback+0xbd>
    1898:	02f12823          	sw	a5,48(sp)
    189c:	000037b7          	lui	a5,0x3
    18a0:	9c178793          	addi	a5,a5,-1599 # 29c1 <irqCallback+0xe9>
    18a4:	02f12a23          	sw	a5,52(sp)
    18a8:	000037b7          	lui	a5,0x3
    18ac:	9d978793          	addi	a5,a5,-1575 # 29d9 <irqCallback+0x101>
    18b0:	02f12c23          	sw	a5,56(sp)
    18b4:	000037b7          	lui	a5,0x3
    18b8:	9f178793          	addi	a5,a5,-1551 # 29f1 <irqCallback+0x119>
    18bc:	02f12e23          	sw	a5,60(sp)
    18c0:	000037b7          	lui	a5,0x3
    18c4:	a0978793          	addi	a5,a5,-1527 # 2a09 <irqCallback+0x131>
    18c8:	04f12023          	sw	a5,64(sp)
    18cc:	000037b7          	lui	a5,0x3
    18d0:	a2178793          	addi	a5,a5,-1503 # 2a21 <irqCallback+0x149>
    18d4:	00f12423          	sw	a5,8(sp)
    18d8:	000037b7          	lui	a5,0x3
    18dc:	a3978793          	addi	a5,a5,-1479 # 2a39 <irqCallback+0x161>
    18e0:	00f12623          	sw	a5,12(sp)
    18e4:	000037b7          	lui	a5,0x3
    18e8:	a5178793          	addi	a5,a5,-1455 # 2a51 <irqCallback+0x179>
    18ec:	00f12823          	sw	a5,16(sp)
    18f0:	000037b7          	lui	a5,0x3
    18f4:	a6d78793          	addi	a5,a5,-1427 # 2a6d <irqCallback+0x195>
    18f8:	00f12a23          	sw	a5,20(sp)
    18fc:	000037b7          	lui	a5,0x3
    1900:	a8978793          	addi	a5,a5,-1399 # 2a89 <irqCallback+0x1b1>
    1904:	00f12c23          	sw	a5,24(sp)
    1908:	000037b7          	lui	a5,0x3
    190c:	aa178793          	addi	a5,a5,-1375 # 2aa1 <irqCallback+0x1c9>
    1910:	00f12e23          	sw	a5,28(sp)
    1914:	000037b7          	lui	a5,0x3
    1918:	abd78793          	addi	a5,a5,-1347 # 2abd <irqCallback+0x1e5>
    191c:	02f12023          	sw	a5,32(sp)
    1920:	000037b7          	lui	a5,0x3
    1924:	ae978793          	addi	a5,a5,-1303 # 2ae9 <irqCallback+0x211>
    1928:	02f12223          	sw	a5,36(sp)
    192c:	000037b7          	lui	a5,0x3
    1930:	b2d78793          	addi	a5,a5,-1235 # 2b2d <irqCallback+0x255>
    1934:	000034b7          	lui	s1,0x3
    1938:	02f12423          	sw	a5,40(sp)
    193c:	b3548793          	addi	a5,s1,-1227 # 2b35 <irqCallback+0x25d>
    1940:	00f12023          	sw	a5,0(sp)
    1944:	000037b7          	lui	a5,0x3
    1948:	b4178793          	addi	a5,a5,-1215 # 2b41 <irqCallback+0x269>
    194c:	02f12623          	sw	a5,44(sp)
    1950:	000037b7          	lui	a5,0x3
    1954:	8f178793          	addi	a5,a5,-1807 # 28f1 <irqCallback+0x19>
    1958:	04f12223          	sw	a5,68(sp)
    195c:	000037b7          	lui	a5,0x3
    1960:	8fd78793          	addi	a5,a5,-1795 # 28fd <irqCallback+0x25>
    1964:	04f12423          	sw	a5,72(sp)
    1968:	000037b7          	lui	a5,0x3
    196c:	90978793          	addi	a5,a5,-1783 # 2909 <irqCallback+0x31>
        QSPI0->REG &= ~QSPI_REG_CRM;
    1970:	fff00437          	lui	s0,0xfff00
    1974:	00003fb7          	lui	t6,0x3
    1978:	00003c37          	lui	s8,0x3
    197c:	00003cb7          	lui	s9,0x3
    1980:	00003d37          	lui	s10,0x3
    1984:	000032b7          	lui	t0,0x3
    1988:	00003937          	lui	s2,0x3
    198c:	04f12623          	sw	a5,76(sp)
    1990:	00003eb7          	lui	t4,0x3
    1994:	fff40793          	addi	a5,s0,-1 # ffefffff <__global_pointer$+0xbfeff7ff>
    1998:	9a9f8f93          	addi	t6,t6,-1623 # 29a9 <irqCallback+0xd1>
    199c:	8dcc0c13          	addi	s8,s8,-1828 # 28dc <irqCallback+0x4>
    19a0:	b15c8c93          	addi	s9,s9,-1259 # 2b15 <irqCallback+0x23d>
    19a4:	b48d0d13          	addi	s10,s10,-1208 # 2b48 <irqCallback+0x270>
    19a8:	b2128293          	addi	t0,t0,-1247 # 2b21 <irqCallback+0x249>
    19ac:	b3990913          	addi	s2,s2,-1223 # 2b39 <irqCallback+0x261>
    19b0:	b09e8493          	addi	s1,t4,-1271 # 2b09 <irqCallback+0x231>
        UART0->DATA = '\r';
    19b4:	83000ab7          	lui	s5,0x83000
    19b8:	00d00b93          	li	s7,13
    UART0->DATA = c;
    19bc:	00a00b13          	li	s6,10
    19c0:	02000993          	li	s3,32
        QSPI0->REG &= ~QSPI_REG_CRM;
    19c4:	00f12223          	sw	a5,4(sp)
        UART0->DATA = '\r';
    19c8:	00d00793          	li	a5,13
    19cc:	00faa023          	sw	a5,0(s5) # 83000000 <__global_pointer$+0x42fff800>
        putchar(*(p++));
    19d0:	03012703          	lw	a4,48(sp)
    UART0->DATA = c;
    19d4:	05300793          	li	a5,83
    19d8:	016aa023          	sw	s6,0(s5)
    19dc:	00faa023          	sw	a5,0(s5)
    while (*p)
    19e0:	06500793          	li	a5,101
        putchar(*(p++));
    19e4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    19e8:	2b6786e3          	beq	a5,s6,2494 <main+0xef8>
    UART0->DATA = c;
    19ec:	00faa023          	sw	a5,0(s5)
    while (*p)
    19f0:	00074783          	lbu	a5,0(a4)
    19f4:	fe0798e3          	bnez	a5,19e4 <main+0x448>
        UART0->DATA = '\r';
    19f8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    19fc:	016aa023          	sw	s6,0(s5)
    1a00:	013aa023          	sw	s3,0(s5)
        putchar(*(p++));
    1a04:	000f8713          	mv	a4,t6
    while (*p)
    1a08:	02000793          	li	a5,32
        putchar(*(p++));
    1a0c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a10:	276788e3          	beq	a5,s6,2480 <main+0xee4>
    UART0->DATA = c;
    1a14:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a18:	00074783          	lbu	a5,0(a4)
    1a1c:	fe0798e3          	bnez	a5,1a0c <main+0x470>
        putchar(*(p++));
    1a20:	03412703          	lw	a4,52(sp)
    UART0->DATA = c;
    1a24:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a28:	02000793          	li	a5,32
        putchar(*(p++));
    1a2c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a30:	23678ee3          	beq	a5,s6,246c <main+0xed0>
    UART0->DATA = c;
    1a34:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a38:	00074783          	lbu	a5,0(a4)
    1a3c:	fe0798e3          	bnez	a5,1a2c <main+0x490>
        putchar(*(p++));
    1a40:	03812703          	lw	a4,56(sp)
    UART0->DATA = c;
    1a44:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a48:	02000793          	li	a5,32
        putchar(*(p++));
    1a4c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a50:	216784e3          	beq	a5,s6,2458 <main+0xebc>
    UART0->DATA = c;
    1a54:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a58:	00074783          	lbu	a5,0(a4)
    1a5c:	fe0798e3          	bnez	a5,1a4c <main+0x4b0>
        putchar(*(p++));
    1a60:	03c12703          	lw	a4,60(sp)
    UART0->DATA = c;
    1a64:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a68:	02000793          	li	a5,32
        putchar(*(p++));
    1a6c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a70:	1d678ae3          	beq	a5,s6,2444 <main+0xea8>
    UART0->DATA = c;
    1a74:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a78:	00074783          	lbu	a5,0(a4)
    1a7c:	fe0798e3          	bnez	a5,1a6c <main+0x4d0>
        putchar(*(p++));
    1a80:	04012703          	lw	a4,64(sp)
    UART0->DATA = c;
    1a84:	013aa023          	sw	s3,0(s5)
    while (*p)
    1a88:	02000793          	li	a5,32
        putchar(*(p++));
    1a8c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a90:	1b6780e3          	beq	a5,s6,2430 <main+0xe94>
    UART0->DATA = c;
    1a94:	00faa023          	sw	a5,0(s5)
    while (*p)
    1a98:	00074783          	lbu	a5,0(a4)
    1a9c:	fe0798e3          	bnez	a5,1a8c <main+0x4f0>
        putchar(*(p++));
    1aa0:	00812703          	lw	a4,8(sp)
    UART0->DATA = c;
    1aa4:	013aa023          	sw	s3,0(s5)
    while (*p)
    1aa8:	02000793          	li	a5,32
        putchar(*(p++));
    1aac:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1ab0:	176786e3          	beq	a5,s6,241c <main+0xe80>
    UART0->DATA = c;
    1ab4:	00faa023          	sw	a5,0(s5)
    while (*p)
    1ab8:	00074783          	lbu	a5,0(a4)
    1abc:	fe0798e3          	bnez	a5,1aac <main+0x510>
        putchar(*(p++));
    1ac0:	00c12703          	lw	a4,12(sp)
    UART0->DATA = c;
    1ac4:	013aa023          	sw	s3,0(s5)
    while (*p)
    1ac8:	02000793          	li	a5,32
        putchar(*(p++));
    1acc:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1ad0:	13678ce3          	beq	a5,s6,2408 <main+0xe6c>
    UART0->DATA = c;
    1ad4:	00faa023          	sw	a5,0(s5)
    while (*p)
    1ad8:	00074783          	lbu	a5,0(a4)
    1adc:	fe0798e3          	bnez	a5,1acc <main+0x530>
        putchar(*(p++));
    1ae0:	01012703          	lw	a4,16(sp)
    UART0->DATA = c;
    1ae4:	013aa023          	sw	s3,0(s5)
    while (*p)
    1ae8:	02000793          	li	a5,32
        putchar(*(p++));
    1aec:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1af0:	1f678ae3          	beq	a5,s6,24e4 <main+0xf48>
    UART0->DATA = c;
    1af4:	00faa023          	sw	a5,0(s5)
    while (*p)
    1af8:	00074783          	lbu	a5,0(a4)
    1afc:	fe0798e3          	bnez	a5,1aec <main+0x550>
        putchar(*(p++));
    1b00:	01412703          	lw	a4,20(sp)
    UART0->DATA = c;
    1b04:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b08:	02000793          	li	a5,32
        putchar(*(p++));
    1b0c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b10:	1d6780e3          	beq	a5,s6,24d0 <main+0xf34>
    UART0->DATA = c;
    1b14:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b18:	00074783          	lbu	a5,0(a4)
    1b1c:	fe0798e3          	bnez	a5,1b0c <main+0x570>
        putchar(*(p++));
    1b20:	01812703          	lw	a4,24(sp)
    UART0->DATA = c;
    1b24:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b28:	02000793          	li	a5,32
        putchar(*(p++));
    1b2c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b30:	196786e3          	beq	a5,s6,24bc <main+0xf20>
    UART0->DATA = c;
    1b34:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b38:	00074783          	lbu	a5,0(a4)
    1b3c:	fe0798e3          	bnez	a5,1b2c <main+0x590>
        putchar(*(p++));
    1b40:	01c12703          	lw	a4,28(sp)
    UART0->DATA = c;
    1b44:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b48:	02000793          	li	a5,32
        putchar(*(p++));
    1b4c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b50:	15678ce3          	beq	a5,s6,24a8 <main+0xf0c>
    UART0->DATA = c;
    1b54:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b58:	00074783          	lbu	a5,0(a4)
    1b5c:	fe0798e3          	bnez	a5,1b4c <main+0x5b0>
        putchar(*(p++));
    1b60:	02012703          	lw	a4,32(sp)
    UART0->DATA = c;
    1b64:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b68:	02000793          	li	a5,32
        putchar(*(p++));
    1b6c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b70:	19678ee3          	beq	a5,s6,250c <main+0xf70>
    UART0->DATA = c;
    1b74:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b78:	00074783          	lbu	a5,0(a4)
    1b7c:	fe0798e3          	bnez	a5,1b6c <main+0x5d0>
        putchar(*(p++));
    1b80:	02412703          	lw	a4,36(sp)
    UART0->DATA = c;
    1b84:	013aa023          	sw	s3,0(s5)
    while (*p)
    1b88:	02000793          	li	a5,32
        putchar(*(p++));
    1b8c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1b90:	176784e3          	beq	a5,s6,24f8 <main+0xf5c>
    UART0->DATA = c;
    1b94:	00faa023          	sw	a5,0(s5)
    while (*p)
    1b98:	00074783          	lbu	a5,0(a4)
    1b9c:	fe0798e3          	bnez	a5,1b8c <main+0x5f0>
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1ba0:	ffc00437          	lui	s0,0xffc00
    while (*p)
    1ba4:	00a00a13          	li	s4,10
    UART0->DATA = c;
    1ba8:	04900d93          	li	s11,73
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1bac:	fff40413          	addi	s0,s0,-1 # ffbfffff <__global_pointer$+0xbfbff7ff>
        UART0->DATA = '\r';
    1bb0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1bb4:	016aa023          	sw	s6,0(s5)
    1bb8:	01baa023          	sw	s11,0(s5)
        putchar(*(p++));
    1bbc:	00048713          	mv	a4,s1
    while (*p)
    1bc0:	04f00793          	li	a5,79
        putchar(*(p++));
    1bc4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1bc8:	73678e63          	beq	a5,s6,2304 <main+0xd68>
    UART0->DATA = c;
    1bcc:	00faa023          	sw	a5,0(s5)
    while (*p)
    1bd0:	00074783          	lbu	a5,0(a4)
    1bd4:	fe0798e3          	bnez	a5,1bc4 <main+0x628>

        for (int rep = 10; rep > 0; rep--)
        {
            print("\n");
            print("IO State: ");
            print_hex(GPIO0->IN, 8);
    1bd8:	820007b7          	lui	a5,0x82000
    1bdc:	0047a783          	lw	a5,4(a5) # 82000004 <__global_pointer$+0x41fff804>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1be0:	01c7d713          	srli	a4,a5,0x1c
    1be4:	00ec0733          	add	a4,s8,a4
    1be8:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    1bec:	75660063          	beq	a2,s6,232c <main+0xd90>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1bf0:	0187d713          	srli	a4,a5,0x18
    1bf4:	00f77713          	andi	a4,a4,15
    1bf8:	00ec0733          	add	a4,s8,a4
    1bfc:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    1c00:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    1c04:	75668263          	beq	a3,s6,2348 <main+0xdac>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c08:	0147d713          	srli	a4,a5,0x14
    1c0c:	00f77713          	andi	a4,a4,15
    1c10:	00ec0733          	add	a4,s8,a4
    1c14:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    1c18:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1c1c:	75660463          	beq	a2,s6,2364 <main+0xdc8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c20:	0107d713          	srli	a4,a5,0x10
    1c24:	00f77713          	andi	a4,a4,15
    1c28:	00ec0733          	add	a4,s8,a4
    1c2c:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    1c30:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    1c34:	75668663          	beq	a3,s6,2380 <main+0xde4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c38:	00c7d713          	srli	a4,a5,0xc
    1c3c:	00f77713          	andi	a4,a4,15
    1c40:	00ec0733          	add	a4,s8,a4
    1c44:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    1c48:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1c4c:	75660863          	beq	a2,s6,239c <main+0xe00>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c50:	0087d713          	srli	a4,a5,0x8
    1c54:	00f77713          	andi	a4,a4,15
    1c58:	00ec0733          	add	a4,s8,a4
    1c5c:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    1c60:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    1c64:	75668a63          	beq	a3,s6,23b8 <main+0xe1c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c68:	0047d713          	srli	a4,a5,0x4
    1c6c:	00f77713          	andi	a4,a4,15
    1c70:	00ec0733          	add	a4,s8,a4
    1c74:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    1c78:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1c7c:	75670c63          	beq	a4,s6,23d4 <main+0xe38>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1c80:	00f7f793          	andi	a5,a5,15
    1c84:	00fc07b3          	add	a5,s8,a5
    1c88:	0007c783          	lbu	a5,0(a5)
    UART0->DATA = c;
    1c8c:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    1c90:	75678e63          	beq	a5,s6,23ec <main+0xe50>
    UART0->DATA = c;
    1c94:	00faa023          	sw	a5,0(s5)
        UART0->DATA = '\r';
    1c98:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1c9c:	016aa023          	sw	s6,0(s5)
        UART0->DATA = '\r';
    1ca0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1ca4:	04300793          	li	a5,67
    1ca8:	016aa023          	sw	s6,0(s5)
    1cac:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1cb0:	000c8713          	mv	a4,s9
    while (*p)
    1cb4:	06f00793          	li	a5,111
        putchar(*(p++));
    1cb8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1cbc:	73678c63          	beq	a5,s6,23f4 <main+0xe58>
    UART0->DATA = c;
    1cc0:	00faa023          	sw	a5,0(s5)
    while (*p)
    1cc4:	00074783          	lbu	a5,0(a4)
    1cc8:	fe0798e3          	bnez	a5,1cb8 <main+0x71c>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
    1ccc:	c00027f3          	rdcycle	a5
    while (c == -1) {
    1cd0:	fff00713          	li	a4,-1
        __asm__ volatile ("rdcycle %0" : "=r"(cycles_now));
    1cd4:	c00027f3          	rdcycle	a5
        c = UART0->DATA;
    1cd8:	000aa783          	lw	a5,0(s5)
    while (c == -1) {
    1cdc:	fee78ce3          	beq	a5,a4,1cd4 <main+0x738>
            print("\n");
            print("\n");

            print("Command> ");
            char cmd = getchar();
            if (cmd > 32 && cmd < 127)
    1ce0:	fdf78713          	addi	a4,a5,-33
    1ce4:	0ff77713          	andi	a4,a4,255
    1ce8:	05d00693          	li	a3,93
    1cec:	0ff7f793          	andi	a5,a5,255
    1cf0:	00e6e663          	bltu	a3,a4,1cfc <main+0x760>
    if (c == '\n')
    1cf4:	57678063          	beq	a5,s6,2254 <main+0xcb8>
    UART0->DATA = c;
    1cf8:	00faa023          	sw	a5,0(s5)
        UART0->DATA = '\r';
    1cfc:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1d00:	016aa023          	sw	s6,0(s5)
                putchar(cmd);
            print("\n");

            switch (cmd)
    1d04:	fcf78793          	addi	a5,a5,-49
    1d08:	04200713          	li	a4,66
    1d0c:	06f76063          	bltu	a4,a5,1d6c <main+0x7d0>
    1d10:	00279793          	slli	a5,a5,0x2
    1d14:	00fd07b3          	add	a5,s10,a5
    1d18:	0007a783          	lw	a5,0(a5)
    1d1c:	00078067          	jr	a5
        UART0->DATA = '\r';
    1d20:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1d24:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1d28:	00074783          	lbu	a5,0(a4)
    1d2c:	900792e3          	bnez	a5,1630 <main+0x94>
    1d30:	915ff06f          	j	1644 <main+0xa8>
        UART0->DATA = '\r';
    1d34:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1d38:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1d3c:	00074783          	lbu	a5,0(a4)
    1d40:	920794e3          	bnez	a5,1668 <main+0xcc>
    1d44:	939ff06f          	j	167c <main+0xe0>
        QSPI0->REG &= ~QSPI_REG_CRM;
    1d48:	810007b7          	lui	a5,0x81000
    1d4c:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1d50:	00412683          	lw	a3,4(sp)
    1d54:	00d77733          	and	a4,a4,a3
        QSPI0->REG |= QSPI_REG_CRM;
    1d58:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG |= QSPI_REG_DSPI;
    1d5c:	0007a703          	lw	a4,0(a5)
    1d60:	004006b7          	lui	a3,0x400
    1d64:	00d76733          	or	a4,a4,a3
    1d68:	00e7a023          	sw	a4,0(a5)
        for (int rep = 10; rep > 0; rep--)
    1d6c:	fffa0a13          	addi	s4,s4,-1
    1d70:	e40a10e3          	bnez	s4,1bb0 <main+0x614>
    1d74:	c55ff06f          	j	19c8 <main+0x42c>
        UART0->DATA = '\r';
    1d78:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1d7c:	05300793          	li	a5,83
    1d80:	016aa023          	sw	s6,0(s5)
    1d84:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1d88:	00028713          	mv	a4,t0
    while (*p)
    1d8c:	05000793          	li	a5,80
        putchar(*(p++));
    1d90:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1d94:	176780e3          	beq	a5,s6,26f4 <main+0x1158>
    UART0->DATA = c;
    1d98:	00faa023          	sw	a5,0(s5)
    while (*p)
    1d9c:	00074783          	lbu	a5,0(a4)
    1da0:	fe0798e3          	bnez	a5,1d90 <main+0x7f4>
        putchar(*(p++));
    1da4:	02812703          	lw	a4,40(sp)
    UART0->DATA = c;
    1da8:	013aa023          	sw	s3,0(s5)
    while (*p)
    1dac:	02000793          	li	a5,32
        putchar(*(p++));
    1db0:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1db4:	2b6786e3          	beq	a5,s6,2860 <main+0x12c4>
    UART0->DATA = c;
    1db8:	00faa023          	sw	a5,0(s5)
    while (*p)
    1dbc:	00074783          	lbu	a5,0(a4)
    1dc0:	fe0798e3          	bnez	a5,1db0 <main+0x814>
    return QSPI0->REG & QSPI_REG_DSPI;
    1dc4:	810007b7          	lui	a5,0x81000
    1dc8:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1dcc:	00400737          	lui	a4,0x400
    1dd0:	00e7f7b3          	and	a5,a5,a4
            case 'F':
            case 'f':
                print("\n");
                print("SPI State:\n");
                print("  DSPI ");
                if ( cmd_get_dspi() )
    1dd4:	2a0798e3          	bnez	a5,2884 <main+0x12e8>
    UART0->DATA = c;
    1dd8:	04f00793          	li	a5,79
    1ddc:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1de0:	00090713          	mv	a4,s2
    while (*p)
    1de4:	04600793          	li	a5,70
        putchar(*(p++));
    1de8:	00170713          	addi	a4,a4,1 # 400001 <_etext+0x3fd3ad>
    if (c == '\n')
    1dec:	2d678ce3          	beq	a5,s6,28c4 <main+0x1328>
    UART0->DATA = c;
    1df0:	00faa023          	sw	a5,0(s5)
    while (*p)
    1df4:	00074783          	lbu	a5,0(a4)
    1df8:	fe0798e3          	bnez	a5,1de8 <main+0x84c>
        putchar(*(p++));
    1dfc:	02c12703          	lw	a4,44(sp)
    UART0->DATA = c;
    1e00:	013aa023          	sw	s3,0(s5)
    while (*p)
    1e04:	02000793          	li	a5,32
        putchar(*(p++));
    1e08:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1e0c:	1f6784e3          	beq	a5,s6,27f4 <main+0x1258>
    UART0->DATA = c;
    1e10:	00faa023          	sw	a5,0(s5)
    while (*p)
    1e14:	00074783          	lbu	a5,0(a4)
    1e18:	fe0798e3          	bnez	a5,1e08 <main+0x86c>
    return QSPI0->REG & QSPI_REG_CRM;
    1e1c:	810007b7          	lui	a5,0x81000
    1e20:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1e24:	00100737          	lui	a4,0x100
    1e28:	00e7f7b3          	and	a5,a5,a4
                    print("ON\n");
                else
                    print("OFF\n");
                print("  CRM  ");
                if ( cmd_get_crm() )
    1e2c:	1e0796e3          	bnez	a5,2818 <main+0x127c>
    UART0->DATA = c;
    1e30:	04f00793          	li	a5,79
    1e34:	00faa023          	sw	a5,0(s5)
        putchar(*(p++));
    1e38:	00090713          	mv	a4,s2
    while (*p)
    1e3c:	04600793          	li	a5,70
        putchar(*(p++));
    1e40:	00170713          	addi	a4,a4,1 # 100001 <_etext+0xfd3ad>
    if (c == '\n')
    1e44:	01678c63          	beq	a5,s6,1e5c <main+0x8c0>
    UART0->DATA = c;
    1e48:	00faa023          	sw	a5,0(s5)
    while (*p)
    1e4c:	00074783          	lbu	a5,0(a4)
    1e50:	f0078ee3          	beqz	a5,1d6c <main+0x7d0>
        putchar(*(p++));
    1e54:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1e58:	ff6798e3          	bne	a5,s6,1e48 <main+0x8ac>
        UART0->DATA = '\r';
    1e5c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    1e60:	00faa023          	sw	a5,0(s5)
    while (*p)
    1e64:	00074783          	lbu	a5,0(a4)
    1e68:	fc079ce3          	bnez	a5,1e40 <main+0x8a4>
        for (int rep = 10; rep > 0; rep--)
    1e6c:	fffa0a13          	addi	s4,s4,-1
    1e70:	d40a10e3          	bnez	s4,1bb0 <main+0x614>
    1e74:	b55ff06f          	j	19c8 <main+0x42c>

                break;

            case 'I':
            case 'i':
                cmd_read_flash_id();
    1e78:	abcfe0ef          	jal	ra,134 <cmd_read_flash_id>
                break;
    1e7c:	000037b7          	lui	a5,0x3
    1e80:	b2178293          	addi	t0,a5,-1247 # 2b21 <irqCallback+0x249>
        for (int rep = 10; rep > 0; rep--)
    1e84:	fffa0a13          	addi	s4,s4,-1
                break;
    1e88:	000037b7          	lui	a5,0x3
    1e8c:	9a978f93          	addi	t6,a5,-1623 # 29a9 <irqCallback+0xd1>
        for (int rep = 10; rep > 0; rep--)
    1e90:	d20a10e3          	bnez	s4,1bb0 <main+0x614>
    1e94:	b35ff06f          	j	19c8 <main+0x42c>
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1e98:	810007b7          	lui	a5,0x81000
    1e9c:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
        QSPI0->REG &= ~QSPI_REG_CRM;
    1ea0:	00412683          	lw	a3,4(sp)
        for (int rep = 10; rep > 0; rep--)
    1ea4:	fffa0a13          	addi	s4,s4,-1
        QSPI0->REG &= ~QSPI_REG_DSPI;
    1ea8:	00877733          	and	a4,a4,s0
    1eac:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG &= ~QSPI_REG_CRM;
    1eb0:	0007a703          	lw	a4,0(a5)
    1eb4:	00d77733          	and	a4,a4,a3
    1eb8:	00e7a023          	sw	a4,0(a5)
        for (int rep = 10; rep > 0; rep--)
    1ebc:	ce0a1ae3          	bnez	s4,1bb0 <main+0x614>
    1ec0:	b09ff06f          	j	19c8 <main+0x42c>
        QSPI0->REG |= QSPI_REG_CRM;
    1ec4:	810007b7          	lui	a5,0x81000
    1ec8:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    1ecc:	001006b7          	lui	a3,0x100
    1ed0:	00d76733          	or	a4,a4,a3
    1ed4:	e85ff06f          	j	1d58 <main+0x7bc>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
    1ed8:	c0002e73          	rdcycle	t3
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
    1edc:	c0202373          	rdinstret	t1
    uint32_t x32 = 314159265;
    1ee0:	12b9b7b7          	lui	a5,0x12b9b
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
    1ee4:	01400893          	li	a7,20
    uint32_t x32 = 314159265;
    1ee8:	0a178793          	addi	a5,a5,161 # 12b9b0a1 <_etext+0x12b9844d>
    1eec:	15010513          	addi	a0,sp,336
        for (int k = 0, p = 0; k < 256; k++)
    1ef0:	10000813          	li	a6,256
        for (int k = 0; k < 256; k++)
    1ef4:	05010613          	addi	a2,sp,80
    while (*p)
    1ef8:	00060693          	mv	a3,a2
    1efc:	00078713          	mv	a4,a5
            x32 ^= x32 << 13;
    1f00:	00d71793          	slli	a5,a4,0xd
    1f04:	00e7c7b3          	xor	a5,a5,a4
            x32 ^= x32 >> 17;
    1f08:	0117d713          	srli	a4,a5,0x11
    1f0c:	00e7c7b3          	xor	a5,a5,a4
            x32 ^= x32 << 5;
    1f10:	00579713          	slli	a4,a5,0x5
    1f14:	00e7c733          	xor	a4,a5,a4
            data[k] = x32;
    1f18:	00e68023          	sb	a4,0(a3) # 100000 <_etext+0xfd3ac>
        for (int k = 0; k < 256; k++)
    1f1c:	00168693          	addi	a3,a3,1
    1f20:	fed510e3          	bne	a0,a3,1f00 <main+0x964>
    1f24:	00070793          	mv	a5,a4
    1f28:	05010693          	addi	a3,sp,80
        for (int k = 0, p = 0; k < 256; k++)
    1f2c:	00000e93          	li	t4,0
    1f30:	00000713          	li	a4,0
            if (data[k])
    1f34:	0006c583          	lbu	a1,0(a3)
    1f38:	00058a63          	beqz	a1,1f4c <main+0x9b0>
                data[p++] = k;
    1f3c:	15010593          	addi	a1,sp,336
    1f40:	01d585b3          	add	a1,a1,t4
    1f44:	f0e58023          	sb	a4,-256(a1)
    1f48:	001e8e93          	addi	t4,t4,1
        for (int k = 0, p = 0; k < 256; k++)
    1f4c:	00170713          	addi	a4,a4,1
    1f50:	00168693          	addi	a3,a3,1
    1f54:	ff0710e3          	bne	a4,a6,1f34 <main+0x998>
            x32 = x32 ^ words[k];
    1f58:	00062703          	lw	a4,0(a2) # 400000 <_etext+0x3fd3ac>
        for (int k = 0, p = 0; k < 64; k++)
    1f5c:	00460613          	addi	a2,a2,4
            x32 = x32 ^ words[k];
    1f60:	00e7c7b3          	xor	a5,a5,a4
        for (int k = 0, p = 0; k < 64; k++)
    1f64:	fec51ae3          	bne	a0,a2,1f58 <main+0x9bc>
    for (int i = 0; i < 20; i++)
    1f68:	fff88893          	addi	a7,a7,-1
    1f6c:	f80894e3          	bnez	a7,1ef4 <main+0x958>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_end));
    1f70:	c00025f3          	rdcycle	a1
    __asm__ volatile ("rdinstret %0" : "=r"(instns_end));
    1f74:	c0202673          	rdinstret	a2
        putchar(*(p++));
    1f78:	04412683          	lw	a3,68(sp)
    UART0->DATA = c;
    1f7c:	04300713          	li	a4,67
    1f80:	00eaa023          	sw	a4,0(s5)
    while (*p)
    1f84:	07900713          	li	a4,121
        putchar(*(p++));
    1f88:	00168693          	addi	a3,a3,1
    if (c == '\n')
    1f8c:	77670e63          	beq	a4,s6,2708 <main+0x116c>
    UART0->DATA = c;
    1f90:	00eaa023          	sw	a4,0(s5)
    while (*p)
    1f94:	0006c703          	lbu	a4,0(a3)
    1f98:	fe0718e3          	bnez	a4,1f88 <main+0x9ec>
        print_hex(cycles_end - cycles_begin, 8);
    1f9c:	41c58e33          	sub	t3,a1,t3
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1fa0:	01ce5713          	srli	a4,t3,0x1c
    1fa4:	00ec0733          	add	a4,s8,a4
    1fa8:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    1fac:	79668063          	beq	a3,s6,272c <main+0x1190>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1fb0:	018e5713          	srli	a4,t3,0x18
    1fb4:	00f77713          	andi	a4,a4,15
    1fb8:	00ec0733          	add	a4,s8,a4
    1fbc:	00074583          	lbu	a1,0(a4)
    UART0->DATA = c;
    1fc0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1fc4:	79658263          	beq	a1,s6,2748 <main+0x11ac>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1fc8:	014e5713          	srli	a4,t3,0x14
    1fcc:	00f77713          	andi	a4,a4,15
    1fd0:	00ec0733          	add	a4,s8,a4
    1fd4:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    1fd8:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    1fdc:	79668463          	beq	a3,s6,2764 <main+0x11c8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1fe0:	010e5713          	srli	a4,t3,0x10
    1fe4:	00f77713          	andi	a4,a4,15
    1fe8:	00ec0733          	add	a4,s8,a4
    1fec:	00074583          	lbu	a1,0(a4)
    UART0->DATA = c;
    1ff0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    1ff4:	79658663          	beq	a1,s6,2780 <main+0x11e4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    1ff8:	00ce5713          	srli	a4,t3,0xc
    1ffc:	00f77713          	andi	a4,a4,15
    2000:	00ec0733          	add	a4,s8,a4
    2004:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2008:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    200c:	79668863          	beq	a3,s6,279c <main+0x1200>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2010:	008e5713          	srli	a4,t3,0x8
    2014:	00f77713          	andi	a4,a4,15
    2018:	00ec0733          	add	a4,s8,a4
    201c:	00074583          	lbu	a1,0(a4)
    UART0->DATA = c;
    2020:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2024:	79658a63          	beq	a1,s6,27b8 <main+0x121c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2028:	004e5713          	srli	a4,t3,0x4
    202c:	00f77713          	andi	a4,a4,15
    2030:	00ec0733          	add	a4,s8,a4
    2034:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2038:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    203c:	79668c63          	beq	a3,s6,27d4 <main+0x1238>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2040:	00fe7e13          	andi	t3,t3,15
    2044:	01cc0733          	add	a4,s8,t3
    2048:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    204c:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2050:	79670e63          	beq	a4,s6,27ec <main+0x1250>
    UART0->DATA = c;
    2054:	00eaa023          	sw	a4,0(s5)
        UART0->DATA = '\r';
    2058:	017aa023          	sw	s7,0(s5)
        putchar(*(p++));
    205c:	04812683          	lw	a3,72(sp)
    UART0->DATA = c;
    2060:	016aa023          	sw	s6,0(s5)
    2064:	01baa023          	sw	s11,0(s5)
    while (*p)
    2068:	06e00713          	li	a4,110
        putchar(*(p++));
    206c:	00168693          	addi	a3,a3,1
    if (c == '\n')
    2070:	4b670863          	beq	a4,s6,2520 <main+0xf84>
    UART0->DATA = c;
    2074:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2078:	0006c703          	lbu	a4,0(a3)
    207c:	fe0718e3          	bnez	a4,206c <main+0xad0>
        print_hex(instns_end - instns_begin, 8);
    2080:	40660333          	sub	t1,a2,t1
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2084:	01c35713          	srli	a4,t1,0x1c
    2088:	00ec0733          	add	a4,s8,a4
    208c:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    2090:	4b668a63          	beq	a3,s6,2544 <main+0xfa8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2094:	01835713          	srli	a4,t1,0x18
    2098:	00f77713          	andi	a4,a4,15
    209c:	00ec0733          	add	a4,s8,a4
    20a0:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    20a4:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    20a8:	4b660c63          	beq	a2,s6,2560 <main+0xfc4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20ac:	01435713          	srli	a4,t1,0x14
    20b0:	00f77713          	andi	a4,a4,15
    20b4:	00ec0733          	add	a4,s8,a4
    20b8:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    20bc:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    20c0:	4b668e63          	beq	a3,s6,257c <main+0xfe0>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20c4:	01035713          	srli	a4,t1,0x10
    20c8:	00f77713          	andi	a4,a4,15
    20cc:	00ec0733          	add	a4,s8,a4
    20d0:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    20d4:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    20d8:	4d660063          	beq	a2,s6,2598 <main+0xffc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20dc:	00c35713          	srli	a4,t1,0xc
    20e0:	00f77713          	andi	a4,a4,15
    20e4:	00ec0733          	add	a4,s8,a4
    20e8:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    20ec:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    20f0:	4d668263          	beq	a3,s6,25b4 <main+0x1018>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    20f4:	00835713          	srli	a4,t1,0x8
    20f8:	00f77713          	andi	a4,a4,15
    20fc:	00ec0733          	add	a4,s8,a4
    2100:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    2104:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2108:	4d660463          	beq	a2,s6,25d0 <main+0x1034>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    210c:	00435713          	srli	a4,t1,0x4
    2110:	00f77713          	andi	a4,a4,15
    2114:	00ec0733          	add	a4,s8,a4
    2118:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    211c:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2120:	4d668663          	beq	a3,s6,25ec <main+0x1050>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2124:	00f37313          	andi	t1,t1,15
    2128:	006c0733          	add	a4,s8,t1
    212c:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    2130:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2134:	4d670863          	beq	a4,s6,2604 <main+0x1068>
    UART0->DATA = c;
    2138:	00eaa023          	sw	a4,0(s5)
        UART0->DATA = '\r';
    213c:	017aa023          	sw	s7,0(s5)
        putchar(*(p++));
    2140:	04c12683          	lw	a3,76(sp)
    UART0->DATA = c;
    2144:	04300713          	li	a4,67
    2148:	016aa023          	sw	s6,0(s5)
    214c:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2150:	06800713          	li	a4,104
        putchar(*(p++));
    2154:	00168693          	addi	a3,a3,1
    if (c == '\n')
    2158:	4b670a63          	beq	a4,s6,260c <main+0x1070>
    UART0->DATA = c;
    215c:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2160:	0006c703          	lbu	a4,0(a3)
    2164:	fe0718e3          	bnez	a4,2154 <main+0xbb8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2168:	01c7d713          	srli	a4,a5,0x1c
    216c:	00ec0733          	add	a4,s8,a4
    2170:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    2174:	4b660c63          	beq	a2,s6,262c <main+0x1090>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2178:	0187d713          	srli	a4,a5,0x18
    217c:	00f77713          	andi	a4,a4,15
    2180:	00ec0733          	add	a4,s8,a4
    2184:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    2188:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    218c:	4b668e63          	beq	a3,s6,2648 <main+0x10ac>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2190:	0147d713          	srli	a4,a5,0x14
    2194:	00f77713          	andi	a4,a4,15
    2198:	00ec0733          	add	a4,s8,a4
    219c:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    21a0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    21a4:	4d660063          	beq	a2,s6,2664 <main+0x10c8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21a8:	0107d713          	srli	a4,a5,0x10
    21ac:	00f77713          	andi	a4,a4,15
    21b0:	00ec0733          	add	a4,s8,a4
    21b4:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    21b8:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    21bc:	4d668263          	beq	a3,s6,2680 <main+0x10e4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21c0:	00c7d713          	srli	a4,a5,0xc
    21c4:	00f77713          	andi	a4,a4,15
    21c8:	00ec0733          	add	a4,s8,a4
    21cc:	00074603          	lbu	a2,0(a4)
    UART0->DATA = c;
    21d0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    21d4:	4d660463          	beq	a2,s6,269c <main+0x1100>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21d8:	0087d713          	srli	a4,a5,0x8
    21dc:	00f77713          	andi	a4,a4,15
    21e0:	00ec0733          	add	a4,s8,a4
    21e4:	00074683          	lbu	a3,0(a4)
    UART0->DATA = c;
    21e8:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    21ec:	4d668663          	beq	a3,s6,26b8 <main+0x111c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    21f0:	0047d713          	srli	a4,a5,0x4
    21f4:	00f77713          	andi	a4,a4,15
    21f8:	00ec0733          	add	a4,s8,a4
    21fc:	00074703          	lbu	a4,0(a4)
    UART0->DATA = c;
    2200:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2204:	4d670863          	beq	a4,s6,26d4 <main+0x1138>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2208:	00f7f793          	andi	a5,a5,15
    220c:	00fc07b3          	add	a5,s8,a5
    2210:	0007c783          	lbu	a5,0(a5)
    UART0->DATA = c;
    2214:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    2218:	4d678a63          	beq	a5,s6,26ec <main+0x1150>
    UART0->DATA = c;
    221c:	00faa023          	sw	a5,0(s5)
        UART0->DATA = '\r';
    2220:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2224:	016aa023          	sw	s6,0(s5)
        for (int rep = 10; rep > 0; rep--)
    2228:	fffa0a13          	addi	s4,s4,-1
    222c:	980a12e3          	bnez	s4,1bb0 <main+0x614>
    2230:	f98ff06f          	j	19c8 <main+0x42c>
                cmd_benchmark(1, 0);
                break;

            case 'A':
            case 'a':
                cmd_benchmark_all();
    2234:	991fe0ef          	jal	ra,bc4 <cmd_benchmark_all>
                break;
    2238:	000037b7          	lui	a5,0x3
    223c:	b2178293          	addi	t0,a5,-1247 # 2b21 <irqCallback+0x249>
        for (int rep = 10; rep > 0; rep--)
    2240:	fffa0a13          	addi	s4,s4,-1
                break;
    2244:	000037b7          	lui	a5,0x3
    2248:	9a978f93          	addi	t6,a5,-1623 # 29a9 <irqCallback+0xd1>
        for (int rep = 10; rep > 0; rep--)
    224c:	960a12e3          	bnez	s4,1bb0 <main+0x614>
    2250:	f78ff06f          	j	19c8 <main+0x42c>
        UART0->DATA = '\r';
    2254:	017aa023          	sw	s7,0(s5)
    2258:	aa1ff06f          	j	1cf8 <main+0x75c>
            case '5':
                GPIO0->OUT ^= 0x00000010;
                break;

            case '6':
                GPIO0->OUT ^= 0x00000020;
    225c:	82000737          	lui	a4,0x82000
    2260:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    2264:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000020;
    2268:	0207c793          	xori	a5,a5,32
    226c:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    2270:	940a10e3          	bnez	s4,1bb0 <main+0x614>
    2274:	f54ff06f          	j	19c8 <main+0x42c>
                GPIO0->OUT ^= 0x00000010;
    2278:	82000737          	lui	a4,0x82000
    227c:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    2280:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000010;
    2284:	0107c793          	xori	a5,a5,16
    2288:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    228c:	920a12e3          	bnez	s4,1bb0 <main+0x614>
    2290:	f38ff06f          	j	19c8 <main+0x42c>
                GPIO0->OUT ^= 0x00000008;
    2294:	82000737          	lui	a4,0x82000
    2298:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    229c:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000008;
    22a0:	0087c793          	xori	a5,a5,8
    22a4:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    22a8:	900a14e3          	bnez	s4,1bb0 <main+0x614>
    22ac:	f1cff06f          	j	19c8 <main+0x42c>
                GPIO0->OUT ^= 0x00000004;
    22b0:	82000737          	lui	a4,0x82000
    22b4:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    22b8:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000004;
    22bc:	0047c793          	xori	a5,a5,4
    22c0:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    22c4:	8e0a16e3          	bnez	s4,1bb0 <main+0x614>
    22c8:	f00ff06f          	j	19c8 <main+0x42c>
                GPIO0->OUT ^= 0x00000002;
    22cc:	82000737          	lui	a4,0x82000
    22d0:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    22d4:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000002;
    22d8:	0027c793          	xori	a5,a5,2
    22dc:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    22e0:	8c0a18e3          	bnez	s4,1bb0 <main+0x614>
    22e4:	ee4ff06f          	j	19c8 <main+0x42c>
                GPIO0->OUT ^= 0x00000001;
    22e8:	82000737          	lui	a4,0x82000
    22ec:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff800>
        for (int rep = 10; rep > 0; rep--)
    22f0:	fffa0a13          	addi	s4,s4,-1
                GPIO0->OUT ^= 0x00000001;
    22f4:	0017c793          	xori	a5,a5,1
    22f8:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    22fc:	8a0a1ae3          	bnez	s4,1bb0 <main+0x614>
    2300:	ec8ff06f          	j	19c8 <main+0x42c>
        UART0->DATA = '\r';
    2304:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2308:	00faa023          	sw	a5,0(s5)
    while (*p)
    230c:	00074783          	lbu	a5,0(a4)
    2310:	8a079ae3          	bnez	a5,1bc4 <main+0x628>
            print_hex(GPIO0->IN, 8);
    2314:	820007b7          	lui	a5,0x82000
    2318:	0047a783          	lw	a5,4(a5) # 82000004 <__global_pointer$+0x41fff804>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    231c:	01c7d713          	srli	a4,a5,0x1c
    2320:	00ec0733          	add	a4,s8,a4
    2324:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    2328:	8d6614e3          	bne	a2,s6,1bf0 <main+0x654>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    232c:	0187d713          	srli	a4,a5,0x18
    2330:	00f77713          	andi	a4,a4,15
    2334:	00ec0733          	add	a4,s8,a4
    2338:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    233c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2340:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2344:	8d6692e3          	bne	a3,s6,1c08 <main+0x66c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2348:	0147d713          	srli	a4,a5,0x14
    234c:	00f77713          	andi	a4,a4,15
    2350:	00ec0733          	add	a4,s8,a4
    2354:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2358:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    235c:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2360:	8d6610e3          	bne	a2,s6,1c20 <main+0x684>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2364:	0107d713          	srli	a4,a5,0x10
    2368:	00f77713          	andi	a4,a4,15
    236c:	00ec0733          	add	a4,s8,a4
    2370:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2374:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2378:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    237c:	8b669ee3          	bne	a3,s6,1c38 <main+0x69c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2380:	00c7d713          	srli	a4,a5,0xc
    2384:	00f77713          	andi	a4,a4,15
    2388:	00ec0733          	add	a4,s8,a4
    238c:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2390:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2394:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2398:	8b661ce3          	bne	a2,s6,1c50 <main+0x6b4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    239c:	0087d713          	srli	a4,a5,0x8
    23a0:	00f77713          	andi	a4,a4,15
    23a4:	00ec0733          	add	a4,s8,a4
    23a8:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    23ac:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    23b0:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    23b4:	8b669ae3          	bne	a3,s6,1c68 <main+0x6cc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    23b8:	0047d713          	srli	a4,a5,0x4
    23bc:	00f77713          	andi	a4,a4,15
    23c0:	00ec0733          	add	a4,s8,a4
    23c4:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    23c8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    23cc:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    23d0:	8b6718e3          	bne	a4,s6,1c80 <main+0x6e4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    23d4:	00f7f793          	andi	a5,a5,15
    23d8:	00fc07b3          	add	a5,s8,a5
    23dc:	0007c783          	lbu	a5,0(a5)
        UART0->DATA = '\r';
    23e0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    23e4:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    23e8:	8b6796e3          	bne	a5,s6,1c94 <main+0x6f8>
        UART0->DATA = '\r';
    23ec:	017aa023          	sw	s7,0(s5)
    23f0:	8a5ff06f          	j	1c94 <main+0x6f8>
    23f4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    23f8:	00faa023          	sw	a5,0(s5)
    while (*p)
    23fc:	00074783          	lbu	a5,0(a4)
    2400:	8a079ce3          	bnez	a5,1cb8 <main+0x71c>
    2404:	8c9ff06f          	j	1ccc <main+0x730>
        UART0->DATA = '\r';
    2408:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    240c:	00faa023          	sw	a5,0(s5)
    while (*p)
    2410:	00074783          	lbu	a5,0(a4)
    2414:	ea079c63          	bnez	a5,1acc <main+0x530>
    2418:	ec8ff06f          	j	1ae0 <main+0x544>
        UART0->DATA = '\r';
    241c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2420:	00faa023          	sw	a5,0(s5)
    while (*p)
    2424:	00074783          	lbu	a5,0(a4)
    2428:	e8079263          	bnez	a5,1aac <main+0x510>
    242c:	e94ff06f          	j	1ac0 <main+0x524>
        UART0->DATA = '\r';
    2430:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2434:	00faa023          	sw	a5,0(s5)
    while (*p)
    2438:	00074783          	lbu	a5,0(a4)
    243c:	e4079863          	bnez	a5,1a8c <main+0x4f0>
    2440:	e60ff06f          	j	1aa0 <main+0x504>
        UART0->DATA = '\r';
    2444:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2448:	00faa023          	sw	a5,0(s5)
    while (*p)
    244c:	00074783          	lbu	a5,0(a4)
    2450:	e0079e63          	bnez	a5,1a6c <main+0x4d0>
    2454:	e2cff06f          	j	1a80 <main+0x4e4>
        UART0->DATA = '\r';
    2458:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    245c:	00faa023          	sw	a5,0(s5)
    while (*p)
    2460:	00074783          	lbu	a5,0(a4)
    2464:	de079463          	bnez	a5,1a4c <main+0x4b0>
    2468:	df8ff06f          	j	1a60 <main+0x4c4>
        UART0->DATA = '\r';
    246c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2470:	00faa023          	sw	a5,0(s5)
    while (*p)
    2474:	00074783          	lbu	a5,0(a4)
    2478:	da079a63          	bnez	a5,1a2c <main+0x490>
    247c:	dc4ff06f          	j	1a40 <main+0x4a4>
        UART0->DATA = '\r';
    2480:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2484:	00faa023          	sw	a5,0(s5)
    while (*p)
    2488:	00074783          	lbu	a5,0(a4)
    248c:	d8079063          	bnez	a5,1a0c <main+0x470>
    2490:	d90ff06f          	j	1a20 <main+0x484>
        UART0->DATA = '\r';
    2494:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2498:	00faa023          	sw	a5,0(s5)
    while (*p)
    249c:	00074783          	lbu	a5,0(a4)
    24a0:	d4079263          	bnez	a5,19e4 <main+0x448>
    24a4:	d54ff06f          	j	19f8 <main+0x45c>
        UART0->DATA = '\r';
    24a8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24ac:	00faa023          	sw	a5,0(s5)
    while (*p)
    24b0:	00074783          	lbu	a5,0(a4)
    24b4:	e8079c63          	bnez	a5,1b4c <main+0x5b0>
    24b8:	ea8ff06f          	j	1b60 <main+0x5c4>
        UART0->DATA = '\r';
    24bc:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24c0:	00faa023          	sw	a5,0(s5)
    while (*p)
    24c4:	00074783          	lbu	a5,0(a4)
    24c8:	e6079263          	bnez	a5,1b2c <main+0x590>
    24cc:	e74ff06f          	j	1b40 <main+0x5a4>
        UART0->DATA = '\r';
    24d0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24d4:	00faa023          	sw	a5,0(s5)
    while (*p)
    24d8:	00074783          	lbu	a5,0(a4)
    24dc:	e2079863          	bnez	a5,1b0c <main+0x570>
    24e0:	e40ff06f          	j	1b20 <main+0x584>
        UART0->DATA = '\r';
    24e4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24e8:	00faa023          	sw	a5,0(s5)
    while (*p)
    24ec:	00074783          	lbu	a5,0(a4)
    24f0:	de079e63          	bnez	a5,1aec <main+0x550>
    24f4:	e0cff06f          	j	1b00 <main+0x564>
        UART0->DATA = '\r';
    24f8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    24fc:	00faa023          	sw	a5,0(s5)
    while (*p)
    2500:	00074783          	lbu	a5,0(a4)
    2504:	e8079463          	bnez	a5,1b8c <main+0x5f0>
    2508:	e98ff06f          	j	1ba0 <main+0x604>
        UART0->DATA = '\r';
    250c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2510:	00faa023          	sw	a5,0(s5)
    while (*p)
    2514:	00074783          	lbu	a5,0(a4)
    2518:	e4079a63          	bnez	a5,1b6c <main+0x5d0>
    251c:	e64ff06f          	j	1b80 <main+0x5e4>
        UART0->DATA = '\r';
    2520:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2524:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2528:	0006c703          	lbu	a4,0(a3)
    252c:	b40710e3          	bnez	a4,206c <main+0xad0>
        print_hex(instns_end - instns_begin, 8);
    2530:	40660333          	sub	t1,a2,t1
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2534:	01c35713          	srli	a4,t1,0x1c
    2538:	00ec0733          	add	a4,s8,a4
    253c:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    2540:	b5669ae3          	bne	a3,s6,2094 <main+0xaf8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2544:	01835713          	srli	a4,t1,0x18
    2548:	00f77713          	andi	a4,a4,15
    254c:	00ec0733          	add	a4,s8,a4
    2550:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2554:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2558:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    255c:	b56618e3          	bne	a2,s6,20ac <main+0xb10>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2560:	01435713          	srli	a4,t1,0x14
    2564:	00f77713          	andi	a4,a4,15
    2568:	00ec0733          	add	a4,s8,a4
    256c:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2570:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2574:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2578:	b56696e3          	bne	a3,s6,20c4 <main+0xb28>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    257c:	01035713          	srli	a4,t1,0x10
    2580:	00f77713          	andi	a4,a4,15
    2584:	00ec0733          	add	a4,s8,a4
    2588:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    258c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2590:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2594:	b56614e3          	bne	a2,s6,20dc <main+0xb40>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2598:	00c35713          	srli	a4,t1,0xc
    259c:	00f77713          	andi	a4,a4,15
    25a0:	00ec0733          	add	a4,s8,a4
    25a4:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    25a8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    25ac:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    25b0:	b56692e3          	bne	a3,s6,20f4 <main+0xb58>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    25b4:	00835713          	srli	a4,t1,0x8
    25b8:	00f77713          	andi	a4,a4,15
    25bc:	00ec0733          	add	a4,s8,a4
    25c0:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    25c4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    25c8:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    25cc:	b56610e3          	bne	a2,s6,210c <main+0xb70>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    25d0:	00435713          	srli	a4,t1,0x4
    25d4:	00f77713          	andi	a4,a4,15
    25d8:	00ec0733          	add	a4,s8,a4
    25dc:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    25e0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    25e4:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    25e8:	b3669ee3          	bne	a3,s6,2124 <main+0xb88>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    25ec:	00f37313          	andi	t1,t1,15
    25f0:	006c0733          	add	a4,s8,t1
    25f4:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    25f8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    25fc:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2600:	b3671ce3          	bne	a4,s6,2138 <main+0xb9c>
        UART0->DATA = '\r';
    2604:	017aa023          	sw	s7,0(s5)
    2608:	b31ff06f          	j	2138 <main+0xb9c>
    260c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2610:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2614:	0006c703          	lbu	a4,0(a3)
    2618:	b2071ee3          	bnez	a4,2154 <main+0xbb8>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    261c:	01c7d713          	srli	a4,a5,0x1c
    2620:	00ec0733          	add	a4,s8,a4
    2624:	00074603          	lbu	a2,0(a4)
    if (c == '\n')
    2628:	b56618e3          	bne	a2,s6,2178 <main+0xbdc>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    262c:	0187d713          	srli	a4,a5,0x18
    2630:	00f77713          	andi	a4,a4,15
    2634:	00ec0733          	add	a4,s8,a4
    2638:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    263c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2640:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    2644:	b56696e3          	bne	a3,s6,2190 <main+0xbf4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2648:	0147d713          	srli	a4,a5,0x14
    264c:	00f77713          	andi	a4,a4,15
    2650:	00ec0733          	add	a4,s8,a4
    2654:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2658:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    265c:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2660:	b56614e3          	bne	a2,s6,21a8 <main+0xc0c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2664:	0107d713          	srli	a4,a5,0x10
    2668:	00f77713          	andi	a4,a4,15
    266c:	00ec0733          	add	a4,s8,a4
    2670:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2674:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2678:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    267c:	b56692e3          	bne	a3,s6,21c0 <main+0xc24>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2680:	00c7d713          	srli	a4,a5,0xc
    2684:	00f77713          	andi	a4,a4,15
    2688:	00ec0733          	add	a4,s8,a4
    268c:	00074603          	lbu	a2,0(a4)
        UART0->DATA = '\r';
    2690:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2694:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2698:	b56610e3          	bne	a2,s6,21d8 <main+0xc3c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    269c:	0087d713          	srli	a4,a5,0x8
    26a0:	00f77713          	andi	a4,a4,15
    26a4:	00ec0733          	add	a4,s8,a4
    26a8:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    26ac:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    26b0:	00caa023          	sw	a2,0(s5)
    if (c == '\n')
    26b4:	b3669ee3          	bne	a3,s6,21f0 <main+0xc54>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    26b8:	0047d713          	srli	a4,a5,0x4
    26bc:	00f77713          	andi	a4,a4,15
    26c0:	00ec0733          	add	a4,s8,a4
    26c4:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    26c8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    26cc:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    26d0:	b3671ce3          	bne	a4,s6,2208 <main+0xc6c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    26d4:	00f7f793          	andi	a5,a5,15
    26d8:	00fc07b3          	add	a5,s8,a5
    26dc:	0007c783          	lbu	a5,0(a5)
        UART0->DATA = '\r';
    26e0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    26e4:	00eaa023          	sw	a4,0(s5)
    if (c == '\n')
    26e8:	b3679ae3          	bne	a5,s6,221c <main+0xc80>
        UART0->DATA = '\r';
    26ec:	017aa023          	sw	s7,0(s5)
    26f0:	b2dff06f          	j	221c <main+0xc80>
    26f4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    26f8:	00faa023          	sw	a5,0(s5)
    while (*p)
    26fc:	00074783          	lbu	a5,0(a4)
    2700:	e8079863          	bnez	a5,1d90 <main+0x7f4>
    2704:	ea0ff06f          	j	1da4 <main+0x808>
        UART0->DATA = '\r';
    2708:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    270c:	00eaa023          	sw	a4,0(s5)
    while (*p)
    2710:	0006c703          	lbu	a4,0(a3)
    2714:	86071ae3          	bnez	a4,1f88 <main+0x9ec>
        print_hex(cycles_end - cycles_begin, 8);
    2718:	41c58e33          	sub	t3,a1,t3
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    271c:	01ce5713          	srli	a4,t3,0x1c
    2720:	00ec0733          	add	a4,s8,a4
    2724:	00074683          	lbu	a3,0(a4)
    if (c == '\n')
    2728:	896694e3          	bne	a3,s6,1fb0 <main+0xa14>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    272c:	018e5713          	srli	a4,t3,0x18
    2730:	00f77713          	andi	a4,a4,15
    2734:	00ec0733          	add	a4,s8,a4
    2738:	00074583          	lbu	a1,0(a4)
        UART0->DATA = '\r';
    273c:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2740:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    2744:	896592e3          	bne	a1,s6,1fc8 <main+0xa2c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2748:	014e5713          	srli	a4,t3,0x14
    274c:	00f77713          	andi	a4,a4,15
    2750:	00ec0733          	add	a4,s8,a4
    2754:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2758:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    275c:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2760:	896690e3          	bne	a3,s6,1fe0 <main+0xa44>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2764:	010e5713          	srli	a4,t3,0x10
    2768:	00f77713          	andi	a4,a4,15
    276c:	00ec0733          	add	a4,s8,a4
    2770:	00074583          	lbu	a1,0(a4)
        UART0->DATA = '\r';
    2774:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2778:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    277c:	87659ee3          	bne	a1,s6,1ff8 <main+0xa5c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    2780:	00ce5713          	srli	a4,t3,0xc
    2784:	00f77713          	andi	a4,a4,15
    2788:	00ec0733          	add	a4,s8,a4
    278c:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    2790:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2794:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    2798:	87669ce3          	bne	a3,s6,2010 <main+0xa74>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    279c:	008e5713          	srli	a4,t3,0x8
    27a0:	00f77713          	andi	a4,a4,15
    27a4:	00ec0733          	add	a4,s8,a4
    27a8:	00074583          	lbu	a1,0(a4)
        UART0->DATA = '\r';
    27ac:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    27b0:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    27b4:	87659ae3          	bne	a1,s6,2028 <main+0xa8c>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    27b8:	004e5713          	srli	a4,t3,0x4
    27bc:	00f77713          	andi	a4,a4,15
    27c0:	00ec0733          	add	a4,s8,a4
    27c4:	00074683          	lbu	a3,0(a4)
        UART0->DATA = '\r';
    27c8:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    27cc:	00baa023          	sw	a1,0(s5)
    if (c == '\n')
    27d0:	876698e3          	bne	a3,s6,2040 <main+0xaa4>
        char c = "0123456789abcdef"[(v >> (4*i)) & 15];
    27d4:	00fe7e13          	andi	t3,t3,15
    27d8:	01cc0733          	add	a4,s8,t3
    27dc:	00074703          	lbu	a4,0(a4)
        UART0->DATA = '\r';
    27e0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    27e4:	00daa023          	sw	a3,0(s5)
    if (c == '\n')
    27e8:	876716e3          	bne	a4,s6,2054 <main+0xab8>
        UART0->DATA = '\r';
    27ec:	017aa023          	sw	s7,0(s5)
    27f0:	865ff06f          	j	2054 <main+0xab8>
    27f4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    27f8:	00faa023          	sw	a5,0(s5)
    while (*p)
    27fc:	00074783          	lbu	a5,0(a4)
    2800:	e0079463          	bnez	a5,1e08 <main+0x86c>
    return QSPI0->REG & QSPI_REG_CRM;
    2804:	810007b7          	lui	a5,0x81000
    2808:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    280c:	00100737          	lui	a4,0x100
    2810:	00e7f7b3          	and	a5,a5,a4
                if ( cmd_get_crm() )
    2814:	e0078e63          	beqz	a5,1e30 <main+0x894>
        putchar(*(p++));
    2818:	00012703          	lw	a4,0(sp)
    UART0->DATA = c;
    281c:	04f00793          	li	a5,79
    2820:	00faa023          	sw	a5,0(s5)
    while (*p)
    2824:	04e00793          	li	a5,78
        putchar(*(p++));
    2828:	00170713          	addi	a4,a4,1 # 100001 <_etext+0xfd3ad>
    if (c == '\n')
    282c:	01678c63          	beq	a5,s6,2844 <main+0x12a8>
    UART0->DATA = c;
    2830:	00faa023          	sw	a5,0(s5)
    while (*p)
    2834:	00074783          	lbu	a5,0(a4)
    2838:	d2078a63          	beqz	a5,1d6c <main+0x7d0>
        putchar(*(p++));
    283c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    2840:	ff6798e3          	bne	a5,s6,2830 <main+0x1294>
        UART0->DATA = '\r';
    2844:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2848:	00faa023          	sw	a5,0(s5)
    while (*p)
    284c:	00074783          	lbu	a5,0(a4)
    2850:	fc079ce3          	bnez	a5,2828 <main+0x128c>
        for (int rep = 10; rep > 0; rep--)
    2854:	fffa0a13          	addi	s4,s4,-1
    2858:	b40a1c63          	bnez	s4,1bb0 <main+0x614>
    285c:	96cff06f          	j	19c8 <main+0x42c>
        UART0->DATA = '\r';
    2860:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    2864:	00faa023          	sw	a5,0(s5)
    while (*p)
    2868:	00074783          	lbu	a5,0(a4)
    286c:	d4079263          	bnez	a5,1db0 <main+0x814>
    return QSPI0->REG & QSPI_REG_DSPI;
    2870:	810007b7          	lui	a5,0x81000
    2874:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff800>
    2878:	00400737          	lui	a4,0x400
    287c:	00e7f7b3          	and	a5,a5,a4
                if ( cmd_get_dspi() )
    2880:	d4078c63          	beqz	a5,1dd8 <main+0x83c>
        putchar(*(p++));
    2884:	00012703          	lw	a4,0(sp)
    UART0->DATA = c;
    2888:	04f00793          	li	a5,79
    288c:	00faa023          	sw	a5,0(s5)
    while (*p)
    2890:	04e00793          	li	a5,78
        putchar(*(p++));
    2894:	00170713          	addi	a4,a4,1 # 400001 <_etext+0x3fd3ad>
    if (c == '\n')
    2898:	01678c63          	beq	a5,s6,28b0 <main+0x1314>
    UART0->DATA = c;
    289c:	00faa023          	sw	a5,0(s5)
    while (*p)
    28a0:	00074783          	lbu	a5,0(a4)
    28a4:	d4078c63          	beqz	a5,1dfc <main+0x860>
        putchar(*(p++));
    28a8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    28ac:	ff6798e3          	bne	a5,s6,289c <main+0x1300>
        UART0->DATA = '\r';
    28b0:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    28b4:	00faa023          	sw	a5,0(s5)
    while (*p)
    28b8:	00074783          	lbu	a5,0(a4)
    28bc:	fc079ce3          	bnez	a5,2894 <main+0x12f8>
    28c0:	d3cff06f          	j	1dfc <main+0x860>
        UART0->DATA = '\r';
    28c4:	017aa023          	sw	s7,0(s5)
    UART0->DATA = c;
    28c8:	00faa023          	sw	a5,0(s5)
    while (*p)
    28cc:	00074783          	lbu	a5,0(a4)
    28d0:	d0079c63          	bnez	a5,1de8 <main+0x84c>
    28d4:	d28ff06f          	j	1dfc <main+0x860>

000028d8 <irqCallback>:
    }
}

void irqCallback() {

    28d8:	00008067          	ret
    28dc:	3130                	fld	fa2,96(a0)
    28de:	3332                	fld	ft6,296(sp)
    28e0:	3534                	fld	fa3,104(a0)
    28e2:	3736                	fld	fa4,360(sp)
    28e4:	3938                	fld	fa4,112(a0)
    28e6:	6261                	lui	tp,0x18
    28e8:	66656463          	bltu	a0,t1,2f50 <_etext+0x2fc>
    28ec:	0000                	unimp
    28ee:	0000                	unimp
    28f0:	6c637943          	0x6c637943
    28f4:	7365                	lui	t1,0xffff9
    28f6:	203a                	fld	ft0,392(sp)
    28f8:	7830                	flw	fa2,112(s0)
    28fa:	0000                	unimp
    28fc:	6e49                	lui	t3,0x12
    28fe:	736e7473          	csrrci	s0,0x736,28
    2902:	203a                	fld	ft0,392(sp)
    2904:	7830                	flw	fa2,112(s0)
    2906:	0000                	unimp
    2908:	736b6843          	fmadd.d	fa6,fs6,fs6,fa4,unknown
    290c:	6d75                	lui	s10,0x1d
    290e:	203a                	fld	ft0,392(sp)
    2910:	7830                	flw	fa2,112(s0)
    2912:	0000                	unimp
    2914:	6564                	flw	fs1,76(a0)
    2916:	6166                	flw	ft2,88(sp)
    2918:	6c75                	lui	s8,0x1d
    291a:	2074                	fld	fa3,192(s0)
    291c:	2020                	fld	fs0,64(s0)
    291e:	2020                	fld	fs0,64(s0)
    2920:	2020                	fld	fs0,64(s0)
    2922:	0020                	addi	s0,sp,8
    2924:	7364                	flw	fs1,100(a4)
    2926:	6970                	flw	fa2,84(a0)
    2928:	002d                	c.nop	11
    292a:	0000                	unimp
    292c:	2020                	fld	fs0,64(s0)
    292e:	2020                	fld	fs0,64(s0)
    2930:	2020                	fld	fs0,64(s0)
    2932:	2020                	fld	fs0,64(s0)
    2934:	0020                	addi	s0,sp,8
    2936:	0000                	unimp
    2938:	7364                	flw	fs1,100(a4)
    293a:	6970                	flw	fa2,84(a0)
    293c:	632d                	lui	t1,0xb
    293e:	6d72                	flw	fs10,28(sp)
    2940:	002d                	c.nop	11
    2942:	0000                	unimp
    2944:	6e69                	lui	t3,0x1a
    2946:	736e7473          	csrrci	s0,0x736,28
    294a:	2020                	fld	fs0,64(s0)
    294c:	2020                	fld	fs0,64(s0)
    294e:	2020                	fld	fs0,64(s0)
    2950:	2020                	fld	fs0,64(s0)
    2952:	3a20                	fld	fs0,112(a2)
    2954:	0020                	addi	s0,sp,8
    2956:	0000                	unimp
    2958:	6e5c                	flw	fa5,28(a2)
    295a:	0a0a                	slli	s4,s4,0x2
    295c:	0a0a                	slli	s4,s4,0x2
    295e:	0000                	unimp
    2960:	2020                	fld	fs0,64(s0)
    2962:	2020                	fld	fs0,64(s0)
    2964:	2020                	fld	fs0,64(s0)
    2966:	2020                	fld	fs0,64(s0)
    2968:	2020                	fld	fs0,64(s0)
    296a:	4f20                	lw	s0,88(a4)
    296c:	206e                	fld	ft0,216(sp)
    296e:	694c                	flw	fa1,20(a0)
    2970:	65656863          	bltu	a0,s6,2fc0 <_etext+0x36c>
    2974:	5420                	lw	s0,104(s0)
    2976:	6e61                	lui	t3,0x18
    2978:	614e2067          	0x614e2067
    297c:	6f6e                	flw	ft10,216(sp)
    297e:	392d                	jal	25b8 <main+0x101c>
    2980:	7962204b          	fnmsub.s	ft0,ft4,fs6,fa5,rdn
    2984:	5020                	lw	s0,96(s0)
    2986:	7465                	lui	s0,0xffff9
    2988:	7265                	lui	tp,0xffff9
    298a:	4720                	lw	s0,72(a4)
    298c:	656c                	flw	fa1,76(a0)
    298e:	0a6e                	slli	s4,s4,0x1b
    2990:	0000                	unimp
    2992:	0000                	unimp
    2994:	656c6553          	0x656c6553
    2998:	61207463          	bgeu	zero,s2,2fa0 <_etext+0x34c>
    299c:	206e                	fld	ft0,216(sp)
    299e:	6361                	lui	t1,0x18
    29a0:	6974                	flw	fa3,84(a0)
    29a2:	0a3a6e6f          	jal	t3,a9244 <_etext+0xa65f0>
    29a6:	0000                	unimp
    29a8:	2020                	fld	fs0,64(s0)
    29aa:	5b20                	lw	s0,112(a4)
    29ac:	5d31                	li	s10,-20
    29ae:	5420                	lw	s0,104(s0)
    29b0:	6c67676f          	jal	a4,79076 <_etext+0x76422>
    29b4:	2065                	jal	2a5c <irqCallback+0x184>
    29b6:	656c                	flw	fa1,76(a0)
    29b8:	2064                	fld	fs1,192(s0)
    29ba:	0a31                	addi	s4,s4,12
    29bc:	0000                	unimp
    29be:	0000                	unimp
    29c0:	2020                	fld	fs0,64(s0)
    29c2:	5b20                	lw	s0,112(a4)
    29c4:	5d32                	lw	s10,44(sp)
    29c6:	5420                	lw	s0,104(s0)
    29c8:	6c67676f          	jal	a4,7908e <_etext+0x7643a>
    29cc:	2065                	jal	2a74 <irqCallback+0x19c>
    29ce:	656c                	flw	fa1,76(a0)
    29d0:	2064                	fld	fs1,192(s0)
    29d2:	0a32                	slli	s4,s4,0xc
    29d4:	0000                	unimp
    29d6:	0000                	unimp
    29d8:	2020                	fld	fs0,64(s0)
    29da:	5b20                	lw	s0,112(a4)
    29dc:	54205d33          	0x54205d33
    29e0:	6c67676f          	jal	a4,790a6 <_etext+0x76452>
    29e4:	2065                	jal	2a8c <irqCallback+0x1b4>
    29e6:	656c                	flw	fa1,76(a0)
    29e8:	2064                	fld	fs1,192(s0)
    29ea:	00000a33          	add	s4,zero,zero
    29ee:	0000                	unimp
    29f0:	2020                	fld	fs0,64(s0)
    29f2:	5b20                	lw	s0,112(a4)
    29f4:	5d34                	lw	a3,120(a0)
    29f6:	5420                	lw	s0,104(s0)
    29f8:	6c67676f          	jal	a4,790be <_etext+0x7646a>
    29fc:	2065                	jal	2aa4 <irqCallback+0x1cc>
    29fe:	656c                	flw	fa1,76(a0)
    2a00:	2064                	fld	fs1,192(s0)
    2a02:	0a34                	addi	a3,sp,280
    2a04:	0000                	unimp
    2a06:	0000                	unimp
    2a08:	2020                	fld	fs0,64(s0)
    2a0a:	5b20                	lw	s0,112(a4)
    2a0c:	5d35                	li	s10,-19
    2a0e:	5420                	lw	s0,104(s0)
    2a10:	6c67676f          	jal	a4,790d6 <_etext+0x76482>
    2a14:	2065                	jal	2abc <irqCallback+0x1e4>
    2a16:	656c                	flw	fa1,76(a0)
    2a18:	2064                	fld	fs1,192(s0)
    2a1a:	0a35                	addi	s4,s4,13
    2a1c:	0000                	unimp
    2a1e:	0000                	unimp
    2a20:	2020                	fld	fs0,64(s0)
    2a22:	5b20                	lw	s0,112(a4)
    2a24:	5d36                	lw	s10,108(sp)
    2a26:	5420                	lw	s0,104(s0)
    2a28:	6c67676f          	jal	a4,790ee <_etext+0x7649a>
    2a2c:	2065                	jal	2ad4 <irqCallback+0x1fc>
    2a2e:	656c                	flw	fa1,76(a0)
    2a30:	2064                	fld	fs1,192(s0)
    2a32:	0a36                	slli	s4,s4,0xd
    2a34:	0000                	unimp
    2a36:	0000                	unimp
    2a38:	2020                	fld	fs0,64(s0)
    2a3a:	5b20                	lw	s0,112(a4)
    2a3c:	5d46                	lw	s10,112(sp)
    2a3e:	4720                	lw	s0,72(a4)
    2a40:	7465                	lui	s0,0xffff9
    2a42:	6620                	flw	fs0,72(a2)
    2a44:	616c                	flw	fa1,68(a0)
    2a46:	6d206873          	csrrsi	a6,0x6d2,0
    2a4a:	0a65646f          	jal	s0,58af0 <_etext+0x55e9c>
    2a4e:	0000                	unimp
    2a50:	2020                	fld	fs0,64(s0)
    2a52:	5b20                	lw	s0,112(a4)
    2a54:	5d49                	li	s10,-14
    2a56:	5220                	lw	s0,96(a2)
    2a58:	6165                	addi	sp,sp,112
    2a5a:	2064                	fld	fs1,192(s0)
    2a5c:	20495053          	0x20495053
    2a60:	6c66                	flw	fs8,88(sp)
    2a62:	7361                	lui	t1,0xffff8
    2a64:	2068                	fld	fa0,192(s0)
    2a66:	4449                	li	s0,18
    2a68:	000a                	c.slli	zero,0x2
    2a6a:	0000                	unimp
    2a6c:	2020                	fld	fs0,64(s0)
    2a6e:	5b20                	lw	s0,112(a4)
    2a70:	53205d53          	0x53205d53
    2a74:	7465                	lui	s0,0xffff9
    2a76:	5320                	lw	s0,96(a4)
    2a78:	6e69                	lui	t3,0x1a
    2a7a:	20656c67          	0x20656c67
    2a7e:	20495053          	0x20495053
    2a82:	6f6d                	lui	t5,0x1b
    2a84:	6564                	flw	fs1,76(a0)
    2a86:	000a                	c.slli	zero,0x2
    2a88:	2020                	fld	fs0,64(s0)
    2a8a:	5b20                	lw	s0,112(a4)
    2a8c:	5d44                	lw	s1,60(a0)
    2a8e:	5320                	lw	s0,96(a4)
    2a90:	7465                	lui	s0,0xffff9
    2a92:	4420                	lw	s0,72(s0)
    2a94:	20495053          	0x20495053
    2a98:	6f6d                	lui	t5,0x1b
    2a9a:	6564                	flw	fs1,76(a0)
    2a9c:	000a                	c.slli	zero,0x2
    2a9e:	0000                	unimp
    2aa0:	2020                	fld	fs0,64(s0)
    2aa2:	5b20                	lw	s0,112(a4)
    2aa4:	53205d43          	fmadd.d	fs10,ft0,fs2,fa0,unknown
    2aa8:	7465                	lui	s0,0xffff9
    2aaa:	4420                	lw	s0,72(s0)
    2aac:	2b495053          	0x2b495053
    2ab0:	204d5243          	fmadd.s	ft4,fs10,ft4,ft4,unknown
    2ab4:	6f6d                	lui	t5,0x1b
    2ab6:	6564                	flw	fs1,76(a0)
    2ab8:	000a                	c.slli	zero,0x2
    2aba:	0000                	unimp
    2abc:	2020                	fld	fs0,64(s0)
    2abe:	5b20                	lw	s0,112(a4)
    2ac0:	5d42                	lw	s10,48(sp)
    2ac2:	5220                	lw	s0,96(a2)
    2ac4:	6e75                	lui	t3,0x1d
    2ac6:	7320                	flw	fs0,96(a4)
    2ac8:	6d69                	lui	s10,0x1a
    2aca:	6c70                	flw	fa2,92(s0)
    2acc:	7369                	lui	t1,0xffffa
    2ace:	6974                	flw	fa3,84(a0)
    2ad0:	65622063          	0x65622063
    2ad4:	636e                	flw	ft6,216(sp)
    2ad6:	6d68                	flw	fa0,92(a0)
    2ad8:	7261                	lui	tp,0xffff8
    2ada:	6556206b          	0x6556206b
    2ade:	2072                	fld	ft0,280(sp)
    2ae0:	2e31                	jal	2dfc <_etext+0x1a8>
    2ae2:	2e30                	fld	fa2,88(a2)
    2ae4:	0a30                	addi	a2,sp,280
    2ae6:	0000                	unimp
    2ae8:	2020                	fld	fs0,64(s0)
    2aea:	5b20                	lw	s0,112(a4)
    2aec:	5d41                	li	s10,-16
    2aee:	4220                	lw	s0,64(a2)
    2af0:	6e65                	lui	t3,0x19
    2af2:	616d6863          	bltu	s10,s6,3102 <_etext+0x4ae>
    2af6:	6b72                	flw	fs6,28(sp)
    2af8:	6120                	flw	fs0,64(a0)
    2afa:	6c6c                	flw	fa1,92(s0)
    2afc:	6320                	flw	fs0,64(a4)
    2afe:	69666e6f          	jal	t3,69194 <_etext+0x66540>
    2b02:	000a7367          	0xa7367
    2b06:	0000                	unimp
    2b08:	4f49                	li	t5,18
    2b0a:	5320                	lw	s0,96(a4)
    2b0c:	6174                	flw	fa3,68(a0)
    2b0e:	6574                	flw	fa3,76(a0)
    2b10:	203a                	fld	ft0,392(sp)
    2b12:	0000                	unimp
    2b14:	6d6d6f43          	0x6d6d6f43
    2b18:	6e61                	lui	t3,0x18
    2b1a:	3e64                	fld	fs1,248(a2)
    2b1c:	0020                	addi	s0,sp,8
    2b1e:	0000                	unimp
    2b20:	20495053          	0x20495053
    2b24:	74617453          	0x74617453
    2b28:	3a65                	jal	24e0 <main+0xf44>
    2b2a:	000a                	c.slli	zero,0x2
    2b2c:	2020                	fld	fs0,64(s0)
    2b2e:	5344                	lw	s1,36(a4)
    2b30:	4950                	lw	a2,20(a0)
    2b32:	0020                	addi	s0,sp,8
    2b34:	000a4e4f          	fnmadd.s	ft8,fs4,ft0,ft0,rmm
    2b38:	0a46464f          	fnmadd.d	fa2,fa2,ft4,ft1,rmm
    2b3c:	0000                	unimp
    2b3e:	0000                	unimp
    2b40:	2020                	fld	fs0,64(s0)
    2b42:	204d5243          	fmadd.s	ft4,fs10,ft4,ft4,unknown
    2b46:	0020                	addi	s0,sp,8
    2b48:	22e8                	fld	fa0,192(a3)
    2b4a:	0000                	unimp
    2b4c:	22cc                	fld	fa1,128(a3)
    2b4e:	0000                	unimp
    2b50:	22b0                	fld	fa2,64(a3)
    2b52:	0000                	unimp
    2b54:	2294                	fld	fa3,0(a3)
    2b56:	0000                	unimp
    2b58:	2278                	fld	fa4,192(a2)
    2b5a:	0000                	unimp
    2b5c:	225c                	fld	fa5,128(a2)
    2b5e:	0000                	unimp
    2b60:	1d6c                	addi	a1,sp,700
    2b62:	0000                	unimp
    2b64:	1d6c                	addi	a1,sp,700
    2b66:	0000                	unimp
    2b68:	1d6c                	addi	a1,sp,700
    2b6a:	0000                	unimp
    2b6c:	1d6c                	addi	a1,sp,700
    2b6e:	0000                	unimp
    2b70:	1d6c                	addi	a1,sp,700
    2b72:	0000                	unimp
    2b74:	1d6c                	addi	a1,sp,700
    2b76:	0000                	unimp
    2b78:	1d6c                	addi	a1,sp,700
    2b7a:	0000                	unimp
    2b7c:	1d6c                	addi	a1,sp,700
    2b7e:	0000                	unimp
    2b80:	1d6c                	addi	a1,sp,700
    2b82:	0000                	unimp
    2b84:	1d6c                	addi	a1,sp,700
    2b86:	0000                	unimp
    2b88:	2234                	fld	fa3,64(a2)
    2b8a:	0000                	unimp
    2b8c:	1ed8                	addi	a4,sp,884
    2b8e:	0000                	unimp
    2b90:	1ec4                	addi	s1,sp,884
    2b92:	0000                	unimp
    2b94:	1d48                	addi	a0,sp,692
    2b96:	0000                	unimp
    2b98:	1d6c                	addi	a1,sp,700
    2b9a:	0000                	unimp
    2b9c:	1d78                	addi	a4,sp,700
    2b9e:	0000                	unimp
    2ba0:	1d6c                	addi	a1,sp,700
    2ba2:	0000                	unimp
    2ba4:	1d6c                	addi	a1,sp,700
    2ba6:	0000                	unimp
    2ba8:	1e78                	addi	a4,sp,828
    2baa:	0000                	unimp
    2bac:	1d6c                	addi	a1,sp,700
    2bae:	0000                	unimp
    2bb0:	1d6c                	addi	a1,sp,700
    2bb2:	0000                	unimp
    2bb4:	1d6c                	addi	a1,sp,700
    2bb6:	0000                	unimp
    2bb8:	1d6c                	addi	a1,sp,700
    2bba:	0000                	unimp
    2bbc:	1d6c                	addi	a1,sp,700
    2bbe:	0000                	unimp
    2bc0:	1d6c                	addi	a1,sp,700
    2bc2:	0000                	unimp
    2bc4:	1d6c                	addi	a1,sp,700
    2bc6:	0000                	unimp
    2bc8:	1d6c                	addi	a1,sp,700
    2bca:	0000                	unimp
    2bcc:	1d6c                	addi	a1,sp,700
    2bce:	0000                	unimp
    2bd0:	1e98                	addi	a4,sp,880
    2bd2:	0000                	unimp
    2bd4:	1d6c                	addi	a1,sp,700
    2bd6:	0000                	unimp
    2bd8:	1d6c                	addi	a1,sp,700
    2bda:	0000                	unimp
    2bdc:	1d6c                	addi	a1,sp,700
    2bde:	0000                	unimp
    2be0:	1d6c                	addi	a1,sp,700
    2be2:	0000                	unimp
    2be4:	1d6c                	addi	a1,sp,700
    2be6:	0000                	unimp
    2be8:	1d6c                	addi	a1,sp,700
    2bea:	0000                	unimp
    2bec:	1d6c                	addi	a1,sp,700
    2bee:	0000                	unimp
    2bf0:	1d6c                	addi	a1,sp,700
    2bf2:	0000                	unimp
    2bf4:	1d6c                	addi	a1,sp,700
    2bf6:	0000                	unimp
    2bf8:	1d6c                	addi	a1,sp,700
    2bfa:	0000                	unimp
    2bfc:	1d6c                	addi	a1,sp,700
    2bfe:	0000                	unimp
    2c00:	1d6c                	addi	a1,sp,700
    2c02:	0000                	unimp
    2c04:	1d6c                	addi	a1,sp,700
    2c06:	0000                	unimp
    2c08:	2234                	fld	fa3,64(a2)
    2c0a:	0000                	unimp
    2c0c:	1ed8                	addi	a4,sp,884
    2c0e:	0000                	unimp
    2c10:	1ec4                	addi	s1,sp,884
    2c12:	0000                	unimp
    2c14:	1d48                	addi	a0,sp,692
    2c16:	0000                	unimp
    2c18:	1d6c                	addi	a1,sp,700
    2c1a:	0000                	unimp
    2c1c:	1d78                	addi	a4,sp,700
    2c1e:	0000                	unimp
    2c20:	1d6c                	addi	a1,sp,700
    2c22:	0000                	unimp
    2c24:	1d6c                	addi	a1,sp,700
    2c26:	0000                	unimp
    2c28:	1e78                	addi	a4,sp,828
    2c2a:	0000                	unimp
    2c2c:	1d6c                	addi	a1,sp,700
    2c2e:	0000                	unimp
    2c30:	1d6c                	addi	a1,sp,700
    2c32:	0000                	unimp
    2c34:	1d6c                	addi	a1,sp,700
    2c36:	0000                	unimp
    2c38:	1d6c                	addi	a1,sp,700
    2c3a:	0000                	unimp
    2c3c:	1d6c                	addi	a1,sp,700
    2c3e:	0000                	unimp
    2c40:	1d6c                	addi	a1,sp,700
    2c42:	0000                	unimp
    2c44:	1d6c                	addi	a1,sp,700
    2c46:	0000                	unimp
    2c48:	1d6c                	addi	a1,sp,700
    2c4a:	0000                	unimp
    2c4c:	1d6c                	addi	a1,sp,700
    2c4e:	0000                	unimp
    2c50:	1e98                	addi	a4,sp,880
	...
