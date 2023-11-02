----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.09.2023 15:19:04
-- Design Name: 
-- Module Name: input_detector - Behavioral
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

entity input_detector is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 0));
end input_detector;

architecture Behavioral of input_detector is

signal inputs : std_logic_vector(3 downto 0) := "0000";

begin

process(clk)
begin

if (rising_edge(clk)) then

    if (rst = '1') then
        inputs <= "0000";
        output <= "0000";
    else
        output <= inputs(2 downto 0) & input;
        inputs <= inputs(2 downto 0) & input;
    end if;

end if;

end process;
end Behavioral;
