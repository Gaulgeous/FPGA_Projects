----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2023 16:38:10
-- Design Name: 
-- Module Name: all_ssd - Behavioral
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

entity all_ssd is
    Port (
    inputs: in std_logic_vector (3 downto 0) := "0000";
    btn_1 : in bit;
    CLK: in std_logic;
    anode_1: std_logic;
    seven_seg: out std_logic_vector(7 downto 0) := "11111111"
    );
end all_ssd;

architecture Behavioral of all_ssd is

component ssd is
    Port (
           active : in bit;
           inputs: in std_logic_vector (3 downto 0);
           seven_seg : out std_logic_vector (7 downto 0)
    );
end component;

signal anodes : std_logic_vector(3 downto 0) := "1111";

begin

g1: ssd PORT MAP (
    active => 
    inputs => inputs,
    seven_seg => seven_seg
)


end Behavioral;
