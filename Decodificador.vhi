
-- VHDL Instantiation Created from source file Decodificador.vhd -- 12:22:30 12/15/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Decodificador
	PORT(
		CODE : IN std_logic_vector(3 downto 0);          
		LED : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	Inst_Decodificador: Decodificador PORT MAP(
		CODE => ,
		LED => 
	);


