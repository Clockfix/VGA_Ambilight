-----------------------------
-- Author - Imants Pulkstenis
-- Date - 19.01.2021 
-- Project name - VGA_Ambilight  
-- Module name - Interconnect between HPS and FPGA (Allow FPGA user HPS GPIO)
--
-- Detailed module description
-- interconnect
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------
LIBRARY ieee; --always use this library
USE ieee.std_logic_1164.ALL; --always use this library
USE ieee.numeric_std.ALL; --use this library if arithmetic require

LIBRARY work; -- this is implicit
USE work.functions.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY interconnect IS
    PORT (
        --------------------------------------------
        --  HPS connections
        --------------------------------------------
        d_out_in : IN STD_LOGIC_VECTOR(66 DOWNTO 0); -- in
        d_out_out : OUT STD_LOGIC_VECTOR(66 DOWNTO 0); -- out
        d_out_oe : OUT STD_LOGIC_VECTOR(66 DOWNTO 0); -- o
        i_ram_readdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0); --         .readdata
        o_writedata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --         .writedata
        o_ram_byteenable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --         .byteenable
        o_ram_address : OUT STD_LOGIC_VECTOR(12 DOWNTO 0); -- address
        --------------------------------------------
        --  FPGA connections
        --------------------------------------------
        o_ram_data : OUT STD_LOGIC_VECTOR(23 DOWNTO 0); --         .readdata
        i_ram_address : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- address
        -- HPS LEDs
        i_led : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --   input from FPGA   
        --
        o_data : IN STD_LOGIC --;
    );
END interconnect;

ARCHITECTURE rtl OF interconnect IS
    -- signal declaration
    -- <your code goes here>
    SIGNAL w_oe : STD_LOGIC_VECTOR(66 DOWNTO 0);
    SIGNAL w_output : STD_LOGIC_VECTOR(66 DOWNTO 0);
    SIGNAL w_input : STD_LOGIC_VECTOR(66 DOWNTO 0);
BEGIN
    ---------------------------------------------
    -- reg-state logic
    ---------------------------------------------
    -- 

    ---------------------------------------------
    -- next-state logic
    ---------------------------------------------
    -- 
 PROCESS (ALL)
 BEGIN
    w_oe <= (OTHERS => '0');
    w_output <= (OTHERS => '0');
    w_input <= d_out_in;

    w_oe(51) <= '1';
    w_output(51) <= o_data;

    w_oe(53) <= '1';
    w_oe(54) <= '1';
    w_oe(55) <= '1';
    w_oe(56) <= '1';
    w_output(53) <= i_led(0);
    w_output(54) <= i_led(1);
    w_output(55) <= i_led(2);
    w_output(56) <= i_led(3);
  END PROCESS;
    ---------------------------------------------
    -- outputs
    ---------------------------------------------
    -- 
    d_out_oe <= w_oe;
    d_out_out <= w_output;
    -- RAM
    o_ram_byteenable <= "0111";
    o_ram_address <= "000" & i_ram_address;
    o_ram_data <= i_ram_readdata(23 DOWNTO 0);
END rtl;