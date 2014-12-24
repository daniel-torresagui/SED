----------------------------------------------------------------------------------
-- Company: ETSIDI
-- Engineer: Daniel Torres Aguilar 
--				 Guillermo Serrano Martinez
--				 Miguel Urias Martinez
-- 
-- Create Date:    12:19:39 12/15/2014 
-- Design Name: 	 Contador de 8 bits
-- Module Name:    Contador_8b - Structural 
-- Project Name:   Contador_Hexadecimal
-- Target Devices: Spartan-3
-- Tool versions:  
-- Description:    Contador síncrono Hexadecimal de 00 hasta 2F, ascendente o descendente
--						 con reset y carga asíncrona y entrada Enable. Se considera 
--						 overflow el reinicio de de la cuenta.
--
-- Dependencies:   
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: Nuestro contador es capaz de contar desde 00 hasta FF, como
--								en la práctica especifican que el contador cuente hasta 2F
--								lo hemos capado.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Contador_8b is
    Port ( 
			  CLK       : in  STD_LOGIC;
           ENABLE    : in  STD_LOGIC;
           UP        : in  STD_LOGIC;
           DOWN      : in  STD_LOGIC;
           LOAD      : in  STD_LOGIC;
           RESET     : in  STD_LOGIC;
			  PRE_CARGA : in  STD_LOGIC_VECTOR(7 downto 0);
           OVF 		: out  STD_LOGIC;
			  B   		: out  STD_LOGIC_VECTOR(7 downto 0)
			  );
end Contador_8b;

architecture STRUCTURAL of Contador_8b is

	component Contador_4b
		Port ( 
			  UP     : in  STD_LOGIC;
           DOWN   : in  STD_LOGIC;
           CLK    : in  STD_LOGIC;
           LOAD   : in  STD_LOGIC;
           CARGA  : in  STD_LOGIC_VECTOR(3 downto 0);
           RESET  : in  STD_LOGIC;
			  TRIGGER: in STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR(3 downto 0);
           Q      : out  STD_LOGIC;
			  Q_N    : out STD_LOGIC
		);
	end component;
	
	component FFJK
		port(
			J         : in  STD_LOGIC;
         K         : in  STD_LOGIC;
         CLK       : in  STD_LOGIC;
         LOAD      : in  STD_LOGIC;
         RESET     : in  STD_LOGIC;
         PRE_CARGA : in  STD_LOGIC;
         Q         : out  STD_LOGIC;
         Q_N       : out  STD_LOGIC
		);
	end component;
	
	component FFSR
		port(
			S   : in  STD_LOGIC;
         R   : in  STD_LOGIC;
         CLK : in  STD_LOGIC;
         Q   : out  STD_LOGIC;
         Q_N : out  STD_LOGIC
		);
	end component;
	
	component AND2
		port(
			I0 : in  STD_LOGIC;
         I1 : in  STD_LOGIC;
         O  : out  STD_LOGIC
		);
	end component;
	
	component AND3
		Port ( 
			I0 : in  STD_LOGIC;
         I1 : in  STD_LOGIC;
         I2 : in  STD_LOGIC;
          O : out  STD_LOGIC
		);
	end component;
	
	component OR2
		Port ( 
			I0 : in  STD_LOGIC;
         I1 : in  STD_LOGIC;
         O  : out  STD_LOGIC
		);
	end component;
	
	component INV
		Port ( 
			I : in  STD_LOGIC;
         O : out  STD_LOGIC
		);
	end component;
	
	constant high           : STD_LOGIC:='1';
	constant MAX_COUNT      : STD_LOGIC_VECTOR(7 downto 0) := "00101111";
	
	-- señales auxiliares
	signal stop,RN,up_n     : STD_LOGIC;
	
	-- entradas y salidas flip-flops
	signal S1,R1,R2,S2      : STD_LOGIC;
	signal ascenso,descenso : STD_LOGIC;
	signal error, no_error  : STD_LOGIC;
	
	-- entradas y salidas contadores 4 bits
	signal cargas           : STD_LOGIC_VECTOR(7 DOWNTO 0):= "00000000";
	signal resultado        : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
	signal salidas,salidas_n: STD_LOGIC_VECTOR(1 downto 0);
	signal overflow         : STD_LOGIC_VECTOR(2 downto 0);
	signal AUX1,AUX2,AUX3   : STD_LOGIC;
	
	-- Señal para limitar la cuenta a 2F
	signal Limit_UP         : STD_LOGIC:='0';
	signal Stopping_count   : STD_LOGIC:='0';
	signal Limit_DOWN       : STD_LOGIC:='0';
	signal Start_LOAD       : STD_LOGIC:='0';
	signal carga            : STD_LOGIC:='0'; -- Carga especial al descender de 0 a 2 
	
