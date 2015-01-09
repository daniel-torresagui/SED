----------------------------------------------------------------------------------
-- Company: ETSIDI
-- Engineer: Daniel Torres Aguilar 
--				 Guillermo Serrano Martinez
--				 Miguel Urias Martinez
-- 
-- Create Date:    12:19:39 11/23/2014 
-- Design Name: 	 Contador con conversor a 7 segmentos
-- Module Name:    Decodificador_A_7segemenos
-- Project Name:   Contador_Hexadecimal
-- Target Devices: Spartan-3
-- Tool versions:  
-- Description:    Este conversor convierte la señal proveniente de los contadores
--						 de 4 bits (0 - F) en la señal deseada para cada caso en los displays
-- Dependencies:   
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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