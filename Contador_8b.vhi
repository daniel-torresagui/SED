
-- VHDL Instantiation Created from source file Contador_8b.vhd -- 12:21:16 12/15/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Contador_8b
	PORT(
		CLK : IN std_logic;
		ENABLE : IN std_logic;
		UP : IN std_logic;
		DOWN : IN std_logic;
		LOAD : IN std_logic;
		RESET : IN std_logic;
		A : IN std_logic_vector(7 downto 0);          
		OVF : OUT std_logic;
		B : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_Contador_8b: Contador_8b PORT MAP(
		CLK => ,
		ENABLE => ,
		UP => ,
		DOWN => ,
		LOAD => ,
		RESET => ,
		OVF => ,
		A => ,
		B => 
	);


