----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 17:04:22
-- Design Name: 
-- Module Name: clock_to_ssd - Behavioral
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

entity clock_to_ssd is
    Port (
    CLK : in std_logic;
    btn_1: in std_logic;
    btn_2: in std_logic;
    inputs: in std_logic_vector (3 downto 0);
    anodes: out std_logic_vector(3 downto 0);
    seven_seg : out std_logic_vector (7 downto 0)
    );
end clock_to_ssd;

architecture Behavioral of clock_to_ssd is

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
           CLK : in std_logic;
           btn_1: in std_logic;
           btn_2: in std_logic;
           inputs: in std_logic_vector (3 downto 0);
           anodes: out std_logic_vector(3 downto 0);
           seven_seg : out std_logic_vector (7 downto 0)
    );
end component;

signal clock_to_ssd: std_logic;

begin

g1: clock_divider PORT MAP (
    clk_in => CLK,
    clk_out => clock_to_ssd
);

g2: ssd PORT MAP (
    CLK => clock_to_ssd,
    btn_1 => btn_1,
    btn_2 => btn_2,
    inputs => inputs,
    anodes => anodes,
    seven_seg => seven_seg
);

end Behavioral;
