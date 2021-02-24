-- module for counting VGA signal pixels and resetting on sync pulses 
--	outputs current coordinate

-- Dependencies (Libraries and packages)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY vga_sync_pulse_counter IS
	PORT (
		v_sync : IN STD_LOGIC;
		h_sync : IN STD_LOGIC;
		VGA_clk : IN STD_LOGIC;
		-- send : IN STD_LOGIC;
		v : OUT INTEGER RANGE 0 TO 599 := 0; -- VGA resolution
		h : OUT INTEGER RANGE 0 TO 799 := 0;
		valid : OUT STD_LOGIC := '0'
	);
END ENTITY;

ARCHITECTURE behavioral OF vga_sync_pulse_counter IS
	SIGNAL h_count : INTEGER RANGE 0 TO 799 := 0; -- VGA resolution
	SIGNAL v_count : INTEGER RANGE 0 TO 599 := 0;
	SIGNAL h_porch_counter : INTEGER RANGE 0 TO 255 := 0;
	SIGNAL v_porch_counter : INTEGER RANGE 0 TO 24289 := 0; -- should fit 23 full video frames 
	SIGNAL h_porch_counter_en : STD_LOGIC := '0';
	SIGNAL v_porch_counter_en : STD_LOGIC := '0';
	SIGNAL visible_region_active : STD_LOGIC := '0';

	TYPE t_State IS (H_start, H_porch, Frame_end);
	SIGNAL State : t_State;

BEGIN
	PROCESS (VGA_clk, v_count, h_count, v_sync, h_sync) IS
	BEGIN
		-- output current coordinates and valid signal when
		-- we're inside visible region
		v <= v_count;
		h <= h_count;
		valid <= visible_region_active;

		IF v_sync = '0' THEN
			State <= Frame_end;
			visible_region_active <= '0';
		ELSIF rising_edge(VGA_clk) THEN

			--counters
			IF rising_edge(VGA_clk) AND h_porch_counter_en = '1' THEN
				h_porch_counter <= h_porch_counter + 1;
			END IF;

			IF rising_edge(VGA_clk) AND v_porch_counter_en = '1' THEN
				v_porch_counter <= v_porch_counter + 1;
			END IF;

			-- FSM
			CASE State IS
				WHEN H_start =>
					h_count <= h_count + 1;
					h_porch_counter_en <= '0';
					h_porch_counter <= 0;
					v_porch_counter_en <= '0';
					v_porch_counter <= 0;
					visible_region_active <= '1';
					IF h_sync = '0' THEN
						v_count <= v_count + 1;
						State <= H_porch;
					END IF;

				WHEN H_porch =>
					h_porch_counter_en <= '1';
					h_count <= 0;
					visible_region_active <= '0';
					IF h_porch_counter = 88 + 128 THEN -- back porch + horizontal sync pulse 
						State <= H_start;
					END IF;

				WHEN Frame_end =>
					v_porch_counter_en <= '1';
					v_count <= 0;
					h_count <= 0;
					visible_region_active <= '0';
					IF v_porch_counter = 23 * 1056 THEN -- 23 full video frames 
						State <= H_start;
					END IF;
			END CASE;
		END IF;

	END PROCESS;
END ARCHITECTURE;