# Warning: this project is far from being considered of acceptable quality

This is a first order approximation to getting a pure Ada program running on a RISC-V synthesized core. In this case, it is the SaxonSOC (VexRISCV CPU) running on a ULX3S (the size of the FPGA should not matter).

## How was it made

Very briefly

1. Load the FPGA with the CPU, OpenOCD and U-Boot. Following this instructions should get you there: https://github.com/lawrie/saxonsoc-ulx3s-bin/tree/master/Smp
2. Generate a startup sequence and a linker script for the CPU.
2.1 This was achieved by using AdaCore's `startup-gen` system. The information of the configuration resides in the `blink.gpr` file. You do not need to install `startup-gen` since the boot file and linker script are provided.
2.2 *Warning:* The `startup-gen` information is FAR from being correct and that is why (I believe) the program does not load directly. More on that later.
3. Abstracted the hardware into a library. The hardware information for the SOC was taken from: https://github.com/SpinalHDL/SaxonSoc/blob/dev-0.3/software/standalone/blinkAndEcho/src/main.c https://github.com/SpinalHDL/SaxonSoc/blob/dev-0.3/bsp/radiona/ulx3s/smp/include/bsp.h https://github.com/SpinalHDL/SaxonSoc/blob/dev-0.3/software/standalone/driver/gpio.h https://github.com/SpinalHDL/SaxonSoc/blob/dev-0.3/software/standalone/driver/io.h and https://github.com/SpinalHDL/SaxonSoc/blob/dev-0.3/bsp/radiona/ulx3s/smp/include/soc.h
3.1 The library can be found under the different `.ads` files.
4. Program the logic. The blink delay is done by forcing the CPU into a lengthy loop.
5. Tranform the generated executable `elf` file into a binary one with: `riscv32-elf-objcopy -O binary blink blink.bin`
5. Load the program with `u-boot`. 
6. Jump to the address where the "main" function resides.
6.1 The reason we cannot jump to the initial addres of `0x80000000` and we need to jump to another addres (in my case `0x80000064`, your may differ) is because the stack is incorrectly set up for `startup-gen`.
7. Profit

## What do you need to try it out
	
- AdaCore's RISCV toolchain: https://www.adacore.com/download/more Search for 32-bit. You can also build your own toolchain based on FSF GNAT.
- Optional: AdaCore's Main toolchain: the one for your platform. I mainly recommend this one to get the `GNATstudio` editor (very nice). See https://github.com/AdaCore/gps
- Optional: `startup-gen`. Inital scripts are already provided, so you do not need to install `startup-gen`. However, if you want to regenerate everything, the see https://github.com/AdaCore/startup-gen The binary is provided in the repo.
	
## What does not work

Mostly everything does not work. Only the first GPIO, yes, just that. The booting sequence for the binary also does not work. See step 2 for the "How was it made" section.
