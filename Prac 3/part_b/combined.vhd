----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 13:26:30
-- Design Name: 
-- Module Name: combined - Behavioral
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

entity combined is
    Port (
        input_a : in std_logic_vector(3 downto 0);
        input_b : in std_logic_vector(3 downto 0);
        clk_in : in std_logic;
        carry_in : in std_logic;
        carry_out : out std_logic;
        result : out std_logic_vector(3 downto 0)
    );
end combined;

architecture Behavioral of combined is

component summer is
    Port (
    a_line : in integer;
    b_line : in integer;
    carry_in : in std_logic;
    sum : out integer;
    carry_out : out std_logic
    );
end component;

component single_adder is
    Port ( input_a : in STD_LOGIC_VECTOR (3 downto 0);
           input_b : in STD_LOGIC_VECTOR (3 downto 0);
           clk_in : in STD_LOGIC;
           int_a: out integer;
           int_b: out integer
           );
end component;

signal a_line : integer;
signal b_line : integer;
signal sum_line: integer;

begin

g1: single_adder PORT MAP (
    input_a => input_a,
    input_b => input_b,
    clk_in => clk_in,
    int_a => a_line,
    int_b => b_line
);

g2: summer PORT MAP (
    a_line => a_line,
    b_line => b_line,
    carry_in => carry_in,
    sum => sum_line,
    carry_out => carry_out
);

process(sum_line)
begin

    case sum_line is
    
        when 0 => result <= "0000";
        when 1 => result <= "0001";
        when 2 => result <= "0010";
        when 3 => result <= "0011";
        when 4 => result <= "0100";
        when 5 => result <= "0101";
        when 6 => result <= "0110";
        when 7 => result <= "0111";
        when 8 => result <= "1000";
        when 9 => result <= "1001";
        when others => result <= "0000";
            
    end case;

end process;
end Behavioral;
