-- multiplicador_IOM testebench
-- Autores: Sebastián Parrado
--				Jelitza Varón
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-------------------------------------------------------
ENTITY multiplicador_IOM_tb IS
	GENERIC ( N		:	INTEGER	:= 8);
END ENTITY multiplicador_IOM_tb;
-------------------------------------------------------
ARCHITECTURE testbench OF multiplicador_IOM_tb IS
	SIGNAL clk_M_tb	:  STD_LOGIC	:=	'0';
	SIGNAL rst_M_tb	:	STD_LOGIC	:= '1';
	SIGNAL ena_M_tb	:	STD_LOGIC	:= '0';
	SIGNAL A_M_tb    	:  STD_LOGIC_VECTOR(N-1 DOWNTO 0)	:="00000111";
	SIGNAL B_M_tb		:  STD_LOGIC_VECTOR(N-1 DOWNTO 0)	:="00011100";
	SIGNAL product_out_M_tb	:  STD_LOGIC_VECTOR((2*N)-1 DOWNTO 0);
	SIGNAL int_M_tb	:	STD_LOGIC;
-------------------------------------------------------
BEGIN
	DUT: ENTITY work.multiplicador_IOM
	PORT MAP(clk_M		=> clk_M_tb,
				rst_M		=>	rst_M_tb,
				ena_M		=> ena_M_tb,
				A_M		=> A_M_tb,
				B_M		=> B_M_tb,
				product_out_M	=>	product_out_M_tb);
	
	-- CLOCK GENERATION
	clk_M_tb <= NOT(clk_M_tb) AFTER 20 ns;
	
	-- TEST VECTORS	
	rst_M_tb	 <= '0'	AFTER 400 ns;
	ena_M_tb		<= '1' AFTER 200 ns;
	
--	A_M_tb	 <= 	"00000111" AFTER 200 ns,
--						"00000100" AFTER 1200 ns,
--						"01010000" AFTER 2400 ns;
--				 
--	B_M_tb	 <= 	"00011100" AFTER 200 ns,
--						"00000100" AFTER 1200 ns,
--						"11010000" AFTER 2400 ns;
END ARCHITECTURE;