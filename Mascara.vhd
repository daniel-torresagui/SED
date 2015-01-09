----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:12:35 01/09/2015 
-- Design Name: 
-- Module Name:    Mascara - Behavioral 
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

entity Mascara is
	Port (
		Display : in  STD_LOGIC_VECTOR(15 downto 0);
      CLK : in  STD_LOGIC;
      Output : out  STD_LOGIC_VECTOR(6 downto 0);
      Display_Select : out  STD_LOGIC_VECTOR(3 downto 0));
end Mascara;

architecture Behavioral of Mascara is
-- Creamos una señal para alternarla cada pulso de reloj
signal s: STD_LOGIC:='0';

begin
process(CLK)
		begin
		if  CLK = '1' and CLK'event then
			s <= not s;
		end if;
	end process;
-- Cada pulso de reloj iremos cambiando el numero a mortrar y el display en el que queremos mostrar dicho numero	
	with S select
		OUTPUT <= Display(7 downto 1)		when '0',
					 Display(15 downto 9)		when '1';
	with S select
		display_Select <= "1110" when '0',
								"1101" when '1';	
end Behavioral;

