-----------------------------
-- Author - Imants Pulkstenis
-- Date - 08.11.2020 
-- Project name - VGA_Ambilight  
-- Module name - Output module
--
-- Detailed module description
-- Output module consists of 2-port RAM, FSM and bit_sender module.
-- Top entity write in memory LED color value and set new_data "HIGH" 
-- to indicate that data in memory have changes and need to be transmitted
-- again. If new_data is always "HIGH" then data will be transmitted continuously
-- no mater what.
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
LIBRARY work;

ENTITY output_module IS
    GENERIC (
        -- generic parameters - passed here from calling entity
        g_LED_COUNT : NATURAL := 1024;
        g_RESET_TIME : NATURAL := 2700 * 2 -- mus be larger then 50us => 2500 * 20ns =50us
    );
    PORT (
        i_clk : IN STD_LOGIC;
        --i_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        --i_wr_addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        --i_wen : IN STD_LOGIC;
        o_data_out : OUT STD_LOGIC;
        o_sent_done : OUT STD_LOGIC;
        i_ram_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        o_ram_addr : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF output_module IS

    ------------------ signal declaration -------------------
    SIGNAL w_send_done : STD_LOGIC; -- connects bit_sender with FSM

    SIGNAL w_rd_addr : STD_LOGIC_VECTOR(9 DOWNTO 0); -- connects memory with FSM
    -- SIGNAL w_rd_data : STD_LOGIC_VECTOR(23 DOWNTO 0); -- connects memory with bit_sender

    SIGNAL w_send_en : STD_LOGIC; -- connects FSM with bit_sender (enable)
    SIGNAL w_send_dv : STD_LOGIC; -- connects FSM with bit_sender (data valid)
BEGIN
    sender_fsm_inst : ENTITY work.sender_fsm
        GENERIC MAP(
            g_RESET_TIME => g_RESET_TIME
        )
        PORT MAP(
            i_clk => i_clk,
            i_enable => '1',
            o_send_en => w_send_en,
            o_send_dv => w_send_dv,
            i_active_leds => STD_LOGIC_VECTOR(to_unsigned(g_LED_COUNT, 10)),
            o_rd_addr => w_rd_addr,
            i_new_data => '1',
            i_sent_done => w_send_done, -- from bit_sender
            o_sent_done => o_sent_done
        );

    bit_sender_inst : ENTITY work.bit_sender
        GENERIC MAP(
            g_FIRST_MAX_VALUE => 20 * 2,
            g_SECOND_MAX_VALUE => 40 * 2,
            g_BIT_COUNTER_MAX_VALUE => 60 * 2,
            g_DATA_WIDTH => 24
        )
        PORT MAP(
            i_clk => i_clk,
            i_data => i_ram_data, -- to mach RGB on LEDs 
            i_data_valid => w_send_dv,
            i_enable => w_send_en,
            o_send_done => w_send_done, -- to FSM
            o_data_out => o_data_out
        );
    -------------------- reg-state logic --------------------

    ------------------- next-state logic --------------------

    ------------------------ outputs ------------------------
    o_ram_addr <= w_rd_addr;
END ARCHITECTURE;