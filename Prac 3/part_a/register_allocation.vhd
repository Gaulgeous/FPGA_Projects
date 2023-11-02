----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 09:52:12
-- Design Name: 
-- Module Name: register_allocation - Behavioral
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

entity register_allocation is
    Port ( inputs : in STD_LOGIC_VECTOR (15 downto 0);
           btn_1 : in STD_LOGIC;
           btn_2 : in STD_LOGIC;
           clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC;
           register_a : out std_logic_vector(15 downto 0);
           register_b : out std_logic_vector(15 downto 0)
           );
end register_allocation;

architecture Behavioral of register_allocation is

component clock_divider is
    generic (
        n: integer := 2 -- Division value, eg 100Mhz in, div=2 => 50Mhz out
    );
    port (
        clk_in: in std_logic;
        clk_out: out std_logic     
    );
end component;

signal clk_line : std_logic;

begin

g1: clock_divider PORT MAP (
    clk_in => clk_in,
    clk_out => clk_line
);

process (clk_line)
begin

    if rising_edge(clk_line) then
    
        if (btn_1 = '1' and btn_2 = '0') then
            register_a <= inputs;
        elsif (btn_1 = '0' and btn_2 = '1') then
            register_b <= inputs;
        end if;
        
    end if;
    
    clk_out <= clk_line;
    
end process;
end Behavioral;
