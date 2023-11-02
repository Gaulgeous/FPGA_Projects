--------------------------------------------
-- Approximate Adder - 6
-- 2-bit Full-Adder
-- Author: Bharath Srinivas Prabakaran, Muhammad Shafique  
--------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity AA6 is
	port (
      	A : in  std_logic_vector(1 downto 0); --input 1
        B : in  std_logic_vector(1 downto 0); --input 2
      	Sum : out std_logic_vector(1 downto 0); --output 1
        C_out : out std_logic;
      	C_in : in std_logic
    );
end entity ;

architecture arch of AA6 is 

begin

LUT6_2_inst : LUT6_2
generic map (
   INIT => X"E080FEF888EE88EE") -- Specify LUT Contents
port map (
   O6 => Sum(1),  -- 6/5-LUT output (1-bit)
   O5 => Sum(0),  -- 5-LUT output (1-bit)
   I0 => C_in,   -- LUT input (1-bit)
   I1 => B(0),   -- LUT input (1-bit)
   I2 => B(1),   -- LUT input (1-bit)
   I3 => A(0),   -- LUT input (1-bit)
   I4 => A(1),   -- LUT input (1-bit)
   I5 => '1'    -- LUT input (1-bit)
);  

C_out <= A(1);

end architecture ;