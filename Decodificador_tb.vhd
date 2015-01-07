--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:05:44 12/14/2014
-- Design Name:   
-- Module Name:   C:/Users/daniel/Desktop/Contador_Hexadecimal_8/Decodificador_tb.vhd
-- Project Name:  Contador_Hexadecimal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decodificador
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY Decodificador_TB IS
END Decodificador_TB;
 
ARCHITECTURE behavior OF Decodificador_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decodificador
    PORT(
         code : IN  std_logic_vector(3 downto 0);
         led : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal code : std_logic_vector(3 downto 0) := (others => '0');
   signal led : std_logic_vector(6 downto 0) := (others => '0');
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	TYPE vtest is record
			code : std_logic_vector(3 DOWNTO 0);
			led : std_logic_vector(6 DOWNTO 0);
	END RECORD;
	
	TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
 
	CONSTANT test: vtest_vector := (
(code => "0000", led => "0111111"),
(code => "0001", led => "0000110"),
(code => "0010", led => "1011011"),
(code => "0011", led => "1001111"),
(code => "0100", led => "1100110"),
(code => "0101", led => "1101101"),
(code => "0110", led => "1111101"),
(code => "0111", led => "0000111"),
(code => "1000", led => "1111111"),
(code => "1001", led => "1100111"),
(code => "1010", led => "1110111"),
(code => "1011", led => "1111100"),
(code => "1100", led => "0111001"),
(code => "1101", led => "1011110"),
(code => "1110", led => "1111001"),
(code => "1111", led => "1110001")
);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decodificador PORT MAP (
          code => code,
          led => led
        );
	tb: PROCESS
	
	BEGIN
		FOR i IN 0 TO test'HIGH LOOP
			code <= test(i).code;
			WAIT FOR 20 ns;
			ASSERT led = test(i).led
				REPORT "Salida incorrecta."
				SEVERITY FAILURE;
		END LOOP;
	
		ASSERT false
			REPORT "Simulación finalizada. Test superado."
			SEVERITY FAILURE;
	END PROCESS;
	
END;
    