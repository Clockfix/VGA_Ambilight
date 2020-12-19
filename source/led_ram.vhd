-----------------------------
-- Author - Imants Pulkstenis
-- Date - 08.11.2020 
-- Project name - VGA_Ambilight  
-- Module name - LED RAM
--
-- Detailed module description
-- RAM memory contains 1024 24bit words with color data
-- that need to be sent to LED
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------
LIBRARY ieee; --always use this library
USE ieee.std_logic_1164.ALL; --always use this library
USE ieee.numeric_std.ALL; --use this library if arithmetic require

--LIBRARY altera_mf;
--USE altera_mf.altera_mf_components.ALL;

USE work.functions.ALL;

ENTITY led_ram IS
    PORT (
        i_clk : IN STD_LOGIC;
        i_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        o_data : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
        i_rd_addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        i_wr_addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        --  i_ren : IN STD_LOGIC;
        i_wen : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
END ENTITY;




ARCHITECTURE rtl OF led_ram IS
    ------------------ signal declaration -------------------
component blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END component;

BEGIN

    ------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
    ram2port_inst :   blk_mem_gen_0
        PORT MAP(
            clka => i_clk,
            ena => '1',
            wea => i_wen,
            addra => i_wr_addr,
            dina => i_data,
            clkb => i_clk,
            enb => '1',
            addrb => i_rd_addr,
            doutb => o_data
        );
    -- INST_TAG_END ------ End INSTANTIATION Template ---------
    -------------------- reg-state logic --------------------

    ------------------- next-state logic --------------------

    ------------------------ outputs ------------------------

END rtl;