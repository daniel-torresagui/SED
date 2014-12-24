----------------------------------------------------------------------------------
-- Company: ETSIDI
-- Engineer: Daniel Torres Aguilar 
--				 Guillermo Serrano Martinez
--				 Miguel Urias Martinez
-- 
-- Create Date:    12:19:39 11/23/2014 
-- Design Name: 	 Contador con conversor a 7 segmentos
-- Module Name:    Contador de 4 bits hexadecimal
-- Project Name:   Contador_Hexadecimal
-- Target Devices: Spartan-3
-- Tool versions:  
-- Description:    Contador síncrono Hexadecimal de 0 hasta F, ascendente o descendente
--						 con reset y carga asíncrona y entrada Enable. Se considera 
--						 overflow el reinicio de la cuenta.
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

entity Contador_4b is
    Port ( UP 	  : in  STD_LOGIC;
           DOWN  : in  STD_LOGIC;
           CLK   : in  STD_LOGIC;
           LOAD  : in  STD_LOGIC;
           CARGA : in  STD_LOGIC_VECTOR(3 downto 0);
           RESET : in  STD_LOGIC;
			  TRIGGER:in  STD_LOGIC;
           OUTPUT: out  STD_LOGIC_VECTOR(3 downto 0);
           Q	  : out  STD_LOGIC;
			  Q_N	  : out STD_LOGIC);
end Contador_4b;

architecture Structural of Contador_4b is
	
	component FFJK
		port(
			J : in  STD_LOGIC;
         K : in  STD_LOGIC;
         CLK : in  STD_LOGIC;
         LOAD : in  STD_LOGIC;
         RESET : in  STD_LOGIC;
         PRE_CARGA : in  STD_LOGIC;
         Q : out  STD_LOGIC;
         Q_N : out  STD_LOGIC
		);
	end component;
	
	component AND2
		port(
			I0 : in  STD_LOGIC;
         I1 : in  STD_LOGIC;
         O : out  STD_LOGIC
		);
	end component;
	
	component OR2
		Port ( 
			I0 : in  STD_LOGIC;
         I1 : in  STD_LOGIC;
         O : out  STD_LOGIC
		);
	end component;
	
	component INV
		Port ( 
			I : in  STD_LOGIC;
         O : out  STD_LOGIC
		);
	end component;
	
	signal UP_N,UND,C1,C2,C3,CN1,CN2,CN3: STD_LOGIC;
	signal Entradas           : STD_LOGIC_VECTOR(3 downto 0);
	signal Salidas,Salidas_N  : STD_LOGIC_VECTOR(3 downto 0);
	signal Ascenso,Descenso   : STD_LOGIC_VECTOR(3 downto 0);
	
begin
	-- El Contador consta principalmente de cuatro FLIP-FLOP's tipo D.
	
	-- Comenzamos con el circuito de control de ascensión, para ello se utiliza la señal UP.
	-- La señal UP esta ligada a que la señal de funcionamiento TRIGGER este activado.
	-- El resultado es la señal Ascenso que es la que utilizaremos y que nos da el circuito de control
	UP_AND_TRIGGER        : AND2 port map(UP,TRIGGER,Ascenso(0));
	
	-- Continuamos con la señal de descenso, la cual solo funcionará cuando UP esté desactivado
	UP_NEGADO             : INV  port map(UP,UP_N);
	UP_NEGADO_AND_DOWN    : AND2 port map(UP_N,DOWN,UND);
	
		-- La señal de Descenso igual que en el caso anterior esta ligada a TRIGGER
		FILTRO_TRIGGER     : AND2 port map(UND,TRIGGER,Descenso(0));
		
	-- Continuamos con los FLIP-FLOP's
	-- ·PRIMER FLIP - FLOP
		-- Señal entrada T0
		SEÑAL_DE_ENTRADA_0 : OR2  port map(Ascenso(0),Descenso(0),Entradas(0));
		-- Instanciación
		FLIP_FLOP_0        : FFJK port map(Entradas(0),Entradas(0),CLK,LOAD,RESET,CARGA(0),Salidas(0),Salidas_N(0));
		
	-- ·SEGUNDO FLIP - FLOP
	   -- Señal de entrada
		DOWN_1             : AND2 port map(Descenso(0),Salidas_N(0),Descenso(1));
	   UP_1               : AND2 port map(Ascenso(0),Salidas(0),Ascenso(1));
	   SEÑAL_DE_ENTRADA_1 : OR2  port map(Ascenso(1),Descenso(1),Entradas(1));
		-- Instanciacion
		FLIP_FLOP_1        : FFJK port map(Entradas(1),Entradas(1),CLK,LOAD,RESET,CARGA(1),Salidas(1),Salidas_N(1));
		
	-- ·TERCER FLIP - FLOP
		-- Señal de entrada
		DOWN_2             : AND2 port map(Descenso(1),Salidas_N(1),Descenso(2));
		UP_2               : AND2 port map(Ascenso(1),Salidas(1),Ascenso(2));
		SEÑAL_DE_ENTRADA_2 : OR2  port map(Ascenso(2),Descenso(2),Entradas(2));
		-- Instanciacion
		FLIP_FLOP_2        : FFJK port map(Entradas(2),Entradas(2),CLK,LOAD,RESET,CARGA(2),Salidas(2),Salidas_N(2));
		
	-- ·CUARTO FLIP - FLOP
		-- Señal de entrada
		DOWN_3				 : AND2 port map(Descenso(2),Salidas_N(2),Descenso(3));
		UP_3               : AND2 port map(Ascenso(2),Salidas(2),Ascenso(3));
		SEÑAL_DE_ENTRADA_3 : OR2  port map(Ascenso(3),Descenso(3),Entradas(3));
		-- Instanciación
		FLIP_FLOP_3        : FFJK port map(Entradas(3),Entradas(3),CLK,LOAD,RESET,CARGA(3),Salidas(3),Salidas_N(3));
		
	-- Deteccion de F
	FF0_FF1_F             : AND2 port map(Salidas(0),Salidas(1),C1);
	FF2_FF3_F             : AND2 port map(Salidas(2),Salidas(3),C2);
	DETECTION_OF_F        : AND2 port map(C1,C2,C3);
	
	-- Deteccion de 0
	FF0_FF1_0             : AND2 port map(Salidas_N(0),Salidas_N(1),CN1);
	FF2_FF3_0             : AND2 port map(Salidas_N(2),Salidas_N(3),CN2);
	DETECTION_OF_0        : AND2 port map(CN1,CN2,CN3);
	
	-- Asignaciones
	OUTPUT	<= Salidas;
	Q  		<= C3;
	Q_N		<= CN3;
	
end Structural;