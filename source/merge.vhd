--input: pixel values, horizontal and vertical coords of pixels (800 x 600)
--output : ~pixel values, horizontal and vertical coords of pixels (25 x 20)

-- Dependencies (Libraries and packages)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY merge IS
	PORT (
		i_clk : IN STD_LOGIC;
		i_horizontal : IN INTEGER RANGE 0 TO 1023;
		i_vertical : IN INTEGER RANGE 0 TO 1023;
		i_ADC_reading : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		i_valid_ADC : IN STD_LOGIC;
		i_valid_VGA : IN STD_LOGIC;
		o_en : OUT STD_LOGIC;
		o_byteenable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		o_data32 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_address : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		o_test : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE behavioral OF merge IS
	CONSTANT horizontal_ratio : INTEGER := 32; -- 800 / 25, old_res / new_res
	CONSTANT vertical_ratio : INTEGER := 30; -- 600 / 20 
	CONSTANT output_horizontal : INTEGER := 25;

	SIGNAL i : INTEGER RANGE 0 TO 8 := 0;
	SIGNAL global_en : STD_LOGIC := '0';
	SIGNAL new_x, new_y : INTEGER RANGE 0 TO 25 := 0;--std_logic_vector(4 downto 0) := (others => '0');
	SIGNAL i_horizontal_s : INTEGER RANGE 0 TO 1023;
	SIGNAL i_vertical_s : INTEGER RANGE 0 TO 1023;
	SIGNAL o_address_integer : INTEGER RANGE 0 TO 4095;

	TYPE t_State IS (step1, step2); -- for cycling byte enable
	SIGNAL State : t_State;

	SIGNAL o_byteenable_s : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL color8 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL color32 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0'); -- padd zeros and shift accordingly
BEGIN
	PROCESS (i_clk) IS
	BEGIN

		IF i_valid_ADC = '1' AND i_valid_VGA = '1' THEN
			global_en <= '1';
			o_en <= '1';
		ELSE
			global_en <= '0';
			o_en <= '0';
		END IF;

		IF rising_edge(i_clk) THEN

			CASE State IS -- counts i_valid_VGA pulses. used for byte enable
				WHEN step1 => -- i_valid_VGA is high, when in visible area
					IF i_valid_VGA = '1' THEN
						i <= i + 1;
						IF i = 8 THEN
							i <= 0;
						END IF;
					END IF;
					State <= step2;
				WHEN step2 =>
					IF i_valid_VGA <= '0' THEN
						State <= step1;
					END IF;
			END CASE;

			CASE i IS
				WHEN 0 | 1 | 2 => o_byteenable_s <= "0100"; -- RED				-- each 3 horizontal lines for one color
				WHEN 3 | 4 | 5 => o_byteenable_s <= "0010"; -- GREEN
				WHEN 6 | 7 | 8 => o_byteenable_s <= "0001"; -- GREEN
				WHEN OTHERS => o_byteenable <= "0100";
			END CASE;
			o_byteenable <= o_byteenable_s;

			IF global_en = '1' THEN
				i_horizontal_s <= i_horizontal;
				i_vertical_s <= i_vertical;

				-- 800x600 => 25x20
				IF i_horizontal_s >= 0 * horizontal_ratio AND i_horizontal_s < 1 * horizontal_ratio THEN
					new_x <= 0;
				ELSIF i_horizontal_s >= 1 * horizontal_ratio AND i_horizontal_s < 2 * horizontal_ratio THEN
					new_x <= 1;
				ELSIF i_horizontal_s >= 2 * horizontal_ratio AND i_horizontal_s < 3 * horizontal_ratio THEN
					new_x <= 2;
				ELSIF i_horizontal_s >= 3 * horizontal_ratio AND i_horizontal_s < 4 * horizontal_ratio THEN
					new_x <= 3;
				ELSIF i_horizontal_s >= 4 * horizontal_ratio AND i_horizontal_s < 5 * horizontal_ratio THEN
					new_x <= 4;
				ELSIF i_horizontal_s >= 5 * horizontal_ratio AND i_horizontal_s < 6 * horizontal_ratio THEN
					new_x <= 5;
				ELSIF i_horizontal_s >= 6 * horizontal_ratio AND i_horizontal_s < 7 * horizontal_ratio THEN
					new_x <= 6;
				ELSIF i_horizontal_s >= 7 * horizontal_ratio AND i_horizontal_s < 8 * horizontal_ratio THEN
					new_x <= 7;
				ELSIF i_horizontal_s >= 8 * horizontal_ratio AND i_horizontal_s < 9 * horizontal_ratio THEN
					new_x <= 8;
				ELSIF i_horizontal_s >= 9 * horizontal_ratio AND i_horizontal_s < 10 * horizontal_ratio THEN
					new_x <= 9;
				ELSIF i_horizontal_s >= 10 * horizontal_ratio AND i_horizontal_s < 11 * horizontal_ratio THEN
					new_x <= 10;
				ELSIF i_horizontal_s >= 11 * horizontal_ratio AND i_horizontal_s < 12 * horizontal_ratio THEN
					new_x <= 11;
				ELSIF i_horizontal_s >= 12 * horizontal_ratio AND i_horizontal_s < 13 * horizontal_ratio THEN
					new_x <= 12;
				ELSIF i_horizontal_s >= 13 * horizontal_ratio AND i_horizontal_s < 14 * horizontal_ratio THEN
					new_x <= 13;
				ELSIF i_horizontal_s >= 14 * horizontal_ratio AND i_horizontal_s < 15 * horizontal_ratio THEN
					new_x <= 14;
				ELSIF i_horizontal_s >= 15 * horizontal_ratio AND i_horizontal_s < 16 * horizontal_ratio THEN
					new_x <= 15;
				ELSIF i_horizontal_s >= 16 * horizontal_ratio AND i_horizontal_s < 17 * horizontal_ratio THEN
					new_x <= 16;
				ELSIF i_horizontal_s >= 17 * horizontal_ratio AND i_horizontal_s < 18 * horizontal_ratio THEN
					new_x <= 17;
				ELSIF i_horizontal_s >= 18 * horizontal_ratio AND i_horizontal_s < 19 * horizontal_ratio THEN
					new_x <= 18;
				ELSIF i_horizontal_s >= 19 * horizontal_ratio AND i_horizontal_s < 20 * horizontal_ratio THEN
					new_x <= 19;
				ELSIF i_horizontal_s >= 20 * horizontal_ratio AND i_horizontal_s < 21 * horizontal_ratio THEN
					new_x <= 20;
				ELSIF i_horizontal_s >= 21 * horizontal_ratio AND i_horizontal_s < 22 * horizontal_ratio THEN
					new_x <= 21;
				ELSIF i_horizontal_s >= 22 * horizontal_ratio AND i_horizontal_s < 23 * horizontal_ratio THEN
					new_x <= 22;
				ELSIF i_horizontal_s >= 23 * horizontal_ratio AND i_horizontal_s < 24 * horizontal_ratio THEN
					new_x <= 23;
				ELSIF i_horizontal_s >= 24 * horizontal_ratio AND i_horizontal_s < 25 * horizontal_ratio THEN
					new_x <= 24;
				ELSE
					new_x <= 0;
				END IF;

				IF i_vertical_s >= 0 * vertical_ratio AND i_vertical_s < 1 * vertical_ratio THEN
					new_y <= 0;
				ELSIF i_vertical_s >= 1 * vertical_ratio AND i_vertical_s < 2 * vertical_ratio THEN
					new_y <= 1;
				ELSIF i_vertical_s >= 2 * vertical_ratio AND i_vertical_s < 3 * vertical_ratio THEN
					new_y <= 2;
				ELSIF i_vertical_s >= 3 * vertical_ratio AND i_vertical_s < 4 * vertical_ratio THEN
					new_y <= 3;
				ELSIF i_vertical_s >= 4 * vertical_ratio AND i_vertical_s < 5 * vertical_ratio THEN
					new_y <= 4;
				ELSIF i_vertical_s >= 5 * vertical_ratio AND i_vertical_s < 6 * vertical_ratio THEN
					new_y <= 5;
				ELSIF i_vertical_s >= 6 * vertical_ratio AND i_vertical_s < 7 * vertical_ratio THEN
					new_y <= 6;
				ELSIF i_vertical_s >= 7 * vertical_ratio AND i_vertical_s < 8 * vertical_ratio THEN
					new_y <= 7;
				ELSIF i_vertical_s >= 8 * vertical_ratio AND i_vertical_s < 9 * vertical_ratio THEN
					new_y <= 8;
				ELSIF i_vertical_s >= 9 * vertical_ratio AND i_vertical_s < 10 * vertical_ratio THEN
					new_y <= 9;
				ELSIF i_vertical_s >= 10 * vertical_ratio AND i_vertical_s < 11 * vertical_ratio THEN
					new_y <= 10;
				ELSIF i_vertical_s >= 11 * vertical_ratio AND i_vertical_s < 12 * vertical_ratio THEN
					new_y <= 11;
				ELSIF i_vertical_s >= 12 * vertical_ratio AND i_vertical_s < 13 * vertical_ratio THEN
					new_y <= 12;
				ELSIF i_vertical_s >= 13 * vertical_ratio AND i_vertical_s < 14 * vertical_ratio THEN
					new_y <= 13;
				ELSIF i_vertical_s >= 14 * vertical_ratio AND i_vertical_s < 15 * vertical_ratio THEN
					new_y <= 14;
				ELSIF i_vertical_s >= 15 * vertical_ratio AND i_vertical_s < 16 * vertical_ratio THEN
					new_y <= 15;
				ELSIF i_vertical_s >= 16 * vertical_ratio AND i_vertical_s < 17 * vertical_ratio THEN
					new_y <= 16;
				ELSIF i_vertical_s >= 17 * vertical_ratio AND i_vertical_s < 18 * vertical_ratio THEN
					new_y <= 17;
				ELSIF i_vertical_s >= 18 * vertical_ratio AND i_vertical_s < 19 * vertical_ratio THEN
					new_y <= 18;
				ELSIF i_vertical_s >= 19 * vertical_ratio AND i_vertical_s < 20 * vertical_ratio THEN
					new_y <= 19;
				ELSE
					new_y <= 0;
				END IF;

				o_address_integer <= output_horizontal * new_y + new_x;
				o_address <= STD_LOGIC_VECTOR(to_unsigned(o_address_integer, 12)); -- address for memory

				color8 <= i_ADC_reading(9 DOWNTO 2); -- 11 and 10 don't care because VGA is 0.7V max, 0 and 1 don't care because wouldn't make difference on leds
				--o_test <= color8;

				color32 <= STD_LOGIC_VECTOR(resize(unsigned(color8), 32)); -- padded with zeros
				--o_test <= color32;

				CASE o_byteenable_s IS
					WHEN "0100" => -- RED
						-- shift 16 left
						o_data32 <= STD_LOGIC_VECTOR(shift_left(unsigned(color32), 16));
					WHEN "0010" => -- GREEN
						-- shift 8 left
						o_data32 <= STD_LOGIC_VECTOR(shift_left(unsigned(color32), 8));
					WHEN "0001" => -- BLUE
						-- don't shift
						o_data32 <= color32;
					WHEN OTHERS =>
						o_data32 <= color32;
				END CASE;

			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;