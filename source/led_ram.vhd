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

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

USE work.functions.ALL;

ENTITY led_ram IS
    PORT (
        i_clk : IN STD_LOGIC;
        i_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        o_data : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
        i_rd_addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        i_wr_addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        i_ren : IN STD_LOGIC;
        i_wen : IN STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF led_ram IS
  ------------------ signal declaration -------------------
BEGIN
    ram2port_inst : ENTITY work.ram2port
        PORT MAP(
            clock => i_clk,
            data => i_data,
            rdaddress => i_rd_addr,
            rden => i_ren,
            wraddress => i_wr_addr,
            wren => i_wen,
            q => o_data
        );
  

    -------------------- reg-state logic --------------------

    ------------------- next-state logic --------------------

    ------------------------ outputs ------------------------

END rtl;