----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 14:21:07
-- Design Name: 
-- Module Name: ssd - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd is
    Port (
       input : in std_logic_vector(3 downto 0);
       seven_seg : out std_logic_vector(7 downto 0)
    );
end ssd;

architecture Behavioral of ssd is

begin

--process(input)
--begin
--    seven_seg <= "11101111";
--end process;

process(input)
begin
    
    case(input) is
    when "0000" => seven_seg <= "10000001";
    when "0001" => seven_seg <= "11001111";
    when "0010" => seven_seg <= "10010010";
    when "0011" => seven_seg <= "10000110";
    when "0100" => seven_seg <= "11001100";
    when "0101" => seven_seg <= "10100100";
    when "0110" => seven_seg <= "10100000";
    when "0111" => seven_seg <= "10001111";
    when "1000" => seven_seg <= "10000000";
    when "1001" => seven_seg <= "10001100";
    when "1010" => seven_seg <= "10001000";
    when "1011" => seven_seg <= "11100000";
    when "1100" => seven_seg <= "10110001";
    when "1101" => seven_seg <= "11000010";
    when "1110" => seven_seg <= "10110000";
    when "1111" => seven_seg <= "10111000";
    when others => seven_seg <= "00000000";
    
    end case;
    
end process;

end Behavioral;
