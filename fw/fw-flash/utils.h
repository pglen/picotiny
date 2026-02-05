
/* =====[ pyedpro.sess ]========================================================

   File Name:       utils.h

   Description:     Functions for utils.h

   Revisions:

      REV   DATE                BY              DESCRIPTION
      ----  -----------         ----------      --------------------------
      0.00  Wed 04.Feb.2026     Peter Glen      Initial version.

   ======================================================================= */

#define false 0
#define true 1

#define FALSE 0
#define TRUE 1

#define NULL ((void*)0)

#define bool char
#define uint32_t  unsigned int
#define uint16_t  unsigned short
#define uint8_t  unsigned char

#define int32_t  int
#define int16_t  short
#define int8_t   char

#define uchar unsigned char
#define ushort unsigned short
#define uint unsigned int
#define ulong unsigned long

// Cast from pointer type
#ifdef TESTME
#define PTRCAST  long    // Linux
#else
#define PTRCAST  int     // RISCV
#endif

#define _A(xx) ((void*)(xx))

// a pointer to this is a null pointer, but the compiler does not
// know that because "sram" is a linker symbol from sections.lds.
extern uint32_t sram;

typedef struct {
    volatile uint32_t DATA;
    volatile uint32_t CLKDIV;
} PICOUART;

typedef struct {
    volatile uint32_t OUT;
    volatile uint32_t IN;
    volatile uint32_t OE;
} PICOGPIO;

typedef struct {
    union {
        volatile uint32_t REG;
        volatile uint16_t IOW;
        struct {
            volatile uint8_t IO;
            volatile uint8_t OE;
            volatile uint8_t CFG;
            volatile uint8_t EN;
        };
    };
} PICOQSPI;

#define QSPI0 ((PICOQSPI*)0x81000000)
#define GPIO0 ((PICOGPIO*)0x82000000)
#define UART0 ((PICOUART*)0x83000000)

#define FLASHIO_ENTRY_ADDR ((void *)0x80000054)

int putchar(int c);
void print(const char *p);

int isxpunct(char chh) ;
int isxnum(char chh) ;
int isxalpha(char chh) ;
int isxalnum(char chh) ;
int isxhex(char chh) ;
int isxupper(char chh) ;
int isxlower(char chh) ;
int isxspace(char chh) ;
int isxctrl(char chh) ;
int isxprint(char chh) ;
int strxcpy(char *out, const char *in, int lim);
int strxlen(char *strx);
int print_num(int vv, int radix, char *out, int lim);
int xsnprintf(char *out, int lim, const char *fmt, void *args[]);

// EOF
