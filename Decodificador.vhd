----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:11:43 12/14/2014 
-- Design Name: 
-- Module Name:    Decodificador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decodificador is
    Port ( CODE : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           LED  : out  STD_LOGIC_VECTOR(6 DOWNTO 0)
			  );
end Decodificador;

architecture Dataflow of Decodificador is

begin
WITH CODE SELECT		
	LED <= "0111111" WHEN "0000",
			 "0000110" WHEN "0001",
			 "1011011" WHEN "0010",
			 "1001111" WHEN "0011",
			 "1100110" WHEN "0100",
			 "1101101" WHEN "0101",
			 "1111101" WHEN "0110",
			 "0000111" WHEN "0111",
			 "1111111" WHEN "1000",
			 "1100111" WHEN "1001",
			 "1110111" WHEN "1010",
			 "1111100" WHEN "1011",
			 "0111001" WHEN "1100",
			 "1011110" WHEN "1101",
			 "1111001" WHEN "1110",
			 "1110001" WHEN others;
end Dataflow;

