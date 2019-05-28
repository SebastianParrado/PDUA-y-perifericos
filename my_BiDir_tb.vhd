-- my_BiDir testbench
-- Autores: Sebastián Parrado
--				Jelitza Varón
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY my_BiDir_tb IS
END ENTITY my_BiDir_tb;
-------------------------------------------------------
ARCHITECTURE testbench OF my_BiDir_tb IS
	SIGNAL clk_tb			:	STD_LOGIC := '0';
	SIGNAL ena_tb 			:	STD_LOGIC := '0';
	SIGNAL A0_tb,A1_tb 	:	STD_LOGIC;
	SIGNAL B_tb 			:	STD_LOGIC;
	SIGNAL BusData_tb 	: STD_LOGIC;
-------------------------------------------------------
BEGIN 
	DUT1: ENTITY work.my_BiDir
	PORT MAP (	clk => clk_tb,
					ena => ena_tb,
					A0 => A0_tb,
					A1 => A1_tb,
					B => B_tb);
		
	-- CLOCK GENERATION
	clk_tb <= NOT(clk_tb) AFTER 20 ns;
	
-- Si ena=0, entonces B=>A1; si ena=1, entonces A0=>B 
	ena_tb <= NOT(ena_tb) AFTER 400 ns;
	B_tb <= '1' AFTER 600 ns;
	
	signal_generation: PROCESS
	BEGIN
		-- TEST VECTOR 1
		A0_tb <= 'Z';
		--B_tb  <= '1';
		WAIT FOR 400 ns;
		
		-- TEST VECTOR 2
		A0_tb <= '1';
		--B_tb <= '0';
		WAIT FOR 400 ns;
		
		-- TEST VECTOR 3
		A0_tb <= '1';
		--B_tb  <= '0';
		WAIT FOR 400 ns;

		-- TEST VECTOR 4
		A0_tb <= '0';
		--B_tb  <= '1';
		WAIT FOR 400 ns;
	END PROCESS signal_generation;
END ARCHITECTURE testbench;