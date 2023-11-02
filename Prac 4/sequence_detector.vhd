----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.09.2023 15:19:04
-- Design Name: 
-- Module Name: sequence_detector - Behavioral
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

entity sequence_detector is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           flag : out STD_LOGIC);
end sequence_detector;

architecture Behavioral of sequence_detector is

component input_detector is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal output : std_logic_vector(3 downto 0);

begin

g1: input_detector PORT MAP (
    input => input,
    clk => clk,
    rst => rst,
    output => output
);

process(output)
begin

    if (output = "1100") then
        flag <= '1';
    else
        flag <= '0';
    end if;

end process;
end Behavioral;
