----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.08.2023 09:14:53
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_combination is
    Port (
        clk_in: in std_logic;
        btn_1 : in std_logic;
        btn_2 : in std_logic;
        rst : in std_logic;
        inputs: in std_logic_vector(7 downto 0);
        lock: out std_logic;
        unlock_out: out std_logic;
        seven_seg: out std_logic_vector(7 downto 0);
        anodes: out std_logic_vector(7 downto 0)
    );
end full_combination;

architecture Behavioral of full_combination is

component reg_allocation is
    Port (
        clk_in: in std_logic;
        btn_1 : in std_logic;
        btn_2 : in std_logic;
        rst : in std_logic;
        inputs: in std_logic_vector(7 downto 0);
        clk_out : out std_logic;
        thick_buff : out std_logic_vector(15 downto 0)
    );
end component;


component ssd is
    Port (
       input : in std_logic_vector(3 downto 0);
       seven_seg : out std_logic_vector(7 downto 0)
    );
end component;


component unlock is
    Port (
        thick_buff: in std_logic_vector(15 downto 0);
        lock: out std_logic;
        unlock_out: out std_logic
    );
end component;


signal buff_line: std_logic_vector(15 downto 0);
signal clk_line : std_logic;
signal ssd_line : std_logic_vector(3 downto 0);
signal alternator : natural range 0 to 4;
signal observation: std_logic_vector(3 downto 0);


begin

g1: reg_allocation port map (
    clk_in => clk_in,
    btn_1 => btn_1,
    btn_2 => btn_2,
    clk_out => clk_line,
    rst => rst,
    inputs => inputs,
    thick_buff => buff_line
);

g2: ssd PORT MAP (
    input => ssd_line,
    seven_seg => seven_seg
);

g3: unlock Port MAP (
    thick_buff => buff_line,
    lock => lock,
    unlock_out => unlock_out
);

process(clk_line)
begin
    if (rising_edge(clk_line)) then
    
        if (alternator = 0) then
            anodes <= "11110111";
            ssd_line <= buff_line(15 downto 12);
            observation <= buff_line(15 downto 12);
            alternator <= alternator + 1;
        elsif (alternator = 1) then
            anodes <= "11111011";
            ssd_line <= buff_line(11 downto 8);
            observation <= buff_line(11 downto 8);
            alternator <= alternator + 1;
        elsif (alternator = 2) then
            anodes <= "11111101";
            ssd_line <= buff_line(7 downto 4);
            observation <= buff_line(7 downto 4);
            alternator <= alternator + 1;
        else
            anodes <= "11111110";
            ssd_line <= buff_line(3 downto 0);
            observation <= buff_line(3 downto 0);
            alternator <= 0;
        end if;
    end if;
end process;
end Behavioral;
