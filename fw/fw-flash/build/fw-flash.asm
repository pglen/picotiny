
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
      54:	315010ef          	jal	ra,1b68 <irqCallback>
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
      a0:	40001197          	auipc	gp,0x40001
      a4:	85018193          	addi	gp,gp,-1968 # 400008f0 <__global_pointer$>
  .option pop
  la sp, _stack_start
      a8:	c1018113          	addi	sp,gp,-1008 # 40000500 <_stack_start>

# copy data section
  la a0, _sidata
      ac:	00002517          	auipc	a0,0x2
      b0:	6a450513          	addi	a0,a0,1700 # 2750 <_etext>
  la a1, _sdata
      b4:	40000597          	auipc	a1,0x40000
      b8:	f4c58593          	addi	a1,a1,-180 # 40000000 <strpg>
  la a2, _edata
      bc:	80818613          	addi	a2,gp,-2040 # 400000f8 <i>
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
      dc:	02050513          	addi	a0,a0,32 # 400000f8 <i>
  la a1, _bss_end
      e0:	40000597          	auipc	a1,0x40000
      e4:	01c58593          	addi	a1,a1,28 # 400000fc <_bss_end>

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
      f8:	00002517          	auipc	a0,0x2
      fc:	65850513          	addi	a0,a0,1624 # 2750 <_etext>
  addi sp,sp,-4
     100:	ffc10113          	addi	sp,sp,-4

00000104 <ctors_loop>:
ctors_loop:
  la a1, _ctors_end
     104:	00002597          	auipc	a1,0x2
     108:	64c58593          	addi	a1,a1,1612 # 2750 <_etext>
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
     12c:	295000ef          	jal	ra,bc0 <main>

00000130 <infinitLoop>:
infinitLoop:
  j infinitLoop
     130:	0000006f          	j	130 <infinitLoop>

00000134 <__divsi3>:
     134:	06054063          	bltz	a0,194 <__umodsi3+0x10>
     138:	0605c663          	bltz	a1,1a4 <__umodsi3+0x20>

0000013c <__udivsi3>:
     13c:	00058613          	mv	a2,a1
     140:	00050593          	mv	a1,a0
     144:	fff00513          	li	a0,-1
     148:	02060c63          	beqz	a2,180 <__udivsi3+0x44>
     14c:	00100693          	li	a3,1
     150:	00b67a63          	bgeu	a2,a1,164 <__udivsi3+0x28>
     154:	00c05863          	blez	a2,164 <__udivsi3+0x28>
     158:	00161613          	slli	a2,a2,0x1
     15c:	00169693          	slli	a3,a3,0x1
     160:	feb66ae3          	bltu	a2,a1,154 <__udivsi3+0x18>
     164:	00000513          	li	a0,0
     168:	00c5e663          	bltu	a1,a2,174 <__udivsi3+0x38>
     16c:	40c585b3          	sub	a1,a1,a2
     170:	00d56533          	or	a0,a0,a3
     174:	0016d693          	srli	a3,a3,0x1
     178:	00165613          	srli	a2,a2,0x1
     17c:	fe0696e3          	bnez	a3,168 <__udivsi3+0x2c>
     180:	00008067          	ret

00000184 <__umodsi3>:
     184:	00008293          	mv	t0,ra
     188:	fb5ff0ef          	jal	ra,13c <__udivsi3>
     18c:	00058513          	mv	a0,a1
     190:	00028067          	jr	t0
     194:	40a00533          	neg	a0,a0
     198:	0005d863          	bgez	a1,1a8 <__umodsi3+0x24>
     19c:	40b005b3          	neg	a1,a1
     1a0:	f9dff06f          	j	13c <__udivsi3>
     1a4:	40b005b3          	neg	a1,a1
     1a8:	00008293          	mv	t0,ra
     1ac:	f91ff0ef          	jal	ra,13c <__udivsi3>
     1b0:	40a00533          	neg	a0,a0
     1b4:	00028067          	jr	t0

000001b8 <__modsi3>:
     1b8:	00008293          	mv	t0,ra
     1bc:	0005ca63          	bltz	a1,1d0 <__modsi3+0x18>
     1c0:	00054c63          	bltz	a0,1d8 <__modsi3+0x20>
     1c4:	f79ff0ef          	jal	ra,13c <__udivsi3>
     1c8:	00058513          	mv	a0,a1
     1cc:	00028067          	jr	t0
     1d0:	40b005b3          	neg	a1,a1
     1d4:	fe0558e3          	bgez	a0,1c4 <__modsi3+0xc>
     1d8:	40a00533          	neg	a0,a0
     1dc:	f61ff0ef          	jal	ra,13c <__udivsi3>
     1e0:	40b00533          	neg	a0,a1
     1e4:	00028067          	jr	t0

000001e8 <cmd_read_flash_id>:
int cmd_get_dspi() {
    return QSPI0->REG & QSPI_REG_DSPI;
}

