----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.09.2023 15:19:04
-- Design Name: 
-- Module Name: flag_outputter - Behavioral
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

entity flag_outputter is
    Port ( input : in STD_LOGIC;
           clk : in std_logic;
           rst: in std_logic;
           flag_peak : out std_logic;
           sequence : out STD_LOGIC;
           previous_state : out natural range 0 to 1);
end flag_outputter;

architecture Behavioral of flag_outputter is

component sequence_detector is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           flag : out STD_LOGIC);
end component;

signal flag : std_logic := '0';
type fsmState is (S0, S1);
signal prev_state : fsmState := S0;

begin

g1: sequence_detector PORT MAP (
    input => input,
    clk => clk,
    rst => rst,
    flag => flag
);

process(flag)
begin

    case prev_state is 
    
        when S0 =>
            if (flag = '1') then
                sequence <= '1';
                prev_state <= S1;
                previous_state <= 1;
            else
                sequence <= '0';
                prev_state <= S0;
                previous_state <= 0;
            end if;
            
        when S1 =>
            if (flag = '1') then
                sequence <= '1';
                prev_state <= S1;
                previous_state <= 1;
            else
                sequence <= '1';
                prev_state <= S0;
                previous_state <= 0;
            end if;
        when others =>
            sequence <= '0';
            prev_state <= S0;
            previous_state <= 0;
        end case;
        
        flag_peak <= flag;
        
end process;
end Behavioral;
