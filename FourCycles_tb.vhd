-- FourCycles testbench
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY FourCycles_tb IS
END ENTITY FourCycles_tb;
-------------------------------------------------------
ARCHITECTURE testbench OF FourCycles_tb IS
	SIGNAL clk_FSM_tb	:	STD_LOGIC := '0';
	SIGNAL rst_FSM_tb	:	STD_LOGIC := '1';
	SIGNAL intA_FSM_tb	:	STD_LOGIC := '0';
	SIGNAL intB_FSM_tb	:	STD_LOGIC;
-------------------------------------------------------
BEGIN
	DUT: ENTITY work.FourCycles
	PORT MAP(clk_FSM => clk_FSM_tb,	
				rst_FSM => rst_FSM_tb,	
				intA_FSM => intA_FSM_tb,	
				intB_FSM => intB_FSM_tb);
	
	-- CLOCK GENERATION
	clk_FSM_tb <= NOT(clk_FSM_tb) AFTER 20 ns;
	
	-- TEST VECTORS	
	rst_FSM_tb	 <= '0' AFTER 200 ns;
	intA_FSM_tb  <= '1' AFTER 800 ns,
						 '0' AFTER 840 ns,
						 '1' AFTER 1 us;

END ARCHITECTURE testbench;