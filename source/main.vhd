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

LIBRARY work; -- this is implicit
USE work.functions.ALL;

ENTITY main IS
    PORT (
        i_clk : IN STD_LOGIC
    );
END main;

ARCHITECTURE rtl OF main IS
    -- signal declaration
    -- <your code goes here>

BEGIN
    -- reg-state logic
    -- <your code goes here>

    -- next-state logic
    -- <your code goes here>

    -- outputs
    -- <your code goes here>

END rtl;