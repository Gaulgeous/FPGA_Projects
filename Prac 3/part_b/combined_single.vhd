----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 13:11:02
-- Design Name: 
-- Module Name: combined_single - Behavioral
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

entity summer is
    Port (
    a_line : in integer;
    b_line : in integer;
    carry_in : in std_logic;
    sum : out integer;
    carry_out : out std_logic
    );
end summer;

architecture Behavioral of summer is

begin

process(a_line, b_line, carry_in)
begin
    
    if (carry_in = '1') then
        if (a_line + b_line + 1 < 10) then
            sum <= a_line + b_line + 1;
            carry_out <= '0';
        else
            sum <= a_line + b_line - 9;
            carry_out <= '1';
        end if;
    else 
        if (a_line + b_line < 10) then
            sum <= a_line + b_line;
            carry_out <= '0';
        else
            sum <= a_line + b_line - 10;
            carry_out <= '1';
        end if;
    end if;
    
    case sum is
    
        when 0 => result <= "0000";
        when 1 => result <= "0001";
        when 2 => result <= "0010";
        when 3 => result <= "0011";
        when 4 => result <= "0100";
        when 5 => result <= "0101";
        when 6 => result <= "0110";
        when 7 => result <= "0111";
        when 8 => result <= "1000";
        when 9 => result <= "1001";
        when others => result <= "0000";
            
        end case;

end process;
end Behavioral;
