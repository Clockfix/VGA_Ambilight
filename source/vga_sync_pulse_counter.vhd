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
-- module for controlling DE0-NANO-SOC DE1-SOC ADC LTC2308

-- Dependencies (Libraries and packages)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY vga_sync_pulse_counter IS
	PORT (
		v_sync : IN STD_LOGIC;
		h_sync : IN STD_LOGIC;
		VGA_clk : IN STD_LOGIC;
		--send : IN STD_LOGIC;
		v : OUT INTEGER RANGE 0 TO 799 := 0;--std_logic_vector(7 downto 0)
		h : OUT INTEGER RANGE 0 TO 799 := 0
	);
END ENTITY;

ARCHITECTURE behavioral OF vga_sync_pulse_counter IS
	SIGNAL h_count : INTEGER RANGE 0 TO 799 := 0; -- VGA resolution
	SIGNAL v_count : INTEGER RANGE 0 TO 599 := 0;
	SIGNAL h_porch_counter : INTEGER RANGE 0 TO 88 := 0;
	SIGNAL v_porch_counter : INTEGER RANGE 0 TO 26 := 0;
	SIGNAL h_porch_counter_en : STD_LOGIC := '0';
	SIGNAL v_porch_counter_en : STD_LOGIC := '0';
	SIGNAL global_start : STD_LOGIC := '0';
	SIGNAL global_start_v_porch_counter : INTEGER RANGE 0 TO 25 := 0;

	TYPE t_State IS (H_start, H_porch);
	SIGNAL State : t_State;

BEGIN
	PROCESS (VGA_clk) IS
	BEGIN
		-- test connections
		v <= v_count;
		h <= h_count;

		--wait for first vertical sync pulse + vertical front porch so we can start at first horizontal pixel
		IF v_sync = '0' AND global_start <= '0' THEN
			IF rising_edge(VGA_clk) THEN
				global_start_v_porch_counter <= global_start_v_porch_counter + 1;
			END IF;
			IF global_start_v_porch_counter = 25 THEN -- v_sync_pulse + front porch [pixels]
				global_start <= '1';
			END IF;
		END IF;

		--counters
		IF global_start <= '1' AND rising_edge(VGA_clk) AND h_porch_counter_en = '1' THEN
			h_porch_counter <= h_porch_counter + 1;
		END IF;

		IF global_start <= '1' AND rising_edge(VGA_clk) AND v_porch_counter_en = '1' THEN
			v_porch_counter <= v_porch_counter + 1;
		END IF;

		-- FSM
		IF global_start <= '1' AND rising_edge(VGA_clk) THEN
			h_count <= h_count + 1;
			IF h_count = 799 THEN -- resolution
				h_count <= 0;
			END IF;

			CASE State IS
				WHEN H_start =>
					h_porch_counter <= 0;
					v_porch_counter <= 0;
					v_porch_counter_en <= '0';
					IF h_sync = '0' THEN
						v_count <= v_count + 1;
						State <= H_porch;
						--					elsif v_sync = '0' then
						--						State <= Frame_end;
					END IF;

				WHEN H_porch =>
					h_count <= 799; -- resolution
					h_porch_counter_en <= '1';
					IF h_porch_counter = 87 THEN -- 88 = back_porch [pixels]
						State <= H_start;
						--					elsif v_sync = '0' then
						--						State <= Frame_end;
					END IF;

					--				when Frame_end =>
					--					v_porch_counter_en <= '1';
					--					h_count <= 799;
					--					v_count <= 599;					-- resolution
					--				if v_porch_counter = 23 then
					--					State <= H_start;
					--				end if;

			END CASE;
		END IF;
	END PROCESS;
END ARCHITECTURE;