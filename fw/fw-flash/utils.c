
/* =====[ pyedpro.sess ]========================================================

   File Name:       utils.c

   Description:     Functions for utils.c

   Revisions:

      REV   DATE                BY              DESCRIPTION
      ----  -----------         ----------      --------------------------
      0.00  Wed 04.Feb.2026     Peter Glen      Initial version.

   ======================================================================= */

#include "utils.h"

#ifdef TESTME
    #include "stdio.h"
#endif

#define ISNUM       (1 << 0)
#define ISHEX       (1 << 1)
#define ISALPHA     (1 << 2)
#define ISUPPER     (1 << 3)
#define ISLOWER     (1 << 4)
#define ISCTRL      (1 << 5)
#define ISPUNCT     (1 << 6)
#define ISSPACE     (1 << 7)

//  0  NUL 16   DLE  32     48 0    64 @    80 P    96  `   112  p
//  1  SOH 17   DC1  33 !   49 1    65 A    81 Q    97  a   113  q
//  2  STX 18   DC2  34 "   50 2    66 B    82 R    98  b   114  r
//  3  ETX 19   DC3  35 #   51 3    67 C    83 S    99  c   115  s
//  4  EOT 20   DC4  36 $   52 4    68 D    84 T    100 d   116  t
//  5  ENQ 21   NAK  37 %   53 5    69 E    85 U    101 e   117  u
//  6  ACK 22   SYN  38 &   54 6    70 F    86 V    102 f   118  v
//  7  BEL 23   ETB  39 '   55 7    71 G    87 W    103 g   119  w
//  8  BS  24   CAN  40 (   56 8    72 H    88 X    104 h   120  x
//  9  HT  25   EM   41 )   57 9    73 I    89 Y    105 i   121  y
// 10  LF  26   SUB  42 *   58 :    74 J    90 Z    106 j   122  z
// 11  VT  27   ESC  43 +   59 ;    75 K    91 [    107 k   123  {
// 12  FF  28   FS   44 ,   60 <    76 L    92 \    108 l   124  |
// 13  CR  29   GS   45 -   61 =    77 M    93 ]    109 m   125  }
// 14  SO  30   RS   46 .   62 >    78 N    94 ^    110 n   126  ~
// 15  SI  31   US   47 /   63 ?    79 O    95 _    111 o   127  DEL

// Eazy does it
#define N ISNUM
#define H ISHEX
#define A ISALPHA
#define U ISUPPER
#define L ISLOWER
#define C ISCTRL
#define T ISPUNCT
#define B ISSPACE

char tab[255] =
    {
    // 0 NUL  1 SOH 2   STX 3   ETX 4   EOT 5   ENQ 6   ACK 7 BEL
        C,      C,      C,      C,      C,      C,      C,      C,

    // 8  BS  9   HT  10  LF  11  VT 12 FF   13 CR  14 SO   15  SI
        B,    B,      B,      B,      B,      B,     B,      C,

    //  16  DLE 17  DC1 18  DC2 19  DC3 20  DC4 21  NAK 22  SYN  23  ETB
        C,      C,      C,      C,      C,      C,      C,      C,

    //  24 CAN  25 EM   26 SUB  27 ESC  28 FS   29 GS   30 RS   31  US
        C,      C,      C,      C,      C,      C,      C,      C,

    //  32 ' '  33  !   34  "   35  #   36  $   37  %   38  &   39  '
        B,      T,      T,      T,      T,      T,      T,      T,

    //  40  (   41  )   42  *   43  +   44  ,   45  -   46  .   47  /
        T,      T,      T,      T,      T,      T,      T,      T,

    //  48 0    49 1    50 2    51 3    52 4    53 5    54 6    55 7
        N|H,   N|H, N|H,  N|H,  N|H,  N|H,  N|H,  N|H,

    //  56 8    57 9    58 :    59 ;    60 <    61 =    62 >    63 ?
        N|H,  N|H,    T,      T,      T,      T,      T,      T,

    //  64 @    65 A    66 B    67 C    68 D    69 E    70 F    71 G
        T,      H|U|A,   H|U|A,  H|U|A,  H|U|A,   H|U|A,  H|U|A,  U|A,

    //  72 H    73 I    74 J    75 K    76 L    77 M    78 N    79 O
        U|A,      U|A,  U|A,    U|A,    U|A,     U|A,      U|A,   U|A,

    //  80 P    81 Q    82 R    83 S    84 T    85 U    86 V    87 W
        U|A,    U|A,     U|A,     U|A,   U|A,    U|A,   U|A,    U|A,

    //  88 X    89 Y    90 Z    91 [    92 \    93 ]    94 ^    95 _
        U|A,    U|A,    U|A,    T,      T,      T,      T,      T,

    //  96  `   97  a   98  b   99  c   100 d   101 e   102 f   103 g
        T,      H|L|A,  H|L|A,  H|L|A,  H|L|A,   H|L|A,  H|L|A, L|A,

    //  104 h   105 i   106 j   107 k   108 l   109 m   110 n   111 o
        L|A,    L|A,    L|A,    L|A,    L|A,    L|A,    L|A,    L|A,

    //  112  p  113  q  114  r  115  s  116  t  117  u  118  v  119  w
        L|A,      L|A,  L|A,  L|A,      L|A,    L|A,    L|A,     L|A,

    //  120  x  121  y  122  z  123  {  124  |  125  }  126  ~  127  DEL
        L|A,    L|A,     L|A,     T,      T,      T,      T,      C,
    } ;

