--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:00:24 01/05/2015
-- Design Name:   
-- Module Name:   C:/Users/Serrano/Desktop/SED-master/Mascara_tb.vhd
-- Project Name:  jod
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mascara
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
 
ENTITY Mascara_tb IS
END Mascara_tb;
 
ARCHITECTURE behavior OF Mascara_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mascara
    PORT(
         Display : IN  std_logic_vector(15 downto 0);
         CLK : IN  std_logic;
         Output : OUT  std_logic_vector(6 downto 0);
         Display_Select : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Display : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(6 downto 0);
   signal Display_Select : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mascara PORT MAP (
          Display => Display,
          CLK => CLK,
          Output => Output,
          Display_Select => Display_Select
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

      -- insert stimulus here 
		Display<="0000000111111110";
      Wait for 200ns;
		assert false
			report "Fin de la simulación..."
			severity failure;
   end process;

END;
