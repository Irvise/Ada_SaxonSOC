        /*********/
        /* .data */
        /*********/
         .section .data.argv
argv_str:
        .ascii  "main\0"

        .align 4
argv:
        .word argv_str
        .word 0

        /**********/
        /* _start */
        /**********/

        .section .start
        .globl _start
        .type _start,@function

_start:
.option push
.option norelax
        la gp, __global_pointer$
.option pop
        la sp, __stack_end


        /* Clear bss section */
        .type _startup_clear_bss,@function
_startup_clear_bss:
        la a0, __bss_start
        la a1, __bss_end
        bgeu a0, a1, 2f
1:
        sw zero, (a0)
        addi a0, a0, 4
        bltu a0, a1, 1b
2:
        .size _startup_clear_bss, . - _startup_clear_bss

        /* Call static constructors */
.weak __libc_init_array
        la t0, __libc_init_array
        beq t0, zero, .skip_libc_init
        jalr t0
.skip_libc_init:

        /* Call main, with argc, argv  */
        la a0, 1
        la a1, argv
        call main

        /* Save main's return value */
        mv t0, a0

        /* static destructors */
.weak __libc_fini_array
        la t0, __libc_fini_array
        beq t0, zero, .skip_libc_fini
        jalr t0
.skip_libc_fini:

        /* Restore main's return value */
        mv a0, t0

        call __gnat_exit
2:      j 2b

        .globl __gnat_exit
        .type __gnat_exit,@function
        .globl _abort
        .type abort,@function
abort:
__gnat_exit:
        /* Write to the SiFive Test device on QEMU to shutdown */
        li t0, 0x5555
        li t1, 0x100000
        sw t0, (t1)

        j __gnat_exit

        /* Weak alias _exit to __gnat_exit */
        .weak      _exit
        .set _exit,__gnat_exit