----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 15:47:58
-- Design Name: 
-- Module Name: dual_bcd - Behavioral
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

entity dual_bcd is
    Port (
        inputs: in std_logic_vector(15 downto 0);
        clk_in : in std_logic;
        output: out std_logic_vector(7 downto 0);
        carry_out : out std_logic
    );
end dual_bcd;

architecture Behavioral of dual_bcd is

component combined is
    Port (
        input_a : in std_logic_vector(3 downto 0);
        input_b : in std_logic_vector(3 downto 0);
        clk_in : in std_logic;
        carry_in : in std_logic;
        carry_out : out std_logic;
        result : out std_logic_vector(3 downto 0)
    );
end component;

signal carry_line : std_logic;
signal carry_in : std_logic := '0';

begin

g2: combined PORT MAP (
    input_a => inputs(11 downto 8),
    input_b => inputs(3 downto 0),
    clk_in => clk_in,
    carry_in => carry_in,
    carry_out => carry_line,
    result => output(3 downto 0)
);

g3: combined PORT MAP (
    input_a => inputs(15 downto 12),
    input_b => inputs(7 downto 4),
    clk_in => clk_in,
    carry_in => carry_line,
    carry_out => carry_out,
    result => output(7 downto 4)
);

end Behavioral;
