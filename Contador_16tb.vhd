--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:12:11 12/02/2014
-- Design Name:   
-- Module Name:   C:/Users/daniel/Dropbox/Universidad/Semestre 7/Sis. digitales/laboratorio/Contador_Hexadecimal/Contador_16tb.vhd
-- Project Name:  Contador_Hexadecimal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Contador_8b
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
 
ENTITY Contador_8b_tb IS
END Contador_8b_tb;
 
ARCHITECTURE behavioral OF Contador_8b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Contador_8b
    PORT(
         CLK : IN  std_logic;
         ENABLE : IN  std_logic;
         UP : IN  std_logic;
         DOWN : IN  std_logic;
         LOAD : IN  std_logic;
         RESET : IN  std_logic;
         OVF : OUT  std_logic;
         PRE_CARGA : IN  std_logic_vector(7 downto 0);
         B : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal ENABLE : std_logic := '0';
   signal UP : std_logic := '0';
   signal DOWN : std_logic := '0';
   signal LOAD : std_logic := '0';
   signal RESET : std_logic := '0';
   signal PRE_CARGA : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal OVF : std_logic;
   signal B : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Contador_8b PORT MAP (
          CLK => CLK,
          ENABLE => ENABLE,
          UP => UP,
          DOWN => DOWN,
          LOAD => LOAD,
          RESET => RESET,
          OVF => OVF,
          PRE_CARGA => PRE_CARGA,
          B => B
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
		RESET <= '1';
      wait for CLK_period*3;	
		RESET <= '0';
		--DOWN <= '1';
      wait for CLK_period*10;
		--DOWN <= '0';
      -- insert stimulus here 
		-- ENABLE
		UP <= '1';
		wait for 5 ns;
		UP <= '0';
		wait for CLK_period;
		ENABLE <= '1';
		-- CUENTA ASCENDENTE
		wait for CLK_period*3;
		-- Cuenta ascedente Cambio segundo digito
		PRE_CARGA <= "00001110";
		LOAD <= '1';
		wait for CLK_period;
		LOAD <= '0';
		wait for CLK_period*3;
		-- Cuenta ascendente limite
		PRE_CARGA <= "00101110";
		LOAD <= '1';
		wait for CLK_period;
		LOAD <= '0';
		wait for CLK_period*3;
		-- Se deberia haber activado el OVF Y PASADO AL 00, lo quitamos
		RESET <= '1';
		WAIT FOR CLK_period;
		RESET <= '0';
		-- CUENTA DESCENDENTE
		DOWN <= '1';
		LOAD <= '1';
		WAIT FOR CLK_period;
		LOAD <= '0';
		WAIT FOR CLK_period*3;
		-- CAMBIO DE DIGITO DESCENDENTE
		PRE_CARGA <= "00010001";
		LOAD <= '1';
		WAIT FOR CLK_period;
		LOAD <= '0';
		WAIT FOR CLK_period*3;
		-- LIMITE INFERIOR
		PRE_CARGA <= "00000001";
		LOAD <= '1';
		WAIT FOR CLK_period;
		LOAD <= '0';
		WAIT FOR CLK_period*5;
		-- SE DEBERÍA HABER ACTIVADO EL OVF Y PASADO AL 2F, LO QUITAMOS
		RESET <= '1';
		WAIT FOR CLK_period;
		RESET <= '0';
		-- PRECARGA FALSA
		PRE_CARGA <= "01110000";
		LOAD <= '1';
		WAIT FOR CLK_period;
		LOAD <= '0';
		WAIT FOR CLK_period*7;
		
		assert false
			report "Fin de la simulacion"
			severity failure;
			
   end process;

END behavioral;
