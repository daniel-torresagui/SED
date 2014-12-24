----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:12:48 12/16/2014 
-- Design Name: 
-- Module Name:    Adaptador_entrada - Behavioral 
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

entity Adaptador_entrada is
    Port ( PRE_CARGA_I : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
			  UP : in STD_LOGIC;
			  Down : in STD_LOGIC;
			  CLK : in STD_LOGIC;
           PRE_CARGA_O : out  STD_LOGIC_VECTOR(7 DOWNTO 0)
			  );
end Adaptador_entrada;

architecture Behavioral of Adaptador_entrada is
signal Y: std_Logic_vector:="00000000";
begin
	process(clk)
		begin
		if PRE_CARGA_I > "00111111" then
			if UP='1' then
			Y <= "00000000";
			elsif DOWN='1' then
			y <= "00111111";
			end if;
		else Y <= PRE_CARGA_I;
		END if;
	end process;
	
PRE_CARGA_O <= Y;

end Behavioral;

