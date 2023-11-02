----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 17:26:03
-- Design Name: 
-- Module Name: logic - Behavioral
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

entity logic is
    Port (
        CLK : in std_logic;
        btn_1: in std_logic;
        btn_2: in std_logic;
        rst: in std_logic;
        inputs: in std_logic_vector (7 downto 0);
        register_1 : out std_logic_vector (7 downto 0);
        register_2 : out std_logic_vector (7 downto 0);
        anodes: out std_logic_vector(3 downto 0);
        seven_seg : out std_logic_vector (7 downto 0)
    );
end logic;

architecture Behavioral of logic is


component ssd is
    Port (
           CLK : in std_logic;
           btn: in std_logic;
           rst: in std_logic;
           input_1: in std_logic_vector (3 downto 0);
           input_2: in std_logic_vector (3 downto 0);
           anodes: out std_logic_vector(1 downto 0);
           seven_seg : out std_logic_vector (7 downto 0)
    );
end component;

signal register_a : std_logic_vector (7 downto 0) := "00000000";
signal register_b : std_logic_vector (7 downto 0) := "00000000";

begin

g1: ssd PORT MAP (
    CLK => CLK,
    btn => btn_1,
    rst => rst,
    input_1 => register_a(7 downto 4),
    input_2 => register_a(3 downto 0),
    anodes => anodes(3 downto 2),
    seven_seg => seven_seg
);

g2: ssd PORT MAP (
    CLK => CLK,
    btn => btn_2,
    rst => rst,
    input_1 => register_b(7 downto 4),
    input_2 => register_b(3 downto 0),
    anodes => anodes(1 downto 0),
    seven_seg => seven_seg
);

process(CLK, btn_1, btn_2, rst)
begin

    if (CLK = '1' and btn_1 = '1' and btn_2 = '0' and rst = '0') then
        register_1 <= inputs;
        register_a <= inputs;
    elsif (CLK = '1' and btn_1 = '0' and btn_2 = '1' and rst = '0') then
        register_2 <= inputs;
        register_b <= inputs;
    elsif (CLK = '1' and btn_1 = '0' and btn_2 = '1' and rst = '1') then
        register_1 <= "10101010";
        register_2 <= "10101010";
        register_a <= "10101010";
        register_b <= "10101010";
    end if;

end process;
end Behavioral;
