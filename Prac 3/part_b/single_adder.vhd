----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 12:53:20
-- Design Name: 
-- Module Name: single_adder - Behavioral
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

entity single_adder is
    Port ( input_a : in STD_LOGIC_VECTOR (3 downto 0);
           input_b : in STD_LOGIC_VECTOR (3 downto 0);
           clk_in : in STD_LOGIC;
           int_a: out integer;
           int_b: out integer
           );
end single_adder;

architecture Behavioral of single_adder is

begin

process(clk_in)

begin

    if rising_edge(clk_in) then
        case input_a is 
            when "0000" => int_a <= 0;
            when "0001" => int_a <= 1;
            when "0010" => int_a <= 2;
            when "0011" => int_a <= 3;
            when "0100" => int_a <= 4;
            when "0101" => int_a <= 5;
            when "0110" => int_a <= 6;
            when "0111" => int_a <= 7;
            when "1000" => int_a <= 8;
            when "1001" => int_a <= 9;
            when others => int_a <= 0;       
        end case;
        
        case input_b is 
            when "0000" => int_b <= 0;
            when "0001" => int_b <= 1;
            when "0010" => int_b <= 2;
            when "0011" => int_b <= 3;
            when "0100" => int_b <= 4;
            when "0101" => int_b <= 5;
            when "0110" => int_b <= 6;
            when "0111" => int_b <= 7;
            when "1000" => int_b <= 8;
            when "1001" => int_b <= 9;
            when others => int_b <= 0;       
        end case;
        
    end if;

end process;
end Behavioral;
