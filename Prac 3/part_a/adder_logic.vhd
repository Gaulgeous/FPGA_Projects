----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.08.2023 10:00:03
-- Design Name: 
-- Module Name: adder_logic - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_logic is
    Port ( register_a : in STD_LOGIC_VECTOR (15 downto 0);
           register_b : in STD_LOGIC_VECTOR (15 downto 0);
           sat_en : in std_logic;
           result : out STD_LOGIC_VECTOR (15 downto 0);
           zero : out std_logic;
           negative : out std_logic;
           carry_out : out std_logic;
           overflow : out std_logic
           );
end adder_logic;

architecture Behavioral of adder_logic is

signal zero_line: std_logic;
signal negative_line: std_logic;
signal overflow_line: std_logic;

begin

process(register_a, register_b)
variable sum_line : std_logic_vector(15 downto 0);
variable carry_line : std_logic_vector(16 downto 0);
variable sat_line : std_logic;
begin

    sum_line := "0000000000000000";
    carry_line := "00000000000000000";

    for i in 0 to 15 loop
        
        sum_line(i) := (register_a(i) XOR register_b(i)) XOR carry_line(i);
        carry_line(i+1) := (register_a(i) AND register_b(i)) OR
                           ((register_a(i) XOR register_b(i)) AND carry_line(i));
     
    
    end loop;
    
    if (sat_en = '1') then
        
        overflow <= (carry_line(15) XOR carry_line(16)); -- Check for overflow
        
        if ((carry_line(15) XOR carry_line(16)) = '1') then
            
            if register_a(15) = '0' then 
                result <= "0111111111111111";
                negative <= '0';
            else
                result <= "1000000000000000";
                negative <= '1';
            end if;
        
        else 
        
            result <= sum_line;
            negative <= sum_line(15);
        
        end if;
        
        carry_out <= carry_line(16);
        
        if (sum_line = "0000000000000000") then
            zero <= '1';
        else
            zero <= '0';
        end if;
        
    else
    
        result <= sum_line;
        carry_out <= carry_line(16);
        negative <= '0';
        zero <= '0';
        overflow <= '0';
    
    end if;
    
end process;
end Behavioral;