void cmd_read_flash_id()
{
     1e8:	fd010113          	addi	sp,sp,-48
    return QSPI0->REG & QSPI_REG_DSPI;
     1ec:	810007b7          	lui	a5,0x81000
{
     1f0:	01612823          	sw	s6,16(sp)
    return QSPI0->REG & QSPI_REG_DSPI;
     1f4:	0007ab03          	lw	s6,0(a5) # 81000000 <__global_pointer$+0x40fff710>
        QSPI0->REG &= ~QSPI_REG_DSPI;
     1f8:	0007a703          	lw	a4,0(a5)
     1fc:	ffc006b7          	lui	a3,0xffc00
     200:	fff68693          	addi	a3,a3,-1 # ffbfffff <__global_pointer$+0xbfbff70f>
{
     204:	02812423          	sw	s0,40(sp)
     208:	02912223          	sw	s1,36(sp)
     20c:	03212023          	sw	s2,32(sp)
     210:	01312e23          	sw	s3,28(sp)
     214:	01412c23          	sw	s4,24(sp)
     218:	01512a23          	sw	s5,20(sp)
        QSPI0->REG &= ~QSPI_REG_DSPI;
     21c:	00d77733          	and	a4,a4,a3
{
     220:	02112623          	sw	ra,44(sp)
        QSPI0->REG &= ~QSPI_REG_DSPI;
     224:	00e7a023          	sw	a4,0(a5)
    int pre_dspi = cmd_get_dspi();

    cmd_set_dspi(0);

    uint8_t buffer[4] = { 0x9F, /* zeros */ };
    spi_flashio(buffer, 4, 0);
     228:	8041a783          	lw	a5,-2044(gp) # 400000f4 <spi_flashio>
    uint8_t buffer[4] = { 0x9F, /* zeros */ };
     22c:	09f00713          	li	a4,159
     230:	00e12023          	sw	a4,0(sp)
    spi_flashio(buffer, 4, 0);
     234:	00010513          	mv	a0,sp
    return QSPI0->REG & QSPI_REG_DSPI;
     238:	00400737          	lui	a4,0x400
    spi_flashio(buffer, 4, 0);
     23c:	00000613          	li	a2,0
     240:	00400593          	li	a1,4
    return QSPI0->REG & QSPI_REG_DSPI;
     244:	00eb7b33          	and	s6,s6,a4
    spi_flashio(buffer, 4, 0);
     248:	00050913          	mv	s2,a0
     24c:	00310a93          	addi	s5,sp,3
     250:	000780e7          	jalr	a5
    UART0->DATA = c;
     254:	83000437          	lui	s0,0x83000
     258:	02000a13          	li	s4,32
    if (c == '\n')
     25c:	00a00493          	li	s1,10
        UART0->DATA = '\r';
     260:	00d00993          	li	s3,13
    UART0->DATA = c;
     264:	01442023          	sw	s4,0(s0) # 83000000 <__global_pointer$+0x42fff710>

    for (int i = 1; i <= 3; i++) {
        putchar(' ');
        //print_hex(buffer[i], 2);
        char out[12];
        print_num(buffer[i], 16, out, 12);  print(out);
     268:	00194503          	lbu	a0,1(s2)
     26c:	00c00693          	li	a3,12
     270:	00410613          	addi	a2,sp,4
     274:	01000593          	li	a1,16
     278:	0f5010ef          	jal	ra,1b6c <print_num>
    while (*p)
     27c:	00414783          	lbu	a5,4(sp)
     280:	00078e63          	beqz	a5,29c <cmd_read_flash_id+0xb4>
     284:	00410713          	addi	a4,sp,4
        putchar(*(p++));
     288:	00170713          	addi	a4,a4,1 # 400001 <_etext+0x3fd8b1>
    if (c == '\n')
     28c:	06978663          	beq	a5,s1,2f8 <cmd_read_flash_id+0x110>
    UART0->DATA = c;
     290:	00f42023          	sw	a5,0(s0)
    while (*p)
     294:	00074783          	lbu	a5,0(a4)
     298:	fe0798e3          	bnez	a5,288 <cmd_read_flash_id+0xa0>
    for (int i = 1; i <= 3; i++) {
     29c:	00190913          	addi	s2,s2,1
     2a0:	fd5912e3          	bne	s2,s5,264 <cmd_read_flash_id+0x7c>
        UART0->DATA = '\r';
     2a4:	830007b7          	lui	a5,0x83000
     2a8:	00d00713          	li	a4,13
     2ac:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     2b0:	00a00713          	li	a4,10
     2b4:	00e7a023          	sw	a4,0(a5)
    if (on) {
     2b8:	040b0e63          	beqz	s6,314 <cmd_read_flash_id+0x12c>
        QSPI0->REG |= QSPI_REG_DSPI;
     2bc:	81000737          	lui	a4,0x81000
     2c0:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff710>
     2c4:	004006b7          	lui	a3,0x400
     2c8:	00d7e7b3          	or	a5,a5,a3
     2cc:	00f72023          	sw	a5,0(a4)
    }
    putchar('\n');

    cmd_set_dspi(pre_dspi);
}
     2d0:	02c12083          	lw	ra,44(sp)
     2d4:	02812403          	lw	s0,40(sp)
     2d8:	02412483          	lw	s1,36(sp)
     2dc:	02012903          	lw	s2,32(sp)
     2e0:	01c12983          	lw	s3,28(sp)
     2e4:	01812a03          	lw	s4,24(sp)
     2e8:	01412a83          	lw	s5,20(sp)
     2ec:	01012b03          	lw	s6,16(sp)
     2f0:	03010113          	addi	sp,sp,48
     2f4:	00008067          	ret
        UART0->DATA = '\r';
     2f8:	01342023          	sw	s3,0(s0)
    UART0->DATA = c;
     2fc:	00f42023          	sw	a5,0(s0)
    while (*p)
     300:	00074783          	lbu	a5,0(a4)
     304:	f80792e3          	bnez	a5,288 <cmd_read_flash_id+0xa0>
    for (int i = 1; i <= 3; i++) {
     308:	00190913          	addi	s2,s2,1
     30c:	f5591ce3          	bne	s2,s5,264 <cmd_read_flash_id+0x7c>
     310:	f95ff06f          	j	2a4 <cmd_read_flash_id+0xbc>
        QSPI0->REG &= ~QSPI_REG_DSPI;
     314:	810006b7          	lui	a3,0x81000
     318:	0006a783          	lw	a5,0(a3) # 81000000 <__global_pointer$+0x40fff710>
     31c:	ffc00737          	lui	a4,0xffc00
     320:	fff70713          	addi	a4,a4,-1 # ffbfffff <__global_pointer$+0xbfbff70f>
     324:	00e7f7b3          	and	a5,a5,a4
     328:	00f6a023          	sw	a5,0(a3)
}
     32c:	fa5ff06f          	j	2d0 <cmd_read_flash_id+0xe8>

00000330 <cmd_benchmark>:

// --------------------------------------------------------

uint32_t cmd_benchmark(bool verbose, uint32_t *instns_p)
{
     330:	ed010113          	addi	sp,sp,-304
     334:	12912223          	sw	s1,292(sp)
     338:	12112623          	sw	ra,300(sp)
     33c:	12812423          	sw	s0,296(sp)
     340:	13212023          	sw	s2,288(sp)
     344:	11312e23          	sw	s3,284(sp)
     348:	11412c23          	sw	s4,280(sp)
     34c:	00050e13          	mv	t3,a0
     350:	00058493          	mv	s1,a1

    uint32_t x32 = 314159265;

    uint32_t cycles_begin, cycles_end;
    uint32_t instns_begin, instns_end;
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
     354:	c0002ef3          	rdcycle	t4
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
     358:	c0202973          	rdinstret	s2
    uint32_t x32 = 314159265;
     35c:	12b9b437          	lui	s0,0x12b9b
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
     360:	01400313          	li	t1,20
    uint32_t x32 = 314159265;
     364:	0a140413          	addi	s0,s0,161 # 12b9b0a1 <_etext+0x12b98951>
     368:	11010513          	addi	a0,sp,272
            x32 ^= x32 >> 17;
            x32 ^= x32 << 5;
            data[k] = x32;
        }

        for (int k = 0, p = 0; k < 256; k++)
     36c:	10000893          	li	a7,256
        for (int k = 0; k < 256; k++)
     370:	01010693          	addi	a3,sp,16
{
     374:	00068713          	mv	a4,a3
            x32 ^= x32 << 13;
     378:	00d41793          	slli	a5,s0,0xd
     37c:	0087c7b3          	xor	a5,a5,s0
            x32 ^= x32 >> 17;
     380:	0117d413          	srli	s0,a5,0x11
     384:	00f44433          	xor	s0,s0,a5
            x32 ^= x32 << 5;
     388:	00541793          	slli	a5,s0,0x5
     38c:	0087c433          	xor	s0,a5,s0
            data[k] = x32;
     390:	00870023          	sb	s0,0(a4)
        for (int k = 0; k < 256; k++)
     394:	00170713          	addi	a4,a4,1
     398:	fee510e3          	bne	a0,a4,378 <cmd_benchmark+0x48>
     39c:	01010713          	addi	a4,sp,16
        for (int k = 0, p = 0; k < 256; k++)
     3a0:	00000613          	li	a2,0
     3a4:	00000793          	li	a5,0
        {
            if (data[k])
     3a8:	00074583          	lbu	a1,0(a4)
                data[p++] = k;
     3ac:	11010813          	addi	a6,sp,272
     3b0:	00c80833          	add	a6,a6,a2
        for (int k = 0, p = 0; k < 256; k++)
     3b4:	00170713          	addi	a4,a4,1
            if (data[k])
     3b8:	00058663          	beqz	a1,3c4 <cmd_benchmark+0x94>
                data[p++] = k;
     3bc:	f0f80023          	sb	a5,-256(a6)
     3c0:	00160613          	addi	a2,a2,1
        for (int k = 0, p = 0; k < 256; k++)
     3c4:	00178793          	addi	a5,a5,1
     3c8:	ff1790e3          	bne	a5,a7,3a8 <cmd_benchmark+0x78>
        }

        for (int k = 0, p = 0; k < 64; k++)
        {
            x32 = x32 ^ words[k];
     3cc:	0006a783          	lw	a5,0(a3)
        for (int k = 0, p = 0; k < 64; k++)
     3d0:	00468693          	addi	a3,a3,4
            x32 = x32 ^ words[k];
     3d4:	00f44433          	xor	s0,s0,a5
        for (int k = 0, p = 0; k < 64; k++)
     3d8:	fed51ae3          	bne	a0,a3,3cc <cmd_benchmark+0x9c>
    for (int i = 0; i < 20; i++)
     3dc:	fff30313          	addi	t1,t1,-1
     3e0:	f80318e3          	bnez	t1,370 <cmd_benchmark+0x40>
        }
    }

    __asm__ volatile ("rdcycle %0" : "=r"(cycles_end));
     3e4:	c0002673          	rdcycle	a2
    __asm__ volatile ("rdinstret %0" : "=r"(instns_end));
     3e8:	c02029f3          	rdinstret	s3
    }

    if (instns_p)
        *instns_p = instns_end - instns_begin;

    return cycles_end - cycles_begin;
     3ec:	41d60a33          	sub	s4,a2,t4
    if (verbose)
     3f0:	1a0e0263          	beqz	t3,594 <_stack_size+0x194>
    UART0->DATA = c;
     3f4:	830007b7          	lui	a5,0x83000
     3f8:	04300713          	li	a4,67
     3fc:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
        putchar(*(p++));
     400:	00002737          	lui	a4,0x2
    while (*p)
     404:	07900793          	li	a5,121
        putchar(*(p++));
     408:	36170713          	addi	a4,a4,865 # 2361 <xsnprintf+0x459>
    if (c == '\n')
     40c:	00a00513          	li	a0,10
    UART0->DATA = c;
     410:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     414:	00d00593          	li	a1,13
        putchar(*(p++));
     418:	00170713          	addi	a4,a4,1
    if (c == '\n')
     41c:	20a78663          	beq	a5,a0,628 <_stack_size+0x228>
    UART0->DATA = c;
     420:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     424:	00074783          	lbu	a5,0(a4)
     428:	fe0798e3          	bnez	a5,418 <_stack_size+0x18>
        print_num(cycles_end - cycles_begin, 16, out, 12);
     42c:	41d60a33          	sub	s4,a2,t4
     430:	00c00693          	li	a3,12
     434:	00410613          	addi	a2,sp,4
     438:	01000593          	li	a1,16
     43c:	000a0513          	mv	a0,s4
     440:	72c010ef          	jal	ra,1b6c <print_num>
    while (*p)
     444:	00414783          	lbu	a5,4(sp)
     448:	00410713          	addi	a4,sp,4
    if (c == '\n')
     44c:	00a00613          	li	a2,10
    UART0->DATA = c;
     450:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     454:	00d00593          	li	a1,13
    while (*p)
     458:	00078c63          	beqz	a5,470 <_stack_size+0x70>
        putchar(*(p++));
     45c:	00170713          	addi	a4,a4,1
    if (c == '\n')
     460:	1cc78e63          	beq	a5,a2,63c <_stack_size+0x23c>
    UART0->DATA = c;
     464:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     468:	00074783          	lbu	a5,0(a4)
     46c:	fe0798e3          	bnez	a5,45c <_stack_size+0x5c>
        UART0->DATA = '\r';
     470:	830007b7          	lui	a5,0x83000
     474:	00d00713          	li	a4,13
     478:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     47c:	00a00713          	li	a4,10
     480:	00e7a023          	sw	a4,0(a5)
     484:	04900713          	li	a4,73
     488:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     48c:	00002737          	lui	a4,0x2
     490:	36d70713          	addi	a4,a4,877 # 236d <xsnprintf+0x465>
    while (*p)
     494:	06e00793          	li	a5,110
    if (c == '\n')
     498:	00a00593          	li	a1,10
    UART0->DATA = c;
     49c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     4a0:	00d00613          	li	a2,13
        putchar(*(p++));
     4a4:	00170713          	addi	a4,a4,1
    if (c == '\n')
     4a8:	16b78663          	beq	a5,a1,614 <_stack_size+0x214>
    UART0->DATA = c;
     4ac:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     4b0:	00074783          	lbu	a5,0(a4)
     4b4:	fe0798e3          	bnez	a5,4a4 <_stack_size+0xa4>
        print_num(instns_end - instns_begin, 16, out, 12);
     4b8:	00c00693          	li	a3,12
     4bc:	00410613          	addi	a2,sp,4
     4c0:	01000593          	li	a1,16
     4c4:	41298533          	sub	a0,s3,s2
     4c8:	6a4010ef          	jal	ra,1b6c <print_num>
    while (*p)
     4cc:	00414783          	lbu	a5,4(sp)
     4d0:	00410713          	addi	a4,sp,4
    if (c == '\n')
     4d4:	00a00613          	li	a2,10
    UART0->DATA = c;
     4d8:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     4dc:	00d00593          	li	a1,13
    while (*p)
     4e0:	00078c63          	beqz	a5,4f8 <_stack_size+0xf8>
        putchar(*(p++));
     4e4:	00170713          	addi	a4,a4,1
    if (c == '\n')
     4e8:	10c78c63          	beq	a5,a2,600 <_stack_size+0x200>
    UART0->DATA = c;
     4ec:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     4f0:	00074783          	lbu	a5,0(a4)
     4f4:	fe0798e3          	bnez	a5,4e4 <_stack_size+0xe4>
        UART0->DATA = '\r';
     4f8:	830007b7          	lui	a5,0x83000
     4fc:	00d00713          	li	a4,13
     500:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     504:	00a00713          	li	a4,10
     508:	00e7a023          	sw	a4,0(a5)
     50c:	04300713          	li	a4,67
     510:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     514:	00002737          	lui	a4,0x2
     518:	37970713          	addi	a4,a4,889 # 2379 <xsnprintf+0x471>
    while (*p)
     51c:	06800793          	li	a5,104
    if (c == '\n')
     520:	00a00593          	li	a1,10
    UART0->DATA = c;
     524:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     528:	00d00613          	li	a2,13
        putchar(*(p++));
     52c:	00170713          	addi	a4,a4,1
    if (c == '\n')
     530:	0ab78e63          	beq	a5,a1,5ec <_stack_size+0x1ec>
    UART0->DATA = c;
     534:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     538:	00074783          	lbu	a5,0(a4)
     53c:	fe0798e3          	bnez	a5,52c <_stack_size+0x12c>
        print_num(x32, 16, out, 12);
     540:	00c00693          	li	a3,12
     544:	00410613          	addi	a2,sp,4
     548:	01000593          	li	a1,16
     54c:	00040513          	mv	a0,s0
     550:	61c010ef          	jal	ra,1b6c <print_num>
    while (*p)
     554:	00414703          	lbu	a4,4(sp)
     558:	00410793          	addi	a5,sp,4
    if (c == '\n')
     55c:	00a00613          	li	a2,10
    UART0->DATA = c;
     560:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     564:	00d00593          	li	a1,13
    while (*p)
     568:	00070c63          	beqz	a4,580 <_stack_size+0x180>
        putchar(*(p++));
     56c:	00178793          	addi	a5,a5,1
    if (c == '\n')
     570:	04c70a63          	beq	a4,a2,5c4 <_stack_size+0x1c4>
    UART0->DATA = c;
     574:	00e6a023          	sw	a4,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     578:	0007c703          	lbu	a4,0(a5)
     57c:	fe0718e3          	bnez	a4,56c <_stack_size+0x16c>
        UART0->DATA = '\r';
     580:	830007b7          	lui	a5,0x83000
     584:	00d00713          	li	a4,13
     588:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     58c:	00a00713          	li	a4,10
     590:	00e7a023          	sw	a4,0(a5)
    if (instns_p)
     594:	00048663          	beqz	s1,5a0 <_stack_size+0x1a0>
        *instns_p = instns_end - instns_begin;
     598:	41298933          	sub	s2,s3,s2
     59c:	0124a023          	sw	s2,0(s1)
}
     5a0:	12c12083          	lw	ra,300(sp)
     5a4:	12812403          	lw	s0,296(sp)
     5a8:	12412483          	lw	s1,292(sp)
     5ac:	12012903          	lw	s2,288(sp)
     5b0:	11c12983          	lw	s3,284(sp)
     5b4:	000a0513          	mv	a0,s4
     5b8:	11812a03          	lw	s4,280(sp)
     5bc:	13010113          	addi	sp,sp,304
     5c0:	00008067          	ret
        UART0->DATA = '\r';
     5c4:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     5c8:	00e6a023          	sw	a4,0(a3)
    while (*p)
     5cc:	0007c703          	lbu	a4,0(a5)
     5d0:	f8071ee3          	bnez	a4,56c <_stack_size+0x16c>
        UART0->DATA = '\r';
     5d4:	830007b7          	lui	a5,0x83000
     5d8:	00d00713          	li	a4,13
     5dc:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     5e0:	00a00713          	li	a4,10
     5e4:	00e7a023          	sw	a4,0(a5)
    return c;
     5e8:	fadff06f          	j	594 <_stack_size+0x194>
        UART0->DATA = '\r';
     5ec:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
     5f0:	00f6a023          	sw	a5,0(a3)
    while (*p)
     5f4:	00074783          	lbu	a5,0(a4)
     5f8:	f2079ae3          	bnez	a5,52c <_stack_size+0x12c>
     5fc:	f45ff06f          	j	540 <_stack_size+0x140>
        UART0->DATA = '\r';
     600:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     604:	00f6a023          	sw	a5,0(a3)
    while (*p)
     608:	00074783          	lbu	a5,0(a4)
     60c:	ec079ce3          	bnez	a5,4e4 <_stack_size+0xe4>
     610:	ee9ff06f          	j	4f8 <_stack_size+0xf8>
        UART0->DATA = '\r';
     614:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
     618:	00f6a023          	sw	a5,0(a3)
    while (*p)
     61c:	00074783          	lbu	a5,0(a4)
     620:	e80792e3          	bnez	a5,4a4 <_stack_size+0xa4>
     624:	e95ff06f          	j	4b8 <_stack_size+0xb8>
        UART0->DATA = '\r';
     628:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     62c:	00f6a023          	sw	a5,0(a3)
    while (*p)
     630:	00074783          	lbu	a5,0(a4)
     634:	de0792e3          	bnez	a5,418 <_stack_size+0x18>
     638:	df5ff06f          	j	42c <_stack_size+0x2c>
        UART0->DATA = '\r';
     63c:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     640:	00f6a023          	sw	a5,0(a3)
    while (*p)
     644:	00074783          	lbu	a5,0(a4)
     648:	e0079ae3          	bnez	a5,45c <_stack_size+0x5c>
     64c:	e25ff06f          	j	470 <_stack_size+0x70>

00000650 <cmd_benchmark_all>:

void cmd_benchmark_all()
{
     650:	fe010113          	addi	sp,sp,-32
    UART0->DATA = c;
     654:	830007b7          	lui	a5,0x83000
     658:	06400713          	li	a4,100
{
     65c:	00112e23          	sw	ra,28(sp)
     660:	00812c23          	sw	s0,24(sp)
    uint32_t instns = 0;
     664:	00012023          	sw	zero,0(sp)
    UART0->DATA = c;
     668:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
        putchar(*(p++));
     66c:	00002737          	lui	a4,0x2
     670:	38570713          	addi	a4,a4,901 # 2385 <xsnprintf+0x47d>
    while (*p)
     674:	06500793          	li	a5,101
    if (c == '\n')
     678:	00a00613          	li	a2,10
    UART0->DATA = c;
     67c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     680:	00d00593          	li	a1,13
        putchar(*(p++));
     684:	00170713          	addi	a4,a4,1
    if (c == '\n')
     688:	4cc78a63          	beq	a5,a2,b5c <cmd_benchmark_all+0x50c>
    UART0->DATA = c;
     68c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     690:	00074783          	lbu	a5,0(a4)
     694:	fe0798e3          	bnez	a5,684 <cmd_benchmark_all+0x34>
        QSPI0->REG &= ~QSPI_REG_DSPI;
     698:	810007b7          	lui	a5,0x81000
     69c:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff710>
     6a0:	ffc006b7          	lui	a3,0xffc00
     6a4:	fff68693          	addi	a3,a3,-1 # ffbfffff <__global_pointer$+0xbfbff70f>
     6a8:	00d77733          	and	a4,a4,a3
     6ac:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG &= ~QSPI_REG_CRM;
     6b0:	0007a683          	lw	a3,0(a5)
     6b4:	fff00737          	lui	a4,0xfff00
     6b8:	fff70713          	addi	a4,a4,-1 # ffefffff <__global_pointer$+0xbfeff70f>
     6bc:	00e6f6b3          	and	a3,a3,a4
     6c0:	00d7a023          	sw	a3,0(a5)
        putchar(*(p++));
     6c4:	00002737          	lui	a4,0x2
    UART0->DATA = c;
     6c8:	830007b7          	lui	a5,0x83000
     6cc:	03a00693          	li	a3,58
     6d0:	00d7a023          	sw	a3,0(a5) # 83000000 <__global_pointer$+0x42fff710>
        putchar(*(p++));
     6d4:	59d70413          	addi	s0,a4,1437 # 259d <xsnprintf+0x695>
    while (*p)
     6d8:	02000793          	li	a5,32
        putchar(*(p++));
     6dc:	59d70713          	addi	a4,a4,1437
    if (c == '\n')
     6e0:	00a00613          	li	a2,10
    UART0->DATA = c;
     6e4:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     6e8:	00d00593          	li	a1,13
        putchar(*(p++));
     6ec:	00170713          	addi	a4,a4,1
    if (c == '\n')
     6f0:	44c78c63          	beq	a5,a2,b48 <cmd_benchmark_all+0x4f8>
    UART0->DATA = c;
     6f4:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     6f8:	00074783          	lbu	a5,0(a4)
     6fc:	fe0798e3          	bnez	a5,6ec <cmd_benchmark_all+0x9c>
    cmd_set_dspi(0);
    cmd_set_crm(0);

    print(": ");
    char out[12];
    print_num(cmd_benchmark(false, &instns), 16, out, 12);
     700:	00010593          	mv	a1,sp
     704:	00000513          	li	a0,0
     708:	c29ff0ef          	jal	ra,330 <cmd_benchmark>
     70c:	00c00693          	li	a3,12
     710:	00410613          	addi	a2,sp,4
     714:	01000593          	li	a1,16
     718:	454010ef          	jal	ra,1b6c <print_num>
    while (*p)
     71c:	00414783          	lbu	a5,4(sp)
     720:	02078463          	beqz	a5,748 <cmd_benchmark_all+0xf8>
     724:	00410713          	addi	a4,sp,4
    if (c == '\n')
     728:	00a00613          	li	a2,10
    UART0->DATA = c;
     72c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     730:	00d00593          	li	a1,13
        putchar(*(p++));
     734:	00170713          	addi	a4,a4,1
    if (c == '\n')
     738:	3ec78e63          	beq	a5,a2,b34 <cmd_benchmark_all+0x4e4>
    UART0->DATA = c;
     73c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     740:	00074783          	lbu	a5,0(a4)
     744:	fe0798e3          	bnez	a5,734 <cmd_benchmark_all+0xe4>
        UART0->DATA = '\r';
     748:	830007b7          	lui	a5,0x83000
     74c:	00d00713          	li	a4,13
     750:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     754:	00a00713          	li	a4,10
     758:	00e7a023          	sw	a4,0(a5)
     75c:	06400713          	li	a4,100
     760:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     764:	00002737          	lui	a4,0x2
     768:	39570713          	addi	a4,a4,917 # 2395 <xsnprintf+0x48d>
    while (*p)
     76c:	07300793          	li	a5,115
    if (c == '\n')
     770:	00a00613          	li	a2,10
    UART0->DATA = c;
     774:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     778:	00d00593          	li	a1,13
        putchar(*(p++));
     77c:	00170713          	addi	a4,a4,1
    if (c == '\n')
     780:	3ac78063          	beq	a5,a2,b20 <cmd_benchmark_all+0x4d0>
    UART0->DATA = c;
     784:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     788:	00074783          	lbu	a5,0(a4)
     78c:	fe0798e3          	bnez	a5,77c <cmd_benchmark_all+0x12c>
     print(out);  putchar('\n');

    print("dspi-");
    print_num(0, 10, out, 12);
     790:	00c00693          	li	a3,12
     794:	00410613          	addi	a2,sp,4
     798:	00a00593          	li	a1,10
     79c:	00000513          	li	a0,0
     7a0:	3cc010ef          	jal	ra,1b6c <print_num>
    while (*p)
     7a4:	00414783          	lbu	a5,4(sp)
     7a8:	02078463          	beqz	a5,7d0 <cmd_benchmark_all+0x180>
     7ac:	00410713          	addi	a4,sp,4
    if (c == '\n')
     7b0:	00a00613          	li	a2,10
    UART0->DATA = c;
     7b4:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     7b8:	00d00593          	li	a1,13
        putchar(*(p++));
     7bc:	00170713          	addi	a4,a4,1
    if (c == '\n')
     7c0:	3cc78263          	beq	a5,a2,b84 <cmd_benchmark_all+0x534>
    UART0->DATA = c;
     7c4:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     7c8:	00074783          	lbu	a5,0(a4)
     7cc:	fe0798e3          	bnez	a5,7bc <cmd_benchmark_all+0x16c>
    UART0->DATA = c;
     7d0:	830007b7          	lui	a5,0x83000
     7d4:	02000713          	li	a4,32
     7d8:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
        putchar(*(p++));
     7dc:	00002737          	lui	a4,0x2
     7e0:	39d70713          	addi	a4,a4,925 # 239d <xsnprintf+0x495>
    while (*p)
     7e4:	02000793          	li	a5,32
    if (c == '\n')
     7e8:	00a00613          	li	a2,10
    UART0->DATA = c;
     7ec:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     7f0:	00d00593          	li	a1,13
        putchar(*(p++));
     7f4:	00170713          	addi	a4,a4,1
    if (c == '\n')
     7f8:	36c78c63          	beq	a5,a2,b70 <cmd_benchmark_all+0x520>
    UART0->DATA = c;
     7fc:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     800:	00074783          	lbu	a5,0(a4)
     804:	fe0798e3          	bnez	a5,7f4 <cmd_benchmark_all+0x1a4>
        QSPI0->REG |= QSPI_REG_DSPI;
     808:	81000737          	lui	a4,0x81000
     80c:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff710>
     810:	004006b7          	lui	a3,0x400
    if (c == '\n')
     814:	00a00613          	li	a2,10
        QSPI0->REG |= QSPI_REG_DSPI;
     818:	00d7e7b3          	or	a5,a5,a3
     81c:	00f72023          	sw	a5,0(a4)
    UART0->DATA = c;
     820:	830007b7          	lui	a5,0x83000
     824:	03a00713          	li	a4,58
     828:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
     82c:	830006b7          	lui	a3,0x83000
        putchar(*(p++));
     830:	00040713          	mv	a4,s0
    while (*p)
     834:	02000793          	li	a5,32
        UART0->DATA = '\r';
     838:	00d00593          	li	a1,13
        putchar(*(p++));
     83c:	00170713          	addi	a4,a4,1
    if (c == '\n')
     840:	34c78c63          	beq	a5,a2,b98 <cmd_benchmark_all+0x548>
    UART0->DATA = c;
     844:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     848:	00074783          	lbu	a5,0(a4)
     84c:	fe0798e3          	bnez	a5,83c <cmd_benchmark_all+0x1ec>
     print("         ");

    cmd_set_dspi(1);

    print(": ");
    print_num(cmd_benchmark(false, &instns), 16, out, 12);
     850:	00010593          	mv	a1,sp
     854:	00000513          	li	a0,0
     858:	ad9ff0ef          	jal	ra,330 <cmd_benchmark>
     85c:	00c00693          	li	a3,12
     860:	00410613          	addi	a2,sp,4
     864:	01000593          	li	a1,16
     868:	304010ef          	jal	ra,1b6c <print_num>
    while (*p)
     86c:	00414783          	lbu	a5,4(sp)
     870:	02078463          	beqz	a5,898 <cmd_benchmark_all+0x248>
     874:	00410713          	addi	a4,sp,4
    if (c == '\n')
     878:	00a00613          	li	a2,10
    UART0->DATA = c;
     87c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     880:	00d00593          	li	a1,13
        putchar(*(p++));
     884:	00170713          	addi	a4,a4,1
    if (c == '\n')
     888:	32c78263          	beq	a5,a2,bac <cmd_benchmark_all+0x55c>
    UART0->DATA = c;
     88c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     890:	00074783          	lbu	a5,0(a4)
     894:	fe0798e3          	bnez	a5,884 <cmd_benchmark_all+0x234>
        UART0->DATA = '\r';
     898:	830007b7          	lui	a5,0x83000
     89c:	00d00713          	li	a4,13
     8a0:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     8a4:	00a00713          	li	a4,10
     8a8:	00e7a023          	sw	a4,0(a5)
     8ac:	06400713          	li	a4,100
     8b0:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     8b4:	00002737          	lui	a4,0x2
     8b8:	3a970713          	addi	a4,a4,937 # 23a9 <xsnprintf+0x4a1>
    while (*p)
     8bc:	07300793          	li	a5,115
    if (c == '\n')
     8c0:	00a00613          	li	a2,10
    UART0->DATA = c;
     8c4:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     8c8:	00d00593          	li	a1,13
        putchar(*(p++));
     8cc:	00170713          	addi	a4,a4,1
    if (c == '\n')
     8d0:	22c78463          	beq	a5,a2,af8 <cmd_benchmark_all+0x4a8>
    UART0->DATA = c;
     8d4:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     8d8:	00074783          	lbu	a5,0(a4)
     8dc:	fe0798e3          	bnez	a5,8cc <cmd_benchmark_all+0x27c>
     print(out);
     putchar('\n');

    print("dspi-crm-");
    print_num(0, 10, out, 12);
     8e0:	00c00693          	li	a3,12
     8e4:	00410613          	addi	a2,sp,4
     8e8:	00a00593          	li	a1,10
     8ec:	00000513          	li	a0,0
     8f0:	27c010ef          	jal	ra,1b6c <print_num>
    while (*p)
     8f4:	00414783          	lbu	a5,4(sp)
     8f8:	02078463          	beqz	a5,920 <cmd_benchmark_all+0x2d0>
     8fc:	00410713          	addi	a4,sp,4
    if (c == '\n')
     900:	00a00613          	li	a2,10
    UART0->DATA = c;
     904:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     908:	00d00593          	li	a1,13
        putchar(*(p++));
     90c:	00170713          	addi	a4,a4,1
    if (c == '\n')
     910:	1ec78e63          	beq	a5,a2,b0c <cmd_benchmark_all+0x4bc>
    UART0->DATA = c;
     914:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     918:	00074783          	lbu	a5,0(a4)
     91c:	fe0798e3          	bnez	a5,90c <cmd_benchmark_all+0x2bc>
    UART0->DATA = c;
     920:	830007b7          	lui	a5,0x83000
     924:	02000713          	li	a4,32
     928:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
        putchar(*(p++));
     92c:	00002737          	lui	a4,0x2
     930:	3a170713          	addi	a4,a4,929 # 23a1 <xsnprintf+0x499>
    while (*p)
     934:	02000793          	li	a5,32
    if (c == '\n')
     938:	00a00613          	li	a2,10
    UART0->DATA = c;
     93c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     940:	00d00593          	li	a1,13
        putchar(*(p++));
     944:	00170713          	addi	a4,a4,1
    if (c == '\n')
     948:	18c78e63          	beq	a5,a2,ae4 <cmd_benchmark_all+0x494>
    UART0->DATA = c;
     94c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     950:	00074783          	lbu	a5,0(a4)
     954:	fe0798e3          	bnez	a5,944 <cmd_benchmark_all+0x2f4>
        QSPI0->REG |= QSPI_REG_CRM;
     958:	81000737          	lui	a4,0x81000
     95c:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff710>
     960:	001006b7          	lui	a3,0x100
    if (c == '\n')
     964:	00a00613          	li	a2,10
        QSPI0->REG |= QSPI_REG_CRM;
     968:	00d7e7b3          	or	a5,a5,a3
     96c:	00f72023          	sw	a5,0(a4)
    UART0->DATA = c;
     970:	830007b7          	lui	a5,0x83000
     974:	03a00713          	li	a4,58
     978:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
     97c:	830006b7          	lui	a3,0x83000
        putchar(*(p++));
     980:	00040713          	mv	a4,s0
    while (*p)
     984:	02000793          	li	a5,32
        UART0->DATA = '\r';
     988:	00d00593          	li	a1,13
        putchar(*(p++));
     98c:	00170713          	addi	a4,a4,1
    if (c == '\n')
     990:	14c78063          	beq	a5,a2,ad0 <cmd_benchmark_all+0x480>
    UART0->DATA = c;
     994:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     998:	00074783          	lbu	a5,0(a4)
     99c:	fe0798e3          	bnez	a5,98c <cmd_benchmark_all+0x33c>
     print("     ");

    cmd_set_crm(1);

    print(": ");
    print_num(cmd_benchmark(false, &instns), 16, out, 12);
     9a0:	00010593          	mv	a1,sp
     9a4:	00000513          	li	a0,0
     9a8:	989ff0ef          	jal	ra,330 <cmd_benchmark>
     9ac:	00c00693          	li	a3,12
     9b0:	00410613          	addi	a2,sp,4
     9b4:	01000593          	li	a1,16
     9b8:	1b4010ef          	jal	ra,1b6c <print_num>
    while (*p)
     9bc:	00414783          	lbu	a5,4(sp)
     9c0:	02078463          	beqz	a5,9e8 <cmd_benchmark_all+0x398>
     9c4:	00410713          	addi	a4,sp,4
    if (c == '\n')
     9c8:	00a00613          	li	a2,10
    UART0->DATA = c;
     9cc:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     9d0:	00d00593          	li	a1,13
        putchar(*(p++));
     9d4:	00170713          	addi	a4,a4,1
    if (c == '\n')
     9d8:	0ec78263          	beq	a5,a2,abc <cmd_benchmark_all+0x46c>
    UART0->DATA = c;
     9dc:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     9e0:	00074783          	lbu	a5,0(a4)
     9e4:	fe0798e3          	bnez	a5,9d4 <cmd_benchmark_all+0x384>
        UART0->DATA = '\r';
     9e8:	830007b7          	lui	a5,0x83000
     9ec:	00d00713          	li	a4,13
     9f0:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     9f4:	00a00713          	li	a4,10
     9f8:	00e7a023          	sw	a4,0(a5)
     9fc:	06900713          	li	a4,105
     a00:	00e7a023          	sw	a4,0(a5)
        putchar(*(p++));
     a04:	00002737          	lui	a4,0x2
     a08:	3b570713          	addi	a4,a4,949 # 23b5 <xsnprintf+0x4ad>
    while (*p)
     a0c:	06e00793          	li	a5,110
    if (c == '\n')
     a10:	00a00613          	li	a2,10
    UART0->DATA = c;
     a14:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     a18:	00d00593          	li	a1,13
        putchar(*(p++));
     a1c:	00170713          	addi	a4,a4,1
    if (c == '\n')
     a20:	08c78463          	beq	a5,a2,aa8 <cmd_benchmark_all+0x458>
    UART0->DATA = c;
     a24:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     a28:	00074783          	lbu	a5,0(a4)
     a2c:	fe0798e3          	bnez	a5,a1c <cmd_benchmark_all+0x3cc>
     print(out);
     putchar('\n');

    print("instns         : ");
    print_num(instns, 16, out, 12);
     a30:	00012503          	lw	a0,0(sp)
     a34:	00c00693          	li	a3,12
     a38:	00410613          	addi	a2,sp,4
     a3c:	01000593          	li	a1,16
     a40:	12c010ef          	jal	ra,1b6c <print_num>
    while (*p)
     a44:	00414703          	lbu	a4,4(sp)
     a48:	02070463          	beqz	a4,a70 <cmd_benchmark_all+0x420>
     a4c:	00410793          	addi	a5,sp,4
    if (c == '\n')
     a50:	00a00613          	li	a2,10
    UART0->DATA = c;
     a54:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     a58:	00d00593          	li	a1,13
        putchar(*(p++));
     a5c:	00178793          	addi	a5,a5,1
    if (c == '\n')
     a60:	02c70a63          	beq	a4,a2,a94 <cmd_benchmark_all+0x444>
    UART0->DATA = c;
     a64:	00e6a023          	sw	a4,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     a68:	0007c703          	lbu	a4,0(a5)
     a6c:	fe0718e3          	bnez	a4,a5c <cmd_benchmark_all+0x40c>
     print(out);
     putchar('\n');
}
     a70:	01c12083          	lw	ra,28(sp)
     a74:	01812403          	lw	s0,24(sp)
        UART0->DATA = '\r';
     a78:	830007b7          	lui	a5,0x83000
     a7c:	00d00713          	li	a4,13
     a80:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     a84:	00a00713          	li	a4,10
     a88:	00e7a023          	sw	a4,0(a5)
}
     a8c:	02010113          	addi	sp,sp,32
     a90:	00008067          	ret
        UART0->DATA = '\r';
     a94:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     a98:	00e6a023          	sw	a4,0(a3)
    while (*p)
     a9c:	0007c703          	lbu	a4,0(a5)
     aa0:	fa071ee3          	bnez	a4,a5c <cmd_benchmark_all+0x40c>
     aa4:	fcdff06f          	j	a70 <cmd_benchmark_all+0x420>
        UART0->DATA = '\r';
     aa8:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     aac:	00f6a023          	sw	a5,0(a3)
    while (*p)
     ab0:	00074783          	lbu	a5,0(a4)
     ab4:	f60794e3          	bnez	a5,a1c <cmd_benchmark_all+0x3cc>
     ab8:	f79ff06f          	j	a30 <cmd_benchmark_all+0x3e0>
        UART0->DATA = '\r';
     abc:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     ac0:	00f6a023          	sw	a5,0(a3)
    while (*p)
     ac4:	00074783          	lbu	a5,0(a4)
     ac8:	f00796e3          	bnez	a5,9d4 <cmd_benchmark_all+0x384>
     acc:	f1dff06f          	j	9e8 <cmd_benchmark_all+0x398>
        UART0->DATA = '\r';
     ad0:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     ad4:	00f6a023          	sw	a5,0(a3)
    while (*p)
     ad8:	00074783          	lbu	a5,0(a4)
     adc:	ea0798e3          	bnez	a5,98c <cmd_benchmark_all+0x33c>
     ae0:	ec1ff06f          	j	9a0 <cmd_benchmark_all+0x350>
        UART0->DATA = '\r';
     ae4:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     ae8:	00f6a023          	sw	a5,0(a3)
    while (*p)
     aec:	00074783          	lbu	a5,0(a4)
     af0:	e4079ae3          	bnez	a5,944 <cmd_benchmark_all+0x2f4>
     af4:	e65ff06f          	j	958 <cmd_benchmark_all+0x308>
        UART0->DATA = '\r';
     af8:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     afc:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b00:	00074783          	lbu	a5,0(a4)
     b04:	dc0794e3          	bnez	a5,8cc <cmd_benchmark_all+0x27c>
     b08:	dd9ff06f          	j	8e0 <cmd_benchmark_all+0x290>
        UART0->DATA = '\r';
     b0c:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b10:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b14:	00074783          	lbu	a5,0(a4)
     b18:	de079ae3          	bnez	a5,90c <cmd_benchmark_all+0x2bc>
     b1c:	e05ff06f          	j	920 <cmd_benchmark_all+0x2d0>
        UART0->DATA = '\r';
     b20:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b24:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b28:	00074783          	lbu	a5,0(a4)
     b2c:	c40798e3          	bnez	a5,77c <cmd_benchmark_all+0x12c>
     b30:	c61ff06f          	j	790 <cmd_benchmark_all+0x140>
        UART0->DATA = '\r';
     b34:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b38:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b3c:	00074783          	lbu	a5,0(a4)
     b40:	be079ae3          	bnez	a5,734 <cmd_benchmark_all+0xe4>
     b44:	c05ff06f          	j	748 <cmd_benchmark_all+0xf8>
        UART0->DATA = '\r';
     b48:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b4c:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b50:	00074783          	lbu	a5,0(a4)
     b54:	b8079ce3          	bnez	a5,6ec <cmd_benchmark_all+0x9c>
     b58:	ba9ff06f          	j	700 <cmd_benchmark_all+0xb0>
        UART0->DATA = '\r';
     b5c:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b60:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b64:	00074783          	lbu	a5,0(a4)
     b68:	b0079ee3          	bnez	a5,684 <cmd_benchmark_all+0x34>
     b6c:	b2dff06f          	j	698 <cmd_benchmark_all+0x48>
        UART0->DATA = '\r';
     b70:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b74:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b78:	00074783          	lbu	a5,0(a4)
     b7c:	c6079ce3          	bnez	a5,7f4 <cmd_benchmark_all+0x1a4>
     b80:	c89ff06f          	j	808 <cmd_benchmark_all+0x1b8>
        UART0->DATA = '\r';
     b84:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b88:	00f6a023          	sw	a5,0(a3)
    while (*p)
     b8c:	00074783          	lbu	a5,0(a4)
     b90:	c20796e3          	bnez	a5,7bc <cmd_benchmark_all+0x16c>
     b94:	c3dff06f          	j	7d0 <cmd_benchmark_all+0x180>
        UART0->DATA = '\r';
     b98:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     b9c:	00f6a023          	sw	a5,0(a3)
    while (*p)
     ba0:	00074783          	lbu	a5,0(a4)
     ba4:	c8079ce3          	bnez	a5,83c <cmd_benchmark_all+0x1ec>
     ba8:	ca9ff06f          	j	850 <cmd_benchmark_all+0x200>
        UART0->DATA = '\r';
     bac:	00b6a023          	sw	a1,0(a3)
    UART0->DATA = c;
     bb0:	00f6a023          	sw	a5,0(a3)
    while (*p)
     bb4:	00074783          	lbu	a5,0(a4)
     bb8:	cc0796e3          	bnez	a5,884 <cmd_benchmark_all+0x234>
     bbc:	cddff06f          	j	898 <cmd_benchmark_all+0x248>

00000bc0 <main>:
    |  __/  __/ ||  __/ |    | |_| | |  __/ | | |\n\
    |_|   \\___|\\__\\___|_|     \\____|_|\\___|_| |_|\n\
\n";

void main()
{
     bc0:	dd010113          	addi	sp,sp,-560
     bc4:	22112623          	sw	ra,556(sp)
     bc8:	22812423          	sw	s0,552(sp)
     bcc:	22912223          	sw	s1,548(sp)
     bd0:	23212023          	sw	s2,544(sp)
     bd4:	21312e23          	sw	s3,540(sp)
     bd8:	21412c23          	sw	s4,536(sp)
     bdc:	21512a23          	sw	s5,532(sp)
     be0:	21612823          	sw	s6,528(sp)
     be4:	21712623          	sw	s7,524(sp)
     be8:	21812423          	sw	s8,520(sp)
     bec:	21912223          	sw	s9,516(sp)
     bf0:	21a12023          	sw	s10,512(sp)
     bf4:	1fb12e23          	sw	s11,508(sp)
    UART0->CLKDIV = CLK_FREQ / UART_BAUD - 2;
     bf8:	830007b7          	lui	a5,0x83000
     bfc:	0d800713          	li	a4,216
     c00:	00e7a223          	sw	a4,4(a5) # 83000004 <__global_pointer$+0x42fff714>

    GPIO0->OE = 0x3F;
     c04:	820007b7          	lui	a5,0x82000
     c08:	03f00713          	li	a4,63
     c0c:	00e7a423          	sw	a4,8(a5) # 82000008 <__global_pointer$+0x41fff718>
    GPIO0->OUT = 0x3F;
     c10:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG |= QSPI_REG_CRM;
     c14:	81000737          	lui	a4,0x81000
     c18:	00072783          	lw	a5,0(a4) # 81000000 <__global_pointer$+0x40fff710>
     c1c:	001006b7          	lui	a3,0x100
        QSPI0->REG |= QSPI_REG_DSPI;
     c20:	00400637          	lui	a2,0x400
        QSPI0->REG |= QSPI_REG_CRM;
     c24:	00d7e7b3          	or	a5,a5,a3
     c28:	00f72023          	sw	a5,0(a4)
        QSPI0->REG |= QSPI_REG_DSPI;
     c2c:	00072683          	lw	a3,0(a4)
    while (*p)
     c30:	00a00793          	li	a5,10
    if (c == '\n')
     c34:	00a00593          	li	a1,10
        QSPI0->REG |= QSPI_REG_DSPI;
     c38:	00c6e6b3          	or	a3,a3,a2
     c3c:	00d72023          	sw	a3,0(a4)
     c40:	00002737          	lui	a4,0x2
     c44:	3c870713          	addi	a4,a4,968 # 23c8 <xsnprintf+0x4c0>
    UART0->DATA = c;
     c48:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     c4c:	00d00613          	li	a2,13
        putchar(*(p++));
     c50:	00170713          	addi	a4,a4,1
    if (c == '\n')
     c54:	7ab78263          	beq	a5,a1,13f8 <main+0x838>
    UART0->DATA = c;
     c58:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     c5c:	00074783          	lbu	a5,0(a4)
     c60:	fe0798e3          	bnez	a5,c50 <main+0x90>
    UART0->DATA = c;
     c64:	830007b7          	lui	a5,0x83000
     c68:	02000713          	li	a4,32
     c6c:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
        putchar(*(p++));
     c70:	00002737          	lui	a4,0x2
     c74:	3d170713          	addi	a4,a4,977 # 23d1 <xsnprintf+0x4c9>
    while (*p)
     c78:	02000793          	li	a5,32
    if (c == '\n')
     c7c:	00a00593          	li	a1,10
    UART0->DATA = c;
     c80:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     c84:	00d00613          	li	a2,13
        putchar(*(p++));
     c88:	00170713          	addi	a4,a4,1
    if (c == '\n')
     c8c:	78b78063          	beq	a5,a1,140c <main+0x84c>
    UART0->DATA = c;
     c90:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     c94:	00074783          	lbu	a5,0(a4)
     c98:	fe0798e3          	bnez	a5,c88 <main+0xc8>
    cmd_set_dspi(1);

    print("\n\n\n\n\n\n");

    print("           Lichee Tang Nano-9K by Peter Glen, Build: ");
    print(BUILD); print("\n");
     c9c:	400007b7          	lui	a5,0x40000
     ca0:	0f07a703          	lw	a4,240(a5) # 400000f0 <BUILD>
    if (c == '\n')
     ca4:	00a00593          	li	a1,10
    UART0->DATA = c;
     ca8:	830006b7          	lui	a3,0x83000
    while (*p)
     cac:	00074783          	lbu	a5,0(a4)
        UART0->DATA = '\r';
     cb0:	00d00613          	li	a2,13
    while (*p)
     cb4:	00078c63          	beqz	a5,ccc <main+0x10c>
        putchar(*(p++));
     cb8:	00170713          	addi	a4,a4,1
    if (c == '\n')
     cbc:	76b78263          	beq	a5,a1,1420 <main+0x860>
    UART0->DATA = c;
     cc0:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     cc4:	00074783          	lbu	a5,0(a4)
     cc8:	fe0798e3          	bnez	a5,cb8 <main+0xf8>
        UART0->DATA = '\r';
     ccc:	830007b7          	lui	a5,0x83000
     cd0:	00d00713          	li	a4,13
     cd4:	00e7a023          	sw	a4,0(a5) # 83000000 <__global_pointer$+0x42fff710>
    UART0->DATA = c;
     cd8:	00a00693          	li	a3,10
     cdc:	00d7a023          	sw	a3,0(a5)
        UART0->DATA = '\r';
     ce0:	00e7a023          	sw	a4,0(a5)
    UART0->DATA = c;
     ce4:	00d7a023          	sw	a3,0(a5)
    while (*p)
     ce8:	40000737          	lui	a4,0x40000
     cec:	00074783          	lbu	a5,0(a4) # 40000000 <strpg>
    if (c == '\n')
     cf0:	00a00593          	li	a1,10
    while (*p)
     cf4:	00070713          	mv	a4,a4
    UART0->DATA = c;
     cf8:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     cfc:	00d00613          	li	a2,13
    while (*p)
     d00:	00078c63          	beqz	a5,d18 <main+0x158>
        putchar(*(p++));
     d04:	00170713          	addi	a4,a4,1
    if (c == '\n')
     d08:	72b78663          	beq	a5,a1,1434 <main+0x874>
    UART0->DATA = c;
     d0c:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     d10:	00074783          	lbu	a5,0(a4)
     d14:	fe0798e3          	bnez	a5,d04 <main+0x144>
    print(strpg);

    // Show clock
    char outx[64];
    void *arr2[] = {(void*)CLK_FREQ, NULL};
    xsnprintf(outx, sizeof(outx), "Clock frequency: %d\n", arr2);
     d18:	00002637          	lui	a2,0x2
    void *arr2[] = {(void*)CLK_FREQ, NULL};
     d1c:	018027b7          	lui	a5,0x1802
     d20:	3d878793          	addi	a5,a5,984 # 18023d8 <_etext+0x17ffc88>
    xsnprintf(outx, sizeof(outx), "Clock frequency: %d\n", arr2);
     d24:	07410693          	addi	a3,sp,116
     d28:	5d460613          	addi	a2,a2,1492 # 25d4 <xsnprintf+0x6cc>
     d2c:	04000593          	li	a1,64
     d30:	0b010513          	addi	a0,sp,176
    void *arr2[] = {(void*)CLK_FREQ, NULL};
     d34:	06f12a23          	sw	a5,116(sp)
     d38:	06012c23          	sw	zero,120(sp)
    xsnprintf(outx, sizeof(outx), "Clock frequency: %d\n", arr2);
     d3c:	1cc010ef          	jal	ra,1f08 <xsnprintf>
    while (*p)
     d40:	0b014783          	lbu	a5,176(sp)
     d44:	0b010713          	addi	a4,sp,176
    if (c == '\n')
     d48:	00a00593          	li	a1,10
    UART0->DATA = c;
     d4c:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     d50:	00d00613          	li	a2,13
    while (*p)
     d54:	00078c63          	beqz	a5,d6c <main+0x1ac>
        putchar(*(p++));
     d58:	00170713          	addi	a4,a4,1
    if (c == '\n')
     d5c:	6eb78663          	beq	a5,a1,1448 <main+0x888>
    UART0->DATA = c;
     d60:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     d64:	00074783          	lbu	a5,0(a4)
     d68:	fe0798e3          	bnez	a5,d58 <main+0x198>
    print(outx);

    for ( i = 0 ; i < 10000; i++);
     d6c:	400007b7          	lui	a5,0x40000
     d70:	0f878793          	addi	a5,a5,248 # 400000f8 <i>
     d74:	0007a023          	sw	zero,0(a5)
     d78:	0007a683          	lw	a3,0(a5)
     d7c:	00002737          	lui	a4,0x2
     d80:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     d84:	00d74c63          	blt	a4,a3,d9c <main+0x1dc>
     d88:	0007a683          	lw	a3,0(a5)
     d8c:	00168693          	addi	a3,a3,1
     d90:	00d7a023          	sw	a3,0(a5)
     d94:	0007a683          	lw	a3,0(a5)
     d98:	fed758e3          	bge	a4,a3,d88 <main+0x1c8>
    GPIO0->OUT = 0x3F ^ 0x01;
     d9c:	82000737          	lui	a4,0x82000
     da0:	03e00693          	li	a3,62
     da4:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     da8:	0007a023          	sw	zero,0(a5)
     dac:	0007a683          	lw	a3,0(a5)
     db0:	00002737          	lui	a4,0x2
     db4:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     db8:	00d74c63          	blt	a4,a3,dd0 <main+0x210>
     dbc:	0007a683          	lw	a3,0(a5)
     dc0:	00168693          	addi	a3,a3,1
     dc4:	00d7a023          	sw	a3,0(a5)
     dc8:	0007a683          	lw	a3,0(a5)
     dcc:	fed758e3          	bge	a4,a3,dbc <main+0x1fc>
    GPIO0->OUT = 0x3F ^ 0x02;
     dd0:	82000737          	lui	a4,0x82000
     dd4:	03d00693          	li	a3,61
     dd8:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     ddc:	0007a023          	sw	zero,0(a5)
     de0:	0007a683          	lw	a3,0(a5)
     de4:	00002737          	lui	a4,0x2
     de8:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     dec:	00d74c63          	blt	a4,a3,e04 <main+0x244>
     df0:	0007a683          	lw	a3,0(a5)
     df4:	00168693          	addi	a3,a3,1
     df8:	00d7a023          	sw	a3,0(a5)
     dfc:	0007a683          	lw	a3,0(a5)
     e00:	fed758e3          	bge	a4,a3,df0 <main+0x230>
    GPIO0->OUT = 0x3F ^ 0x04;
     e04:	82000737          	lui	a4,0x82000
     e08:	03b00693          	li	a3,59
     e0c:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     e10:	0007a023          	sw	zero,0(a5)
     e14:	0007a683          	lw	a3,0(a5)
     e18:	00002737          	lui	a4,0x2
     e1c:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     e20:	00d74c63          	blt	a4,a3,e38 <main+0x278>
     e24:	0007a683          	lw	a3,0(a5)
     e28:	00168693          	addi	a3,a3,1
     e2c:	00d7a023          	sw	a3,0(a5)
     e30:	0007a683          	lw	a3,0(a5)
     e34:	fed758e3          	bge	a4,a3,e24 <main+0x264>
    GPIO0->OUT = 0x3F ^ 0x08;
     e38:	82000737          	lui	a4,0x82000
     e3c:	03700693          	li	a3,55
     e40:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     e44:	0007a023          	sw	zero,0(a5)
     e48:	0007a683          	lw	a3,0(a5)
     e4c:	00002737          	lui	a4,0x2
     e50:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     e54:	00d74c63          	blt	a4,a3,e6c <main+0x2ac>
     e58:	0007a683          	lw	a3,0(a5)
     e5c:	00168693          	addi	a3,a3,1
     e60:	00d7a023          	sw	a3,0(a5)
     e64:	0007a683          	lw	a3,0(a5)
     e68:	fed758e3          	bge	a4,a3,e58 <main+0x298>
    GPIO0->OUT = 0x3F ^ 0x10;
     e6c:	82000737          	lui	a4,0x82000
     e70:	02f00693          	li	a3,47
     e74:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     e78:	0007a023          	sw	zero,0(a5)
     e7c:	0007a683          	lw	a3,0(a5)
     e80:	00002737          	lui	a4,0x2
     e84:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     e88:	00d74c63          	blt	a4,a3,ea0 <main+0x2e0>
     e8c:	0007a683          	lw	a3,0(a5)
     e90:	00168693          	addi	a3,a3,1
     e94:	00d7a023          	sw	a3,0(a5)
     e98:	0007a683          	lw	a3,0(a5)
     e9c:	fed758e3          	bge	a4,a3,e8c <main+0x2cc>
    GPIO0->OUT = 0x3F ^ 0x20;
     ea0:	82000737          	lui	a4,0x82000
     ea4:	01f00693          	li	a3,31
     ea8:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     eac:	0007a023          	sw	zero,0(a5)
     eb0:	0007a683          	lw	a3,0(a5)
     eb4:	00002737          	lui	a4,0x2
     eb8:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     ebc:	00d74c63          	blt	a4,a3,ed4 <main+0x314>
     ec0:	0007a683          	lw	a3,0(a5)
     ec4:	00168693          	addi	a3,a3,1
     ec8:	00d7a023          	sw	a3,0(a5)
     ecc:	0007a683          	lw	a3,0(a5)
     ed0:	fed758e3          	bge	a4,a3,ec0 <main+0x300>
    GPIO0->OUT = 0x3F;
     ed4:	82000737          	lui	a4,0x82000
     ed8:	03f00693          	li	a3,63
     edc:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     ee0:	0007a023          	sw	zero,0(a5)
     ee4:	0007a683          	lw	a3,0(a5)
     ee8:	00002737          	lui	a4,0x2
     eec:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     ef0:	00d74c63          	blt	a4,a3,f08 <main+0x348>
     ef4:	0007a683          	lw	a3,0(a5)
     ef8:	00168693          	addi	a3,a3,1
     efc:	00d7a023          	sw	a3,0(a5)
     f00:	0007a683          	lw	a3,0(a5)
     f04:	fed758e3          	bge	a4,a3,ef4 <main+0x334>
    GPIO0->OUT = 0x00;
     f08:	82000737          	lui	a4,0x82000
     f0c:	00072023          	sw	zero,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     f10:	0007a023          	sw	zero,0(a5)
     f14:	0007a683          	lw	a3,0(a5)
     f18:	00002737          	lui	a4,0x2
     f1c:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     f20:	00d74c63          	blt	a4,a3,f38 <main+0x378>
     f24:	0007a683          	lw	a3,0(a5)
     f28:	00168693          	addi	a3,a3,1
     f2c:	00d7a023          	sw	a3,0(a5)
     f30:	0007a683          	lw	a3,0(a5)
     f34:	fed758e3          	bge	a4,a3,f24 <main+0x364>
    GPIO0->OUT = 0x3F;
     f38:	82000737          	lui	a4,0x82000
     f3c:	03f00693          	li	a3,63
     f40:	00d72023          	sw	a3,0(a4) # 82000000 <__global_pointer$+0x41fff710>
    for ( i = 0 ; i < 10000; i++);
     f44:	0007a023          	sw	zero,0(a5)
     f48:	0007a683          	lw	a3,0(a5)
     f4c:	00002737          	lui	a4,0x2
     f50:	70f70713          	addi	a4,a4,1807 # 270f <xsnprintf+0x807>
     f54:	00d74c63          	blt	a4,a3,f6c <main+0x3ac>
     f58:	0007a683          	lw	a3,0(a5)
     f5c:	00168693          	addi	a3,a3,1
     f60:	00d7a023          	sw	a3,0(a5)
     f64:	0007a683          	lw	a3,0(a5)
     f68:	fed758e3          	bge	a4,a3,f58 <main+0x398>

    // test xsnprintf
    void *arr[] = {(void*)"\nHello",(void*)-99, (void*)33, 0, arr, 63, NULL};
     f6c:	000027b7          	lui	a5,0x2
     f70:	5ec78793          	addi	a5,a5,1516 # 25ec <xsnprintf+0x6e4>
     f74:	08f12a23          	sw	a5,148(sp)
     f78:	f9d00793          	li	a5,-99
     f7c:	08f12c23          	sw	a5,152(sp)
     f80:	02100793          	li	a5,33
     f84:	08f12e23          	sw	a5,156(sp)
    int xx = 1234;
    arr[3] = (void*)xx;
    xsnprintf(outx, sizeof(outx), "%s: %22 %d 0x%x 0b%b %p 0%o %%\n", arr);
     f88:	00002637          	lui	a2,0x2
    void *arr[] = {(void*)"\nHello",(void*)-99, (void*)33, 0, arr, 63, NULL};
     f8c:	03f00793          	li	a5,63
     f90:	09410693          	addi	a3,sp,148
    xsnprintf(outx, sizeof(outx), "%s: %22 %d 0x%x 0b%b %p 0%o %%\n", arr);
     f94:	5f460613          	addi	a2,a2,1524 # 25f4 <xsnprintf+0x6ec>
     f98:	04000593          	li	a1,64
    void *arr[] = {(void*)"\nHello",(void*)-99, (void*)33, 0, arr, 63, NULL};
     f9c:	0af12423          	sw	a5,168(sp)
    xsnprintf(outx, sizeof(outx), "%s: %22 %d 0x%x 0b%b %p 0%o %%\n", arr);
     fa0:	0b010513          	addi	a0,sp,176
    arr[3] = (void*)xx;
     fa4:	4d200793          	li	a5,1234
    void *arr[] = {(void*)"\nHello",(void*)-99, (void*)33, 0, arr, 63, NULL};
     fa8:	0ad12223          	sw	a3,164(sp)
    arr[3] = (void*)xx;
     fac:	0af12023          	sw	a5,160(sp)
    void *arr[] = {(void*)"\nHello",(void*)-99, (void*)33, 0, arr, 63, NULL};
     fb0:	0a012623          	sw	zero,172(sp)
    xsnprintf(outx, sizeof(outx), "%s: %22 %d 0x%x 0b%b %p 0%o %%\n", arr);
     fb4:	755000ef          	jal	ra,1f08 <xsnprintf>
    while (*p)
     fb8:	0b014783          	lbu	a5,176(sp)
     fbc:	0b010713          	addi	a4,sp,176
    if (c == '\n')
     fc0:	00a00593          	li	a1,10
    UART0->DATA = c;
     fc4:	830006b7          	lui	a3,0x83000
        UART0->DATA = '\r';
     fc8:	00d00613          	li	a2,13
    while (*p)
     fcc:	00078c63          	beqz	a5,fe4 <main+0x424>
        putchar(*(p++));
     fd0:	00170713          	addi	a4,a4,1
    if (c == '\n')
     fd4:	38b780e3          	beq	a5,a1,1b54 <main+0xf94>
    UART0->DATA = c;
     fd8:	00f6a023          	sw	a5,0(a3) # 83000000 <__global_pointer$+0x42fff710>
    while (*p)
     fdc:	00074783          	lbu	a5,0(a4)
     fe0:	fe0798e3          	bnez	a5,fd0 <main+0x410>
     fe4:	000027b7          	lui	a5,0x2
     fe8:	40978793          	addi	a5,a5,1033 # 2409 <xsnprintf+0x501>
     fec:	00f12a23          	sw	a5,20(sp)
     ff0:	000027b7          	lui	a5,0x2
     ff4:	43d78793          	addi	a5,a5,1085 # 243d <xsnprintf+0x535>
     ff8:	00f12c23          	sw	a5,24(sp)
     ffc:	000027b7          	lui	a5,0x2
    1000:	45578793          	addi	a5,a5,1109 # 2455 <xsnprintf+0x54d>
    1004:	00f12e23          	sw	a5,28(sp)
    1008:	000027b7          	lui	a5,0x2
    100c:	46d78793          	addi	a5,a5,1133 # 246d <xsnprintf+0x565>
    1010:	02f12023          	sw	a5,32(sp)
    1014:	000027b7          	lui	a5,0x2
    1018:	48578793          	addi	a5,a5,1157 # 2485 <xsnprintf+0x57d>
    101c:	02f12223          	sw	a5,36(sp)
    1020:	000027b7          	lui	a5,0x2
    1024:	49d78793          	addi	a5,a5,1181 # 249d <xsnprintf+0x595>
    1028:	02f12423          	sw	a5,40(sp)
    102c:	000027b7          	lui	a5,0x2
    1030:	4b578793          	addi	a5,a5,1205 # 24b5 <xsnprintf+0x5ad>
    1034:	02f12623          	sw	a5,44(sp)
    1038:	000027b7          	lui	a5,0x2
    103c:	4cd78793          	addi	a5,a5,1229 # 24cd <xsnprintf+0x5c5>
    1040:	02f12823          	sw	a5,48(sp)
    1044:	000027b7          	lui	a5,0x2
    1048:	4e578793          	addi	a5,a5,1253 # 24e5 <xsnprintf+0x5dd>
    104c:	02f12a23          	sw	a5,52(sp)
    1050:	000027b7          	lui	a5,0x2
    1054:	50178793          	addi	a5,a5,1281 # 2501 <xsnprintf+0x5f9>
    1058:	02f12c23          	sw	a5,56(sp)
    105c:	000027b7          	lui	a5,0x2
    1060:	51d78793          	addi	a5,a5,1309 # 251d <xsnprintf+0x615>
    1064:	02f12e23          	sw	a5,60(sp)
    1068:	000027b7          	lui	a5,0x2
    106c:	53578793          	addi	a5,a5,1333 # 2535 <xsnprintf+0x62d>
    1070:	04f12023          	sw	a5,64(sp)
    1074:	000027b7          	lui	a5,0x2
    1078:	55178793          	addi	a5,a5,1361 # 2551 <xsnprintf+0x649>
    107c:	04f12223          	sw	a5,68(sp)
    1080:	000027b7          	lui	a5,0x2
    1084:	57578793          	addi	a5,a5,1397 # 2575 <xsnprintf+0x66d>
    1088:	04f12423          	sw	a5,72(sp)
    108c:	000027b7          	lui	a5,0x2
    1090:	5b978793          	addi	a5,a5,1465 # 25b9 <xsnprintf+0x6b1>
    1094:	00002d37          	lui	s10,0x2
    1098:	00002cb7          	lui	s9,0x2
    109c:	04f12623          	sw	a5,76(sp)
    10a0:	5c5d0793          	addi	a5,s10,1477 # 25c5 <xsnprintf+0x6bd>
    10a4:	00f12623          	sw	a5,12(sp)
    10a8:	5c1c8793          	addi	a5,s9,1473 # 25c1 <xsnprintf+0x6b9>
    10ac:	00f12423          	sw	a5,8(sp)
    10b0:	000027b7          	lui	a5,0x2
    10b4:	5cd78793          	addi	a5,a5,1485 # 25cd <xsnprintf+0x6c5>
    10b8:	04f12823          	sw	a5,80(sp)
    10bc:	000027b7          	lui	a5,0x2
    10c0:	36178793          	addi	a5,a5,865 # 2361 <xsnprintf+0x459>
    10c4:	04f12a23          	sw	a5,84(sp)
    10c8:	000027b7          	lui	a5,0x2
    10cc:	36d78793          	addi	a5,a5,877 # 236d <xsnprintf+0x465>
    10d0:	04f12c23          	sw	a5,88(sp)
    10d4:	000027b7          	lui	a5,0x2
    10d8:	37978793          	addi	a5,a5,889 # 2379 <xsnprintf+0x471>
    10dc:	04f12e23          	sw	a5,92(sp)
        QSPI0->REG &= ~QSPI_REG_CRM;
    10e0:	fff007b7          	lui	a5,0xfff00
    10e4:	00002bb7          	lui	s7,0x2
    10e8:	00002437          	lui	s0,0x2
    10ec:	000024b7          	lui	s1,0x2
    10f0:	00002c37          	lui	s8,0x2
    10f4:	00002a37          	lui	s4,0x2
    10f8:	fff78793          	addi	a5,a5,-1 # ffefffff <__global_pointer$+0xbfeff70f>
    10fc:	41db8b93          	addi	s7,s7,1053 # 241d <xsnprintf+0x515>
    1100:	5a140413          	addi	s0,s0,1441 # 25a1 <xsnprintf+0x699>
    1104:	61448493          	addi	s1,s1,1556 # 2614 <xsnprintf+0x70c>
    1108:	5adc0c13          	addi	s8,s8,1453 # 25ad <xsnprintf+0x6a5>
    110c:	595a0a13          	addi	s4,s4,1429 # 2595 <xsnprintf+0x68d>
        UART0->DATA = '\r';
    1110:	83000db7          	lui	s11,0x83000
    1114:	00d00d13          	li	s10,13
    1118:	00d00a93          	li	s5,13
    UART0->DATA = c;
    111c:	00a00c93          	li	s9,10
    1120:	02000993          	li	s3,32
        QSPI0->REG &= ~QSPI_REG_CRM;
    1124:	00f12823          	sw	a5,16(sp)
        UART0->DATA = '\r';
    1128:	015da023          	sw	s5,0(s11) # 83000000 <__global_pointer$+0x42fff710>
        putchar(*(p++));
    112c:	01412703          	lw	a4,20(sp)
    UART0->DATA = c;
    1130:	05300793          	li	a5,83
    1134:	019da023          	sw	s9,0(s11)
    1138:	00fda023          	sw	a5,0(s11)
    while (*p)
    113c:	06500793          	li	a5,101
        putchar(*(p++));
    1140:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1144:	099782e3          	beq	a5,s9,19c8 <main+0xe08>
    UART0->DATA = c;
    1148:	00fda023          	sw	a5,0(s11)
    while (*p)
    114c:	00074783          	lbu	a5,0(a4)
    1150:	fe0798e3          	bnez	a5,1140 <main+0x580>
        UART0->DATA = '\r';
    1154:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1158:	019da023          	sw	s9,0(s11)
    115c:	013da023          	sw	s3,0(s11)
        putchar(*(p++));
    1160:	000b8713          	mv	a4,s7
    while (*p)
    1164:	02000793          	li	a5,32
        putchar(*(p++));
    1168:	00170713          	addi	a4,a4,1
    if (c == '\n')
    116c:	059784e3          	beq	a5,s9,19b4 <main+0xdf4>
    UART0->DATA = c;
    1170:	00fda023          	sw	a5,0(s11)
    while (*p)
    1174:	00074783          	lbu	a5,0(a4)
    1178:	fe0798e3          	bnez	a5,1168 <main+0x5a8>
        putchar(*(p++));
    117c:	01812703          	lw	a4,24(sp)
    UART0->DATA = c;
    1180:	013da023          	sw	s3,0(s11)
    while (*p)
    1184:	02000793          	li	a5,32
        putchar(*(p++));
    1188:	00170713          	addi	a4,a4,1
    if (c == '\n')
    118c:	01978ae3          	beq	a5,s9,19a0 <main+0xde0>
    UART0->DATA = c;
    1190:	00fda023          	sw	a5,0(s11)
    while (*p)
    1194:	00074783          	lbu	a5,0(a4)
    1198:	fe0798e3          	bnez	a5,1188 <main+0x5c8>
        putchar(*(p++));
    119c:	01c12703          	lw	a4,28(sp)
    UART0->DATA = c;
    11a0:	013da023          	sw	s3,0(s11)
    while (*p)
    11a4:	02000793          	li	a5,32
        putchar(*(p++));
    11a8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    11ac:	7f978063          	beq	a5,s9,198c <main+0xdcc>
    UART0->DATA = c;
    11b0:	00fda023          	sw	a5,0(s11)
    while (*p)
    11b4:	00074783          	lbu	a5,0(a4)
    11b8:	fe0798e3          	bnez	a5,11a8 <main+0x5e8>
        putchar(*(p++));
    11bc:	02012703          	lw	a4,32(sp)
    UART0->DATA = c;
    11c0:	013da023          	sw	s3,0(s11)
    while (*p)
    11c4:	02000793          	li	a5,32
        putchar(*(p++));
    11c8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    11cc:	7b978663          	beq	a5,s9,1978 <main+0xdb8>
    UART0->DATA = c;
    11d0:	00fda023          	sw	a5,0(s11)
    while (*p)
    11d4:	00074783          	lbu	a5,0(a4)
    11d8:	fe0798e3          	bnez	a5,11c8 <main+0x608>
        putchar(*(p++));
    11dc:	02412703          	lw	a4,36(sp)
    UART0->DATA = c;
    11e0:	013da023          	sw	s3,0(s11)
    while (*p)
    11e4:	02000793          	li	a5,32
        putchar(*(p++));
    11e8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    11ec:	77978c63          	beq	a5,s9,1964 <main+0xda4>
    UART0->DATA = c;
    11f0:	00fda023          	sw	a5,0(s11)
    while (*p)
    11f4:	00074783          	lbu	a5,0(a4)
    11f8:	fe0798e3          	bnez	a5,11e8 <main+0x628>
        putchar(*(p++));
    11fc:	02812703          	lw	a4,40(sp)
    UART0->DATA = c;
    1200:	013da023          	sw	s3,0(s11)
    while (*p)
    1204:	02000793          	li	a5,32
        putchar(*(p++));
    1208:	00170713          	addi	a4,a4,1
    if (c == '\n')
    120c:	75978263          	beq	a5,s9,1950 <main+0xd90>
    UART0->DATA = c;
    1210:	00fda023          	sw	a5,0(s11)
    while (*p)
    1214:	00074783          	lbu	a5,0(a4)
    1218:	fe0798e3          	bnez	a5,1208 <main+0x648>
        putchar(*(p++));
    121c:	02c12703          	lw	a4,44(sp)
    UART0->DATA = c;
    1220:	013da023          	sw	s3,0(s11)
    while (*p)
    1224:	02000793          	li	a5,32
        putchar(*(p++));
    1228:	00170713          	addi	a4,a4,1
    if (c == '\n')
    122c:	71978863          	beq	a5,s9,193c <main+0xd7c>
    UART0->DATA = c;
    1230:	00fda023          	sw	a5,0(s11)
    while (*p)
    1234:	00074783          	lbu	a5,0(a4)
    1238:	fe0798e3          	bnez	a5,1228 <main+0x668>
        putchar(*(p++));
    123c:	03012703          	lw	a4,48(sp)
    UART0->DATA = c;
    1240:	013da023          	sw	s3,0(s11)
    while (*p)
    1244:	02000793          	li	a5,32
        putchar(*(p++));
    1248:	00170713          	addi	a4,a4,1
    if (c == '\n')
    124c:	6d978e63          	beq	a5,s9,1928 <main+0xd68>
    UART0->DATA = c;
    1250:	00fda023          	sw	a5,0(s11)
    while (*p)
    1254:	00074783          	lbu	a5,0(a4)
    1258:	fe0798e3          	bnez	a5,1248 <main+0x688>
        putchar(*(p++));
    125c:	03412703          	lw	a4,52(sp)
    UART0->DATA = c;
    1260:	013da023          	sw	s3,0(s11)
    while (*p)
    1264:	02000793          	li	a5,32
        putchar(*(p++));
    1268:	00170713          	addi	a4,a4,1
    if (c == '\n')
    126c:	6b978463          	beq	a5,s9,1914 <main+0xd54>
    UART0->DATA = c;
    1270:	00fda023          	sw	a5,0(s11)
    while (*p)
    1274:	00074783          	lbu	a5,0(a4)
    1278:	fe0798e3          	bnez	a5,1268 <main+0x6a8>
        putchar(*(p++));
    127c:	03812703          	lw	a4,56(sp)
    UART0->DATA = c;
    1280:	013da023          	sw	s3,0(s11)
    while (*p)
    1284:	02000793          	li	a5,32
        putchar(*(p++));
    1288:	00170713          	addi	a4,a4,1
    if (c == '\n')
    128c:	67978a63          	beq	a5,s9,1900 <main+0xd40>
    UART0->DATA = c;
    1290:	00fda023          	sw	a5,0(s11)
    while (*p)
    1294:	00074783          	lbu	a5,0(a4)
    1298:	fe0798e3          	bnez	a5,1288 <main+0x6c8>
        putchar(*(p++));
    129c:	03c12703          	lw	a4,60(sp)
    UART0->DATA = c;
    12a0:	013da023          	sw	s3,0(s11)
    while (*p)
    12a4:	02000793          	li	a5,32
        putchar(*(p++));
    12a8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    12ac:	65978063          	beq	a5,s9,18ec <main+0xd2c>
    UART0->DATA = c;
    12b0:	00fda023          	sw	a5,0(s11)
    while (*p)
    12b4:	00074783          	lbu	a5,0(a4)
    12b8:	fe0798e3          	bnez	a5,12a8 <main+0x6e8>
        putchar(*(p++));
    12bc:	04012703          	lw	a4,64(sp)
    UART0->DATA = c;
    12c0:	013da023          	sw	s3,0(s11)
    while (*p)
    12c4:	02000793          	li	a5,32
        putchar(*(p++));
    12c8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    12cc:	61978663          	beq	a5,s9,18d8 <main+0xd18>
    UART0->DATA = c;
    12d0:	00fda023          	sw	a5,0(s11)
    while (*p)
    12d4:	00074783          	lbu	a5,0(a4)
    12d8:	fe0798e3          	bnez	a5,12c8 <main+0x708>
        putchar(*(p++));
    12dc:	04412703          	lw	a4,68(sp)
    UART0->DATA = c;
    12e0:	013da023          	sw	s3,0(s11)
    while (*p)
    12e4:	02000793          	li	a5,32
        putchar(*(p++));
    12e8:	00170713          	addi	a4,a4,1
    if (c == '\n')
    12ec:	5d978c63          	beq	a5,s9,18c4 <main+0xd04>
    UART0->DATA = c;
    12f0:	00fda023          	sw	a5,0(s11)
    while (*p)
    12f4:	00074783          	lbu	a5,0(a4)
    12f8:	fe0798e3          	bnez	a5,12e8 <main+0x728>
        putchar(*(p++));
    12fc:	04812703          	lw	a4,72(sp)
    UART0->DATA = c;
    1300:	013da023          	sw	s3,0(s11)
    while (*p)
    1304:	02000793          	li	a5,32
        putchar(*(p++));
    1308:	00170713          	addi	a4,a4,1
    if (c == '\n')
    130c:	5b978263          	beq	a5,s9,18b0 <main+0xcf0>
    UART0->DATA = c;
    1310:	00fda023          	sw	a5,0(s11)
    while (*p)
    1314:	00074783          	lbu	a5,0(a4)
    1318:	fe0798e3          	bnez	a5,1308 <main+0x748>
        QSPI0->REG &= ~QSPI_REG_DSPI;
    131c:	ffc007b7          	lui	a5,0xffc00
    1320:	fff78793          	addi	a5,a5,-1 # ffbfffff <__global_pointer$+0xbfbff70f>
    while (*p)
    1324:	00a00913          	li	s2,10
    UART0->DATA = c;
    1328:	04900b13          	li	s6,73
        QSPI0->REG &= ~QSPI_REG_DSPI;
    132c:	06f12023          	sw	a5,96(sp)
        UART0->DATA = '\r';
    1330:	015da023          	sw	s5,0(s11)
    UART0->DATA = c;
    1334:	019da023          	sw	s9,0(s11)
    1338:	016da023          	sw	s6,0(s11)
        putchar(*(p++));
    133c:	000a0713          	mv	a4,s4
    while (*p)
    1340:	04f00793          	li	a5,79
        putchar(*(p++));
    1344:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1348:	55978a63          	beq	a5,s9,189c <main+0xcdc>
    UART0->DATA = c;
    134c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1350:	00074783          	lbu	a5,0(a4)
    1354:	fe0798e3          	bnez	a5,1344 <main+0x784>
        {
            char out[12];

            print("\n");
            print("IO State: ");
            print_num(GPIO0->IN, 16, out, 12);
    1358:	820007b7          	lui	a5,0x82000
    135c:	0047a503          	lw	a0,4(a5) # 82000004 <__global_pointer$+0x41fff714>
    1360:	00c00693          	li	a3,12
    1364:	07c10613          	addi	a2,sp,124
    1368:	01000593          	li	a1,16
    136c:	001000ef          	jal	ra,1b6c <print_num>
        UART0->DATA = '\r';
    1370:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1374:	019da023          	sw	s9,0(s11)
        UART0->DATA = '\r';
    1378:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    137c:	04300793          	li	a5,67
    1380:	019da023          	sw	s9,0(s11)
    1384:	00fda023          	sw	a5,0(s11)
        putchar(*(p++));
    1388:	00040713          	mv	a4,s0
    while (*p)
    138c:	06f00793          	li	a5,111
        putchar(*(p++));
    1390:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1394:	4f978a63          	beq	a5,s9,1888 <main+0xcc8>
    UART0->DATA = c;
    1398:	00fda023          	sw	a5,0(s11)
    while (*p)
    139c:	00074783          	lbu	a5,0(a4)
    13a0:	fe0798e3          	bnez	a5,1390 <main+0x7d0>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
    13a4:	c00027f3          	rdcycle	a5
    while (c == -1) {
    13a8:	fff00713          	li	a4,-1
        __asm__ volatile ("rdcycle %0" : "=r"(cycles_now));
    13ac:	c00027f3          	rdcycle	a5
        c = UART0->DATA;
    13b0:	000da783          	lw	a5,0(s11)
    while (c == -1) {
    13b4:	fee78ce3          	beq	a5,a4,13ac <main+0x7ec>
            print("\n");
            print("\n");

            print("Command> ");
            char cmd = getchar();
            if (cmd > 32 && cmd < 127)
    13b8:	fdf78713          	addi	a4,a5,-33
    13bc:	0ff77713          	andi	a4,a4,255
    13c0:	05d00693          	li	a3,93
    13c4:	0ff7f793          	andi	a5,a5,255
    13c8:	00e6e663          	bltu	a3,a4,13d4 <main+0x814>
    if (c == '\n')
    13cc:	41978663          	beq	a5,s9,17d8 <main+0xc18>
    UART0->DATA = c;
    13d0:	00fda023          	sw	a5,0(s11)
        UART0->DATA = '\r';
    13d4:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    13d8:	019da023          	sw	s9,0(s11)
                putchar(cmd);
            print("\n");

            switch (cmd)
    13dc:	fcf78793          	addi	a5,a5,-49
    13e0:	04200713          	li	a4,66
    13e4:	08f76e63          	bltu	a4,a5,1480 <main+0x8c0>
    13e8:	00279793          	slli	a5,a5,0x2
    13ec:	00f487b3          	add	a5,s1,a5
    13f0:	0007a783          	lw	a5,0(a5)
    13f4:	00078067          	jr	a5
        UART0->DATA = '\r';
    13f8:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    13fc:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1400:	00074783          	lbu	a5,0(a4)
    1404:	840796e3          	bnez	a5,c50 <main+0x90>
    1408:	85dff06f          	j	c64 <main+0xa4>
        UART0->DATA = '\r';
    140c:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1410:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1414:	00074783          	lbu	a5,0(a4)
    1418:	860798e3          	bnez	a5,c88 <main+0xc8>
    141c:	881ff06f          	j	c9c <main+0xdc>
        UART0->DATA = '\r';
    1420:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1424:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1428:	00074783          	lbu	a5,0(a4)
    142c:	880796e3          	bnez	a5,cb8 <main+0xf8>
    1430:	89dff06f          	j	ccc <main+0x10c>
        UART0->DATA = '\r';
    1434:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1438:	00f6a023          	sw	a5,0(a3)
    while (*p)
    143c:	00074783          	lbu	a5,0(a4)
    1440:	8c0792e3          	bnez	a5,d04 <main+0x144>
    1444:	8d5ff06f          	j	d18 <main+0x158>
        UART0->DATA = '\r';
    1448:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    144c:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1450:	00074783          	lbu	a5,0(a4)
    1454:	900792e3          	bnez	a5,d58 <main+0x198>
    1458:	915ff06f          	j	d6c <main+0x1ac>
        QSPI0->REG &= ~QSPI_REG_CRM;
    145c:	810007b7          	lui	a5,0x81000
    1460:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff710>
    1464:	01012683          	lw	a3,16(sp)
    1468:	00d77733          	and	a4,a4,a3
        QSPI0->REG |= QSPI_REG_CRM;
    146c:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG |= QSPI_REG_DSPI;
    1470:	0007a703          	lw	a4,0(a5)
    1474:	004006b7          	lui	a3,0x400
    1478:	00d76733          	or	a4,a4,a3
    147c:	00e7a023          	sw	a4,0(a5)
        for (int rep = 10; rep > 0; rep--)
    1480:	fff90913          	addi	s2,s2,-1
    1484:	ea0916e3          	bnez	s2,1330 <main+0x770>
    1488:	ca1ff06f          	j	1128 <main+0x568>
        UART0->DATA = '\r';
    148c:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1490:	05300793          	li	a5,83
    1494:	019da023          	sw	s9,0(s11)
    1498:	00fda023          	sw	a5,0(s11)
        putchar(*(p++));
    149c:	000c0713          	mv	a4,s8
    while (*p)
    14a0:	05000793          	li	a5,80
        putchar(*(p++));
    14a4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    14a8:	61978263          	beq	a5,s9,1aac <main+0xeec>
    UART0->DATA = c;
    14ac:	00fda023          	sw	a5,0(s11)
    while (*p)
    14b0:	00074783          	lbu	a5,0(a4)
    14b4:	fe0798e3          	bnez	a5,14a4 <main+0x8e4>
        putchar(*(p++));
    14b8:	04c12703          	lw	a4,76(sp)
    UART0->DATA = c;
    14bc:	013da023          	sw	s3,0(s11)
    while (*p)
    14c0:	02000793          	li	a5,32
        putchar(*(p++));
    14c4:	00170713          	addi	a4,a4,1
    if (c == '\n')
    14c8:	59978063          	beq	a5,s9,1a48 <main+0xe88>
    UART0->DATA = c;
    14cc:	00fda023          	sw	a5,0(s11)
    while (*p)
    14d0:	00074783          	lbu	a5,0(a4)
    14d4:	fe0798e3          	bnez	a5,14c4 <main+0x904>
    return QSPI0->REG & QSPI_REG_DSPI;
    14d8:	810007b7          	lui	a5,0x81000
    14dc:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff710>
    14e0:	00400737          	lui	a4,0x400
    14e4:	00e7f7b3          	and	a5,a5,a4
            case 'F':
            case 'f':
                print("\n");
                print("SPI State:\n");
                print("  DSPI ");
                if ( cmd_get_dspi() )
    14e8:	58079263          	bnez	a5,1a6c <main+0xeac>
        putchar(*(p++));
    14ec:	00c12703          	lw	a4,12(sp)
    UART0->DATA = c;
    14f0:	04f00793          	li	a5,79
    14f4:	00fda023          	sw	a5,0(s11)
    while (*p)
    14f8:	04600793          	li	a5,70
        putchar(*(p++));
    14fc:	00170713          	addi	a4,a4,1 # 400001 <_etext+0x3fd8b1>
    if (c == '\n')
    1500:	65978063          	beq	a5,s9,1b40 <main+0xf80>
    UART0->DATA = c;
    1504:	00fda023          	sw	a5,0(s11)
    while (*p)
    1508:	00074783          	lbu	a5,0(a4)
    150c:	fe0798e3          	bnez	a5,14fc <main+0x93c>
        putchar(*(p++));
    1510:	05012703          	lw	a4,80(sp)
    UART0->DATA = c;
    1514:	013da023          	sw	s3,0(s11)
    while (*p)
    1518:	02000793          	li	a5,32
        putchar(*(p++));
    151c:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1520:	4b978e63          	beq	a5,s9,19dc <main+0xe1c>
    UART0->DATA = c;
    1524:	00fda023          	sw	a5,0(s11)
    while (*p)
    1528:	00074783          	lbu	a5,0(a4)
    152c:	fe0798e3          	bnez	a5,151c <main+0x95c>
    return QSPI0->REG & QSPI_REG_CRM;
    1530:	810007b7          	lui	a5,0x81000
    1534:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff710>
    1538:	00100737          	lui	a4,0x100
    153c:	00e7f7b3          	and	a5,a5,a4
                    print("ON\n");
                else
                    print("OFF\n");
                print("  CRM  ");
                if ( cmd_get_crm() )
    1540:	4c079063          	bnez	a5,1a00 <main+0xe40>
        putchar(*(p++));
    1544:	00c12703          	lw	a4,12(sp)
    UART0->DATA = c;
    1548:	04f00793          	li	a5,79
    154c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1550:	04600793          	li	a5,70
        putchar(*(p++));
    1554:	00170713          	addi	a4,a4,1 # 100001 <_etext+0xfd8b1>
    if (c == '\n')
    1558:	01978c63          	beq	a5,s9,1570 <main+0x9b0>
    UART0->DATA = c;
    155c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1560:	00074783          	lbu	a5,0(a4)
    1564:	f0078ee3          	beqz	a5,1480 <main+0x8c0>
        putchar(*(p++));
    1568:	00170713          	addi	a4,a4,1
    if (c == '\n')
    156c:	ff9798e3          	bne	a5,s9,155c <main+0x99c>
        UART0->DATA = '\r';
    1570:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1574:	00fda023          	sw	a5,0(s11)
    while (*p)
    1578:	00074783          	lbu	a5,0(a4)
    157c:	fc079ce3          	bnez	a5,1554 <main+0x994>
        for (int rep = 10; rep > 0; rep--)
    1580:	fff90913          	addi	s2,s2,-1
    1584:	da0916e3          	bnez	s2,1330 <main+0x770>
    1588:	ba1ff06f          	j	1128 <main+0x568>
        QSPI0->REG &= ~QSPI_REG_DSPI;
    158c:	810007b7          	lui	a5,0x81000
    1590:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff710>
    1594:	06012683          	lw	a3,96(sp)
        for (int rep = 10; rep > 0; rep--)
    1598:	fff90913          	addi	s2,s2,-1
        QSPI0->REG &= ~QSPI_REG_DSPI;
    159c:	00d77733          	and	a4,a4,a3
    15a0:	00e7a023          	sw	a4,0(a5)
        QSPI0->REG &= ~QSPI_REG_CRM;
    15a4:	0007a703          	lw	a4,0(a5)
    15a8:	01012683          	lw	a3,16(sp)
    15ac:	00d77733          	and	a4,a4,a3
    15b0:	00e7a023          	sw	a4,0(a5)
        for (int rep = 10; rep > 0; rep--)
    15b4:	d6091ee3          	bnez	s2,1330 <main+0x770>
    15b8:	b71ff06f          	j	1128 <main+0x568>
    15bc:	fff90913          	addi	s2,s2,-1

                break;

            case 'I':
            case 'i':
                cmd_read_flash_id();
    15c0:	c29fe0ef          	jal	ra,1e8 <cmd_read_flash_id>
        for (int rep = 10; rep > 0; rep--)
    15c4:	d60916e3          	bnez	s2,1330 <main+0x770>
    15c8:	b61ff06f          	j	1128 <main+0x568>
        QSPI0->REG |= QSPI_REG_CRM;
    15cc:	810007b7          	lui	a5,0x81000
    15d0:	0007a703          	lw	a4,0(a5) # 81000000 <__global_pointer$+0x40fff710>
    15d4:	001006b7          	lui	a3,0x100
    15d8:	00d76733          	or	a4,a4,a3
    15dc:	e91ff06f          	j	146c <main+0x8ac>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
    15e0:	c0002573          	rdcycle	a0
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
    15e4:	c0202873          	rdinstret	a6
    uint32_t x32 = 314159265;
    15e8:	12b9b7b7          	lui	a5,0x12b9b
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));
    15ec:	01400e13          	li	t3,20
    uint32_t x32 = 314159265;
    15f0:	0a178793          	addi	a5,a5,161 # 12b9b0a1 <_etext+0x12b98951>
    15f4:	1f010893          	addi	a7,sp,496
        for (int k = 0, p = 0; k < 256; k++)
    15f8:	10000313          	li	t1,256
        for (int k = 0; k < 256; k++)
    15fc:	0f010613          	addi	a2,sp,240
    while (*p)
    1600:	00060693          	mv	a3,a2
    1604:	00078713          	mv	a4,a5
            x32 ^= x32 << 13;
    1608:	00d71793          	slli	a5,a4,0xd
    160c:	00e7c7b3          	xor	a5,a5,a4
            x32 ^= x32 >> 17;
    1610:	0117d713          	srli	a4,a5,0x11
    1614:	00e7c7b3          	xor	a5,a5,a4
            x32 ^= x32 << 5;
    1618:	00579713          	slli	a4,a5,0x5
    161c:	00e7c733          	xor	a4,a5,a4
            data[k] = x32;
    1620:	00e68023          	sb	a4,0(a3) # 100000 <_etext+0xfd8b0>
        for (int k = 0; k < 256; k++)
    1624:	00168693          	addi	a3,a3,1
    1628:	fed890e3          	bne	a7,a3,1608 <main+0xa48>
    162c:	00070793          	mv	a5,a4
    1630:	0f010693          	addi	a3,sp,240
        for (int k = 0, p = 0; k < 256; k++)
    1634:	00000e93          	li	t4,0
    1638:	00000713          	li	a4,0
            if (data[k])
    163c:	0006c583          	lbu	a1,0(a3)
    1640:	00058a63          	beqz	a1,1654 <main+0xa94>
                data[p++] = k;
    1644:	1f010593          	addi	a1,sp,496
    1648:	01d585b3          	add	a1,a1,t4
    164c:	f0e58023          	sb	a4,-256(a1)
    1650:	001e8e93          	addi	t4,t4,1
        for (int k = 0, p = 0; k < 256; k++)
    1654:	00170713          	addi	a4,a4,1
    1658:	00168693          	addi	a3,a3,1
    165c:	fe6710e3          	bne	a4,t1,163c <main+0xa7c>
            x32 = x32 ^ words[k];
    1660:	00062703          	lw	a4,0(a2)
        for (int k = 0, p = 0; k < 64; k++)
    1664:	00460613          	addi	a2,a2,4
            x32 = x32 ^ words[k];
    1668:	00e7c7b3          	xor	a5,a5,a4
        for (int k = 0, p = 0; k < 64; k++)
    166c:	fec89ae3          	bne	a7,a2,1660 <main+0xaa0>
    for (int i = 0; i < 20; i++)
    1670:	fffe0e13          	addi	t3,t3,-1
    1674:	f80e14e3          	bnez	t3,15fc <main+0xa3c>
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_end));
    1678:	c0002373          	rdcycle	t1
    __asm__ volatile ("rdinstret %0" : "=r"(instns_end));
    167c:	c02028f3          	rdinstret	a7
        putchar(*(p++));
    1680:	05412683          	lw	a3,84(sp)
    UART0->DATA = c;
    1684:	04300713          	li	a4,67
    1688:	00eda023          	sw	a4,0(s11)
    while (*p)
    168c:	07900713          	li	a4,121
        putchar(*(p++));
    1690:	00168693          	addi	a3,a3,1
    if (c == '\n')
    1694:	43970663          	beq	a4,s9,1ac0 <main+0xf00>
    UART0->DATA = c;
    1698:	00eda023          	sw	a4,0(s11)
    while (*p)
    169c:	0006c703          	lbu	a4,0(a3)
    16a0:	fe0718e3          	bnez	a4,1690 <main+0xad0>
        print_num(cycles_end - cycles_begin, 16, out, 12);
    16a4:	00c00693          	li	a3,12
    16a8:	08810613          	addi	a2,sp,136
    16ac:	01000593          	li	a1,16
    16b0:	40a30533          	sub	a0,t1,a0
    16b4:	07112623          	sw	a7,108(sp)
    16b8:	06f12423          	sw	a5,104(sp)
    16bc:	07012223          	sw	a6,100(sp)
    16c0:	4ac000ef          	jal	ra,1b6c <print_num>
    while (*p)
    16c4:	08814703          	lbu	a4,136(sp)
    16c8:	06412803          	lw	a6,100(sp)
    16cc:	06812783          	lw	a5,104(sp)
    16d0:	06c12883          	lw	a7,108(sp)
    16d4:	08810693          	addi	a3,sp,136
    16d8:	00070c63          	beqz	a4,16f0 <main+0xb30>
        putchar(*(p++));
    16dc:	00168693          	addi	a3,a3,1
    if (c == '\n')
    16e0:	3f970a63          	beq	a4,s9,1ad4 <main+0xf14>
    UART0->DATA = c;
    16e4:	00eda023          	sw	a4,0(s11)
    while (*p)
    16e8:	0006c703          	lbu	a4,0(a3)
    16ec:	fe0718e3          	bnez	a4,16dc <main+0xb1c>
        UART0->DATA = '\r';
    16f0:	01ada023          	sw	s10,0(s11)
        putchar(*(p++));
    16f4:	05812683          	lw	a3,88(sp)
    UART0->DATA = c;
    16f8:	019da023          	sw	s9,0(s11)
    16fc:	016da023          	sw	s6,0(s11)
    while (*p)
    1700:	06e00713          	li	a4,110
        putchar(*(p++));
    1704:	00168693          	addi	a3,a3,1
    if (c == '\n')
    1708:	3f970063          	beq	a4,s9,1ae8 <main+0xf28>
    UART0->DATA = c;
    170c:	00eda023          	sw	a4,0(s11)
    while (*p)
    1710:	0006c703          	lbu	a4,0(a3)
    1714:	fe0718e3          	bnez	a4,1704 <main+0xb44>
        print_num(instns_end - instns_begin, 16, out, 12);
    1718:	00c00693          	li	a3,12
    171c:	08810613          	addi	a2,sp,136
    1720:	01000593          	li	a1,16
    1724:	41088533          	sub	a0,a7,a6
    1728:	06f12223          	sw	a5,100(sp)
    172c:	440000ef          	jal	ra,1b6c <print_num>
    while (*p)
    1730:	08814703          	lbu	a4,136(sp)
    1734:	06412783          	lw	a5,100(sp)
    1738:	08810693          	addi	a3,sp,136
    173c:	00070c63          	beqz	a4,1754 <main+0xb94>
        putchar(*(p++));
    1740:	00168693          	addi	a3,a3,1
    if (c == '\n')
    1744:	3b970c63          	beq	a4,s9,1afc <main+0xf3c>
    UART0->DATA = c;
    1748:	00eda023          	sw	a4,0(s11)
    while (*p)
    174c:	0006c703          	lbu	a4,0(a3)
    1750:	fe0718e3          	bnez	a4,1740 <main+0xb80>
        UART0->DATA = '\r';
    1754:	01ada023          	sw	s10,0(s11)
        putchar(*(p++));
    1758:	05c12683          	lw	a3,92(sp)
    UART0->DATA = c;
    175c:	04300713          	li	a4,67
    1760:	019da023          	sw	s9,0(s11)
    1764:	00eda023          	sw	a4,0(s11)
    while (*p)
    1768:	06800713          	li	a4,104
        putchar(*(p++));
    176c:	00168693          	addi	a3,a3,1
    if (c == '\n')
    1770:	3b970063          	beq	a4,s9,1b10 <main+0xf50>
    UART0->DATA = c;
    1774:	00eda023          	sw	a4,0(s11)
    while (*p)
    1778:	0006c703          	lbu	a4,0(a3)
    177c:	fe0718e3          	bnez	a4,176c <main+0xbac>
        print_num(x32, 16, out, 12);
    1780:	00078513          	mv	a0,a5
    1784:	00c00693          	li	a3,12
    1788:	08810613          	addi	a2,sp,136
    178c:	01000593          	li	a1,16
    1790:	3dc000ef          	jal	ra,1b6c <print_num>
    while (*p)
    1794:	08814783          	lbu	a5,136(sp)
    1798:	08810713          	addi	a4,sp,136
    179c:	00078c63          	beqz	a5,17b4 <main+0xbf4>
        putchar(*(p++));
    17a0:	00170713          	addi	a4,a4,1
    if (c == '\n')
    17a4:	39978063          	beq	a5,s9,1b24 <main+0xf64>
    UART0->DATA = c;
    17a8:	00fda023          	sw	a5,0(s11)
    while (*p)
    17ac:	00074783          	lbu	a5,0(a4)
    17b0:	fe0798e3          	bnez	a5,17a0 <main+0xbe0>
        UART0->DATA = '\r';
    17b4:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    17b8:	019da023          	sw	s9,0(s11)
        for (int rep = 10; rep > 0; rep--)
    17bc:	fff90913          	addi	s2,s2,-1
    17c0:	b60918e3          	bnez	s2,1330 <main+0x770>
    17c4:	965ff06f          	j	1128 <main+0x568>
    17c8:	fff90913          	addi	s2,s2,-1
                cmd_benchmark(1, 0);
                break;

            case 'A':
            case 'a':
                cmd_benchmark_all();
    17cc:	e85fe0ef          	jal	ra,650 <cmd_benchmark_all>
        for (int rep = 10; rep > 0; rep--)
    17d0:	b60910e3          	bnez	s2,1330 <main+0x770>
    17d4:	955ff06f          	j	1128 <main+0x568>
        UART0->DATA = '\r';
    17d8:	01ada023          	sw	s10,0(s11)
    17dc:	bf5ff06f          	j	13d0 <main+0x810>
            case '5':
                GPIO0->OUT ^= 0x00000010;
                break;

            case '6':
                GPIO0->OUT ^= 0x00000020;
    17e0:	82000737          	lui	a4,0x82000
    17e4:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff710>
        for (int rep = 10; rep > 0; rep--)
    17e8:	fff90913          	addi	s2,s2,-1
                GPIO0->OUT ^= 0x00000020;
    17ec:	0207c793          	xori	a5,a5,32
    17f0:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    17f4:	b2091ee3          	bnez	s2,1330 <main+0x770>
    17f8:	931ff06f          	j	1128 <main+0x568>
                GPIO0->OUT ^= 0x00000010;
    17fc:	82000737          	lui	a4,0x82000
    1800:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff710>
        for (int rep = 10; rep > 0; rep--)
    1804:	fff90913          	addi	s2,s2,-1
                GPIO0->OUT ^= 0x00000010;
    1808:	0107c793          	xori	a5,a5,16
    180c:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    1810:	b20910e3          	bnez	s2,1330 <main+0x770>
    1814:	915ff06f          	j	1128 <main+0x568>
                GPIO0->OUT ^= 0x00000008;
    1818:	82000737          	lui	a4,0x82000
    181c:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff710>
        for (int rep = 10; rep > 0; rep--)
    1820:	fff90913          	addi	s2,s2,-1
                GPIO0->OUT ^= 0x00000008;
    1824:	0087c793          	xori	a5,a5,8
    1828:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    182c:	b00912e3          	bnez	s2,1330 <main+0x770>
    1830:	8f9ff06f          	j	1128 <main+0x568>
                GPIO0->OUT ^= 0x00000004;
    1834:	82000737          	lui	a4,0x82000
    1838:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff710>
        for (int rep = 10; rep > 0; rep--)
    183c:	fff90913          	addi	s2,s2,-1
                GPIO0->OUT ^= 0x00000004;
    1840:	0047c793          	xori	a5,a5,4
    1844:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    1848:	ae0914e3          	bnez	s2,1330 <main+0x770>
    184c:	8ddff06f          	j	1128 <main+0x568>
                GPIO0->OUT ^= 0x00000002;
    1850:	82000737          	lui	a4,0x82000
    1854:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff710>
        for (int rep = 10; rep > 0; rep--)
    1858:	fff90913          	addi	s2,s2,-1
                GPIO0->OUT ^= 0x00000002;
    185c:	0027c793          	xori	a5,a5,2
    1860:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    1864:	ac0916e3          	bnez	s2,1330 <main+0x770>
    1868:	8c1ff06f          	j	1128 <main+0x568>
                GPIO0->OUT ^= 0x00000001;
    186c:	82000737          	lui	a4,0x82000
    1870:	00072783          	lw	a5,0(a4) # 82000000 <__global_pointer$+0x41fff710>
        for (int rep = 10; rep > 0; rep--)
    1874:	fff90913          	addi	s2,s2,-1
                GPIO0->OUT ^= 0x00000001;
    1878:	0017c793          	xori	a5,a5,1
    187c:	00f72023          	sw	a5,0(a4)
        for (int rep = 10; rep > 0; rep--)
    1880:	aa0918e3          	bnez	s2,1330 <main+0x770>
    1884:	8a5ff06f          	j	1128 <main+0x568>
        UART0->DATA = '\r';
    1888:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    188c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1890:	00074783          	lbu	a5,0(a4)
    1894:	ae079ee3          	bnez	a5,1390 <main+0x7d0>
    1898:	b0dff06f          	j	13a4 <main+0x7e4>
        UART0->DATA = '\r';
    189c:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    18a0:	00fda023          	sw	a5,0(s11)
    while (*p)
    18a4:	00074783          	lbu	a5,0(a4)
    18a8:	a8079ee3          	bnez	a5,1344 <main+0x784>
    18ac:	aadff06f          	j	1358 <main+0x798>
        UART0->DATA = '\r';
    18b0:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    18b4:	00fda023          	sw	a5,0(s11)
    while (*p)
    18b8:	00074783          	lbu	a5,0(a4)
    18bc:	a40796e3          	bnez	a5,1308 <main+0x748>
    18c0:	a5dff06f          	j	131c <main+0x75c>
        UART0->DATA = '\r';
    18c4:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    18c8:	00fda023          	sw	a5,0(s11)
    while (*p)
    18cc:	00074783          	lbu	a5,0(a4)
    18d0:	a0079ce3          	bnez	a5,12e8 <main+0x728>
    18d4:	a29ff06f          	j	12fc <main+0x73c>
        UART0->DATA = '\r';
    18d8:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    18dc:	00fda023          	sw	a5,0(s11)
    while (*p)
    18e0:	00074783          	lbu	a5,0(a4)
    18e4:	9e0792e3          	bnez	a5,12c8 <main+0x708>
    18e8:	9f5ff06f          	j	12dc <main+0x71c>
        UART0->DATA = '\r';
    18ec:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    18f0:	00fda023          	sw	a5,0(s11)
    while (*p)
    18f4:	00074783          	lbu	a5,0(a4)
    18f8:	9a0798e3          	bnez	a5,12a8 <main+0x6e8>
    18fc:	9c1ff06f          	j	12bc <main+0x6fc>
        UART0->DATA = '\r';
    1900:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1904:	00fda023          	sw	a5,0(s11)
    while (*p)
    1908:	00074783          	lbu	a5,0(a4)
    190c:	96079ee3          	bnez	a5,1288 <main+0x6c8>
    1910:	98dff06f          	j	129c <main+0x6dc>
        UART0->DATA = '\r';
    1914:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1918:	00fda023          	sw	a5,0(s11)
    while (*p)
    191c:	00074783          	lbu	a5,0(a4)
    1920:	940794e3          	bnez	a5,1268 <main+0x6a8>
    1924:	959ff06f          	j	127c <main+0x6bc>
        UART0->DATA = '\r';
    1928:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    192c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1930:	00074783          	lbu	a5,0(a4)
    1934:	90079ae3          	bnez	a5,1248 <main+0x688>
    1938:	925ff06f          	j	125c <main+0x69c>
        UART0->DATA = '\r';
    193c:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1940:	00fda023          	sw	a5,0(s11)
    while (*p)
    1944:	00074783          	lbu	a5,0(a4)
    1948:	8e0790e3          	bnez	a5,1228 <main+0x668>
    194c:	8f1ff06f          	j	123c <main+0x67c>
        UART0->DATA = '\r';
    1950:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1954:	00fda023          	sw	a5,0(s11)
    while (*p)
    1958:	00074783          	lbu	a5,0(a4)
    195c:	8a0796e3          	bnez	a5,1208 <main+0x648>
    1960:	8bdff06f          	j	121c <main+0x65c>
        UART0->DATA = '\r';
    1964:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1968:	00fda023          	sw	a5,0(s11)
    while (*p)
    196c:	00074783          	lbu	a5,0(a4)
    1970:	86079ce3          	bnez	a5,11e8 <main+0x628>
    1974:	889ff06f          	j	11fc <main+0x63c>
        UART0->DATA = '\r';
    1978:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    197c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1980:	00074783          	lbu	a5,0(a4)
    1984:	840792e3          	bnez	a5,11c8 <main+0x608>
    1988:	855ff06f          	j	11dc <main+0x61c>
        UART0->DATA = '\r';
    198c:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1990:	00fda023          	sw	a5,0(s11)
    while (*p)
    1994:	00074783          	lbu	a5,0(a4)
    1998:	800798e3          	bnez	a5,11a8 <main+0x5e8>
    199c:	821ff06f          	j	11bc <main+0x5fc>
        UART0->DATA = '\r';
    19a0:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    19a4:	00fda023          	sw	a5,0(s11)
    while (*p)
    19a8:	00074783          	lbu	a5,0(a4)
    19ac:	fc079e63          	bnez	a5,1188 <main+0x5c8>
    19b0:	fecff06f          	j	119c <main+0x5dc>
        UART0->DATA = '\r';
    19b4:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    19b8:	00fda023          	sw	a5,0(s11)
    while (*p)
    19bc:	00074783          	lbu	a5,0(a4)
    19c0:	fa079463          	bnez	a5,1168 <main+0x5a8>
    19c4:	fb8ff06f          	j	117c <main+0x5bc>
        UART0->DATA = '\r';
    19c8:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    19cc:	00fda023          	sw	a5,0(s11)
    while (*p)
    19d0:	00074783          	lbu	a5,0(a4)
    19d4:	f6079663          	bnez	a5,1140 <main+0x580>
    19d8:	f7cff06f          	j	1154 <main+0x594>
        UART0->DATA = '\r';
    19dc:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    19e0:	00fda023          	sw	a5,0(s11)
    while (*p)
    19e4:	00074783          	lbu	a5,0(a4)
    19e8:	b2079ae3          	bnez	a5,151c <main+0x95c>
    return QSPI0->REG & QSPI_REG_CRM;
    19ec:	810007b7          	lui	a5,0x81000
    19f0:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff710>
    19f4:	00100737          	lui	a4,0x100
    19f8:	00e7f7b3          	and	a5,a5,a4
                if ( cmd_get_crm() )
    19fc:	b40784e3          	beqz	a5,1544 <main+0x984>
        putchar(*(p++));
    1a00:	00812703          	lw	a4,8(sp)
    UART0->DATA = c;
    1a04:	04f00793          	li	a5,79
    1a08:	00fda023          	sw	a5,0(s11)
    while (*p)
    1a0c:	04e00793          	li	a5,78
        putchar(*(p++));
    1a10:	00170713          	addi	a4,a4,1 # 100001 <_etext+0xfd8b1>
    if (c == '\n')
    1a14:	01978c63          	beq	a5,s9,1a2c <main+0xe6c>
    UART0->DATA = c;
    1a18:	00fda023          	sw	a5,0(s11)
    while (*p)
    1a1c:	00074783          	lbu	a5,0(a4)
    1a20:	a60780e3          	beqz	a5,1480 <main+0x8c0>
        putchar(*(p++));
    1a24:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a28:	ff9798e3          	bne	a5,s9,1a18 <main+0xe58>
        UART0->DATA = '\r';
    1a2c:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1a30:	00fda023          	sw	a5,0(s11)
    while (*p)
    1a34:	00074783          	lbu	a5,0(a4)
    1a38:	fc079ce3          	bnez	a5,1a10 <main+0xe50>
        for (int rep = 10; rep > 0; rep--)
    1a3c:	fff90913          	addi	s2,s2,-1
    1a40:	8e0918e3          	bnez	s2,1330 <main+0x770>
    1a44:	ee4ff06f          	j	1128 <main+0x568>
        UART0->DATA = '\r';
    1a48:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1a4c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1a50:	00074783          	lbu	a5,0(a4)
    1a54:	a60798e3          	bnez	a5,14c4 <main+0x904>
    return QSPI0->REG & QSPI_REG_DSPI;
    1a58:	810007b7          	lui	a5,0x81000
    1a5c:	0007a783          	lw	a5,0(a5) # 81000000 <__global_pointer$+0x40fff710>
    1a60:	00400737          	lui	a4,0x400
    1a64:	00e7f7b3          	and	a5,a5,a4
                if ( cmd_get_dspi() )
    1a68:	a80782e3          	beqz	a5,14ec <main+0x92c>
        putchar(*(p++));
    1a6c:	00812703          	lw	a4,8(sp)
    UART0->DATA = c;
    1a70:	04f00793          	li	a5,79
    1a74:	00fda023          	sw	a5,0(s11)
    while (*p)
    1a78:	04e00793          	li	a5,78
        putchar(*(p++));
    1a7c:	00170713          	addi	a4,a4,1 # 400001 <_etext+0x3fd8b1>
    if (c == '\n')
    1a80:	01978c63          	beq	a5,s9,1a98 <main+0xed8>
    UART0->DATA = c;
    1a84:	00fda023          	sw	a5,0(s11)
    while (*p)
    1a88:	00074783          	lbu	a5,0(a4)
    1a8c:	a80782e3          	beqz	a5,1510 <main+0x950>
        putchar(*(p++));
    1a90:	00170713          	addi	a4,a4,1
    if (c == '\n')
    1a94:	ff9798e3          	bne	a5,s9,1a84 <main+0xec4>
        UART0->DATA = '\r';
    1a98:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1a9c:	00fda023          	sw	a5,0(s11)
    while (*p)
    1aa0:	00074783          	lbu	a5,0(a4)
    1aa4:	fc079ce3          	bnez	a5,1a7c <main+0xebc>
    1aa8:	a69ff06f          	j	1510 <main+0x950>
        UART0->DATA = '\r';
    1aac:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1ab0:	00fda023          	sw	a5,0(s11)
    while (*p)
    1ab4:	00074783          	lbu	a5,0(a4)
    1ab8:	9e0796e3          	bnez	a5,14a4 <main+0x8e4>
    1abc:	9fdff06f          	j	14b8 <main+0x8f8>
        UART0->DATA = '\r';
    1ac0:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1ac4:	00eda023          	sw	a4,0(s11)
    while (*p)
    1ac8:	0006c703          	lbu	a4,0(a3)
    1acc:	bc0712e3          	bnez	a4,1690 <main+0xad0>
    1ad0:	bd5ff06f          	j	16a4 <main+0xae4>
        UART0->DATA = '\r';
    1ad4:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1ad8:	00eda023          	sw	a4,0(s11)
    while (*p)
    1adc:	0006c703          	lbu	a4,0(a3)
    1ae0:	be071ee3          	bnez	a4,16dc <main+0xb1c>
    1ae4:	c0dff06f          	j	16f0 <main+0xb30>
        UART0->DATA = '\r';
    1ae8:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1aec:	00eda023          	sw	a4,0(s11)
    while (*p)
    1af0:	0006c703          	lbu	a4,0(a3)
    1af4:	c00718e3          	bnez	a4,1704 <main+0xb44>
    1af8:	c21ff06f          	j	1718 <main+0xb58>
        UART0->DATA = '\r';
    1afc:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1b00:	00eda023          	sw	a4,0(s11)
    while (*p)
    1b04:	0006c703          	lbu	a4,0(a3)
    1b08:	c2071ce3          	bnez	a4,1740 <main+0xb80>
    1b0c:	c49ff06f          	j	1754 <main+0xb94>
        UART0->DATA = '\r';
    1b10:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1b14:	00eda023          	sw	a4,0(s11)
    while (*p)
    1b18:	0006c703          	lbu	a4,0(a3)
    1b1c:	c40718e3          	bnez	a4,176c <main+0xbac>
    1b20:	c61ff06f          	j	1780 <main+0xbc0>
        UART0->DATA = '\r';
    1b24:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1b28:	00fda023          	sw	a5,0(s11)
    while (*p)
    1b2c:	00074783          	lbu	a5,0(a4)
    1b30:	c60798e3          	bnez	a5,17a0 <main+0xbe0>
        UART0->DATA = '\r';
    1b34:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1b38:	019da023          	sw	s9,0(s11)
    return cycles_end - cycles_begin;
    1b3c:	c81ff06f          	j	17bc <main+0xbfc>
        UART0->DATA = '\r';
    1b40:	01ada023          	sw	s10,0(s11)
    UART0->DATA = c;
    1b44:	00fda023          	sw	a5,0(s11)
    while (*p)
    1b48:	00074783          	lbu	a5,0(a4)
    1b4c:	9a0798e3          	bnez	a5,14fc <main+0x93c>
    1b50:	9c1ff06f          	j	1510 <main+0x950>
        UART0->DATA = '\r';
    1b54:	00c6a023          	sw	a2,0(a3)
    UART0->DATA = c;
    1b58:	00f6a023          	sw	a5,0(a3)
    while (*p)
    1b5c:	00074783          	lbu	a5,0(a4)
    1b60:	c6079863          	bnez	a5,fd0 <main+0x410>
    1b64:	c80ff06f          	j	fe4 <main+0x424>

00001b68 <irqCallback>:
    }
}

void irqCallback() {

    1b68:	00008067          	ret

00001b6c <print_num>:
//}

#define MEMSIZE 10

void print_num(int vv, int radix, char *out, int lim)
{
    1b6c:	fd010113          	addi	sp,sp,-48
    1b70:	02812423          	sw	s0,40(sp)
    1b74:	02912223          	sw	s1,36(sp)
    1b78:	01312e23          	sw	s3,28(sp)
    1b7c:	01412c23          	sw	s4,24(sp)
    1b80:	02112623          	sw	ra,44(sp)
    1b84:	03212023          	sw	s2,32(sp)
    1b88:	01512a23          	sw	s5,20(sp)
    1b8c:	01612823          	sw	s6,16(sp)
    int digits = 0, neg = 0, bb = 0;
    char outp[MEMSIZE];
    for(int aa = 0; aa < MEMSIZE; aa++)
        outp[aa] = '\0';
    1b90:	00012223          	sw	zero,4(sp)
    1b94:	00012423          	sw	zero,8(sp)
    1b98:	00011623          	sh	zero,12(sp)
{
    1b9c:	00050413          	mv	s0,a0
    1ba0:	00058493          	mv	s1,a1
    1ba4:	00060a13          	mv	s4,a2
    1ba8:	00068993          	mv	s3,a3

    if( vv < 0) { neg = 1; vv = -vv;} ;
    1bac:	2c054e63          	bltz	a0,1e88 <print_num+0x31c>

    while(1)
        {
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1bb0:	00002937          	lui	s2,0x2
    1bb4:	e04fe0ef          	jal	ra,1b8 <__modsi3>
    1bb8:	72890913          	addi	s2,s2,1832 # 2728 <xsnprintf+0x820>
    1bbc:	00a90533          	add	a0,s2,a0
    1bc0:	00054b03          	lbu	s6,0(a0)
        //putchar('\''); putchar(c); putchar('\''); putchar('\n');
        if (vv == 0)
    1bc4:	32040e63          	beqz	s0,1f00 <print_num+0x394>
            if(!digits)
                outp[digits++] = '0';  // At least one zero
            break;
            }
        outp[digits++] = c;
        vv /= radix;
    1bc8:	00048593          	mv	a1,s1
    1bcc:	00040513          	mv	a0,s0
    1bd0:	d64fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1bd4:	00048593          	mv	a1,s1
        vv /= radix;
    1bd8:	00050413          	mv	s0,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1bdc:	ddcfe0ef          	jal	ra,1b8 <__modsi3>
    1be0:	00a90533          	add	a0,s2,a0
    1be4:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1be8:	14040e63          	beqz	s0,1d44 <print_num+0x1d8>
        vv /= radix;
    1bec:	00048593          	mv	a1,s1
    1bf0:	00040513          	mv	a0,s0
        outp[digits++] = c;
    1bf4:	00f102a3          	sb	a5,5(sp)
        vv /= radix;
    1bf8:	d3cfe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1bfc:	00048593          	mv	a1,s1
        vv /= radix;
    1c00:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1c04:	db4fe0ef          	jal	ra,1b8 <__modsi3>
    1c08:	00a90533          	add	a0,s2,a0
    1c0c:	00054783          	lbu	a5,0(a0)
    int digits = 0, neg = 0, bb = 0;
    1c10:	00000413          	li	s0,0
        if (vv == 0)
    1c14:	120a8863          	beqz	s5,1d44 <print_num+0x1d8>
        vv /= radix;
    1c18:	00048593          	mv	a1,s1
    1c1c:	000a8513          	mv	a0,s5
        outp[digits++] = c;
    1c20:	00f10323          	sb	a5,6(sp)
        vv /= radix;
    1c24:	d10fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1c28:	00048593          	mv	a1,s1
        vv /= radix;
    1c2c:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1c30:	d88fe0ef          	jal	ra,1b8 <__modsi3>
    1c34:	00a90533          	add	a0,s2,a0
    1c38:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1c3c:	0e0a8c63          	beqz	s5,1d34 <print_num+0x1c8>
        vv /= radix;
    1c40:	00048593          	mv	a1,s1
    1c44:	000a8513          	mv	a0,s5
        outp[digits++] = c;
    1c48:	00f103a3          	sb	a5,7(sp)
        vv /= radix;
    1c4c:	ce8fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1c50:	00048593          	mv	a1,s1
        vv /= radix;
    1c54:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1c58:	d60fe0ef          	jal	ra,1b8 <__modsi3>
    1c5c:	00a90533          	add	a0,s2,a0
    1c60:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1c64:	0c0a8863          	beqz	s5,1d34 <print_num+0x1c8>
        vv /= radix;
    1c68:	00048593          	mv	a1,s1
    1c6c:	000a8513          	mv	a0,s5
        outp[digits++] = c;
    1c70:	00f10423          	sb	a5,8(sp)
        vv /= radix;
    1c74:	cc0fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1c78:	00048593          	mv	a1,s1
        vv /= radix;
    1c7c:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1c80:	d38fe0ef          	jal	ra,1b8 <__modsi3>
    1c84:	00a90533          	add	a0,s2,a0
    1c88:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1c8c:	0a0a8463          	beqz	s5,1d34 <print_num+0x1c8>
        vv /= radix;
    1c90:	00048593          	mv	a1,s1
    1c94:	000a8513          	mv	a0,s5
        outp[digits++] = c;
    1c98:	00f104a3          	sb	a5,9(sp)
        vv /= radix;
    1c9c:	c98fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1ca0:	00048593          	mv	a1,s1
        vv /= radix;
    1ca4:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1ca8:	d10fe0ef          	jal	ra,1b8 <__modsi3>
    1cac:	00a90533          	add	a0,s2,a0
    1cb0:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1cb4:	080a8063          	beqz	s5,1d34 <print_num+0x1c8>
        vv /= radix;
    1cb8:	00048593          	mv	a1,s1
    1cbc:	000a8513          	mv	a0,s5
        outp[digits++] = c;
    1cc0:	00f10523          	sb	a5,10(sp)
        vv /= radix;
    1cc4:	c70fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1cc8:	00048593          	mv	a1,s1
        vv /= radix;
    1ccc:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1cd0:	ce8fe0ef          	jal	ra,1b8 <__modsi3>
    1cd4:	00a90533          	add	a0,s2,a0
    1cd8:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1cdc:	040a8c63          	beqz	s5,1d34 <print_num+0x1c8>
        vv /= radix;
    1ce0:	00048593          	mv	a1,s1
    1ce4:	000a8513          	mv	a0,s5
        outp[digits++] = c;
    1ce8:	00f105a3          	sb	a5,11(sp)
        vv /= radix;
    1cec:	c48fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1cf0:	00048593          	mv	a1,s1
        vv /= radix;
    1cf4:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1cf8:	cc0fe0ef          	jal	ra,1b8 <__modsi3>
    1cfc:	00a90533          	add	a0,s2,a0
    1d00:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1d04:	020a8863          	beqz	s5,1d34 <print_num+0x1c8>
        vv /= radix;
    1d08:	00048593          	mv	a1,s1
    1d0c:	000a8513          	mv	a0,s5
        outp[digits++] = c;
    1d10:	00f10623          	sb	a5,12(sp)
        vv /= radix;
    1d14:	c20fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1d18:	00048593          	mv	a1,s1
        vv /= radix;
    1d1c:	00050493          	mv	s1,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1d20:	c98fe0ef          	jal	ra,1b8 <__modsi3>
    1d24:	00a90933          	add	s2,s2,a0
    1d28:	00094783          	lbu	a5,0(s2)
        if (vv == 0)
    1d2c:	00048463          	beqz	s1,1d34 <print_num+0x1c8>
        outp[digits++] = c;
    1d30:	00f106a3          	sb	a5,13(sp)
        }
    // Sign
    if(neg)
    1d34:	00040863          	beqz	s0,1d44 <print_num+0x1d8>
        out[bb++] = '-';
    1d38:	02d00793          	li	a5,45
    1d3c:	00fa0023          	sb	a5,0(s4)
    1d40:	00100413          	li	s0,1
    for(int aa = MEMSIZE - 1; aa >= 0; aa--)
        {
        if (bb >= lim - 1)
            break;
        if(outp[aa])
            out[bb++] = outp[aa];
    1d44:	008a07b3          	add	a5,s4,s0
        if (bb >= lim - 1)
    1d48:	fff98693          	addi	a3,s3,-1
            out[bb++] = outp[aa];
    1d4c:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1d50:	10d45663          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1d54:	00d14703          	lbu	a4,13(sp)
    1d58:	00070c63          	beqz	a4,1d70 <print_num+0x204>
            out[bb++] = outp[aa];
    1d5c:	00140413          	addi	s0,s0,1
    1d60:	00e78023          	sb	a4,0(a5)
    1d64:	008a07b3          	add	a5,s4,s0
    1d68:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1d6c:	0ed45863          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1d70:	00c14703          	lbu	a4,12(sp)
    1d74:	00070c63          	beqz	a4,1d8c <print_num+0x220>
            out[bb++] = outp[aa];
    1d78:	00140413          	addi	s0,s0,1
    1d7c:	00e78023          	sb	a4,0(a5)
    1d80:	008a07b3          	add	a5,s4,s0
    1d84:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1d88:	0cd45a63          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1d8c:	00b14703          	lbu	a4,11(sp)
    1d90:	00070c63          	beqz	a4,1da8 <print_num+0x23c>
            out[bb++] = outp[aa];
    1d94:	00140413          	addi	s0,s0,1
    1d98:	00e78023          	sb	a4,0(a5)
    1d9c:	008a07b3          	add	a5,s4,s0
    1da0:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1da4:	0ad45c63          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1da8:	00a14703          	lbu	a4,10(sp)
    1dac:	00070c63          	beqz	a4,1dc4 <print_num+0x258>
            out[bb++] = outp[aa];
    1db0:	00140413          	addi	s0,s0,1
    1db4:	00e78023          	sb	a4,0(a5)
    1db8:	008a07b3          	add	a5,s4,s0
    1dbc:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1dc0:	08d45e63          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1dc4:	00914703          	lbu	a4,9(sp)
    1dc8:	00070c63          	beqz	a4,1de0 <print_num+0x274>
            out[bb++] = outp[aa];
    1dcc:	00140413          	addi	s0,s0,1
    1dd0:	00e78023          	sb	a4,0(a5)
    1dd4:	008a07b3          	add	a5,s4,s0
    1dd8:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1ddc:	08d45063          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1de0:	00814703          	lbu	a4,8(sp)
    1de4:	00070c63          	beqz	a4,1dfc <print_num+0x290>
            out[bb++] = outp[aa];
    1de8:	00140413          	addi	s0,s0,1
    1dec:	00e78023          	sb	a4,0(a5)
    1df0:	008a07b3          	add	a5,s4,s0
    1df4:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1df8:	06d45263          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1dfc:	00714703          	lbu	a4,7(sp)
    1e00:	00070c63          	beqz	a4,1e18 <print_num+0x2ac>
            out[bb++] = outp[aa];
    1e04:	00140413          	addi	s0,s0,1
    1e08:	00e78023          	sb	a4,0(a5)
    1e0c:	008a07b3          	add	a5,s4,s0
    1e10:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1e14:	04d45463          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1e18:	00614703          	lbu	a4,6(sp)
    1e1c:	00070c63          	beqz	a4,1e34 <print_num+0x2c8>
            out[bb++] = outp[aa];
    1e20:	00140413          	addi	s0,s0,1
    1e24:	00e78023          	sb	a4,0(a5)
    1e28:	008a07b3          	add	a5,s4,s0
    1e2c:	00078713          	mv	a4,a5
        if (bb >= lim - 1)
    1e30:	02d45663          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1e34:	00514703          	lbu	a4,5(sp)
    1e38:	0c070063          	beqz	a4,1ef8 <print_num+0x38c>
            out[bb++] = outp[aa];
    1e3c:	00140413          	addi	s0,s0,1
    1e40:	00e78023          	sb	a4,0(a5)
    1e44:	008a0733          	add	a4,s4,s0
        if (bb >= lim - 1)
    1e48:	00d45a63          	bge	s0,a3,1e5c <print_num+0x2f0>
        if(outp[aa])
    1e4c:	000b0863          	beqz	s6,1e5c <print_num+0x2f0>
            out[bb++] = outp[aa];
    1e50:	00140413          	addi	s0,s0,1
    1e54:	01670023          	sb	s6,0(a4)
        }
    out[bb] = '\0';
    1e58:	008a0733          	add	a4,s4,s0
    1e5c:	00070023          	sb	zero,0(a4)
}
    1e60:	02c12083          	lw	ra,44(sp)
    1e64:	02812403          	lw	s0,40(sp)
    1e68:	02412483          	lw	s1,36(sp)
    1e6c:	02012903          	lw	s2,32(sp)
    1e70:	01c12983          	lw	s3,28(sp)
    1e74:	01812a03          	lw	s4,24(sp)
    1e78:	01412a83          	lw	s5,20(sp)
    1e7c:	01012b03          	lw	s6,16(sp)
    1e80:	03010113          	addi	sp,sp,48
    1e84:	00008067          	ret
    if( vv < 0) { neg = 1; vv = -vv;} ;
    1e88:	40a00433          	neg	s0,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1e8c:	00040513          	mv	a0,s0
    1e90:	00002937          	lui	s2,0x2
    1e94:	b24fe0ef          	jal	ra,1b8 <__modsi3>
    1e98:	72890913          	addi	s2,s2,1832 # 2728 <xsnprintf+0x820>
    1e9c:	00a907b3          	add	a5,s2,a0
        vv /= radix;
    1ea0:	00048593          	mv	a1,s1
    1ea4:	00040513          	mv	a0,s0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1ea8:	0007cb03          	lbu	s6,0(a5)
        vv /= radix;
    1eac:	a88fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1eb0:	00048593          	mv	a1,s1
        vv /= radix;
    1eb4:	00050413          	mv	s0,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1eb8:	b00fe0ef          	jal	ra,1b8 <__modsi3>
    1ebc:	00a90533          	add	a0,s2,a0
    1ec0:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1ec4:	e6040ae3          	beqz	s0,1d38 <print_num+0x1cc>
        vv /= radix;
    1ec8:	00048593          	mv	a1,s1
    1ecc:	00040513          	mv	a0,s0
        outp[digits++] = c;
    1ed0:	00f102a3          	sb	a5,5(sp)
        vv /= radix;
    1ed4:	a60fe0ef          	jal	ra,134 <__divsi3>
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1ed8:	00048593          	mv	a1,s1
        vv /= radix;
    1edc:	00050a93          	mv	s5,a0
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
    1ee0:	ad8fe0ef          	jal	ra,1b8 <__modsi3>
    1ee4:	00a90533          	add	a0,s2,a0
    1ee8:	00054783          	lbu	a5,0(a0)
        if (vv == 0)
    1eec:	e40a86e3          	beqz	s5,1d38 <print_num+0x1cc>
    if( vv < 0) { neg = 1; vv = -vv;} ;
    1ef0:	00100413          	li	s0,1
    1ef4:	d25ff06f          	j	1c18 <print_num+0xac>
            out[bb++] = outp[aa];
    1ef8:	00078713          	mv	a4,a5
    1efc:	f51ff06f          	j	1e4c <print_num+0x2e0>
                outp[digits++] = '0';  // At least one zero
    1f00:	03000b13          	li	s6,48
    1f04:	e41ff06f          	j	1d44 <print_num+0x1d8>

00001f08 <xsnprintf>:
//      %p      -- pointer
//      %o      -- octal

int xsnprintf(char *out, int lim, const char *fmt, void *args[])

{
    1f08:	fb010113          	addi	sp,sp,-80
    1f0c:	03612823          	sw	s6,48(sp)
    1f10:	04112623          	sw	ra,76(sp)
    1f14:	04812423          	sw	s0,72(sp)
    1f18:	04912223          	sw	s1,68(sp)
    1f1c:	05212023          	sw	s2,64(sp)
    1f20:	03312e23          	sw	s3,60(sp)
    1f24:	03412c23          	sw	s4,56(sp)
    1f28:	03512a23          	sw	s5,52(sp)
    1f2c:	03712623          	sw	s7,44(sp)
    1f30:	03812423          	sw	s8,40(sp)
    1f34:	03912223          	sw	s9,36(sp)
    1f38:	03a12023          	sw	s10,32(sp)
    1f3c:	01b12e23          	sw	s11,28(sp)
    int argidx = 0, prog = 0;
    *out = '\0';
    1f40:	00050023          	sb	zero,0(a0)
    char out2[12];

    while(*fmt)
    1f44:	00064783          	lbu	a5,0(a2)
{
    1f48:	00050b13          	mv	s6,a0
    while(*fmt)
    1f4c:	40078463          	beqz	a5,2354 <xsnprintf+0x44c>
    1f50:	00060993          	mv	s3,a2
    1f54:	00058c13          	mv	s8,a1
    1f58:	00068c93          	mv	s9,a3
    int argidx = 0, prog = 0;
    1f5c:	00000913          	li	s2,0
    1f60:	00000b93          	li	s7,0
    1f64:	00050493          	mv	s1,a0
        {
        if(*fmt == '%')
    1f68:	02500a93          	li	s5,37
                break;
            else if(chh == '%')
               {
               prog += strxcpy(out + prog, "%", lim - prog);
               }
            else if(chh == 's')
    1f6c:	07300d13          	li	s10,115
               {
               prog += strxcpy(out + prog, args[argidx], lim - prog);
               argidx++;
               }
            else if(chh == 'd')
    1f70:	06400d93          	li	s11,100
               {
               print_num((int)args[argidx], 10, out2, sizeof(out2));
               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else if(chh == 'o')
    1f74:	06f00813          	li	a6,111
               {
               print_num((int)args[argidx], 8, out2, sizeof(out2));
               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else if(chh == 'x')
    1f78:	07800893          	li	a7,120
               {
               print_num((int)args[argidx], 16, out2, sizeof(out2));
               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else if(chh == 'b')
    1f7c:	06200313          	li	t1,98
               {
               print_num((int)args[argidx], 2, out2, sizeof(out2));
               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else if(chh == 'p')
    1f80:	07000e13          	li	t3,112
    1f84:	0280006f          	j	1fac <xsnprintf+0xa4>
                out[prog++] = chh;
                }
            }
        else
            {
            out[prog++] = *fmt;
    1f88:	00190913          	addi	s2,s2,1
            }
        fmt++;
        }
    // Zero terminate
    out[prog]   = '\0';
    1f8c:	000a0713          	mv	a4,s4
            out[prog++] = *fmt;
    1f90:	00f48023          	sb	a5,0(s1)
    out[prog]   = '\0';
    1f94:	012b04b3          	add	s1,s6,s2
    1f98:	00098a13          	mv	s4,s3
    1f9c:	00048413          	mv	s0,s1
    1fa0:	00070993          	mv	s3,a4
    while(*fmt)
    1fa4:	001a4783          	lbu	a5,1(s4)
    1fa8:	04078e63          	beqz	a5,2004 <xsnprintf+0xfc>
               prog += strxcpy(out + prog, "%", lim - prog);
    1fac:	00048413          	mv	s0,s1
            fmt++;
    1fb0:	00198a13          	addi	s4,s3,1
        if(*fmt == '%')
    1fb4:	fd579ae3          	bne	a5,s5,1f88 <xsnprintf+0x80>
            char chh = *fmt;
    1fb8:	0019c783          	lbu	a5,1(s3)
            if(chh == '\0')
    1fbc:	04078463          	beqz	a5,2004 <xsnprintf+0xfc>
        fmt++;
    1fc0:	00298993          	addi	s3,s3,2
            else if(chh == '%')
    1fc4:	09578263          	beq	a5,s5,2048 <xsnprintf+0x140>
            else if(chh == 's')
    1fc8:	0ba78863          	beq	a5,s10,2078 <xsnprintf+0x170>
            else if(chh == 'd')
    1fcc:	13b78663          	beq	a5,s11,20f8 <xsnprintf+0x1f0>
            else if(chh == 'o')
    1fd0:	1b078c63          	beq	a5,a6,2188 <xsnprintf+0x280>
            else if(chh == 'x')
    1fd4:	23178463          	beq	a5,a7,21fc <xsnprintf+0x2f4>
            else if(chh == 'b')
    1fd8:	2a678063          	beq	a5,t1,2278 <xsnprintf+0x370>
            else if(chh == 'p')
    1fdc:	31c78063          	beq	a5,t3,22dc <xsnprintf+0x3d4>
                out[prog++] = '%';
    1fe0:	00190713          	addi	a4,s2,1
    1fe4:	01548023          	sb	s5,0(s1)
                out[prog++] = chh;
    1fe8:	00eb0733          	add	a4,s6,a4
    1fec:	00f70023          	sb	a5,0(a4)
    while(*fmt)
    1ff0:	001a4783          	lbu	a5,1(s4)
                out[prog++] = chh;
    1ff4:	00290913          	addi	s2,s2,2
    out[prog]   = '\0';
    1ff8:	012b04b3          	add	s1,s6,s2
    1ffc:	00048413          	mv	s0,s1
    while(*fmt)
    2000:	fa0796e3          	bnez	a5,1fac <xsnprintf+0xa4>
    out[prog]   = '\0';
    2004:	00040023          	sb	zero,0(s0)
    return prog;
}
    2008:	04c12083          	lw	ra,76(sp)
    200c:	04812403          	lw	s0,72(sp)
    2010:	04412483          	lw	s1,68(sp)
    2014:	03c12983          	lw	s3,60(sp)
    2018:	03812a03          	lw	s4,56(sp)
    201c:	03412a83          	lw	s5,52(sp)
    2020:	03012b03          	lw	s6,48(sp)
    2024:	02c12b83          	lw	s7,44(sp)
    2028:	02812c03          	lw	s8,40(sp)
    202c:	02412c83          	lw	s9,36(sp)
    2030:	02012d03          	lw	s10,32(sp)
    2034:	01c12d83          	lw	s11,28(sp)
    2038:	00090513          	mv	a0,s2
    203c:	04012903          	lw	s2,64(sp)
    2040:	05010113          	addi	sp,sp,80
    2044:	00008067          	ret
               prog += strxcpy(out + prog, "%", lim - prog);
    2048:	412c0733          	sub	a4,s8,s2
        if(lnx >= lim-1)
    204c:	fff70713          	addi	a4,a4,-1
    2050:	06e05e63          	blez	a4,20cc <xsnprintf+0x1c4>
        *out++ = *in++; lnx++;
    2054:	01548023          	sb	s5,0(s1)
                out[prog++] = '%';
    2058:	00190913          	addi	s2,s2,1
        if(lnx >= lim-1)
    205c:	00100793          	li	a5,1
        *out++ = *in++; lnx++;
    2060:	00148693          	addi	a3,s1,1
                out[prog++] = chh;
    2064:	012b04b3          	add	s1,s6,s2
        if(lnx >= lim-1)
    2068:	06f70463          	beq	a4,a5,20d0 <xsnprintf+0x1c8>
            *out = '\0'; break;
    206c:	000400a3          	sb	zero,1(s0)
    2070:	00048413          	mv	s0,s1
    2074:	f31ff06f          	j	1fa4 <xsnprintf+0x9c>
               prog += strxcpy(out + prog, args[argidx], lim - prog);
    2078:	002b9793          	slli	a5,s7,0x2
    207c:	412c06b3          	sub	a3,s8,s2
    2080:	00fc87b3          	add	a5,s9,a5
        if(lnx >= lim-1)
    2084:	fff68693          	addi	a3,a3,-1
               prog += strxcpy(out + prog, args[argidx], lim - prog);
    2088:	0007a603          	lw	a2,0(a5)
    int lnx = 0;
    208c:	00000793          	li	a5,0
        if(lnx >= lim-1)
    2090:	00d04c63          	bgtz	a3,20a8 <xsnprintf+0x1a0>
    2094:	1a80006f          	j	223c <xsnprintf+0x334>
        *out++ = *in++; lnx++;
    2098:	00e40023          	sb	a4,0(s0)
    209c:	00178793          	addi	a5,a5,1
    20a0:	00140413          	addi	s0,s0,1
        if(lnx >= lim-1)
    20a4:	02d78c63          	beq	a5,a3,20dc <xsnprintf+0x1d4>
        if(*in == '\0')
    20a8:	00f60733          	add	a4,a2,a5
    20ac:	00074703          	lbu	a4,0(a4)
    20b0:	fe0714e3          	bnez	a4,2098 <xsnprintf+0x190>
               prog += strxcpy(out + prog, args[argidx], lim - prog);
    20b4:	00f90933          	add	s2,s2,a5
            *out = '\0'; break;
    20b8:	00040023          	sb	zero,0(s0)
    out[prog]   = '\0';
    20bc:	012b0433          	add	s0,s6,s2
    20c0:	00040493          	mv	s1,s0
               argidx++;
    20c4:	001b8b93          	addi	s7,s7,1
    20c8:	eddff06f          	j	1fa4 <xsnprintf+0x9c>
               prog += strxcpy(out + prog, "%", lim - prog);
    20cc:	00048693          	mv	a3,s1
            *out = '\0'; break;
    20d0:	00068023          	sb	zero,0(a3)
    20d4:	00048413          	mv	s0,s1
    20d8:	ecdff06f          	j	1fa4 <xsnprintf+0x9c>
               prog += strxcpy(out + prog, args[argidx], lim - prog);
    20dc:	00f90933          	add	s2,s2,a5
    out[prog]   = '\0';
    20e0:	012b04b3          	add	s1,s6,s2
        *out++ = *in++; lnx++;
    20e4:	00040793          	mv	a5,s0
            *out = '\0'; break;
    20e8:	00078023          	sb	zero,0(a5)
    out[prog]   = '\0';
    20ec:	00048413          	mv	s0,s1
               argidx++;
    20f0:	001b8b93          	addi	s7,s7,1
    20f4:	eb1ff06f          	j	1fa4 <xsnprintf+0x9c>
               print_num((int)args[argidx], 10, out2, sizeof(out2));
    20f8:	002b9793          	slli	a5,s7,0x2
    20fc:	00fc87b3          	add	a5,s9,a5
    2100:	0007a503          	lw	a0,0(a5)
    2104:	00410613          	addi	a2,sp,4
    2108:	00c00693          	li	a3,12
    210c:	00a00593          	li	a1,10
    2110:	a5dff0ef          	jal	ra,1b6c <print_num>
               prog += strxcpy(out + prog, out2, lim - prog);
    2114:	412c0633          	sub	a2,s8,s2
        if(lnx >= lim-1)
    2118:	fff60613          	addi	a2,a2,-1
    211c:	00410793          	addi	a5,sp,4
    int lnx = 0;
    2120:	00000713          	li	a4,0
        if(lnx >= lim-1)
    2124:	06f00813          	li	a6,111
    2128:	07800893          	li	a7,120
    212c:	06200313          	li	t1,98
    2130:	07000e13          	li	t3,112
    2134:	00c04c63          	bgtz	a2,214c <xsnprintf+0x244>
    2138:	1040006f          	j	223c <xsnprintf+0x334>
        *out++ = *in++; lnx++;
    213c:	00d40023          	sb	a3,0(s0)
    2140:	00170713          	addi	a4,a4,1
    2144:	00140413          	addi	s0,s0,1
        if(lnx >= lim-1)
    2148:	02e60463          	beq	a2,a4,2170 <xsnprintf+0x268>
        if(*in == '\0')
    214c:	0007c683          	lbu	a3,0(a5)
        *out++ = *in++; lnx++;
    2150:	00178793          	addi	a5,a5,1
        if(*in == '\0')
    2154:	fe0694e3          	bnez	a3,213c <xsnprintf+0x234>
               prog += strxcpy(out + prog, out2, lim - prog);
    2158:	00e90933          	add	s2,s2,a4
            *out = '\0'; break;
    215c:	00040023          	sb	zero,0(s0)
    out[prog]   = '\0';
    2160:	012b0433          	add	s0,s6,s2
    2164:	00040493          	mv	s1,s0
               argidx++;
    2168:	001b8b93          	addi	s7,s7,1
    216c:	e39ff06f          	j	1fa4 <xsnprintf+0x9c>
               prog += strxcpy(out + prog, out2, lim - prog);
    2170:	00c90933          	add	s2,s2,a2
        *out++ = *in++; lnx++;
    2174:	00040793          	mv	a5,s0
    out[prog]   = '\0';
    2178:	012b04b3          	add	s1,s6,s2
    217c:	00048413          	mv	s0,s1
            *out = '\0'; break;
    2180:	00078023          	sb	zero,0(a5)
    2184:	f6dff06f          	j	20f0 <xsnprintf+0x1e8>
               print_num((int)args[argidx], 8, out2, sizeof(out2));
    2188:	002b9793          	slli	a5,s7,0x2
    218c:	00fc87b3          	add	a5,s9,a5
    2190:	0007a503          	lw	a0,0(a5)
    2194:	00410613          	addi	a2,sp,4
    2198:	00c00693          	li	a3,12
    219c:	00800593          	li	a1,8
    21a0:	9cdff0ef          	jal	ra,1b6c <print_num>
               prog += strxcpy(out + prog, out2, lim - prog);
    21a4:	412c0633          	sub	a2,s8,s2
        if(lnx >= lim-1)
    21a8:	fff60613          	addi	a2,a2,-1
    21ac:	00410793          	addi	a5,sp,4
    int lnx = 0;
    21b0:	00000713          	li	a4,0
        if(lnx >= lim-1)
    21b4:	06f00813          	li	a6,111
    21b8:	07800893          	li	a7,120
    21bc:	06200313          	li	t1,98
    21c0:	07000e13          	li	t3,112
    21c4:	00c04c63          	bgtz	a2,21dc <xsnprintf+0x2d4>
    21c8:	0740006f          	j	223c <xsnprintf+0x334>
        *out++ = *in++; lnx++;
    21cc:	00d40023          	sb	a3,0(s0)
    21d0:	00170713          	addi	a4,a4,1
    21d4:	00140413          	addi	s0,s0,1
        if(lnx >= lim-1)
    21d8:	f8e60ce3          	beq	a2,a4,2170 <xsnprintf+0x268>
        if(*in == '\0')
    21dc:	0007c683          	lbu	a3,0(a5)
        *out++ = *in++; lnx++;
    21e0:	00178793          	addi	a5,a5,1
        if(*in == '\0')
    21e4:	fe0694e3          	bnez	a3,21cc <xsnprintf+0x2c4>
               prog += strxcpy(out + prog, out2, lim - prog);
    21e8:	00e90933          	add	s2,s2,a4
            *out = '\0'; break;
    21ec:	00040023          	sb	zero,0(s0)
    out[prog]   = '\0';
    21f0:	012b0433          	add	s0,s6,s2
    21f4:	00040493          	mv	s1,s0
    21f8:	f71ff06f          	j	2168 <xsnprintf+0x260>
               print_num((int)args[argidx], 16, out2, sizeof(out2));
    21fc:	002b9793          	slli	a5,s7,0x2
    2200:	00fc87b3          	add	a5,s9,a5
    2204:	0007a503          	lw	a0,0(a5)
    2208:	00410613          	addi	a2,sp,4
    220c:	00c00693          	li	a3,12
    2210:	01000593          	li	a1,16
    2214:	959ff0ef          	jal	ra,1b6c <print_num>
               prog += strxcpy(out + prog, out2, lim - prog);
    2218:	412c0633          	sub	a2,s8,s2
        if(lnx >= lim-1)
    221c:	fff60613          	addi	a2,a2,-1
    2220:	00410793          	addi	a5,sp,4
    int lnx = 0;
    2224:	00000713          	li	a4,0
        if(lnx >= lim-1)
    2228:	06f00813          	li	a6,111
    222c:	07800893          	li	a7,120
    2230:	06200313          	li	t1,98
    2234:	07000e13          	li	t3,112
    2238:	02c04063          	bgtz	a2,2258 <xsnprintf+0x350>
               prog += strxcpy(out + prog, "%", lim - prog);
    223c:	00048793          	mv	a5,s1
            *out = '\0'; break;
    2240:	00078023          	sb	zero,0(a5)
    2244:	eadff06f          	j	20f0 <xsnprintf+0x1e8>
        *out++ = *in++; lnx++;
    2248:	00d40023          	sb	a3,0(s0)
    224c:	00170713          	addi	a4,a4,1
    2250:	00140413          	addi	s0,s0,1
        if(lnx >= lim-1)
    2254:	f0e60ee3          	beq	a2,a4,2170 <xsnprintf+0x268>
        if(*in == '\0')
    2258:	0007c683          	lbu	a3,0(a5)
        *out++ = *in++; lnx++;
    225c:	00178793          	addi	a5,a5,1
        if(*in == '\0')
    2260:	fe0694e3          	bnez	a3,2248 <xsnprintf+0x340>
               prog += strxcpy(out + prog, out2, lim - prog);
    2264:	00e90933          	add	s2,s2,a4
            *out = '\0'; break;
    2268:	00040023          	sb	zero,0(s0)
    out[prog]   = '\0';
    226c:	012b0433          	add	s0,s6,s2
    2270:	00040493          	mv	s1,s0
    2274:	ef5ff06f          	j	2168 <xsnprintf+0x260>
               print_num((int)args[argidx], 2, out2, sizeof(out2));
    2278:	002b9793          	slli	a5,s7,0x2
    227c:	00fc87b3          	add	a5,s9,a5
    2280:	0007a503          	lw	a0,0(a5)
    2284:	00410613          	addi	a2,sp,4
    2288:	00c00693          	li	a3,12
    228c:	00200593          	li	a1,2
    2290:	8ddff0ef          	jal	ra,1b6c <print_num>
               prog += strxcpy(out + prog, out2, lim - prog);
    2294:	412c0633          	sub	a2,s8,s2
        if(lnx >= lim-1)
    2298:	fff60613          	addi	a2,a2,-1
    229c:	00410793          	addi	a5,sp,4
    int lnx = 0;
    22a0:	00000713          	li	a4,0
        if(lnx >= lim-1)
    22a4:	06f00813          	li	a6,111
    22a8:	07800893          	li	a7,120
    22ac:	06200313          	li	t1,98
    22b0:	07000e13          	li	t3,112
    22b4:	00c04c63          	bgtz	a2,22cc <xsnprintf+0x3c4>
    22b8:	f85ff06f          	j	223c <xsnprintf+0x334>
        *out++ = *in++; lnx++;
    22bc:	00d40023          	sb	a3,0(s0)
    22c0:	00170713          	addi	a4,a4,1
    22c4:	00140413          	addi	s0,s0,1
        if(lnx >= lim-1)
    22c8:	eae604e3          	beq	a2,a4,2170 <xsnprintf+0x268>
        if(*in == '\0')
    22cc:	0007c683          	lbu	a3,0(a5)
        *out++ = *in++; lnx++;
    22d0:	00178793          	addi	a5,a5,1
        if(*in == '\0')
    22d4:	fe0694e3          	bnez	a3,22bc <xsnprintf+0x3b4>
    22d8:	e81ff06f          	j	2158 <xsnprintf+0x250>
               print_num((int)&args[argidx], 16, out2, sizeof(out2));
    22dc:	002b9513          	slli	a0,s7,0x2
    22e0:	00410613          	addi	a2,sp,4
    22e4:	00c00693          	li	a3,12
    22e8:	01000593          	li	a1,16
    22ec:	00ac8533          	add	a0,s9,a0
    22f0:	87dff0ef          	jal	ra,1b6c <print_num>
               prog += strxcpy(out + prog, out2, lim - prog);
    22f4:	412c0633          	sub	a2,s8,s2
        if(lnx >= lim-1)
    22f8:	fff60613          	addi	a2,a2,-1
    22fc:	00410793          	addi	a5,sp,4
    int lnx = 0;
    2300:	00000713          	li	a4,0
        if(lnx >= lim-1)
    2304:	06f00813          	li	a6,111
    2308:	07800893          	li	a7,120
    230c:	06200313          	li	t1,98
    2310:	07000e13          	li	t3,112
    2314:	00c04c63          	bgtz	a2,232c <xsnprintf+0x424>
    2318:	f25ff06f          	j	223c <xsnprintf+0x334>
        *out++ = *in++; lnx++;
    231c:	00d40023          	sb	a3,0(s0)
    2320:	00170713          	addi	a4,a4,1
    2324:	00140413          	addi	s0,s0,1
        if(lnx >= lim-1)
    2328:	00c70a63          	beq	a4,a2,233c <xsnprintf+0x434>
        if(*in == '\0')
    232c:	0007c683          	lbu	a3,0(a5)
        *out++ = *in++; lnx++;
    2330:	00178793          	addi	a5,a5,1
        if(*in == '\0')
    2334:	fe0694e3          	bnez	a3,231c <xsnprintf+0x414>
    2338:	e21ff06f          	j	2158 <xsnprintf+0x250>
               prog += strxcpy(out + prog, out2, lim - prog);
    233c:	00e90933          	add	s2,s2,a4
        *out++ = *in++; lnx++;
    2340:	00040793          	mv	a5,s0
    out[prog]   = '\0';
    2344:	012b04b3          	add	s1,s6,s2
    2348:	00048413          	mv	s0,s1
            *out = '\0'; break;
    234c:	00078023          	sb	zero,0(a5)
    2350:	da1ff06f          	j	20f0 <xsnprintf+0x1e8>
    while(*fmt)
    2354:	00050413          	mv	s0,a0
    int argidx = 0, prog = 0;
    2358:	00000913          	li	s2,0
    235c:	ca9ff06f          	j	2004 <xsnprintf+0xfc>
    2360:	6c637943          	0x6c637943
    2364:	7365                	lui	t1,0xffff9
    2366:	203a                	fld	ft0,392(sp)
    2368:	7830                	flw	fa2,112(s0)
    236a:	0000                	unimp
    236c:	6e49                	lui	t3,0x12
    236e:	736e7473          	csrrci	s0,0x736,28
    2372:	203a                	fld	ft0,392(sp)
    2374:	7830                	flw	fa2,112(s0)
    2376:	0000                	unimp
    2378:	736b6843          	fmadd.d	fa6,fs6,fs6,fa4,unknown
    237c:	6d75                	lui	s10,0x1d
    237e:	203a                	fld	ft0,392(sp)
    2380:	7830                	flw	fa2,112(s0)
    2382:	0000                	unimp
    2384:	6564                	flw	fs1,76(a0)
    2386:	6166                	flw	ft2,88(sp)
    2388:	6c75                	lui	s8,0x1d
    238a:	2074                	fld	fa3,192(s0)
    238c:	2020                	fld	fs0,64(s0)
    238e:	2020                	fld	fs0,64(s0)
    2390:	2020                	fld	fs0,64(s0)
    2392:	0020                	addi	s0,sp,8
    2394:	7364                	flw	fs1,100(a4)
    2396:	6970                	flw	fa2,84(a0)
    2398:	002d                	c.nop	11
    239a:	0000                	unimp
    239c:	2020                	fld	fs0,64(s0)
    239e:	2020                	fld	fs0,64(s0)
    23a0:	2020                	fld	fs0,64(s0)
    23a2:	2020                	fld	fs0,64(s0)
    23a4:	0020                	addi	s0,sp,8
    23a6:	0000                	unimp
    23a8:	7364                	flw	fs1,100(a4)
    23aa:	6970                	flw	fa2,84(a0)
    23ac:	632d                	lui	t1,0xb
    23ae:	6d72                	flw	fs10,28(sp)
    23b0:	002d                	c.nop	11
    23b2:	0000                	unimp
    23b4:	6e69                	lui	t3,0x1a
    23b6:	736e7473          	csrrci	s0,0x736,28
    23ba:	2020                	fld	fs0,64(s0)
    23bc:	2020                	fld	fs0,64(s0)
    23be:	2020                	fld	fs0,64(s0)
    23c0:	2020                	fld	fs0,64(s0)
    23c2:	3a20                	fld	fs0,112(a2)
    23c4:	0020                	addi	s0,sp,8
    23c6:	0000                	unimp
    23c8:	0a0a                	slli	s4,s4,0x2
    23ca:	0a0a                	slli	s4,s4,0x2
    23cc:	0a0a                	slli	s4,s4,0x2
    23ce:	0000                	unimp
    23d0:	2020                	fld	fs0,64(s0)
    23d2:	2020                	fld	fs0,64(s0)
    23d4:	2020                	fld	fs0,64(s0)
    23d6:	2020                	fld	fs0,64(s0)
    23d8:	2020                	fld	fs0,64(s0)
    23da:	4c20                	lw	s0,88(s0)
    23dc:	6369                	lui	t1,0x1a
    23de:	6568                	flw	fa0,76(a0)
    23e0:	2065                	jal	2488 <xsnprintf+0x580>
    23e2:	6154                	flw	fa3,4(a0)
    23e4:	676e                	flw	fa4,216(sp)
    23e6:	4e20                	lw	s0,88(a2)
    23e8:	6e61                	lui	t3,0x18
    23ea:	4b392d6f          	jal	s10,9509c <_etext+0x9294c>
    23ee:	6220                	flw	fs0,64(a2)
    23f0:	2079                	jal	247e <xsnprintf+0x576>
    23f2:	6550                	flw	fa2,12(a0)
    23f4:	6574                	flw	fa3,76(a0)
    23f6:	2072                	fld	ft0,280(sp)
    23f8:	6e656c47          	fmsub.q	fs8,fa0,ft6,fa3,unknown
    23fc:	202c                	fld	fa1,64(s0)
    23fe:	7542                	flw	fa0,48(sp)
    2400:	6c69                	lui	s8,0x1a
    2402:	3a64                	fld	fs1,240(a2)
    2404:	0020                	addi	s0,sp,8
    2406:	0000                	unimp
    2408:	656c6553          	0x656c6553
    240c:	61207463          	bgeu	zero,s2,2a14 <_etext+0x2c4>
    2410:	206e                	fld	ft0,216(sp)
    2412:	6361                	lui	t1,0x18
    2414:	6974                	flw	fa3,84(a0)
    2416:	0a3a6e6f          	jal	t3,a8cb8 <_etext+0xa6568>
    241a:	0000                	unimp
    241c:	2020                	fld	fs0,64(s0)
    241e:	5b20                	lw	s0,112(a4)
    2420:	5d30                	lw	a2,120(a0)
    2422:	5220                	lw	s0,96(a2)
    2424:	6e75                	lui	t3,0x1d
    2426:	6d20                	flw	fs0,88(a0)
    2428:	6961                	lui	s2,0x18
    242a:	206e                	fld	ft0,216(sp)
    242c:	7061                	c.lui	zero,0xffff8
    242e:	2070                	fld	fa2,192(s0)
    2430:	6b28                	flw	fa0,80(a4)
    2432:	6f69                	lui	t5,0x1a
    2434:	0a296b73          	csrrsi	s6,0xa2,18
    2438:	0000                	unimp
    243a:	0000                	unimp
    243c:	2020                	fld	fs0,64(s0)
    243e:	5b20                	lw	s0,112(a4)
    2440:	5d31                	li	s10,-20
    2442:	5420                	lw	s0,104(s0)
    2444:	6c67676f          	jal	a4,78b0a <_etext+0x763ba>
    2448:	2065                	jal	24f0 <xsnprintf+0x5e8>
    244a:	656c                	flw	fa1,76(a0)
    244c:	2064                	fld	fs1,192(s0)
    244e:	0a31                	addi	s4,s4,12
    2450:	0000                	unimp
    2452:	0000                	unimp
    2454:	2020                	fld	fs0,64(s0)
    2456:	5b20                	lw	s0,112(a4)
    2458:	5d32                	lw	s10,44(sp)
    245a:	5420                	lw	s0,104(s0)
    245c:	6c67676f          	jal	a4,78b22 <_etext+0x763d2>
    2460:	2065                	jal	2508 <xsnprintf+0x600>
    2462:	656c                	flw	fa1,76(a0)
    2464:	2064                	fld	fs1,192(s0)
    2466:	0a32                	slli	s4,s4,0xc
    2468:	0000                	unimp
    246a:	0000                	unimp
    246c:	2020                	fld	fs0,64(s0)
    246e:	5b20                	lw	s0,112(a4)
    2470:	54205d33          	0x54205d33
    2474:	6c67676f          	jal	a4,78b3a <_etext+0x763ea>
    2478:	2065                	jal	2520 <xsnprintf+0x618>
    247a:	656c                	flw	fa1,76(a0)
    247c:	2064                	fld	fs1,192(s0)
    247e:	00000a33          	add	s4,zero,zero
    2482:	0000                	unimp
    2484:	2020                	fld	fs0,64(s0)
    2486:	5b20                	lw	s0,112(a4)
    2488:	5d34                	lw	a3,120(a0)
    248a:	5420                	lw	s0,104(s0)
    248c:	6c67676f          	jal	a4,78b52 <_etext+0x76402>
    2490:	2065                	jal	2538 <xsnprintf+0x630>
    2492:	656c                	flw	fa1,76(a0)
    2494:	2064                	fld	fs1,192(s0)
    2496:	0a34                	addi	a3,sp,280
    2498:	0000                	unimp
    249a:	0000                	unimp
    249c:	2020                	fld	fs0,64(s0)
    249e:	5b20                	lw	s0,112(a4)
    24a0:	5d35                	li	s10,-19
    24a2:	5420                	lw	s0,104(s0)
    24a4:	6c67676f          	jal	a4,78b6a <_etext+0x7641a>
    24a8:	2065                	jal	2550 <xsnprintf+0x648>
    24aa:	656c                	flw	fa1,76(a0)
    24ac:	2064                	fld	fs1,192(s0)
    24ae:	0a35                	addi	s4,s4,13
    24b0:	0000                	unimp
    24b2:	0000                	unimp
    24b4:	2020                	fld	fs0,64(s0)
    24b6:	5b20                	lw	s0,112(a4)
    24b8:	5d36                	lw	s10,108(sp)
    24ba:	5420                	lw	s0,104(s0)
    24bc:	6c67676f          	jal	a4,78b82 <_etext+0x76432>
    24c0:	2065                	jal	2568 <xsnprintf+0x660>
    24c2:	656c                	flw	fa1,76(a0)
    24c4:	2064                	fld	fs1,192(s0)
    24c6:	0a36                	slli	s4,s4,0xd
    24c8:	0000                	unimp
    24ca:	0000                	unimp
    24cc:	2020                	fld	fs0,64(s0)
    24ce:	5b20                	lw	s0,112(a4)
    24d0:	5d46                	lw	s10,112(sp)
    24d2:	4720                	lw	s0,72(a4)
    24d4:	7465                	lui	s0,0xffff9
    24d6:	6620                	flw	fs0,72(a2)
    24d8:	616c                	flw	fa1,68(a0)
    24da:	6d206873          	csrrsi	a6,0x6d2,0
    24de:	0a65646f          	jal	s0,58584 <_etext+0x55e34>
    24e2:	0000                	unimp
    24e4:	2020                	fld	fs0,64(s0)
    24e6:	5b20                	lw	s0,112(a4)
    24e8:	5d49                	li	s10,-14
    24ea:	5220                	lw	s0,96(a2)
    24ec:	6165                	addi	sp,sp,112
    24ee:	2064                	fld	fs1,192(s0)
    24f0:	20495053          	0x20495053
    24f4:	6c66                	flw	fs8,88(sp)
    24f6:	7361                	lui	t1,0xffff8
    24f8:	2068                	fld	fa0,192(s0)
    24fa:	4449                	li	s0,18
    24fc:	000a                	c.slli	zero,0x2
    24fe:	0000                	unimp
    2500:	2020                	fld	fs0,64(s0)
    2502:	5b20                	lw	s0,112(a4)
    2504:	53205d53          	0x53205d53
    2508:	7465                	lui	s0,0xffff9
    250a:	5320                	lw	s0,96(a4)
    250c:	6e69                	lui	t3,0x1a
    250e:	20656c67          	0x20656c67
    2512:	20495053          	0x20495053
    2516:	6f6d                	lui	t5,0x1b
    2518:	6564                	flw	fs1,76(a0)
    251a:	000a                	c.slli	zero,0x2
    251c:	2020                	fld	fs0,64(s0)
    251e:	5b20                	lw	s0,112(a4)
    2520:	5d44                	lw	s1,60(a0)
    2522:	5320                	lw	s0,96(a4)
    2524:	7465                	lui	s0,0xffff9
    2526:	4420                	lw	s0,72(s0)
    2528:	20495053          	0x20495053
    252c:	6f6d                	lui	t5,0x1b
    252e:	6564                	flw	fs1,76(a0)
    2530:	000a                	c.slli	zero,0x2
    2532:	0000                	unimp
    2534:	2020                	fld	fs0,64(s0)
    2536:	5b20                	lw	s0,112(a4)
    2538:	53205d43          	fmadd.d	fs10,ft0,fs2,fa0,unknown
    253c:	7465                	lui	s0,0xffff9
    253e:	4420                	lw	s0,72(s0)
    2540:	2b495053          	0x2b495053
    2544:	204d5243          	fmadd.s	ft4,fs10,ft4,ft4,unknown
    2548:	6f6d                	lui	t5,0x1b
    254a:	6564                	flw	fs1,76(a0)
    254c:	000a                	c.slli	zero,0x2
    254e:	0000                	unimp
    2550:	2020                	fld	fs0,64(s0)
    2552:	5b20                	lw	s0,112(a4)
    2554:	5d42                	lw	s10,48(sp)
    2556:	5220                	lw	s0,96(a2)
    2558:	6e75                	lui	t3,0x1d
    255a:	7320                	flw	fs0,96(a4)
    255c:	6d69                	lui	s10,0x1a
    255e:	6c70                	flw	fa2,92(s0)
    2560:	7369                	lui	t1,0xffffa
    2562:	6974                	flw	fa3,84(a0)
    2564:	65622063          	0x65622063
    2568:	636e                	flw	ft6,216(sp)
    256a:	6d68                	flw	fa0,92(a0)
    256c:	7261                	lui	tp,0xffff8
    256e:	00000a6b          	0xa6b
    2572:	0000                	unimp
    2574:	2020                	fld	fs0,64(s0)
    2576:	5b20                	lw	s0,112(a4)
    2578:	5d41                	li	s10,-16
    257a:	4220                	lw	s0,64(a2)
    257c:	6e65                	lui	t3,0x19
    257e:	616d6863          	bltu	s10,s6,2b8e <_etext+0x43e>
    2582:	6b72                	flw	fs6,28(sp)
    2584:	6120                	flw	fs0,64(a0)
    2586:	6c6c                	flw	fa1,92(s0)
    2588:	6320                	flw	fs0,64(a4)
    258a:	69666e6f          	jal	t3,68c20 <_etext+0x664d0>
    258e:	000a7367          	0xa7367
    2592:	0000                	unimp
    2594:	4f49                	li	t5,18
    2596:	5320                	lw	s0,96(a4)
    2598:	6174                	flw	fa3,68(a0)
    259a:	6574                	flw	fa3,76(a0)
    259c:	203a                	fld	ft0,392(sp)
    259e:	0000                	unimp
    25a0:	6d6d6f43          	0x6d6d6f43
    25a4:	6e61                	lui	t3,0x18
    25a6:	3e64                	fld	fs1,248(a2)
    25a8:	0020                	addi	s0,sp,8
    25aa:	0000                	unimp
    25ac:	20495053          	0x20495053
    25b0:	74617453          	0x74617453
    25b4:	3a65                	jal	1f6c <xsnprintf+0x64>
    25b6:	000a                	c.slli	zero,0x2
    25b8:	2020                	fld	fs0,64(s0)
    25ba:	5344                	lw	s1,36(a4)
    25bc:	4950                	lw	a2,20(a0)
    25be:	0020                	addi	s0,sp,8
    25c0:	000a4e4f          	fnmadd.s	ft8,fs4,ft0,ft0,rmm
    25c4:	0a46464f          	fnmadd.d	fa2,fa2,ft4,ft1,rmm
    25c8:	0000                	unimp
    25ca:	0000                	unimp
    25cc:	2020                	fld	fs0,64(s0)
    25ce:	204d5243          	fmadd.s	ft4,fs10,ft4,ft4,unknown
    25d2:	0020                	addi	s0,sp,8
    25d4:	636f6c43          	fmadd.d	fs8,ft10,fs6,fa2,unknown
    25d8:	7266206b          	0x7266206b
    25dc:	7165                	addi	sp,sp,-400
    25de:	6575                	lui	a0,0x1d
    25e0:	636e                	flw	ft6,216(sp)
    25e2:	3a79                	jal	1f80 <xsnprintf+0x78>
    25e4:	2520                	fld	fs0,72(a0)
    25e6:	0a64                	addi	s1,sp,284
    25e8:	0000                	unimp
    25ea:	0000                	unimp
    25ec:	480a                	lw	a6,128(sp)
    25ee:	6c65                	lui	s8,0x19
    25f0:	6f6c                	flw	fa1,92(a4)
    25f2:	0000                	unimp
    25f4:	7325                	lui	t1,0xfffe9
    25f6:	203a                	fld	ft0,392(sp)
    25f8:	3225                	jal	1f20 <xsnprintf+0x18>
    25fa:	2032                	fld	ft0,264(sp)
    25fc:	6425                	lui	s0,0x9
    25fe:	3020                	fld	fs0,96(s0)
    2600:	2578                	fld	fa4,200(a0)
    2602:	2078                	fld	fa4,192(s0)
    2604:	6230                	flw	fa2,64(a2)
    2606:	6225                	lui	tp,0x9
    2608:	2520                	fld	fs0,72(a0)
    260a:	2070                	fld	fa2,192(s0)
    260c:	2530                	fld	fa2,72(a0)
    260e:	2525206f          	j	54860 <_etext+0x52110>
    2612:	000a                	c.slli	zero,0x2
    2614:	186c                	addi	a1,sp,60
    2616:	0000                	unimp
    2618:	1850                	addi	a2,sp,52
    261a:	0000                	unimp
    261c:	1834                	addi	a3,sp,56
    261e:	0000                	unimp
    2620:	1818                	addi	a4,sp,48
    2622:	0000                	unimp
    2624:	17fc                	addi	a5,sp,1004
    2626:	0000                	unimp
    2628:	17e0                	addi	s0,sp,1004
    262a:	0000                	unimp
    262c:	1480                	addi	s0,sp,608
    262e:	0000                	unimp
    2630:	1480                	addi	s0,sp,608
    2632:	0000                	unimp
    2634:	1480                	addi	s0,sp,608
    2636:	0000                	unimp
    2638:	1480                	addi	s0,sp,608
    263a:	0000                	unimp
    263c:	1480                	addi	s0,sp,608
    263e:	0000                	unimp
    2640:	1480                	addi	s0,sp,608
    2642:	0000                	unimp
    2644:	1480                	addi	s0,sp,608
    2646:	0000                	unimp
    2648:	1480                	addi	s0,sp,608
    264a:	0000                	unimp
    264c:	1480                	addi	s0,sp,608
    264e:	0000                	unimp
    2650:	1480                	addi	s0,sp,608
    2652:	0000                	unimp
    2654:	17c8                	addi	a0,sp,996
    2656:	0000                	unimp
    2658:	15e0                	addi	s0,sp,748
    265a:	0000                	unimp
    265c:	15cc                	addi	a1,sp,740
    265e:	0000                	unimp
    2660:	145c                	addi	a5,sp,548
    2662:	0000                	unimp
    2664:	1480                	addi	s0,sp,608
    2666:	0000                	unimp
    2668:	148c                	addi	a1,sp,608
    266a:	0000                	unimp
    266c:	1480                	addi	s0,sp,608
    266e:	0000                	unimp
    2670:	1480                	addi	s0,sp,608
    2672:	0000                	unimp
    2674:	15bc                	addi	a5,sp,744
    2676:	0000                	unimp
    2678:	1480                	addi	s0,sp,608
    267a:	0000                	unimp
    267c:	1480                	addi	s0,sp,608
    267e:	0000                	unimp
    2680:	1480                	addi	s0,sp,608
    2682:	0000                	unimp
    2684:	1480                	addi	s0,sp,608
    2686:	0000                	unimp
    2688:	1480                	addi	s0,sp,608
    268a:	0000                	unimp
    268c:	1480                	addi	s0,sp,608
    268e:	0000                	unimp
    2690:	1480                	addi	s0,sp,608
    2692:	0000                	unimp
    2694:	1480                	addi	s0,sp,608
    2696:	0000                	unimp
    2698:	1480                	addi	s0,sp,608
    269a:	0000                	unimp
    269c:	158c                	addi	a1,sp,736
    269e:	0000                	unimp
    26a0:	1480                	addi	s0,sp,608
    26a2:	0000                	unimp
    26a4:	1480                	addi	s0,sp,608
    26a6:	0000                	unimp
    26a8:	1480                	addi	s0,sp,608
    26aa:	0000                	unimp
    26ac:	1480                	addi	s0,sp,608
    26ae:	0000                	unimp
    26b0:	1480                	addi	s0,sp,608
    26b2:	0000                	unimp
    26b4:	1480                	addi	s0,sp,608
    26b6:	0000                	unimp
    26b8:	1480                	addi	s0,sp,608
    26ba:	0000                	unimp
    26bc:	1480                	addi	s0,sp,608
    26be:	0000                	unimp
    26c0:	1480                	addi	s0,sp,608
    26c2:	0000                	unimp
    26c4:	1480                	addi	s0,sp,608
    26c6:	0000                	unimp
    26c8:	1480                	addi	s0,sp,608
    26ca:	0000                	unimp
    26cc:	1480                	addi	s0,sp,608
    26ce:	0000                	unimp
    26d0:	1480                	addi	s0,sp,608
    26d2:	0000                	unimp
    26d4:	17c8                	addi	a0,sp,996
    26d6:	0000                	unimp
    26d8:	15e0                	addi	s0,sp,748
    26da:	0000                	unimp
    26dc:	15cc                	addi	a1,sp,740
    26de:	0000                	unimp
    26e0:	145c                	addi	a5,sp,548
    26e2:	0000                	unimp
    26e4:	1480                	addi	s0,sp,608
    26e6:	0000                	unimp
    26e8:	148c                	addi	a1,sp,608
    26ea:	0000                	unimp
    26ec:	1480                	addi	s0,sp,608
    26ee:	0000                	unimp
    26f0:	1480                	addi	s0,sp,608
    26f2:	0000                	unimp
    26f4:	15bc                	addi	a5,sp,744
    26f6:	0000                	unimp
    26f8:	1480                	addi	s0,sp,608
    26fa:	0000                	unimp
    26fc:	1480                	addi	s0,sp,608
    26fe:	0000                	unimp
    2700:	1480                	addi	s0,sp,608
    2702:	0000                	unimp
    2704:	1480                	addi	s0,sp,608
    2706:	0000                	unimp
    2708:	1480                	addi	s0,sp,608
    270a:	0000                	unimp
    270c:	1480                	addi	s0,sp,608
    270e:	0000                	unimp
    2710:	1480                	addi	s0,sp,608
    2712:	0000                	unimp
    2714:	1480                	addi	s0,sp,608
    2716:	0000                	unimp
    2718:	1480                	addi	s0,sp,608
    271a:	0000                	unimp
    271c:	158c                	addi	a1,sp,736
    271e:	0000                	unimp
    2720:	2e32                	fld	ft8,264(sp)
    2722:	00382e33          	slt	t3,a6,gp
    2726:	0000                	unimp
    2728:	3130                	fld	fa2,96(a0)
    272a:	3332                	fld	ft6,296(sp)
    272c:	3534                	fld	fa3,104(a0)
    272e:	3736                	fld	fa4,360(sp)
    2730:	3938                	fld	fa4,112(a0)
    2732:	6261                	lui	tp,0x18
    2734:	66656463          	bltu	a0,t1,2d9c <_etext+0x64c>
    2738:	6a696867          	0x6a696867
    273c:	6e6d6c6b          	0x6e6d6c6b
    2740:	7271706f          	j	1a666 <_etext+0x17f16>
    2744:	76757473          	csrrci	s0,0x767,10
    2748:	7a797877          	0x7a797877
    274c:	0000                	unimp
	...
