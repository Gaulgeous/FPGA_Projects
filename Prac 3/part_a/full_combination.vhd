----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 10:56:27
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
        btn_1: in std_logic;
        btn_2: in std_logic;
        sat_en: in std_logic;
        clk: in std_logic;
        inputs: in std_logic_vector(15 downto 0);
        sat_led: out std_logic;
        result: out std_logic_vector(15 downto 0);
        seven_seg: out std_logic_vector(7 downto 0);
        anodes: out std_logic_vector(7 downto 0)
    );
end full_combination;

architecture Behavioral of full_combination is

component SSD is
    Port ( zero : in STD_LOGIC;
           negative : in STD_LOGIC;
           carry_out : in STD_LOGIC;
           overflow : in STD_LOGIC;
           clk_in : in STD_LOGIC;
           anodes : out STD_LOGIC_VECTOR (7 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component adder_logic is
    Port ( register_a : in STD_LOGIC_VECTOR (15 downto 0);
           register_b : in STD_LOGIC_VECTOR (15 downto 0);
           sat_en: in std_logic;
           result : out STD_LOGIC_VECTOR (15 downto 0);
           zero : out std_logic;
           negative : out std_logic;
           carry_out : out std_logic;
           overflow : out std_logic
           );
end component;

component register_allocation is
    Port ( inputs : in STD_LOGIC_VECTOR (15 downto 0);
           btn_1 : in STD_LOGIC;
           btn_2 : in STD_LOGIC;
           clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC;
           register_a : out std_logic_vector(15 downto 0);
           register_b : out std_logic_vector(15 downto 0)
           );
end component;

signal reg_a_line : std_logic_vector(15 downto 0);
signal reg_b_line : std_logic_vector(15 downto 0);
signal clk_line : std_logic;
signal zero_line : std_logic;
signal neg_line : std_logic;
signal carry_line : std_logic;
signal overflow_line : std_logic;

begin

g1: register_allocation PORT MAP (
    inputs => inputs,
    btn_1 => btn_1,
    btn_2 => btn_2,
    clk_in => clk,
    clk_out => clk_line,
    register_a => reg_a_line,
    register_b => reg_b_line
);

g2: adder_logic PORT MAP (
    register_a => reg_a_line,
    register_b => reg_b_line,
    sat_en => sat_en,
    result => result,
    zero => zero_line,
    negative => neg_line,
    carry_out => carry_line,
    overflow => overflow_line
);

g3: SSD PORT MAP (
    zero => zero_line,
    negative => neg_line,
    carry_out => carry_line,
    overflow => overflow_line,
    clk_in => clk_line,
    anodes => anodes,
    seven_seg => seven_seg
);

process(sat_en)
begin

sat_led <= sat_en;

end process;
end Behavioral;
