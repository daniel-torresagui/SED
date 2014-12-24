----------------------------------------------------------------------------------
-- Company: ETSIDI
-- Engineer: Daniel Torres Aguilar 
--				 Guillermo Serrano Martinez
--				 Miguel Urias Martinez
-- 
-- Create Date:    12:19:39 11/23/2014 
-- Design Name: 	 Contador con conversor a 7 segmentos
-- Module Name:    FFSR - Behavioral
-- Project Name:   Contador_Hexadecimal
-- Target Devices: Spartan-3
-- Tool versions:  
-- Description:    Flip - Flop tipo SR con entradas asíncronas de reset y carga
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

entity FFSR is
    Port ( S : in  STD_LOGIC;
           R : in  STD_LOGIC;
			  CLK:in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Q_N : out  STD_LOGIC);
end FFSR;

architecture Behavioral of FFSR is
	signal Y : STD_LOGIC:='0';
begin
	process(CLK)
		begin
		if clk = '1' and CLK'event THEN 
			if S = '1' then Y <= '1';
			elsif R = '1' then Y <= '0';
			end if;
			else Y <= Y;
		end if;
	end process;
	
	Q <= Y;
	Q_N <= NOT Y;
end Behavioral;

