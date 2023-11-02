----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 16:23:41
-- Design Name: 
-- Module Name: full_combination - Behavioral
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

entity full_combination is
    Port (
        clk_100mhz : in std_logic;
        inputs: in std_logic_vector(15 downto 0);
        seven_seg : out std_logic_vector(7 downto 0);
        anodes: out std_logic_vector(7 downto 0) := "11111111"
    );
end full_combination;

architecture Behavioral of full_combination is

component ssd is
    Port (
       input : in std_logic_vector(3 downto 0);
       seven_seg : out std_logic_vector(7 downto 0)
    );
end component;

component clock_divider is
    generic (
        n: integer := 2 -- Division value, eg 100Mhz in, div=2 => 50Mhz out
    );
    port (
        clk_in: in std_logic;
        clk_out: out std_logic     
    );
end component;

component dual_bcd is
    Port (
        inputs: in std_logic_vector(15 downto 0);
        clk_in : in std_logic;
        output: out std_logic_vector(7 downto 0);
        carry_out : out std_logic
    );
end component;

signal clk_line: std_logic;
signal output_line: std_logic_vector(7 downto 0);
signal carry_line : std_logic;
signal ssd_line : std_logic_vector(3 downto 0);
signal alternator : natural range 0 to 3 := 0;

begin

g1: clock_divider PORT MAP (
    clk_in => clk_100mhz,
    clk_out => clk_line
);

g2: dual_bcd PORT MAP (
    inputs => inputs,
    clk_in => clk_line,
    output => output_line,
    carry_out => carry_line
);

g4: ssd PORT MAP (
    input => ssd_line,
    seven_seg => seven_seg
);


process(clk_line, alternator, carry_line) is

-- Still require an output going to the seven_seg display
begin

    if (alternator = 0) then
--        anodes <= "11111011";
        if (carry_line = '1') then
            ssd_line <= "0001";
        else 
            ssd_line <= "0000";
        end if;
        alternator <= alternator + 1;
    elsif (alternator = 1) then
--        anodes <= "11111101";
        ssd_line <= output_line(7 downto 4);
        alternator <= alternator + 1;
    else
--        anodes <= "11111110";
        ssd_line <= output_line(3 downto 0);
        alternator <= 0;
        
    end if;

end process;


end Behavioral;
