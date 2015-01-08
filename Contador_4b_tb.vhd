--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:03 12/04/2014
-- Design Name:   
-- Module Name:   C:/Users/sed/Desktop/Contador_Hexadecimal_8/Contador_4b_tb.vhd
-- Project Name:  Contador_Hexadecimal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Contador_4b
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
 
ENTITY Contador_4b_tb IS
END Contador_4b_tb;
 
ARCHITECTURE behavior OF Contador_4b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Contador_4b
    PORT(
         UP : IN  std_logic;
         DOWN : IN  std_logic;
         CLK : IN  std_logic;
         LOAD : IN  std_logic;
         A0 : IN  std_logic;
         A1 : IN  std_logic;
         A2 : IN  std_logic;
         A3 : IN  std_logic;
         RESET : IN  std_logic;
			TRIGGER: IN std_logic;
         B0 : OUT  std_logic;
         B1 : OUT  std_logic;
         B2 : OUT  std_logic;
         B3 : OUT  std_logic;
         Q : OUT  std_logic;
         Q_N : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal UP : std_logic := '0';
   signal DOWN : std_logic := '0';
   signal CLK : std_logic := '0';
   signal LOAD : std_logic := '0';
   signal A0 : std_logic := '0';
   signal A1 : std_logic := '0';
   signal A2 : std_logic := '0';
   signal A3 : std_logic := '0';
   signal RESET : std_logic := '0';
	signal TRIGGER: std_logic := '0';

 	--Outputs
   signal B0 : std_logic;
   signal B1 : std_logic;
   signal B2 : std_logic;
   signal B3 : std_logic;
   signal Q : std_logic;
   signal Q_N : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Contador_4b PORT MAP (
          UP => UP,
          DOWN => DOWN,
          CLK => CLK,
          LOAD => LOAD,
          A0 => A0,
          A1 => A1,
          A2 => A2,
          A3 => A3,
          RESET => RESET,
			 TRIGGER => TRIGGER,
          B0 => B0,
          B1 => B1,
          B2 => B2,
          B3 => B3,
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
		Reset <= '1';
      wait for 10 ns;	
		Reset <= '0';

      wait for CLK_period*20;

      -- insert stimulus here 
		UP <='1';
		Wait for 30 ns;
		TRIGGER<='1';
		Wait for 200ns;
		Up <='0';
		Down <= '1';
		Wait for 50ns;
		TRIGGER<='0';
		Down <= '0';
		Reset <='1';
		A0 <= '1';
		A1 <= '1';
		A2 <= '1';
		A3 <= '1';
		Wait for 50ns;
		Reset <= '0';
		Wait for 20ns;
		Load <= '1';
		Wait for 50ns;
		Load <= '0';
		Down <= '1';
		Wait for 200ns;
		assert false
			report "Fin de la simulación..."
			severity failure;

   end process;

END;
