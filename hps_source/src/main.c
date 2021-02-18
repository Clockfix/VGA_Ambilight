//=================================================================================
// Some parts of code are from Terasic Technologies Inc. and is was provided with
// SoC FPGA with license that can be found in other *.c files.
//
//
//=================================================================================

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/types.h>
//#include "utils.h"
#include <sys/file.h>
//#include "image.h"

// /* single file library for loading images */
// #define STB_IMAGE_IMPLEMENTATION
// #include "stb_image.h"

// /* single file library for sabing images */
// #define STB_IMAGE_WRITE_IMPLEMENTATION
// #include "stb_image_write.h"

#include "image.h" /* image API */
#include "utils.h" /* some useful defines */

/* utilities */
#define _I(fmt, args...) printf(fmt "\n", ##args)
#define _E(fmt, args...) printf("ERROR: " fmt "\n", ##args)

/* physical address spans for RAM */
#define LWHPS2FPGA_BASE 0xff200000 /* physical address of the LWH2F bridge */
#define LWHPS2FPGA_SPAN 0xf777     /* address span to map */
#define HPS2FPGA_BASE 0xc0000000   /* physical address of the H2F bridge */
#define HPS2FPGA_SPAN 0xf777       /* address span to map */

void print_usage()
{
    _I("USAGE:");
    _I("./main.elf <command>  <led_place>  <led_color>");
    _I("./main.elf <command>  <option>");
    _I("COMANDS:");
    _I("    1 - clear LEDs");
    _I("    2 - write LED");
    _I("    3 - read image and write LEDs");
    _I("EXAMPLE:");
    _I("./main.elf 2 10 0xf0a41f");
    _I("./main.elf 3 image.png");
    _I("./main.elf 1");
}

void print_start()
{
    _I("=====================================");
    _I("|               RTU                 |");
    _I("|           SoC project             |");
    _I("|                                   |");
    _I("=====================================");
}

/* Function to reverse bits of num */
unsigned char reverseBits(unsigned char num)
{
    unsigned char NO_OF_BITS = sizeof(num) * 8;
    unsigned char reverse_num = 0, i, temp;

    for (i = 0; i < NO_OF_BITS; i++)
    {
        temp = (num & (1 << i));
        if (temp)
            reverse_num |= (1 << ((NO_OF_BITS - 1) - i));
    }

    return reverse_num;
}

/* Function to corect correct color order */
// Usage: sort_color(   strtoul(argv[2], NULL, 16)    )
unsigned long sort_color(unsigned long num)
{
    unsigned char red = (num & 0xFF0000) >> 16;
    unsigned char green = (num & 0x00FF00) >> 8;
    unsigned char blue = (num & 0x0000FF);

    // _I("red=%2x green=%2x blue=%2x", red, green, blue);
    /* sorting bits is not needed because it is implemented in FPGA */
    // red = reverseBits(red);
    // green = reverseBits(green);
    // blue = reverseBits(blue);
    // _I("Reversed:");
    // _I("red=%2x green=%2x blue=%2x", red, green, blue);
    unsigned long out = (green << 16) + (red << 8) + blue;
    // _I("output:%6lx", out);
    return out;
}

/* Set LED in specified color */
// Usage:  write_led(mem_lwh2f, place , color);
void write_led(unsigned long *mem_lwh2f, unsigned int place, unsigned long color)
{
    unsigned long *mem_target;

    color = sort_color(color);
    // _I("write LED");
    //place = strtoul(argv[1], NULL, 10);
    if (place > 1024)
    {
        _I("%d is outside physical address span of LWHPS2FPGA", place);
    }
    else
    {
        /* Get LED addrres */
        mem_target = mem_lwh2f + place;
        /* get LED mask */
        // color = strtoul(argv[2], NULL, 16);
        // _I("In %4d addrres are saved this color: 0x%lx ", place, color);
        *mem_target = color; /* writing mask to the LED output */
        // _I("Value mask has been written");
    }
}

/* select target memory region */
// Usage:  clear_all_leds(mem_lwh2f, num );
void clear_all_leds(unsigned long *mem_lwh2f, unsigned int num)
{
    unsigned long *mem_target;
    // _I("Clear all LEDs");
    for (int i = 0; i < num; i++)
    {
        write_led(mem_lwh2f, i, 0);
    }
}

int main(int argc, char *argv[])
{
    int fd;                   /* file descriptor */
    unsigned long *mem_lwh2f; /* memory pointer for LW HPS2FPGA bridge */
    image_t image, imageIn;

    /*---------------------------------------*/
    /* Initial welcome message               */
    /* on CLI and LCD                        */
    /*---------------------------------------*/
    print_start();
    welcome_screen();

    /*---------------------------------------*/
    /* Check is there three input arguments  */
    /*                                       */
    /*---------------------------------------*/
    if ( argc < 2 )
    {
        print_usage();
        return 0;
    }

    if ( 
        (argc < 3 & strtoul(argv[1], NULL, 10) == 3) |
        (argc < 4 & strtoul(argv[1], NULL, 10) == 2) |
        strtoul(argv[1], NULL, 10) < 1 |
        strtoul(argv[1], NULL, 10) > 3)
    {
        print_usage();
        return 0;
    }
    /*---------------------------------------*/
    /* Preparing bridge and memory map       */
    /*                                       */
    /*---------------------------------------*/

    /* Acquire "/dev/mem" file's descriptor (use "open" syscall) */
    //_I("Opening (acquiring descriptor) \"/dev/mem\" file");
    fd = open("/dev/mem", O_RDWR);
    if (fd == -1)
    {
        _E("Failed to open \"/dev/mem\" file");
        return 1;
    }
    /* Map LWHPS2FPGA physical address to this process (use "mmap" syscall) */
    //_I("Mapping physical address of the LWHPS2FPGA");
    mem_lwh2f = mmap(NULL, HPS2FPGA_SPAN, PROT_READ | PROT_WRITE,
                     MAP_SHARED, fd, HPS2FPGA_BASE);
    if ((int)mem_lwh2f == -1)
    {
        _E("Failed to map physical address LWHPS2FPGA");
        return 1;
    }

    /*---------------------------------------*/
    /* Main code                             */
    /*                                       */
    /*---------------------------------------*/

    /* clear all LEDs */
    if (strtoul(argv[1], NULL, 10) == 1)
    {
        clear_all_leds(mem_lwh2f, 256);
        _I("Clear LEDs done!");
    }

    /* open and load image */
    if (strtoul(argv[1], NULL, 10) == 3)
    {
        _I("Loading input image...");
        if (image_load(&image, argv[2]) == -1)
        {
            _E("Failed to load image");
            return -1;
        }
        image_display(mem_lwh2f, &image);
    }
    /* write single LED */
    if (strtoul(argv[1], NULL, 10) == 2)
    {
        write_led(mem_lwh2f, strtoul(argv[2], NULL, 10), strtoul(argv[3], NULL, 16));
        _I("Write LED done!");
    }

    /*---------------------------------------*/
    /* Release memory map                    */
    /*                                       */
    /*---------------------------------------*/

    //_I("Unmapping physical address");
    munmap(mem_lwh2f, HPS2FPGA_SPAN);

    return 0;
}