int isxpunct(char chh) {
    return tab[(uchar)chh] & ISPUNCT ? 1 : 0;
    }
int isxnum(char chh) {
    return tab[(uchar)chh] & ISNUM ? 1 : 0;
    }
int isxalpha(char chh) {
    return tab[(uchar)chh] & ISALPHA ? 1 : 0;
    }
int isxalnum(char chh) {
    return tab[(uchar)chh] & (ISALPHA | ISNUM) ? 1 : 0;
    }
int isxhex(char chh) {
    return tab[(uchar)chh] & ISHEX ? 1 : 0;
    }
int isxupper(char chh) {
    return tab[(uchar)chh] & ISUPPER ? 1 : 0;
    }
int isxlower(char chh) {
    return tab[(uchar)chh] & ISLOWER ? 1 : 0;
    }
int isxspace(char chh) {
    return tab[(uchar)chh] & ISSPACE ? 1 : 0;
    }
int isxctrl(char chh) {
    return tab[(uchar)chh] & ISCTRL ? 1 : 0;
    }
int isxprint(char chh) {
    return tab[(uchar)chh] & (ISPUNCT | ISSPACE | ISALPHA | ISNUM) ? 1 : 0;
    }

// Safe strcpy. Return length of copy.

#ifdef TESTME
    void print(const char *strx)
        {
        printf("%s\n", strx);
        }
#endif


int strxcpy(char *out, const char *in, int lim)

{
    int lnx = 0;
    while(1)
        {
        if(lnx >= lim-1)
            {
            *out = '\0'; break;
            }
        if(*in == '\0')
            {
            *out = '\0'; break;
            }
        *out++ = *in++; lnx++;
        }
    return lnx;
}

int strxlen(char *strx)
{
    int lnx = 0;
    while(1)
        {
        if (*strx == '\0')
            break;
        strx++; lnx++;
        }
    return lnx;
}

#define DIVRADIX(xx, rrr)   \
    if(rrr == 2)            \
        {                   \
        xx >>= 1;           \
        }                   \
    else if(rrr == 8)       \
        {                   \
        xx >>= 3;           \
        }                   \
    else if(rrr == 10)      \
        {                   \
        xx /= rrr;          \
        }                   \
    else if(rrr == 16)      \
        {                   \
        xx >>= 4;           \
        }                   \
    else                    \
        {                   \
        xx /= rrr;          \
        }

#define MEMSIZE 16   // Temporary string size for numbers

int     print_long(long vv, int radix, char *out, int lim)
{
    int prog = 0, digits = 0, neg = 0, bb = 0;
    char outp[MEMSIZE];
    for(int aa = 0; aa < MEMSIZE; aa++)
        outp[aa] = '\0';
    if( vv < 0) { neg = 1; vv = -vv;} ;
    while(1)
        {
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
        //putchar('\''); putchar(c); putchar('\''); putchar('\n');
        if (vv == 0)
            {
            if(!digits)
                outp[digits++] = '0';  // At least one zero
            break;
            }
        outp[digits++] = c;
        //vv /= radix;
        DIVRADIX(vv, radix)
        prog += 1;
        }
    // Sign
    if(neg)
        out[bb++] = '-';
    // Reverse
    for(int aa = MEMSIZE - 1; aa >= 0; aa--)
        {
        if (bb >= lim - 1)
            break;
        if(outp[aa])
            out[bb++] = outp[aa];
        }
    out[bb] = '\0';

    return prog;
}

