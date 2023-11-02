----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.08.2023 11:02:52
-- Design Name: 
-- Module Name: ssd_combined - Behavioral
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

entity ssd_combined is
    Port (
        register_a : in std_logic_vector(3 downto 0);
        register_b : in std_logic_vector(3 downto 0);
        register_c : in std_logic_vector(3 downto 0);
        register_d : in std_logic_vector(3 downto 0);
        combination : in std_logic_vector(1 downto 0);
        anodes : out std_logic_vector(3 downto 0);
        seven_seg : out std_logic_vector(7 downto 0)
    );
end ssd_combined;

architecture Behavioral of ssd_combined is

begin

process(combination)
begin

    if (combination = "00") then
    
        seven_seg(0) <= register_a(0) or register_a(2) or ((not register_a(1)) and (not register_a(3)));
        seven_seg(1) <= (not register_a(1)) or ((not register_a(2)) and not register_a(3)) or (register_a(2) and register_a(3));
        seven_seg(2) <= register_a(1) or (not register_a(2)) or register_a(3);
        seven_seg(3) <= ((not register_a(1)) and (not register_a(3))) or (register_a(2) and (not register_a(3))) or (register_a(1) and (not register_a(2))and register_a(3)) or ((not register_a(1) and register_a(2))) or register_a(0);
        seven_seg(4) <= ((not register_a(1)) and (not register_a(3))) or (register_a(2) and (not register_a(3)));
        seven_seg(5) <= register_a(0) or ((not register_a(2)) and (not register_a(3))) or (register_a(1) and (not register_a(2))) or (register_a(1) and (not register_a(3)));
        seven_seg(6) <= register_a(0) or (register_a(1) and (not register_a(2))) or (register_a(2) and (not register_a(1))) or (register_a(2) and (not register_a(3)));
        seven_seg(7) <= '1';

    elsif (combination = "01") then
    
        seven_seg <= "00000000";
    
    elsif (combination = "10") then
    
        seven_seg <= "00000000";
        
    else
    
        seven_seg <= "00000000";
        
    end if;

end process;
end Behavioral;
