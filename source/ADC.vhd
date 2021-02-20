-----------------------------
-- Author - Artis Rusins
-- Date -  
-- Project name - VGA_Ambilight  
-- Module name -  
--
-- Detailed module description
--  
--
-- Revision:
-- A - initial design
-- B -  
-----------------------------
-- module for controlling DE1-SOC ADC LTC2308

-- Dependencies (Libraries and packages)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ADC_spi_master IS
	PORT (
		ADC_clk : IN STD_LOGIC; -- 40 MHz clock is needed
		ADC_DOUT : IN STD_LOGIC; -- sampled data
		ADC_DIN : OUT STD_LOGIC; -- 6 configuration bits for ADC operation mode
		ADC_SCLK : OUT STD_LOGIC; -- ADC clk
		ADC_CONVST : OUT STD_LOGIC := '0'; -- conversion start (chip select)
		--config_bits	: in std_logic_vector(5 downto 0) := "100010"
		test_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0')
	);
END ENTITY;
--define inside of the module
ARCHITECTURE behavioral OF ADC_spi_master IS
	SIGNAL config_bits : STD_LOGIC_VECTOR(17 DOWNTO 0) := "100010000000000000"; --channel 0
	--signal config_bits		: std_logic_vector(17 downto 0) := "110010000000000000";			--channel 5
	--signal config_bits		: std_logic_vector(17 downto 0) := "100110000000000000";			--channel 2 channel 3 ???
	SIGNAL done : STD_LOGIC := '0';
	SIGNAL sampling_active : STD_LOGIC := '0';
	SIGNAL i : INTEGER RANGE 0 TO 81; -- count to 80 clock cycles (2us) for ADC_CONVST
	SIGNAL config_counter : INTEGER RANGE 0 TO 81; -- count to 6 clk for config bits
	SIGNAL sampled_data : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sampled_data_integer : INTEGER RANGE 0 TO 4100;

	TYPE t_State IS (init_state, tx_state);
	SIGNAL State : t_State;

BEGIN
	ADC_SCLK <= ADC_clk;
	--sampled_data_integer <= to_integer(unsigned(sampled_data));
	test_out <= sampled_data;
	PROCESS (ADC_clk) IS
	BEGIN
		IF rising_edge(ADC_clk) THEN
			i <= i + 1;
			IF i = 79 THEN
				i <= 0;
			END IF;
			CASE State IS
				WHEN init_state =>
					ADC_CONVST <= '1';
					ADC_DIN <= '0';
					sampling_active <= '0';
					done <= '0';
					config_counter <= 0;
					IF i = 60 THEN
						State <= tx_state;
					END IF;

				WHEN tx_state =>
					ADC_CONVST <= '0';
					CASE i IS
						WHEN 62 => ADC_DIN <= config_bits(17);
						WHEN 63 => ADC_DIN <= config_bits(16);
						WHEN 64 => ADC_DIN <= config_bits(15);
						WHEN 65 => ADC_DIN <= config_bits(14);
						WHEN 66 => ADC_DIN <= config_bits(13);
						WHEN 67 => ADC_DIN <= config_bits(12);
						WHEN 68 => ADC_DIN <= config_bits(11);
						WHEN 69 => ADC_DIN <= config_bits(10);
						WHEN 70 => ADC_DIN <= config_bits(9);
						WHEN 71 => ADC_DIN <= config_bits(8);
						WHEN 72 => ADC_DIN <= config_bits(7);
						WHEN 73 => ADC_DIN <= config_bits(6);
						WHEN 74 => ADC_DIN <= config_bits(5);
						WHEN 75 => ADC_DIN <= config_bits(4);
						WHEN 76 => ADC_DIN <= config_bits(3);
						WHEN 77 => ADC_DIN <= config_bits(2);
						WHEN 78 => ADC_DIN <= config_bits(1);
						WHEN 79 => ADC_DIN <= config_bits(0);
						WHEN OTHERS => ADC_DIN <= '0';
					END CASE;
					sampling_active <= '1';
					done <= '0';
					IF i = 79 THEN
						State <= init_state;
					END IF;
			END CASE;
		END IF;
	END PROCESS;

	PROCESS (ADC_clk) IS
	BEGIN
		IF falling_edge(ADC_clk) THEN
			CASE i IS
				WHEN 63 => sampled_data(11) <= ADC_DOUT;
				WHEN 64 => sampled_data(10) <= ADC_DOUT;
				WHEN 65 => sampled_data(9) <= ADC_DOUT;
				WHEN 66 => sampled_data(8) <= ADC_DOUT;
				WHEN 67 => sampled_data(7) <= ADC_DOUT;
				WHEN 68 => sampled_data(6) <= ADC_DOUT;
				WHEN 69 => sampled_data(5) <= ADC_DOUT;
				WHEN 70 => sampled_data(4) <= ADC_DOUT;
				WHEN 71 => sampled_data(3) <= ADC_DOUT;
				WHEN 72 => sampled_data(2) <= ADC_DOUT;
				WHEN 73 => sampled_data(1) <= ADC_DOUT;
				WHEN 74 => sampled_data(0) <= ADC_DOUT;
				WHEN OTHERS => done <= '0';
			END CASE;
		END IF;
	END PROCESS;
END ARCHITECTURE;