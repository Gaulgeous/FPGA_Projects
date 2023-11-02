----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.09.2023 10:18:53
-- Design Name: 
-- Module Name: combined_fsm - Behavioral
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

entity combined_fsm is
    Port (
        clk: in std_logic;
        input: in std_logic;
        rst: in std_logic;
        z_flag: out std_logic
    );
end combined_fsm;

architecture Behavioral of combined_fsm is

component fsm_2 is
    Port (
        clk: in std_logic;
        input_flag: in std_logic;
        input_bit: in std_logic;
        z_flag: out std_logic
    );
end component;

component sequence_detector is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           flag : out STD_LOGIC);
end component;

signal connector : std_logic := '0';

begin

g1: sequence_detector PORT MAP (
    input => input,
    clk => clk,
    rst => rst,
    flag => connector
);

g2: fsm_2 PORT MAP (
    clk => clk,
    input_flag => connector,
    input_bit => input,
    z_flag => z_flag
);
end Behavioral;
