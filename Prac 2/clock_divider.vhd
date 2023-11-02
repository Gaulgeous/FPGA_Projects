----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 14:35:51
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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

entity clock_divider is
    generic (
        n: integer := 2 -- Division value, eg 100Mhz in, div=2 => 50Mhz out
    );
    port (
        clk_in: in std_logic;
        clk_out: out std_logic     
    );
end entity clock_divider;

architecture Behavioral of clock_divider is

signal clk_divider_counter : natural range 0 to n;
signal clock_state : std_logic := '0';

begin
    process (clk_in)
    begin
        if rising_edge(clk_in) then
            if (clk_divider_counter = n-1) then
                clk_divider_counter <= 0;
                clock_state <= not clock_state;
            else
                clk_divider_counter <= clk_divider_counter + 1;
            end if;
        end if;
    end process;

clk_out <= clock_state;
end Behavioral;