int     print_ulong(ulong vv, int radix, char *out, int lim)
{
    int prog = 0, digits = 0, neg = 0, bb = 0;
    char outp[MEMSIZE];
    for(int aa = 0; aa < MEMSIZE; aa++)
        outp[aa] = '\0';
    //if( vv < 0) { neg = 1; vv = -vv;} ;
    while(1)
        {
        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
        //putchar('\''); putchar(c); putchar('\''); putchar('\n');
        if (vv == 0)
            {
            if(!digits)
                outp[digits++] = '0';  // At least one zero
            break;
            }
        outp[digits++] = c;
        //vv /= radix;
        DIVRADIX(vv, radix)
        prog += 1;
        }
    // Sign
    if(neg)
        out[bb++] = '-';
    // Reverse
    for(int aa = MEMSIZE - 1; aa >= 0; aa--)
        {
        if (bb >= lim - 1)
            break;
        if(outp[aa])
            out[bb++] = outp[aa];
        }
    out[bb] = '\0';

    return prog;
}

// Return how many chars are consumed

int     print_int(int vv, int radix, char *out, int lim)

{
    int prog = 0, digits = 0, neg = 0, bb = 0;
    char outp[MEMSIZE];
    for(int aa = 0; aa < MEMSIZE; aa++)
        outp[aa] = '\0';

    if( vv < 0) { neg = 1; vv = -vv;} ;

    while(1)
        {
        if(prog >= lim - 2)
            break;

        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
        //putchar('\''); putchar(c); putchar('\''); putchar('\n');
        if (vv == 0)
            {
            if(!digits)
                outp[digits++] = '0';  // At least one zero
            break;
            }
        outp[digits++] = c;
        //vv /= radix;
        DIVRADIX(vv, radix)
        prog += 1;
        }
    // Sign
    if(neg)
        out[bb++] = '-';
    // Reverse
    for(int aa = MEMSIZE - 1; aa >= 0; aa--)
        {
        if (bb >= lim - 1)
            break;
        if(outp[aa])
            out[bb++] = outp[aa];
        }
    out[bb] = '\0';
    return prog;
}

// Return how many chars are consumed

int     print_uint(uint vv, int radix, char *out, int lim)

{
    int prog = 0, digits = 0, neg = 0, bb = 0;
    char outp[MEMSIZE];
    for(int aa = 0; aa < MEMSIZE; aa++)
        outp[aa] = '\0';

    //if( vv < 0) { neg = 1; vv = -vv;} ;

    while(1)
        {
        if(prog >= lim-3)
            {
            outp[digits++] = 'R';
            outp[digits++] = 'R';
            outp[digits++] = 'E';
            break;
            }

        char c = "0123456789abcdefghijklmnopqrstuvwxyz"[(vv % radix)];
        //putchar('\''); putchar(c); putchar('\''); putchar('\n');
        if (vv == 0)
            {
            if(!digits)
                outp[digits++] = '0';  // At least one zero
            break;
            }
        outp[digits++] = c;
        //vv /= radix;
        DIVRADIX(vv, radix)
        prog += 1;
        }
    // Sign
    if(neg)
        out[bb++] = '-';
    // Reverse
    for(int aa = MEMSIZE - 1; aa >= 0; aa--)
        {
        if (bb >= lim - 1)
            break;
        if(outp[aa])
            out[bb++] = outp[aa];
        }
    out[bb] = '\0';
    return prog;
}

// Format characters:
//
//      %[opts]d        -- decimal (signed)
//      %[opts]u        -- decimal (unsigned)
//      %[opts]x        -- hexadecimal
//      %[opts]b        -- binary
//      %[opts]p        -- pointer
//      %[opts]o        -- octal
//
// opts:
//      -               -- align left
//      +               -- align right (default)
//      l               -- long
//      [0-9]+          -- pad this number of times


int xsnprintf(char *out, int lim, const char *fmt, void *args[])

