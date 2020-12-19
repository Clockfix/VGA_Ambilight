-----------------------------
-- Author - Imants Pulkstenis
-- Date - 29.10.2020 
-- Project name - VGA_Ambilight  
-- Module name - main - TOP entity
--
-- Detailed module description
-- Top module
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------
LIBRARY ieee; --always use this library
USE ieee.std_logic_1164.ALL; --always use this library
USE ieee.numeric_std.ALL; --use this library if arithmetic require

USE work.functions.ALL;
LIBRARY work;

ENTITY main IS
    GENERIC (
        -- generic parameters - passed here from calling entity
        g_LED_COUNT : NATURAL := 2;
        g_RESET_TIME : NATURAL := 2500 * 3 -- mus be larger then 50us => 2500 * 2 * 10ns =50us
    );
    PORT (
        i_clk : IN STD_LOGIC;
        o_data_out : OUT STD_LOGIC;
        o_sent_done : OUT STD_LOGIC
    );
END main;

ARCHITECTURE rtl OF main IS
    -- signal declaration
    -- <your code goes here>

BEGIN
    -- reg-state logic
    -- <your code goes here>
    output_module_inst : ENTITY work.output_module
        GENERIC MAP(
            g_LED_COUNT => g_LED_COUNT,
            g_RESET_TIME => g_RESET_TIME
        )
        PORT MAP(
            i_clk => i_clk,
            i_data => x"0000ff",
            i_wr_addr => "0000000001",
            i_wen => (OTHERS => '1'),
            o_data_out => o_data_out,
            o_sent_done => o_sent_done
        );
    -- next-state logic
    -- <your code goes here>

    -- outputs
    -- <your code goes here>

END rtl;