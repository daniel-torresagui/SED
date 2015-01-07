--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:44:18 12/04/2014
-- Design Name:   
-- Module Name:   C:/Users/sed/Desktop/Contador_Hexadecimal_8/AND3_tb.vhd
-- Project Name:  Contador_Hexadecimal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AND3
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
 
ENTITY AND3_tb IS
END AND3_tb;
 
ARCHITECTURE behavior OF AND3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AND3
    PORT(
         I0 : IN  std_logic;
         I1 : IN  std_logic;
         I2 : IN  std_logic;
         O : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal I0 : std_logic := '0';
   signal I1 : std_logic := '0';
   signal I2 : std_logic := '0';

 	--Outputs
   signal O : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AND3 PORT MAP (
          I0 => I0,
          I1 => I1,
          I2 => I2,
          O => O
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


      -- insert stimulus here 
		I0 <= '0';
		I1 <= '0';
		I2 <= '0';
		Wait for 50 ns;
		I0 <= '1';
		I1 <= '0';
		I2 <= '0';
		Wait for 50 ns;
		I0 <= '0';
		I1 <= '1';
		I2 <= '0';
		Wait for 50 ns;
		I0 <= '1';
		I1 <= '1';
		I2 <= '0';
		Wait for 50 ns;
		I0 <= '0';
		I1 <= '0';
		I2 <= '1';
		Wait for 50 ns;
		I0 <= '1';
		I1 <= '0';
		I2 <= '1';
		Wait for 50 ns;
		I0 <= '0';
		I1 <= '1';
		I2 <= '1';
		Wait for 50 ns;
		I0 <= '1';
		I1 <= '1';
		I2 <= '1';
		Wait for 50 ns;
		assert false
			report "Fin de la simulación..."
			severity failure;

   end process;

END;
