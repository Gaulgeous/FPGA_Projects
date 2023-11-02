--------------------------------------------
-- Approximate Adder - 6
-- Multibit Adder
-- Author: Bharath Srinivas Prabakaran, Muhammad Shafique  
--------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;
entity Multibit is
	generic(bitWidth : integer := 16; approxBits : integer :=  0);
  	port (
  		A: in std_logic_vector(bitWidth-1 downto 0);
		B: in std_logic_vector(bitWidth-1 downto 0);
--		C_in: in std_logic;
--		C_out: out std_logic;
		Sum: out std_logic_vector(bitWidth-1 downto 0)
  	);
end entity ;

architecture arch of Multibit is

component AA6 is
port(
	A : in std_logic_vector(1 downto 0);
	B : in std_logic_vector(1 downto 0);
	C_in : in std_logic;
	C_out : out std_logic;
	Sum : out std_logic_vector(1 downto 0)
	);
end component;

component AdderAccurateOneBit is
port (
	A : in std_logic;
	B : in std_logic;
	Cin : in std_logic;
	Sum : out std_logic;
	Cout : out std_logic 
	);
end component;

signal carry_internal: std_logic_vector(bitWidth downto 0);

begin

carry_internal(0) <= '0';
approx: for i in 0 to approxBits-1 generate
smoop: if i rem 2 = 0 generate
approxInstances: AA6
    port map (
        A  => A(i+1 downto i),
        B  => B(i+1 downto i),
        C_in => carry_internal(i),
        C_out => carry_internal(i+2),
		Sum => Sum(i+1 downto i)
    );
end generate smoop;
end generate approx;
--carry_internal(approxBits) <= A(approxBits-1);

accurate: for i in approxBits to bitWidth-1 generate
accurateInstances: AdderAccurateOneBit
    port map (
        A  => A(i),
        B  => B(i),
		Sum => Sum(i),
        Cin => carry_internal(i),
        Cout => carry_internal(i+1)
    );
end generate;
--C_out <= carry_internal(bitWidth);

end architecture ;