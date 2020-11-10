LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY output_module_tb IS
END ENTITY;
ARCHITECTURE rtl OF output_module_tb IS
    -- constants                                                 
    -- signals                                                   
    SIGNAL i_clk : STD_LOGIC;
    SIGNAL i_data : STD_LOGIC_VECTOR(23 DOWNTO 0);
    SIGNAL i_wr_addr : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL i_wen : STD_LOGIC;
    SIGNAL o_data_out : STD_LOGIC;
    SIGNAL o_sent_done : STD_LOGIC;

    COMPONENT output_module
        PORT (
            i_clk : IN STD_LOGIC;
            i_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
            i_wr_addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            i_wen : IN STD_LOGIC;
            o_data_out : OUT STD_LOGIC;
            o_sent_done : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    ------------------------------------------------------------------------------
    -- Instantiate DUT
    ------------------------------------------------------------------------------
    DUT : output_module
    PORT MAP(
        -- list connections between master ports and signals
        i_clk => i_clk,
        i_data => i_data,
        i_wr_addr => i_wr_addr,
        i_wen => i_wen,
        o_data_out => o_data_out,
        o_sent_done => o_sent_done
    );

    ------------------------------------------------------------------------------
    -- Clock (bad practice)
    ------------------------------------------------------------------------------

    PROCESS
    BEGIN
        WAIT FOR 10 ns;
        i_clk <= NOT i_clk;
    END PROCESS;
    ------------------------------------------------------------------------------
    -- Model-based test
    ------------------------------------------------------------------------------

    PROCESS
    BEGIN

        i_wen <= '1';
        i_wr_addr <= "0000000000";
        i_data <= X"F00002";
        WAIT FOR 40 ns;
        i_wen <= '0';
        i_wr_addr <= "0000000001";
        i_data <= X"F05008";
        WAIT FOR 60 ns;
        i_wen <= '1';
        WAIT FOR 20 ns;
        i_wen <= '0';
        i_wr_addr <= "0000000010";
        i_data <= X"F05099";
        WAIT FOR 60 ns;
        i_wen <= '1';
        WAIT FOR 20 ns;
        i_wen <= '0';
        i_wr_addr <= "0000000011";
        i_data <= X"F0aa55";
        WAIT FOR 60 ns;
        i_wen <= '1';
        WAIT FOR 20 ns;
        i_wen <= '0';

        WAIT FOR 500 us;
        -- wait; -- end of test
        REPORT"TEST SUCCESSFUL";

    END PROCESS;

END rtl;