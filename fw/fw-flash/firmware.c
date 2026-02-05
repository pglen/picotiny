
/* =====[ pyedpro.sess ]========================================================

   File Name:       firmware.c

   Description:     Functions for firmware.c

   Revisions:

      REV   DATE                BY              DESCRIPTION
      ----  -----------         ----------      --------------------------
      0.00  Wed 04.Feb.2026     Peter Glen      Initial version.

   ======================================================================= */

#include "utils.h"
#include "genver.txt"

int putchar(int c)
{
    if (c == '\n')
        UART0->DATA = '\r';
    UART0->DATA = c;

    return c;
}

void print(const char *p)
{
    while (*p)
        putchar(*(p++));
}

//include "utils.c"

void (*spi_flashio)(uint8_t *pdata, int length, int wren) = FLASHIO_ENTRY_ADDR;

char getchar_prompt(char *prompt)
{
    int32_t c = -1;

    uint32_t cycles_begin, cycles_now, cycles;
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));

    if (prompt)
        print(prompt);

    // if (prompt)
        // GPIO0->OUT = ~0;
        // reg_leds = ~0;

    while (c == -1) {
        __asm__ volatile ("rdcycle %0" : "=r"(cycles_now));
        cycles = cycles_now - cycles_begin;
        if (cycles > 12000000) {
            if (prompt)
                print(prompt);
            cycles_begin = cycles_now;
            // if (prompt)
                // GPIO0->OUT = ~GPIO0->OUT;
                // reg_leds = ~reg_leds;
        }
        c = UART0->DATA;
    }
    // if (prompt)
        // GPIO0->OUT = 0;
        // reg_leds = 0;
    return c;
}

char getchar()
{
    return getchar_prompt(0);
}

#define QSPI_REG_CRM  0x00100000
#define QSPI_REG_DSPI 0x00400000

void cmd_set_crm(int on)
{
    if (on) {
        QSPI0->REG |= QSPI_REG_CRM;
    } else {
        QSPI0->REG &= ~QSPI_REG_CRM;
    }
}

int cmd_get_crm() {
    return QSPI0->REG & QSPI_REG_CRM;
}

void cmd_set_dspi(int on)
{
    if (on) {
        QSPI0->REG |= QSPI_REG_DSPI;
    } else {
        QSPI0->REG &= ~QSPI_REG_DSPI;
    }
}

int cmd_get_dspi() {
    return QSPI0->REG & QSPI_REG_DSPI;
}

void cmd_read_flash_id()
{
    int pre_dspi = cmd_get_dspi();

    cmd_set_dspi(0);

    uint8_t buffer[4] = { 0x9F, /* zeros */ };
    spi_flashio(buffer, 4, 0);

    for (int i = 1; i <= 3; i++) {
        putchar(' ');
        //print_hex(buffer[i], 2);
        char out[12];
        print_num(buffer[i], 16, out, 12);  print(out);
    }
    putchar('\n');

    cmd_set_dspi(pre_dspi);
}

// --------------------------------------------------------

uint32_t cmd_benchmark(bool verbose, uint32_t *instns_p)
{
    uint8_t data[256];
    uint32_t *words = (void*)data;

    uint32_t x32 = 314159265;

    uint32_t cycles_begin, cycles_end;
    uint32_t instns_begin, instns_end;
    __asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
    __asm__ volatile ("rdinstret %0" : "=r"(instns_begin));

    for (int i = 0; i < 20; i++)
    {
        for (int k = 0; k < 256; k++)
        {
            x32 ^= x32 << 13;
            x32 ^= x32 >> 17;
            x32 ^= x32 << 5;
            data[k] = x32;
        }

        for (int k = 0, p = 0; k < 256; k++)
        {
            if (data[k])
                data[p++] = k;
        }

        for (int k = 0, p = 0; k < 64; k++)
        {
            x32 = x32 ^ words[k];
        }
    }

    __asm__ volatile ("rdcycle %0" : "=r"(cycles_end));
    __asm__ volatile ("rdinstret %0" : "=r"(instns_end));

    if (verbose)
    {
        char out[12];

        print("Cycles: 0x");
        //print_hex(cycles_end - cycles_begin, 8);
        print_num(cycles_end - cycles_begin, 16, out, 12);
         print(out);
         putchar('\n');

        print("Instns: 0x");
        print_num(instns_end - instns_begin, 16, out, 12);
         print(out);
         putchar('\n');

        print("Chksum: 0x");
        print_num(x32, 16, out, 12);
         print(out); putchar('\n');
    }

    if (instns_p)
        *instns_p = instns_end - instns_begin;

    return cycles_end - cycles_begin;
}

void cmd_benchmark_all()
{
    uint32_t instns = 0;

    print("default        ");

    cmd_set_dspi(0);
    cmd_set_crm(0);

    print(": ");
    char out[12];
    print_num(cmd_benchmark(false, &instns), 16, out, 12);
     print(out);  putchar('\n');

    print("dspi-");
    print_num(0, 10, out, 12);
     print(out);
     print("         ");

    cmd_set_dspi(1);

    print(": ");
    print_num(cmd_benchmark(false, &instns), 16, out, 12);
     print(out);
     putchar('\n');

    print("dspi-crm-");
    print_num(0, 10, out, 12);
     print(out);
     print("     ");

    cmd_set_crm(1);

    print(": ");
    print_num(cmd_benchmark(false, &instns), 16, out, 12);
     print(out);
     putchar('\n');

    print("instns         : ");
    print_num(instns, 16, out, 12);
     print(out);
     putchar('\n');
}

