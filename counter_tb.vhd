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
--	SIGNAL	c0_tb			: STD_LOGIC;			-- Output clock
	
	SIGNAL 	clk_tb			:	STD_LOGIC := '0';
	SIGNAL	rst_tb			:	STD_LOGIC := '1';
	SIGNAL	ena_T_tb			:	STD_LOGIC := '0';
	SIGNAL	ena_tb			:	STD_LOGIC := '0';
	SIGNAL 	count_ini_tb	:	STD_LOGIC_VECTOR(7 DOWNTO 0) := "ZZZZZZZZ";
	SIGNAL	count_fin_tb	:	STD_LOGIC_VECTOR(7 DOWNTO 0) := "ZZZZZZZZ";
	SIGNAL	q_tb				:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL	int_T_tb			:	STD_LOGIC;
-------------------------------------------------------
BEGIN
	
--	PLL: ENTITY work.my_pll
--	PORT MAP (	areset	=> rst_tb,
--					inclk0	=> clk_tb,
--					c0			=> c0_tb);
	DUT: ENTITY work.counter
	PORT MAP (	clk			=> clk_tb,
					rst			=> rst_tb,
					ena_T			=> ena_T_tb,
					ena			=> ena_tb,
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
	ena_tb <= '1' AFTER 200 ns;
	rst_tb <= '0' AFTER 400 ns;
--signal_generation: PROCESS
--BEGIN
--	-- TEST VECTOR 1
--	ena_tb <= '0';
--	rst_tb <= '1';
--	WAIT FOR 200 ns;
--	
--	-- TEST VECTOR 2
--	ena_tb <= '1';
--	rst_tb <= '0';
--	WAIT FOR 11 us;
--	
--	-- TEST VECTOR 3
--	ena_tb <= '0';
--	rst_tb <= '1';
--	WAIT FOR 200 ns;
--
--	-- TEST VECTOR 4
--	ena_tb <= '1';
--	rst_tb <= '0';
--	WAIT FOR 11 us;
--	
--	-- TEST VECTOR 5
--	ena_tb <= '0';
--	rst_tb <= '1';
--	WAIT FOR 200 ns;
--
--	-- TEST VECTOR 6
--	ena_tb <= '1';
--	rst_tb <= '0';
--	WAIT FOR 11 us;
--END PROCESS;
END ARCHITECTURE testbench;