begin
		-- Comenzamos por el filtro de la señal de reloj, que solo pasara cuando Enable este activo, paralizando el contador
		-- en caso contrario.
		FILTRO_DE_RELOJ   : AND2 port map(CLK,ENABLE,stop);
		
		-- El ascenso y descenso se controla mediante un Flip Flop tipo SR con preferencia en el SET
		UP_NEGADO         : INV port map(UP,up_n);
		ENTRADA_RESET_A_D : AND2 port map(up_n,DOWN,R1);
		ENTRADA_SET_A_D   : S1 <= UP;
		FLIP_FLOP_A_D     : FFSR port map(S1,R1,CLK,ascenso,descenso);
		
		-- Instanciación de los contadores de 4 bits
		LOW_LEVEL         : Contador_4b port map(
										UP      => ascenso,
										DOWN    => descenso,
										CLK     => stop,
										LOAD    => carga,
										CARGA   => cargas(3 downto 0),
										RESET   => stopping_count,
										TRIGGER => HIGH,
										OUTPUT  => resultado(3 downto 0),
										Q       => salidas(0),
										Q_N     => salidas_n(0)
										);
										
			-- Obviamente los dos contadores estan relacionados y esta sinergia lo hacemos gracias al trigger
			-- lo que hacemos es condicionar el funcionamiento del segundo contador a la llegada al limite del
			-- contador anterior
			MAXIMO_ASCENSO : AND2 port map(ascenso,salidas(0),AUX1);
		   MINIMO_DESCENSO: AND2 port map(descenso,salidas_n(0),AUX2);
			TRIGGER_A2:OR2  port map(AUX1,AUX2,AUX3);
										
		HIGH_LEVEL        : Contador_4b port map(
										UP      => ascenso,
										DOWN    => descenso,
										CLK     => stop,
										LOAD    => carga,
										CARGA   => cargas(7 downto 4),
										RESET   => stopping_count,
										TRIGGER => AUX3,
										OUTPUT  => resultado(7 downto 4),
										Q       => salidas(1),
										Q_N     => salidas_n(1)
										);
										
		-- Control del overflow, se considera overflow el reinicio de la cuenta. Para ello utilizamos un flip-flop SR
		-- con prefencia en el SET
		
			-- Consideramos overflow Aumentar en 1 estando en FF
			OVERFLOW_TOP   : AND3 port map(salidas(0),salidas(1),ascenso,overflow(0));
			-- Consideramos overflow Disminuir en 1 estando en 00
			OVERFLOW_BOT   : AND3 port map(salidas_n(0),salidas_n(1),descenso,overflow(1));
			-- Salida de overflow
		   SEÑAL_OVERFLOW : OR2  port map(overflow(0),overflow(1),overflow(2));
		
			-- Damos prefencia al RESET del contador de 8 bits, para ello lo convertimos en la entrada set del flip-flop SR
			RESET_NEGADO      : INV  port map(RESET,rn);
		   ENTRADA_SET_OVF   : AND2 port map(overflow(2),rn,S2);
			ENTRADA_RESET_OVF : R2 <= RESET;
			FLIP_FLOP_OVF     : FFSR port map(S2,R2,CLK,error,no_error);
		
		--Limitacion de la señal
		-- + Limite ascendente
		 Signal_de_limitacion_Ascendente: AND2 port map (resultado(4),resultado(5),Limit_UP);
		 Entrada_de_reseteo: OR2 port map(RESET,Limit_UP,Stopping_count);
		 Stopping_count <= RESET OR LIMIT_UP;
		
		-- + Limite descendente
		SEÑAL_LIMITACION_DESCENDENTE : Limit_DOWN <= salidas_n(1);
		PROCESS(CLK)
	   BEGIN
			IF Limit_DOWN = '1' AND descenso = '1' AND CLK'EVENT AND CLK = '1' THEN cargas <= MAX_COUNT;
			ELSE
				Start_LOAD <= '0';
			END IF;
			IF cargas = MAX_COUNT THEN Start_LOAD <= '1'; END IF;
		END PROCESS;
		
		SELECTOR_PRECARGA            : OR2 port map(Start_LOAD,LOAD,CARGA);
		CARGA <= LOAD OR Start_LOAD;
		
		--Proteccion contra mal uso del contador
		PROCESS(LOAD)
		BEGIN
			IF cargas > MAX_COUNT AND LOAD'EVENT AND LOAD = '0' THEN
				IF ascenso = '1' THEN Stopping_count <= '1';        -- Poner limite Inferior 00
				ELSE			          cargas <= MAX_COUNT;			 -- Poner limite superior 2F					
				END IF;
			END IF;
		END PROCESS;
		
		-- Asignaciones
	
		cargas <= PRE_CARGA;
		B      <= resultado;
	   OVF    <= error;
	

end STRUCTURAL;