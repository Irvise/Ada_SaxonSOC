--  SaxonSOC GPIO mapping

--  The structure is mostly based on https://github.com/AdaCore/bb-runtimes/
--  blob/community-2020/riscv/sifive/fe310/svd/i-fe310-gpio.ads

with System;

--  TODO do more than just the LEDS

package Interfaces.SaxonSOC.GPIO is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   --  Auxiliary types
   type GPIO_Control_Reg is new Unsigned_32;
   type Mask_T is new Unsigned_32;

   --  Addresses
   GPIO_A_Base_Address : constant := 16#1000_0000#;

   GPIO_A_Input : GPIO_Control_Reg
     with Volatile_Full_Access,
     Address => System'To_Address (GPIO_A_Base_Address);
   GPIO_A_Output : GPIO_Control_Reg
     with Address => System'To_Address (GPIO_A_Base_Address + 16#04#);
   GPIO_A_Output_Enable : GPIO_Control_Reg
     with Address => System'To_Address (GPIO_A_Base_Address + 16#08#);

end Interfaces.SaxonSOC.GPIO;
