-- Bloque que une multiplicación con la interrupción
-- Autores: Sebastián Parrado
--				Jelitza Varón
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY Conexion IS
	GENERIC (M	:	INTEGER := 8);
	PORT(	-- Señales generales
			clk_C			:	IN		STD_LOGIC;
			rst_C			:	IN		STD_LOGIC;
			-- Entradas y salidas de la multicacion
			ena_M_C		:	IN		STD_LOGIC;
			A_C			:	IN		STD_LOGIC_VECTOR(M-1 DOWNTO 0);
			B_C			:	IN		STD_LOGIC_VECTOR(M-1 DOWNTO 0);
			product_C	:	OUT	STD_LOGIC_VECTOR((2*M)-1 DOWNTO 0);
			int_M_C		:	OUT	STD_LOGIC;
			-- Entradas y salidas del contador
			ena_T_C		:	IN		STD_LOGIC;
			ena_C			:	IN		STD_LOGIC;
			count_ini_C	:	IN		STD_LOGIC_VECTOR(M-1 DOWNTO 0);
			count_fin_C	:	IN		STD_LOGIC_VECTOR(M-1 DOWNTO 0);
			q_C			:	OUT	STD_LOGIC_VECTOR(M-1 DOWNTO 0);
			int_T_C		:	OUT	STD_LOGIC;
			-- Entradas y salidas de la GPIO
			ena_GPIO_C	:	IN		STD_LOGIC;
         dir_C 	   : IN 	  STD_LOGIC_VECTOR(M-1 DOWNTO 0); 	-- Direcciones. Entrada dada por el usuario
  			PORT_OUT_C  : IN	  STD_LOGIC_VECTOR(M-1 DOWNTO 0);	--	Salida de la GPIO. Entrada al BiDir.
			PORT_IN_C  	: OUT   STD_LOGIC_VECTOR(M-1 DOWNTO 0);	--	Entrada a la GPIO. Salida del BiDir.
			PIN_INOUT_C	: INOUT  STD_LOGIC_VECTOR(M-1 DOWNTO 0); 	-- Entrada a la GPIO. Salida del Pin.
			int_GPIO_C  : OUT   STD_LOGIC;
			LEDS_C   	: OUT   STD_LOGIC_VECTOR(9 DOWNTO 0));
END ENTITY Conexion;
-------------------------------------------------------
ARCHITECTURE structural OF Conexion IS
	SIGNAL int_M_s	:	STD_LOGIC;
	SIGNAL int_T_s	:	STD_LOGIC;
	SIGNAL int_GPIO_s	:	STD_LOGIC;
BEGIN
-- Llamando bloques
	Mult: ENTITY work.multiplicador_IOM
	GENERIC MAP( N 	=> M)
	PORT MAP(clk_M		=> clk_C,
				rst_M		=> rst_C,
				ena_M		=> ena_M_C,
				A_M		=> A_C,
				B_M		=> B_C,
				product_out_M	=> product_C,
				int_M		=> int_M_s);
	FourCycles_Mult: ENTITY work.FourCycles
	PORT MAP(clk_FSM	=> clk_C,
				rst_FSM	=> rst_C,
				intA_FSM	=> int_M_s,
				intB_FSM	=> int_M_C);
				
				
	Cont:	ENTITY work.counter
	PORT MAP(clk		=> clk_C,
				rst		=> rst_C,
				ena_T		=> ena_T_C,
				ena		=> ena_C,
				count_ini=> count_ini_C,
				count_fin=> count_fin_C,
				q			=> q_C,
				int_T		=> int_T_s);
	FourCycles_Cont : ENTITY work.FourCycles
	PORT MAP(clk_FSM	=> clk_C,
				rst_FSM	=> rst_C,
				intA_FSM	=> int_T_s,
				intB_FSM	=> int_T_C);
				
				
	GPIO:	ENTITY work.GPIO
	PORT MAP(clk		=> clk_C,
				dir 	   => dir_C,
				ena_GPIO	=> ena_GPIO_C,
				PORT_OUT => PORT_OUT_C,
				PORT_IN  => PORT_IN_C,
				PIN_INOUT=> PIN_INOUT_C,
				int_GPIO	=> int_GPIO_s,
				LEDS   	=> LEDS_C);
	FourCycles_GPIO : ENTITY work.FourCycles
	PORT MAP(clk_FSM	=> clk_C,
				rst_FSM	=> rst_C,
				intA_FSM	=> int_GPIO_s,
				intB_FSM	=> int_GPIO_C);

END ARCHITECTURE structural;	