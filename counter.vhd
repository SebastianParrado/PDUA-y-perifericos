-- Timer_IOM
-- Version 1.3
-- Autores: Sebastián Parrado
--				Jelitza Varón
-- Contador de 8 bits usando un tff
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY counter IS 
	PORT (	clk		:	IN		STD_LOGIC;
				rst		:	IN		STD_LOGIC;
				ena_T		:	IN		STD_LOGIC;
				count_ini:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				count_fin:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				q			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				int_T		:	OUT	STD_LOGIC);
END ENTITY counter;
-------------------------------------------------------
ARCHITECTURE rtl OF counter IS
	SIGNAL 	q_s	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL	ena2	:	STD_LOGIC;
	SIGNAL	ena3	:	STD_LOGIC;
	SIGNAL	ena4	:	STD_LOGIC;
	SIGNAL	ena5	:	STD_LOGIC;
	SIGNAL	ena6	:	STD_LOGIC;
	SIGNAL	ena7	:	STD_LOGIC;
	
	SIGNAL	c0_s	:	STD_LOGIC;
	
	SIGNAL p0		:	STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	ena2 <= q_s(1) AND q_s(0);
	ena3 <= q_s(2) AND ena2;
	ena4 <= q_s(3) AND ena3;
	ena5 <= q_s(4) AND ena4;
	ena6 <= q_s(5) AND ena5;
	ena7 <= q_s(6) AND ena6;
	
-- Señal de interrupción será 1 cuando el contador llegue al valor de count_fin o si llega al valor 
-- máximo
	int_T <= (p0(7) AND p0(6) AND p0(5) AND p0(4) AND p0(3) AND p0(2) AND p0(1) AND p0(0))
				OR
				(q_s(7) AND q_s(6) AND q_s(5) AND q_s(4) AND q_s(3) AND q_s(2) AND q_s(1) AND q_s(0));
		p0 <= q_s XNOR count_fin;
-------------------------------------------------------
	q_8: PROCESS (ena_T,c0_s,rst,count_ini,count_fin)
	BEGIN
	IF (ena_T='1') THEN
		IF (rst='1') THEN
			IF (count_ini="UUUUUUUU") THEN
				q_s <= "00000000";
			ELSIF(count_ini="XXXXXXXX") THEN
				q_s <= "00000000";
			ELSIF (count_ini="ZZZZZZZZ") THEN
				q_s <= "00000000";
			ELSE
				q_s <= count_ini;
			END IF;
		ELSIF (rising_edge(c0_s)) THEN
		-- q0
			q_s(0) <= NOT(q_s(0));
		-- q1
			IF (q_s(0) ='1') THEN
				q_s(1) <= NOT(q_s(1));
		-- q2
				IF (ena2 ='1') THEN
					q_s(2) <= NOT(q_s(2));
		-- q3
					IF (ena3 ='1') THEN
						q_s(3) <= NOT(q_s(3));
		-- q4
						IF (ena4 ='1') THEN
							q_s(4) <= NOT(q_s(4));
		-- q5
							IF (ena5 ='1') THEN
								q_s(5) <= NOT(q_s(5));
		-- q6
								IF (ena6 ='1') THEN
									q_s(6) <= NOT(q_s(6));
		-- q7
									IF(ena7='1') THEN
										q_s(7) <= NOT(q_s(7));
									END IF;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
	END PROCESS q_8;
	q <= q_s;
-------------------------------------------------------	
	PLL: ENTITY work.my_pll
	PORT MAP (	areset	=> rst,
					inclk0	=> clk,
					c0			=> c0_s);
END ARCHITECTURE rtl;