{
    int argidx = 0, prog = 0;
    *out = '\0';
    char out2[MEMSIZE];

    while(*fmt)
        {
        if(*fmt == '%')
            {
            fmt++;
            char    longopt = '\0', opt = '\0';
            int     outnum = 0;
            while(*fmt)
                {
                // Gather num
                char chh2 = *fmt;
                if(isxnum(*fmt))
                    {
                    //printf("num: %c ", chh2);
                    outnum *= 10;
                    outnum += chh2 - '0';
                    }
                else if(*fmt == '-')
                    {
                    //printf("opt: %c ", chh2);
                    opt = *fmt;
                    }
                else if(*fmt == 'l')
                    {
                    printf("longopt: %c ", chh2);
                    longopt = *fmt;
                    }
                else if(*fmt == '+')
                    {
                    //printf("opt: %c ", chh2);
                    opt = *fmt;
                    }
                else
                    {
                    break;
                    }
                fmt++;
                }
            char chh = *fmt;
            //printf("outnum: oper=%c outnum=%d opt='%c'\n", chh, outnum, opt);

            if(chh == '\0')
                break;
            else if(chh == '%')
               {
               prog += strxcpy(out + prog, "%", lim - prog);
               }
            else if(chh == 'c')
               {
               //printf("char c=%c\n", (char)(args[argidx]) );
               out[prog] = (char)(PTRCAST)(args[argidx]);
               prog++;
               argidx++;
               }
            else if(chh == 's')
               {
               prog += strxcpy(out + prog, args[argidx], lim - prog);
               argidx++;
               }
            else if(chh == 'd' || chh == 'u')
               {
               int len = 0;
               if(chh == 'd')
                    {
                    if(longopt)
                        len = print_long((PTRCAST)args[argidx], 10, out2, sizeof(out2));
                    else
                        len = print_int((PTRCAST)args[argidx], 10, out2, sizeof(out2));
                    }
               else
                    {
                    if(longopt)
                        len = print_ulong((PTRCAST)args[argidx], 10, out2, sizeof(out2));
                    else
                        len = print_uint((PTRCAST)args[argidx], 10, out2, sizeof(out2));
                    }
               if(outnum)
                    {
                    if(opt == '-')
                        {
                        //printf("padd left %d %d\n", outnum, len);
                        prog += strxcpy(out + prog, out2, lim - prog);
                        for (int aa = 0; aa < outnum - len; aa++)
                            prog += strxcpy(out + prog, " ", lim - prog);
                        }
                    else
                        {
                        //printf("padd right %d %d\n", outnum, len);
                        for (int aa = 0; aa < outnum - len; aa++)
                            prog += strxcpy(out + prog, " ", lim - prog);
                        prog += strxcpy(out + prog, out2, lim - prog);
                        }
                    }
               else
                    {
                    prog += strxcpy(out + prog, out2, lim - prog);
                    }
               argidx++;
               }
            else if(chh == 'o')
               {
               print_uint((PTRCAST)args[argidx], 8, out2, sizeof(out2));
               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else if(chh == 'x')
               {
               if (longopt)
                    print_ulong((PTRCAST)args[argidx], 16, out2, sizeof(out2));
                else
                    print_uint((PTRCAST)args[argidx], 16, out2, sizeof(out2));

               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else if(chh == 'b')
               {
               if (longopt)
                    print_ulong((PTRCAST)args[argidx], 2, out2, sizeof(out2));
                else
                    print_uint((PTRCAST)args[argidx], 2, out2, sizeof(out2));

               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else if(chh == 'p')
               {
               print_long((PTRCAST)&args[argidx], 16, out2, sizeof(out2));
               prog += strxcpy(out + prog, "0x", lim - prog);
               prog += strxcpy(out + prog, out2, lim - prog);
               argidx++;
               }
            else
                {
                // Output verbatim
                out[prog++] = '%';
                out[prog++] = chh;
                }
            }
        else
            {
            out[prog++] = *fmt;
            }
        fmt++;
        }
    // Zero terminate
    out[prog]   = '\0';
    return prog;
}

#ifdef TESTME
int main(int argc, char *argv[])
{
    for (int aa = 0; aa < 128; aa++)
        {
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxalnum(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxalpha(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxspace(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxhex(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxupper(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxlower(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxpunct(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxctrl(aa) );
        //printf("%3d '%c' =>%d  ", aa, aa >= 32 ? aa : ' ', isxprint(aa) );

        //if(aa % 6 == 5)
        //    printf("\n");
        }
    char    out[64];
    void *arr[] = { _A("World"),  _A(123412340),
                    _A('a' + 2),  _A(arr), _A(0623)};
    xsnprintf(out, sizeof(out), "Hello '%s' %b %c %p %o", arr);
    printf("out: %p [%s] \n", arr, out);
}
#endif

// EOF
