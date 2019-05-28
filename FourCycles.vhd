-- Contador de 0 a 5
-- Versión 2.3
-- Usa Toggle Flip-Flops
-- Autores: Sebastián Parrado
--				Jelitza Varón
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY FourCycles IS
	PORT (clk_FSM	:	IN		STD_LOGIC;
			rst_FSM	:	IN		STD_LOGIC;
			intA_FSM	:	IN		STD_LOGIC;
			intB_FSM	:	OUT	STD_LOGIC);
END ENTITY FourCycles;
-------------------------------------------------------
ARCHITECTURE rtl OF FourCycles IS
	TYPE state IS (state0, state1,state2);
	SIGNAL pr_state, nx_state: state;

	SIGNAL	q0		:	STD_LOGIC;
	SIGNAL	q1		:	STD_LOGIC;
	SIGNAL	q2		:	STD_LOGIC;
	SIGNAL	q		:	STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL	d0		:	STD_LOGIC;
	SIGNAL	d1		:	STD_LOGIC;
	SIGNAL	d2		:	STD_LOGIC;
	
	SIGNAL	ena2	:	STD_LOGIC;
	SIGNAL	int_s	:	STD_LOGIC;
	
BEGIN
-------------------------------------------------------
-- Esta FSM es para el caso de que la interrupción se queda en '1'
	PROCESS(clk_FSM,rst_FSM,intA_FSM,pr_state,int_s,q)
	BEGIN	
-- Si hay reset 
		IF(rst_FSM='1') THEN
			pr_state <= state0;  				-- Entonces el estado 0 pasa a ser el estado previo
			intB_FSM <= '0';						-- Interrupción de salida valdrá '0'
			int_s <= 'Z';							-- Una interrupción auxiliar será una alta impedancia
-- Si el reloj se levanta
		ELSIF(rising_edge(clk_FSM)) THEN
			pr_state <= nx_state;				-- El estado actual pasa a ser el anterior
			CASE pr_state IS
				WHEN state0 => 
					IF (q = "000") THEN 			-- Si el contador 0
						IF(intA_FSM='1') THEN	-- Y si la interrupción de entrada sigue siendo '1'
							int_s <= '1';			-- Coloca la int auxiliar y la int de salida en '1'
							intB_FSM <= '1';
							nx_state <= state1;	-- Se pasa al siguiente estado
						END IF;
					END IF;
				WHEN state1 =>
					IF (q="100") THEN				-- Si el contador es 4
						IF(int_s='1') THEN		-- Y la int_aux sigue siendo '1'
							intB_FSM <= '0';		-- La int de salida será '0'
							int_s <= '0';			-- Y la int auxiliar pasa a valer '0'. Así no vuelve a entrar al condicional
							nx_state <= state2;
						END IF;
					END IF;
				WHEN state2 =>
					IF (int_s ='0') THEN			-- Si la int auxiliar es '0'
						intB_FSM <= '0';			-- Mantenga la int de salida en '0'
					END IF;
			END CASE;
		END IF;
	END PROCESS;
-------------------------------------------------------
-- Contador de 4 ciclos
	-- Data signal is q negated
	-- to obtain a flip-flop toggle
	d0 <=	NOT(q0);
	d1	<= NOT(q1);
	d2	<= NOT(q2);
	
	--Logic to obtain the enable signals
	ena2 <= q1 AND q0;
	
	--Output concatenation
	q <= q2&q1&q0;

	-- DFF instantiation
	bit0: ENTITY work.my_dff
	PORT MAP (	clk	=>	clk_FSM,
					rst 	=>	rst_FSM,
					ena 	=> int_s,
					d 		=>	d0,
					q 		=>	q0);
	
	bit1: ENTITY work.my_dff
	PORT MAP (	clk	=>	clk_FSM,
					rst 	=>	rst_FSM,
					ena 	=>	q0,
					d 		=>	d1,
					q 		=>	q1);
	
	bit2: ENTITY work.my_dff
	PORT MAP (	clk	=>	clk_FSM,
					rst 	=>	rst_FSM,
					ena 	=>	ena2,
					d 		=>	d2,
					q 		=>	q2);	
END ARCHITECTURE rtl;
