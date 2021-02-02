-----------------------------
-- Author - Imants Pulkstenis
-- Date - 31.10.2020 
-- Project name - VGA_Ambilight  
-- Module name - bit_sender
--
-- Detailed module description
-- bit sender to WS2812B LEDs
--
-- Revision:
-- A - initial design
-- B - add another wire(w_is_timer_almost_done) and shift o_send_done output by one clock cycle, to use it for address increase counter 
-- C - 
-----------------------------
LIBRARY ieee; --always use this library
USE ieee.std_logic_1164.ALL; --always use this library
USE ieee.numeric_std.ALL; --use this library if arithmetic require

USE work.functions.ALL;

ENTITY bit_sender IS
    GENERIC (
        g_FIRST_MAX_VALUE : NATURAL := 20;
        g_SECOND_MAX_VALUE : NATURAL := 40;
        g_BIT_COUNTER_MAX_VALUE : NATURAL := 60;
        g_DATA_WIDTH : NATURAL := 24
    );
    PORT (
        i_clk : IN STD_LOGIC;
        i_data : IN STD_LOGIC_VECTOR(g_DATA_WIDTH - 1 DOWNTO 0);
        i_data_valid : IN STD_LOGIC;
        i_enable : IN STD_LOGIC;
        o_send_done : OUT STD_LOGIC;
        o_data_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF bit_sender IS
    ------------ signal declaration -------------------------

    -- input registers 
    SIGNAL r_data_in_reg : STD_LOGIC_VECTOR(g_DATA_WIDTH - 1 DOWNTO 0) := (OTHERS => '0'); -- r_data reg NEXT is i_data
    SIGNAL r_sending_reg : STD_LOGIC := '0'; --  r_sending_next is i_data_valid
    -- counter registers
    SIGNAL r_bit_counter_reg, r_bit_counter_next : unsigned(log2c(g_DATA_WIDTH + 1) - 1 DOWNTO 0) := (OTHERS => '0'); -- counts the time to toggle between H and L during BIT transfer or RESET
    SIGNAL r_timer_reg, r_timer_next : unsigned(log2c(g_BIT_COUNTER_MAX_VALUE + 1) - 1 DOWNTO 0) := (OTHERS => '0'); -- counts witch bit to transfer
    -- output register
    SIGNAL r_data_out_reg, r_data_out_next : STD_LOGIC := '0';
    SIGNAL r_send_done_reg, r_send_done_next : STD_LOGIC := '0';
    -- wires
    SIGNAL w_demux_out : STD_LOGIC; -- output of DEMUX (selects one of bits)
    SIGNAL w_is_bit_max : STD_LOGIC; -- is HIGH when bit_counter = g_DATA_WIDTH-1
    SIGNAL w_is_timer_max : STD_LOGIC; -- is HIGH when timer_counter = g_BIT_COUNTER_MAX_VALUE
    SIGNAL w_is_timer_almost_done : STD_LOGIC; -- is HIGH when timer_counter = g_BIT_COUNTER_MAX_VALUE - 1
    SIGNAL w_is_timer_first : STD_LOGIC; -- is HIGH when timer_counter = g_FIRST_MAX_VALUE
    SIGNAL w_is_timer_second : STD_LOGIC; -- is HIGH when timer_counter = g_SECOND_MAX_VALUE
    SIGNAL w_is_bit_zero : STD_LOGIC; -- is HIGH when bit_counter = g_DATA_WIDTH-1
    SIGNAL w_is_timer_zero : STD_LOGIC; -- is HIGH when timer_counter = g_BIT_COUNTER_MAX_VALUE
    SIGNAL w_enable_read_in : STD_LOGIC; -- is HIGH when read from Input is enables - both counters are "0"
    -- enable signals to registers
    SIGNAL w_en_data_in, w_en_data_out, w_en_sending, w_en_send_done, w_en_bit_counter, w_en_timer : STD_LOGIC;

    -- attribute keep: boolean;
    -- attribute keep of w_demux_out: signal is true;	 

BEGIN
    -- enable wires
    w_en_data_in <= w_enable_read_in;
    w_en_sending <= w_enable_read_in OR r_send_done_reg;
    w_en_timer <= r_sending_reg;
    w_en_bit_counter <= w_is_timer_max;
    w_en_data_out <= r_data_out_reg XOR r_data_out_next;
    w_en_send_done <= r_send_done_reg XOR r_send_done_next;

    -- other wires
    w_is_timer_almost_done <= '1' WHEN (r_timer_reg = g_BIT_COUNTER_MAX_VALUE - 2) ELSE
        '0';
    w_is_timer_max <= '1' WHEN (r_timer_reg = g_BIT_COUNTER_MAX_VALUE) ELSE
        '0';
    w_is_bit_max <= '1' WHEN (r_bit_counter_reg = g_DATA_WIDTH - 1) ELSE
        '0'; -- (g_DATA_WIDTH - 1) bits of data
    w_is_bit_zero <= '1' WHEN (r_bit_counter_reg = to_unsigned(0, log2c(g_DATA_WIDTH + 1))) ELSE
        '0';
    w_is_timer_zero <= '1' WHEN (r_timer_reg = to_unsigned(0, log2c(g_BIT_COUNTER_MAX_VALUE + 1))) ELSE
        '0';
    w_is_timer_first <= '1' WHEN (r_timer_reg < g_FIRST_MAX_VALUE) ELSE
        '0';
    w_is_timer_second <= '1' WHEN (r_timer_reg < g_SECOND_MAX_VALUE) ELSE
        '0';
    w_enable_read_in <= '1' WHEN (w_is_timer_zero AND w_is_bit_zero AND i_data_valid) ELSE
        '0';
    -- demux
    WITH r_bit_counter_reg SELECT w_demux_out <=
        r_data_in_reg(23) WHEN to_unsigned(23, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(22) WHEN to_unsigned(22, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(21) WHEN to_unsigned(21, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(20) WHEN to_unsigned(20, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(19) WHEN to_unsigned(19, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(18) WHEN to_unsigned(18, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(17) WHEN to_unsigned(17, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(16) WHEN to_unsigned(16, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(15) WHEN to_unsigned(15, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(14) WHEN to_unsigned(14, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(13) WHEN to_unsigned(13, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(12) WHEN to_unsigned(12, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(11) WHEN to_unsigned(11, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(10) WHEN to_unsigned(10, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(9) WHEN to_unsigned(9, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(8) WHEN to_unsigned(8, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(7) WHEN to_unsigned(7, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(6) WHEN to_unsigned(6, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(5) WHEN to_unsigned(5, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(4) WHEN to_unsigned(4, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(3) WHEN to_unsigned(3, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(2) WHEN to_unsigned(2, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(1) WHEN to_unsigned(1, log2c(g_DATA_WIDTH + 1)),
        r_data_in_reg(0) WHEN to_unsigned(0, log2c(g_DATA_WIDTH + 1)),
        '0' WHEN OTHERS;

    ------------------ reg-state logic ---------------------
    PROCESS (ALL)
    BEGIN
        IF (NOT i_enable) THEN
            -- if i_enable is LOW then registers are reset
            r_data_in_reg <= (OTHERS => '0');
            r_bit_counter_reg <= (OTHERS => '0');
            r_timer_reg <= (OTHERS => '0');
            r_sending_reg <= '0';
            r_send_done_reg <= '0';
            r_data_out_reg <= '0';
        ELSE
            IF rising_edge(i_clk) THEN
                -- input data register
                IF w_en_data_in THEN
                    r_data_in_reg <= i_data;
                END IF;
                -- input activate register
                IF w_en_sending THEN
                    r_sending_reg <= i_data_valid;
                END IF;
                -- timer register
                IF w_en_timer THEN
                    r_timer_reg <= r_timer_next;
                END IF;
                -- bit counter register
                IF w_en_bit_counter THEN
                    r_bit_counter_reg <= r_bit_counter_next;
                END IF;
                -- active out register
                IF w_en_send_done THEN
                    r_send_done_reg <= r_send_done_next;
                END IF;
                -- data out register
                IF w_en_data_out THEN
                    r_data_out_reg <= r_data_out_next;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    ------------------- next-state logic -------------------

    r_timer_next <= to_unsigned(0, log2c(g_BIT_COUNTER_MAX_VALUE + 1)) WHEN w_is_timer_max ELSE
        r_timer_reg + 1;

    r_bit_counter_next <= to_unsigned(0, log2c(g_DATA_WIDTH + 1)) WHEN w_is_bit_max ELSE
        r_bit_counter_reg + 1;

    r_send_done_next <= w_is_bit_max AND w_is_timer_almost_done;
    r_data_out_next <= (w_is_timer_second AND w_demux_out) WHEN w_demux_out ELSE
        (w_is_timer_first AND (NOT w_demux_out));
    ------------------------ outputs ------------------------
    o_send_done <= r_send_done_reg;
    o_data_out <= r_data_out_reg AND w_en_timer; -- when not sending data line is LOW
END rtl;