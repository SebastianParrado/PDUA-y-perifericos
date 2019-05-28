-- Conexion testebench
-- Autores: Jelitza Varón
--				Sebastián Parrado
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-------------------------------------------------------
ENTITY Conexion_tb IS
	GENERIC ( M		:	INTEGER	:= 8);
END ENTITY Conexion_tb;
-------------------------------------------------------
ARCHITECTURE testbench OF Conexion_tb IS
	-- Señales generales
	SIGNAL clk_C_tb		:  STD_LOGIC	:=	'0';
	SIGNAL rst_C_tb		:	STD_LOGIC	:= '0';
	-- Entradas y salidas de la multicacion
	SIGNAL ena_M_C_tb		:	STD_LOGIC	:= '0';
	SIGNAL A_C_tb    		:  STD_LOGIC_VECTOR(M-1 DOWNTO 0)	:= "ZZZZZZZZ";
	SIGNAL B_C_tb			:  STD_LOGIC_VECTOR(M-1 DOWNTO 0)	:= "ZZZZZZZZ";
	SIGNAL product_C_tb	:  STD_LOGIC_VECTOR((2*M)-1 DOWNTO 0);
	SIGNAL int_M_C_tb		:	STD_LOGIC;
	-- Entradas y salidas del contador
	SIGNAL ena_T_C_tb		:	STD_LOGIC 	:= '0';
	SIGNAL ena_C_tb		:	STD_LOGIC 	:= '0';
	SIGNAL count_ini_C_tb:	STD_LOGIC_VECTOR(M-1 DOWNTO 0)	:= "ZZZZZZZZ";
	SIGNAL count_fin_C_tb:	STD_LOGIC_VECTOR(M-1 DOWNTO 0)	:= "ZZZZZZZZ";
	SIGNAL q_C_tb	 		:	STD_LOGIC_VECTOR(M-1 DOWNTO 0);
	SIGNAL int_T_C_tb		:	STD_LOGIC;
	-- Entradas y salidas de la GPIO
	SIGNAL ena_GPIO_C_tb	:	STD_LOGIC	:= '0';
	SIGNAL dir_C_tb 	   :  STD_LOGIC_VECTOR(M-1 DOWNTO 0); 	
	SIGNAL PORT_OUT_C_tb :  STD_LOGIC_VECTOR(M-1 DOWNTO 0);	
	SIGNAL PORT_IN_C_tb  :  STD_LOGIC_VECTOR(M-1 DOWNTO 0);	
	SIGNAL PIN_INOUT_C_tb:  STD_LOGIC_VECTOR(M-1 DOWNTO 0); 	
	SIGNAL int_GPIO_C_tb :  STD_LOGIC;
	SIGNAL LEDS_C_tb   	:  STD_LOGIC_VECTOR(9 DOWNTO 0);
-------------------------------------------------------
BEGIN
	DUT: ENTITY work.Conexion
	GENERIC MAP (M => M)
	PORT MAP(clk_C			=> clk_C_tb,
				rst_C			=>	rst_C_tb,
				-- Entradas y salidas de la multicacion
				ena_M_C		=> ena_M_C_tb,
				A_C			=> A_C_tb,
				B_C			=> B_C_tb,
				product_C	=> product_C_tb,
				int_M_C		=> int_M_C_tb,
				-- Entradas y salidas del contador
				ena_T_C		=> ena_T_C_tb,
				ena_C			=> ena_C_tb,
				count_ini_C	=> count_ini_C_tb,
				count_fin_C	=> count_fin_C_tb,
				q_C			=> q_C_tb,
				int_T_C		=> int_T_C_tb,
				-- Entradas y salidas de la GPIO
				ena_GPIO_C	=> ena_GPIO_C_tb,
				dir_C 	   => dir_C_tb,
				PORT_OUT_C  => PORT_OUT_C_tb,
				PORT_IN_C  	=> PORT_IN_C_tb,
				PIN_INOUT_C	=> PIN_INOUT_C_tb,
				int_GPIO_C  => int_GPIO_C_tb,
				LEDS_C   	=> LEDS_C_tb);
-------------------------------------------------------
	-- CLOCK GENERATION
	clk_C_tb <= NOT(clk_C_tb) AFTER 20 ns;
	-- TEST VECTORS	
	rst_C_tb	 <= '1'	AFTER 200 ns,
					 '0'	AFTER 400 ns;
	
-------------------------------------------------------
	-- Multicacion
	ena_M_C_tb		<= '1' AFTER 200 ns;
	A_C_tb    		<= "00000111" AFTER 200 ns;
	B_C_tb			<= "00011100" AFTER 200 ns;
	
	-- Contador
	ena_T_C_tb		<= '1' AFTER 200 ns;
	ena_C_tb		<= '1' AFTER 200 ns;
	count_ini_C_tb	<= "00010010" AFTER 200 ns;
	count_fin_C_tb	<= "00110100" AFTER 200 ns;
	
	-- GPIO
	ena_GPIO_C_tb	<= '1' AFTER 200 ns;
	dir_C_tb 	   <= "00000000" AFTER 200 ns,
							"11111111" AFTER 700 ns;
	PORT_OUT_C_tb 	<= "00000110" AFTER 200 ns;
	--PIN_INOUT_C_tb	<= 
	
END ARCHITECTURE;