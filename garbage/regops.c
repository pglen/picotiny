int c_var0 = 11;
int c_var1 = 22;
int c_var2 = 33;
int c_var3 = 44;

for(int aa = 0; aa < 1; aa++)
        {
        __asm__ volatile ("mv %0, x0" : "=r" (c_var0) : : "x0");
        __asm__ volatile ("mv %0, x1" : "=r" (c_var1) : : "x1");
        __asm__ volatile ("mv %0, x2" : "=r" (c_var2) : : "x2");
        __asm__ volatile ("mv %0, x3" : "=r" (c_var3) : : "x3");

        print_num(c_var0, 10);    print(" ");
        print_num(c_var1, 10);    print(" ");
        print_num(c_var2, 10);    print(" ");
        print_num(c_var3, 10);    print(" ");

        __asm__ volatile ("mv %0, x4" : "=r" (c_var0) : : "x4");
        __asm__ volatile ("mv %0, x5" : "=r" (c_var1) : : "x5");
        __asm__ volatile ("mv %0, x6" : "=r" (c_var2) : : "x6");
        __asm__ volatile ("mv %0, x7" : "=r" (c_var3) : : "x7");

        print_num(c_var0, 10);    print(" ");
        print_num(c_var1, 10);    print(" ");
        print_num(c_var2, 10);    print(" ");
        print_num(c_var3, 10);    print(" ");
        }

        //print("'\nvals2: ");
       //char *gmt2 = (char*)fmt;
       //for(int aa = 0; aa < 40; aa++)
       //     {
       //     print_num(gmt2[aa], 10);    print(" ");
       //     }
       //print("'\nvals3: ");
       //for(int aa = 0; aa < 40; aa++)
       //     {
       //     print_num(gmt2[-aa], 10);    print(" ");
       //     }
       //print("'\n");

