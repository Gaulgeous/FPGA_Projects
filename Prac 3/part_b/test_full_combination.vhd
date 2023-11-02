----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 16:40:31
-- Design Name: 
-- Module Name: test_full_combination - Behavioral
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

entity test_full_combination is
--  Port ( );
end test_full_combination;

architecture Behavioral of test_full_combination is

component full_combination is
    Port (
        clk_100mhz : in std_logic;
        inputs: in std_logic_vector(15 downto 0);
        seven_seg : out std_logic_vector(7 downto 0);
        anodes: out std_logic_vector(7 downto 0);
        clk_peak : out std_logic
    );
end component;

signal clk: std_logic := '0';
signal inputs : std_logic_vector(15 downto 0);
signal seven_seg : std_logic_vector(7 downto 0);
signal anodes : std_logic_vector(7 downto 0);
signal clk_peak : std_logic;

begin

uut: full_combination PORT MAP (
    clk_100mhz => clk,
    inputs => inputs,
    seven_seg => seven_seg,
    anodes => anodes,
    clk_peak => clk_peak
);

test: process
begin


inputs <= "0000000000000000";
for i in 0 to 23 loop
    clk <= not clk;
    wait for 1ps;
end loop;

inputs <= "0000000000000001";
for i in 0 to 23 loop
    clk <= not clk;
    wait for 1ps;
end loop;

inputs <= "1000000000000001";
for i in 0 to 23 loop
    clk <= not clk;
    wait for 1ps;
end loop;

end process;
end Behavioral;
