--  Main SaxonSOC package

--  See https://github.com/SpinalHDL/SaxonSoc/blob/
--  bade201e38363030aab41dbec5565885a2f68dc3/bsp/radiona/ulx3s/smp/include/
--  soc.h#L64

--  with System;

package Interfaces.SaxonSOC is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   ---------------
   -- Base type --
   ---------------

   type Bit is mod 2**1
     with Size => 1;

end Interfaces.SaxonSOC;
