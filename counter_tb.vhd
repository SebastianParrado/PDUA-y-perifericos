-- Timer_IOM testbench
-- Autores: Sebastián Parrado
--				Jelitza Varón
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY counter_tb IS 
END ENTITY counter_tb;
-------------------------------------------------------
ARCHITECTURE testbench OF counter_tb IS	
	SIGNAL 	clk_tb			:	STD_LOGIC := '0';
	SIGNAL	rst_tb			:	STD_LOGIC := '1';
	SIGNAL	ena_T_tb			:	STD_LOGIC := '0';

	SIGNAL 	count_ini_tb	:	STD_LOGIC_VECTOR(7 DOWNTO 0) := "ZZZZZZZZ";
	SIGNAL	count_fin_tb	:	STD_LOGIC_VECTOR(7 DOWNTO 0) := "ZZZZZZZZ";
	SIGNAL	q_tb				:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL	int_T_tb			:	STD_LOGIC;
-------------------------------------------------------
BEGIN
	DUT: ENTITY work.counter
	PORT MAP (	clk			=> clk_tb,
					rst			=> rst_tb,
					ena_T			=> ena_T_tb,
--					ena			=> ena_tb,
					count_ini	=> count_ini_tb,
					count_fin	=> count_fin_tb,
					q				=>	q_tb,
					int_T			=> int_T_tb);
	-- CLOCK GENERATION
	clk_tb <= NOT(clk_tb) AFTER 20 ns;
	
	-- TEST VECTORS
--	count_ini_tb <= "XXXXXXXX" AFTER 200 ns,
--						 "ZZZZZZZZ" AFTER 11 us,
--						 "UUUUUUUU" AFTER 22 us,
--						 "00010010"	AFTER 33 us;
--						 
--	count_fin_tb <= "10101100" AFTER 200 ns,
--						 "00110100" AFTER 11 us,
--						 "11111111" AFTER 22 us,
--						 "11111111" AFTER 33 us;
	count_ini_tb <= "00001010" AFTER 200 ns;
	count_fin_tb <= "01101000" AFTER 200 ns;
	ena_T_tb <= '1' AFTER 200 ns;
	rst_tb <= '0' AFTER 400 ns;
END ARCHITECTURE testbench;
