----------------------------------------------------------------------------------
-- Company: ETSIDI
-- Engineer: Daniel Torres Aguilar 
--				 Guillermo Serrano Martinez
--				 Miguel Urias Martinez
-- 
-- Create Date:    12:19:39 11/23/2014 
-- Design Name: 	 Contador con conversor a 7 segmentos
-- Module Name:    Adaptador_entrada
-- Project Name:   Contador_Hexadecimal
-- Target Devices: Spartan-3
-- Tool versions:  
-- Description:    Debido a que nuestros contadores de 4 bits pueden contar de 0 a F y 
--						 nosotros queremos que el contador de 8 bits cuente de 00 a 2F. Este 
--						 adaptador hace de "filtro", para proteger al contador de una mala praxis
--						 por parte del cliente, de forma que una vez superado el rango (00 - 2F)
--						 el adaptador reinicia la cuenta a 00 en caso de que estemos en modo 
--						 ascendente o a 2F en caso de que estemos en modo descendente, para 
--						 evitar el overflow.
-- Dependencies:   
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adaptador_entrada is
    Port ( INPUT : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
			  UP : in STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR(7 DOWNTO 0)
			  );
end Adaptador_entrada;

architecture Dataflow OF Adaptador_entrada is
CONSTANT MAX_COUNT : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00101111";
SIGNAL AUX : STD_LOGIC_VECTOR(1 DOWNTO 0):="00";
begin

AUX(1) <= '1' WHEN INPUT > MAX_COUNT ELSE
          '0' WHEN INPUT <= MAX_COUNT;
AUX(0) <= UP;
	with AUX select
		OUTPUT <= INPUT		when "01",
					 INPUT			when "00",
					 MAX_COUNT		when "10",
					 "00000000"	   when "11";		
			 
end Dataflow;
