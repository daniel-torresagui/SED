--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:27:58 12/16/2014
-- Design Name:   
-- Module Name:   F:/jodido_guille/Adaptador_entrada_tb.vhd
-- Project Name:  Contador_Hexadecimal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Adaptador_entrada
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
 
ENTITY Adaptador_entrada_tb IS
END Adaptador_entrada_tb;
 
ARCHITECTURE behavior OF Adaptador_entrada_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adaptador_entrada
    PORT(
         PRE_CARGA_I : IN  std_logic_vector(7 downto 0);
         UP : IN  std_logic;
         Down : IN  std_logic;
         CLK : IN  std_logic;
         PRE_CARGA_O : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PRE_CARGA_I : std_logic_vector(7 downto 0) := (others => '0');
   signal UP : std_logic := '0';
   signal Down : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal PRE_CARGA_O : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adaptador_entrada PORT MAP (
          PRE_CARGA_I => PRE_CARGA_I,
          UP => UP,
          Down => Down,
          CLK => CLK,
          PRE_CARGA_O => PRE_CARGA_O
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
		UP <='1';
		PRE_CARGA_I <= "00010010";
		wait for 20 ns;
		PRE_CARGA_I <="10100010";
		wait for 20 ns;
		UP <= '0';
		DOWN <= '1';
		PRE_CARGA_I <= "00010111";
		wait for 20 ns;
		PRE_CARGA_I <= "11001101";
		wait for 50 ns;
		assert false
			report "Fin de la simulación..."
			severity failure;
   end process;

END;
