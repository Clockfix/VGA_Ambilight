-----------------------------
-- Author - Imants Pulkstenis
-- Date - 08.11.2020 
-- Project name - VGA_Ambilight  
-- Module name - data send FSM
--
-- Detailed module description
-- State machine thats sends data to led's, read 
-- color information from memory and
-- send reset signal when data send is done
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; --use this library if arithmetic require

USE work.functions.ALL;

ENTITY sender_fsm IS
    GENERIC (
        -- generic parameters - passed here from calling entity
        g_STATES : NATURAL := 4;
        g_RESET_TIME : NATURAL := 2500 -- must be larger then 50us => 2500 * 20ns =50us
    );
    PORT (
        i_clk : IN STD_LOGIC;
        i_enable : IN STD_LOGIC;
        o_send_en : OUT STD_LOGIC;
        o_send_dv : OUT STD_LOGIC;
        o_rd_addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); --read address from memory
        i_active_leds : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- led count in strip (active)
        i_new_data : IN STD_LOGIC;
        i_sent_done : IN STD_LOGIC; -- word send done 
        o_sent_done : OUT STD_LOGIC--;
        --o_ren : OUT STD_LOGIC -- read enable
    );
END ENTITY;

ARCHITECTURE rtl OF sender_fsm IS

    ------------ signal declaration -------------------------
    TYPE state_t IS
    (
    S_IDLE, -- Idle state (START state)
    S_RESET, -- sends reset signal
    S_WAIT, -- in there are no data to send, wait in this state
    S_SEND_DATA -- sending data in this state
    );
    SIGNAL state_reg, state_next : state_t := S_IDLE;

    SIGNAL r_timer_reg, r_timer_next : unsigned(log2c(g_RESET_TIME + 1) - 1 DOWNTO 0) := (OTHERS => '0'); -- reset counter, determines, how long is reset period
    SIGNAL r_count_reg, r_count_next : unsigned(9 DOWNTO 0) := (OTHERS => '0'); -- count the sent words to LED strip
    SIGNAL r_send_done_reg, r_send_done_next : STD_LOGIC := '0'; -- send done register to top entity
    SIGNAL r_send_en_reg, r_send_en_next : STD_LOGIC := '0'; -- send enable to bit_sender
    SIGNAL r_send_dv_reg, r_send_dv_next : STD_LOGIC := '0'; -- data valid for bit_sender

BEGIN

    -------------------- reg-state logic --------------------
    PROCESS (ALL)
    BEGIN
        IF rising_edge(i_clk) THEN
            state_reg <= state_next;
            r_timer_reg <= r_timer_next;
            r_count_reg <= r_count_next;
            r_send_done_reg <= r_send_done_next;
            r_send_en_reg <= r_send_en_next;
            r_send_dv_reg <= r_send_dv_next;
        END IF;
    END PROCESS;

    ------------------- next-state logic --------------------

    r_count_next <= r_count_reg + 1 WHEN ((state_reg = S_SEND_DATA) AND (i_sent_done = '1') AND (NOT (r_count_reg = unsigned(i_active_leds)))) ELSE
        r_count_reg WHEN ((state_reg = S_SEND_DATA) AND (NOT (r_count_reg = unsigned(i_active_leds)))) ELSE
        (OTHERS => '0');

    r_timer_next <= r_timer_reg + 1 WHEN (state_reg = S_RESET AND (NOT (r_timer_reg = g_RESET_TIME))) ELSE
        (OTHERS => '0');

    r_send_done_next <= '1' WHEN r_count_reg = unsigned(i_active_leds) ELSE
        '0';
    r_send_en_next <= '1' WHEN state_reg = S_SEND_DATA ELSE
        '0';
    r_send_dv_next <= '1' WHEN state_reg = S_SEND_DATA ELSE
        '0';

    ------------------------- FSM ---------------------------
    PROCESS (ALL)
    BEGIN
        IF NOT i_enable THEN -- when enable enter RESET state
            state_next <= S_IDLE;
        ELSE
            CASE state_reg IS
                WHEN S_IDLE =>
                    state_next <= S_RESET;
                WHEN S_RESET =>
                    IF r_timer_reg = g_RESET_TIME THEN
                        IF i_new_data THEN
                            state_next <= S_SEND_DATA;
                        ELSE
                            state_next <= S_WAIT;
                        END IF;
                    ELSE
                        state_next <= S_RESET;
                    END IF;
                WHEN S_WAIT =>
                    IF i_new_data THEN
                        state_next <= S_SEND_DATA;
                    ELSE
                        state_next <= S_WAIT;
                    END IF;
                WHEN S_SEND_DATA =>
                    IF r_count_reg = unsigned(i_active_leds) THEN
                        state_next <= S_RESET;
                    ELSE
                        state_next <= S_SEND_DATA;
                    END IF;
                WHEN OTHERS =>
                    -- we have encountered error:
                    state_next <= S_IDLE;
            END CASE;

        END IF;
    END PROCESS;

    ------------------------ outputs ------------------------;
    o_sent_done <= r_send_done_reg;
    o_rd_addr <= STD_LOGIC_VECTOR(r_count_reg);
    o_send_dv <= r_send_dv_reg;
    o_send_en <= r_send_en_reg;
END ARCHITECTURE;