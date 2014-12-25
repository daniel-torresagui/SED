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
 
ENTITY Contador_4b_tb IS
END Contador_4b_tb;
 
ARCHITECTURE behavior OF Contador_4b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Contador_4b
    PORT(
         UP     : IN  std_logic;
         DOWN   : IN  std_logic;
         CLK    : IN  std_logic;
         LOAD   : IN  std_logic;
         CARGA  : IN  std_logic_vector(3 downto 0);
         RESET  : IN  std_logic;
			TRIGGER: IN std_logic;
         OUTPUT : OUT  std_logic_vector(3 downto 0);
         Q      : OUT  std_logic;
         Q_N    : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal UP     : std_logic := '0';
   signal DOWN   : std_logic := '0';
   signal CLK    : std_logic := '0';
   signal LOAD   : std_logic := '0';
   signal CARGA  : std_logic_vector(3 donwto 0) := "0000";
   signal RESET  : std_logic := '0';
	signal TRIGGER: std_logic := '0';

 	--Outputs
   signal OUTPUT : std_logic_vector(3 downto 0);
   signal Q      : std_logic;
   signal Q_N    : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Contador_4b PORT MAP (
          UP => UP,
          DOWN => DOWN,
          CLK => CLK,
          LOAD => LOAD,
          CARGA => CARGA,
          RESET => RESET,
			 TRIGGER => TRIGGER,
          OUTPUT => OUTPUT,
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

      wait for CLK_period*20;

      -- insert stimulus here 
		-- En primer lugar comprobamos que funciona bien el Trigger, para ello iniciamo la cuenta ascendente
		-- mientras el trigger está a cero
		UP <='1';
		Wait for 30 ns;
		-- Observamos que hace bien la cuenta ascendente
		TRIGGER<='1';
		Wait for 200ns;
		-- Observamos que hace bien la cuenta descendente
		Up <='0';
		Down <= '1';
		Wait for 50ns;
		-- Ponemos a prueba el reset y la carga. En este momento se deberia detener la cuenta, reiniciarse a cero
		-- y aunque tenemos una carga, no ponerse hasta que no activemos load
		TRIGGER<='0';
		Down <= '0';
		Reset <='1';
		CARGA <= "1111";
		Wait for 50ns;
		Reset <= '0';
		-- Esperamos después de quitar el reset para asegurarnos de que el contador no cuenta
		Wait for 20ns;
		Load <= '1';
		-- Comprobamos que todo esta bien dejando descender el contador
		Wait for 50ns;
		Load <= '0';
		Down <= '1';
		Wait for 200ns;
		assert false
			report "Fin de la simulación..."
			severity failure;

   end process;

END;