volatile int i;
// --------------------------------------------------------

#define CLK_FREQ        25175000
#define UART_BAUD       115200

// ____      _               ____ _
//|  _ \ ___| |_ ___ _ __   / ___| | ___ _ __
//| |_) / _ \ __/ _ \ '__| | |  _| |/ _ \ '_ \
//|  __/  __/ ||  __/ |    | |_| | |  __/ | | |
//|_|   \___|\__\___|_|     \____|_|\___|_| |_|
//

char strpg[] =  "\
     ____      _               ____ _\n\
    |  _ \\ ___| |_ ___ _ __   / ___| | ___ _ __\n\
    | |_) / _ \\ __/ _ \\ '__| | |  _| |/ _ \\ '_ \\\n\
    |  __/  __/ ||  __/ |    | |_| | |  __/ | | |\n\
    |_|   \\___|\\__\\___|_|     \\____|_|\\___|_| |_|\n\
\n";

void main()
{
    UART0->CLKDIV = CLK_FREQ / UART_BAUD - 2;

    GPIO0->OE = 0x3F;
    GPIO0->OUT = 0x3F;

    cmd_set_crm(1);
    cmd_set_dspi(1);

    print("\n\n\n\n\n\n");

    print("           Lichee Tang Nano-9K by Peter Glen, Build: ");
    print(BUILD); print("\n");
    print("\n");
    char out[12];

    //print("len: '");
    //print_num(strxlen(strpg), 10, out, 12);
    // print(out);
    // print("'  '");
    //print_num(strxlen(strpg), 16, out, 12);
    // print(out);
    // print("'\n");
    //for(int aa = 0; aa < 10; aa++)
    //    {
    //    print_hex(aa, 4); print(" -- ");
    //    print_num(aa, 10); print(" - ");
    //    }
    //print("\n");

    // Show banner
    print(strpg);

    // Show clock
    char outx[64];
    void *arr2[] = {(void*)CLK_FREQ, NULL};
    xsnprintf(outx, sizeof(outx), "Clock frequency: %d\n", arr2);
    print(outx);

    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F ^ 0x01;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F ^ 0x02;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F ^ 0x04;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F ^ 0x08;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F ^ 0x10;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F ^ 0x20;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x00;
    for ( i = 0 ; i < 10000; i++);
    GPIO0->OUT = 0x3F;
    for ( i = 0 ; i < 10000; i++);

    // test xsnprintf
    void *arr[] = {(void*)"\nHello",(void*)-99, (void*)33, 0, arr, 63, NULL};
    int xx = 1234;
    arr[3] = (void*)xx;
    xsnprintf(outx, sizeof(outx), "%s: %22 %d 0x%x 0b%b %p 0%o %%\n", arr);
    print(outx);

    while (1)
    {
        print("\n");
        print("Select an action:\n");
        print("\n");
        print("   [0] Run main app (kiosk)\n");
        print("   [1] Toggle led 1\n");
        print("   [2] Toggle led 2\n");
        print("   [3] Toggle led 3\n");
        print("   [4] Toggle led 4\n");
        print("   [5] Toggle led 5\n");
        print("   [6] Toggle led 6\n");
        print("   [F] Get flash mode\n");
        print("   [I] Read SPI flash ID\n");
        print("   [S] Set Single SPI mode\n");
        print("   [D] Set DSPI mode\n");
        print("   [C] Set DSPI+CRM mode\n");
        print("   [B] Run simplistic benchmark\n");
        print("   [A] Benchmark all configs\n");

        for (int rep = 10; rep > 0; rep--)
        {
            char out[12];

            print("\n");
            print("IO State: ");
            print_num(GPIO0->IN, 16, out, 12);
            print("\n");
            print("\n");

            print("Command> ");
            char cmd = getchar();
            if (cmd > 32 && cmd < 127)
                putchar(cmd);
            print("\n");

            switch (cmd)
            {
            case 'F':
            case 'f':
                print("\n");
                print("SPI State:\n");
                print("  DSPI ");
                if ( cmd_get_dspi() )
                    print("ON\n");
                else
                    print("OFF\n");
                print("  CRM  ");
                if ( cmd_get_crm() )
                    print("ON\n");
                else
                    print("OFF\n");

                break;

            case 'I':
            case 'i':
                cmd_read_flash_id();
                break;

            case 'S':
            case 's':
                cmd_set_dspi(0);
                cmd_set_crm(0);
                break;

            case 'D':
            case 'd':
                cmd_set_crm(0);
                cmd_set_dspi(1);
                break;

            case 'C':
            case 'c':
                cmd_set_crm(1);
                cmd_set_dspi(1);
                break;

            case 'B':
            case 'b':
                cmd_benchmark(1, 0);
                break;

            case 'A':
            case 'a':
                cmd_benchmark_all();
                break;

            case '1':
                GPIO0->OUT ^= 0x00000001;
                break;

            case '2':
                GPIO0->OUT ^= 0x00000002;
                break;

            case '3':
                GPIO0->OUT ^= 0x00000004;
                break;

            case '4':
                GPIO0->OUT ^= 0x00000008;
                break;

            case '5':
                GPIO0->OUT ^= 0x00000010;
                break;

            case '6':
                GPIO0->OUT ^= 0x00000020;
                break;

            default:
                continue;
            }
        }
    }
}

void irqCallback() {

}