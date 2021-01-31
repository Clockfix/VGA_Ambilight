#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/types.h>

/* utilities */
#define _I(fmt, args...) printf(fmt "\n", ##args)
#define _E(fmt, args...) printf("ERROR: " fmt "\n", ##args)

/* physical address spans */
#define LWHPS2FPGA_BASE 0xff200000 /* physical address of the LWH2F bridge */
#define LWHPS2FPGA_SPAN 0xf777     /* address span to map */

void print_usage()
{
    _I("USAGE:");
    _I("./main.elf <led_place>  <led_color>");
    _I("EXAMPLE:");
    _I("./main.elf 10 0xf0a41f");
}

int main(int argc, char *argv[])
{
    unsigned long mask;
    unsigned int place;
    int fd;                   /* file descriptor */
    unsigned long *mem_lwh2f; /* memory pointer for LW HPS2FPGA bridge */
                              // unsigned char *mem_h2f;   /* memory pointer for HPS2FPGA bridge */
    unsigned long *mem_target;

    if (argc < 3)
    {
        print_usage();
        return 0;
    }

    /* Acquire "/dev/mem" file's descriptor (use "open" syscall) */
    _I("Opening (acquiring descriptor) \"/dev/mem\" file");
    fd = open("/dev/mem", O_RDWR);
    if (fd == -1)
    {
        _E("Failed to open \"/dev/mem\" file");
        return 1;
    }
    /* Map LWHPS2FPGA physical address to this process (use "mmap" syscall) */
    _I("Mapping physical address of the LWHPS2FPGA");
    mem_lwh2f = mmap(NULL, LWHPS2FPGA_SPAN, PROT_READ | PROT_WRITE,
                     MAP_SHARED, fd, LWHPS2FPGA_BASE);
    if ((int)mem_lwh2f == -1)
    {
        _E("Failed to map physical address LWHPS2FPGA");
        return 1;
    }

    /* select target memory region */
    place = strtoul(argv[1], NULL, 10);
    if (place > 1024)
    {
        _I("Outside physical address span of LWHPS2FPGA");
    }
    else
    {
        /* Get LED addrres */
        mem_target = mem_lwh2f + place;
        /* get LED mask */
        mask = strtoul(argv[2], NULL, 16);
        _I("In %d addrres are saved this number: 0x%lx ", place, mask);
        *mem_target = mask; /* writing mask to the LED output */
        _I("Value mask has been written");
    }
    _I("Unmapping physical address");
    munmap(mem_lwh2f, LWHPS2FPGA_SPAN);

    return 0;
}
