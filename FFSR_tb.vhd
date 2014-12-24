--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:18:47 12/04/2014
-- Design Name:   
-- Module Name:   C:/Users/sed/Desktop/Contador_Hexadecimal_8/FFSR_tb.vhd
-- Project Name:  Contador_Hexadecimal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FFSR
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FFSR_tb IS
END FFSR_tb;
 
ARCHITECTURE behavior OF FFSR_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FFSR
    PORT(
         S : IN  std_logic;
         R : IN  std_logic;
         CLK : IN  std_logic;
         Q : OUT  std_logic;
         Q_N : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic := '0';
   signal R : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal Q_N : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FFSR PORT MAP (
          S => S,
          R => R,
          CLK => CLK,
          Q => Q,
          Q_N => Q_N
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

     Wait for 100ns;
		S <='1';
		R <='0';
		Wait for 100ns;
		S <='0';
		R <='1';
		Wait for 100ns;
		S <='1';
		R <='1';
		Wait for 100ns;
		S <='0';
		R <='0';
		Wait for 100ns;
		assert false
			report "Fin de la simulación..."
			severity failure;

   end process;

END;
