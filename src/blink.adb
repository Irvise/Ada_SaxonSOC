--  Blink a led

with Interfaces.SaxonSOC.GPIO;
use Interfaces.SaxonSOC.GPIO;

procedure Blink is

   type Large is mod 2 ** 32;
   Counter_1 : Large := 0;
begin
   --  GPIO_A_Output_Enable := 16#1111_1111#;
   GPIO_A_Output_Enable := 16#01#;
   GPIO_A_Output := 0;
   loop
      GPIO_A_Output := GPIO_A_Output xor 16#1111_1111#;
      while Counter_1 < Large'Last / 800 loop -- About a period of 2 seconds
         Counter_1 := Counter_1 + 1;
      end loop;
      Counter_1 := 0;
   end loop;

end Blink;
