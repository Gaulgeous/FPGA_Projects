----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.08.2023 10:02:40
-- Design Name: 
-- Module Name: unlock - Behavioral
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

entity unlock is
    Port (
        thick_buff: in std_logic_vector(15 downto 0);
        lock: out std_logic;
        unlock_out: out std_logic
    );
end unlock;

architecture Behavioral of unlock is

begin

process(thick_buff)
begin

    if (thick_buff = "0011000100111001") then
        lock <= '0';
        unlock_out <= '1';
    else
        lock <= '1';
        unlock_out <= '0';
    end if;

end process;
end Behavioral;
