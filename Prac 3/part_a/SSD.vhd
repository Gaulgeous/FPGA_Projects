----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 10:49:22
-- Design Name: 
-- Module Name: SSD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
    Port ( zero : in STD_LOGIC;
           negative : in STD_LOGIC;
           carry_out : in STD_LOGIC;
           overflow : in STD_LOGIC;
           clk_in : in STD_LOGIC;
           anodes : out STD_LOGIC_VECTOR (7 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (7 downto 0));
end SSD;

architecture Behavioral of SSD is

signal alternator : natural range 0 to 4 := 0;

begin

process(clk_in)
begin

    if rising_edge(clk_in) then
    
        if (alternator = 0) then
            anodes <= "01111111";
            if (zero = '0') then 
                seven_seg <= "10000001";
            else
                seven_seg <= "11001111";
            end if;
            alternator <= 1;
        elsif (alternator = 1) then
            anodes <= "10111111";
            if (negative = '0') then 
                seven_seg <= "10000001";
            else
                seven_seg <= "11001111";
            end if;
            alternator <= 2;
        elsif (alternator = 2) then
            anodes <= "11011111";
            if (carry_out = '0') then 
                seven_seg <= "10000001";
            else
                seven_seg <= "11001111";
            end if;
            alternator <= 3;
        elsif (alternator = 3) then
            anodes <= "11101111";
            if (overflow = '0') then 
                seven_seg <= "10000001";
            else
                seven_seg <= "11001111";
            end if;
            alternator <= 0;
        end if;
            
    end if;

end process;
end Behavioral;
