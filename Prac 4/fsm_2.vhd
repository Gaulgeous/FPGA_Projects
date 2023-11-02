----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2023 11:52:45
-- Design Name: 
-- Module Name: fsm_2 - Behavioral
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

entity fsm_2 is
    Port (
        clk: in std_logic;
        input_flag: in std_logic;
        input_bit: in std_logic;
        z_flag: out std_logic
    );
end fsm_2;

architecture Behavioral of fsm_2 is

signal counter: std_logic := '0';

begin
process(clk)
begin
    if (rising_edge(clk)) then
        if (counter = '1') then
            z_flag <= '1';
            counter <= '0';
        else
            z_flag <= input_bit and input_flag;
            counter <= input_bit and input_flag;
        end if;
    end if;
end process;
end Behavioral;
