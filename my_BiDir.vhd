-- my_BiDir 
-- Versión: 1.1.1
-- Autores: Sebastián Parrado
--				Jelitza Varón
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY my_BiDir IS
	PORT ( 	ena 		:	IN 	STD_LOGIC;
				clk		:	IN 	STD_LOGIC;
				A0 		:	IN		STD_LOGIC;
				A1			:	OUT	STD_LOGIC;
				B 			:	INOUT	STD_LOGIC);
END ENTITY my_BiDir;
-------------------------------------------------------
ARCHITECTURE rtl OF my_BiDir IS
	SIGNAL X0	:	STD_LOGIC;
	SIGNAL X1	:	STD_LOGIC;
	SIGNAL Y		:	STD_LOGIC;
	SIGNAL BusData :	STD_LOGIC;
-------------------------------------------------------
BEGIN
	PROCESS(clk,A0)
	BEGIN
		IF (rising_edge(clk)) THEN
			X0 <= A0;
			A1 <= X1;
			B  <= Y;
			IF (ena='0') THEN
				B <= Y;
				BusData <= X0;
				Y <= BusData;
				X1 <= 'Z';
			ELSE
--				BusData <= 'Z';
--				B <= BusData;
--				X1 <= B;
				Y <= B;
				BusData <= Y;
				X1 <= BusData;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE rtl;