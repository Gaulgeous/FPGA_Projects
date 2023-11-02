----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 15:12:20
-- Design Name: 
-- Module Name: clk_to_all_ssd - Behavioral
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

entity clk_to_all_ssd is
    Port ( 
    CLK: in std_logic;
    btn_1: in bit;
    inputs: in std_logic_vector(3 downto 0) := "0000";
    anodes: out std_logic_vector(3 downto 0) := "1111"; -- Write a 0 to make it active
    seven_seg: out std_logic_vector(7 downto 0) := "11111111" -- Write a 0 to make it active
    );
end clk_to_all_ssd;

architecture Behavioral of clk_to_all_ssd is

component clock_divider is
    generic (
        n: integer := 2 -- Division value, eg 100Mhz in, div=2 => 50Mhz out
    );
    port (
        clk_in: in std_logic;
        clk_out: out std_logic
    );
end component;

component ssd is
    Port (
           active : in bit;
           CLK: in std_logic;
           inputs: in std_logic_vector(3 downto 0);
           seven_seg : out std_logic_vector (7 downto 0)
           );
end component;

signal clk_line : std_logic;
signal ssd_line : std_logic_vector(7 downto 0) := "11111111";
signal anode_line : std_logic_vector(3 downto 0) := "1111";

begin

g1: clock_divider PORT MAP (
    clk_in => CLK,
    clk_out => clk_line
);

g2: ssd PORT MAP (
    active => btn_1,
    CLK => clk_line,
    inputs => inputs,
    seven_seg => ssd_line
);


end Behavioral;
