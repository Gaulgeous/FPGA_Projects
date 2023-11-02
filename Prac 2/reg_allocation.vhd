----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.08.2023 08:46:20
-- Design Name: 
-- Module Name: reg_allocation - Behavioral
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

entity reg_allocation is
    Port (
        clk_in: in std_logic;
        btn_1 : in std_logic;
        btn_2 : in std_logic;
        rst : in std_logic;
        inputs: in std_logic_vector(7 downto 0);
        clk_out : out std_logic;
        thick_buff : out std_logic_vector(15 downto 0)
    );
end reg_allocation;

architecture Behavioral of reg_allocation is

component clock_divider is
    generic (
        n: integer := 2 -- Division value, eg 100Mhz in, div=2 => 50Mhz out
    );
    port (
        clk_in: in std_logic;
        clk_out: out std_logic     
    );
end component;

signal clk_line: std_logic;

begin

g1: clock_divider PORT MAP (
    clk_in => clk_in,
    clk_out => clk_line
); 

process(clk_line)
begin
    if rising_edge(clk_line) then
        if (btn_1 = '1' and btn_2 = '0' and rst = '0') then
            thick_buff(15 downto 8) <= inputs;
        elsif (btn_1 = '0' and btn_2 = '1' and rst = '0') then
            thick_buff(7 downto 0) <= inputs;
        elsif (btn_1 = '0' and btn_2 = '0' and rst = '1') then
            thick_buff <= "1010101010101010";
        end if;
    end if;
    
    clk_out <= clk_line;

end process;
end Behavioral;
