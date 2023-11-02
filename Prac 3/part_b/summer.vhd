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

end process;
end Behavioral;
