LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bit_sender_tb IS
END ENTITY;
ARCHITECTURE rtl OF bit_sender_tb IS
    -- constants                                                 
    -- signals                                                   
    SIGNAL i_clk : STD_LOGIC;
    SIGNAL i_data : STD_LOGIC_VECTOR(23 DOWNTO 0);
    SIGNAL i_data_valid : STD_LOGIC;
    SIGNAL i_enable : STD_LOGIC;
    SIGNAL o_data_out : STD_LOGIC;
    SIGNAL o_send_done : STD_LOGIC;
    COMPONENT bit_sender
        PORT (
            i_clk : IN STD_LOGIC;
            i_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
            i_data_valid : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            o_data_out : BUFFER STD_LOGIC;
            o_send_done : BUFFER STD_LOGIC
        );
    END COMPONENT;
BEGIN
    ------------------------------------------------------------------------------
    -- Instantiate DUT
    ------------------------------------------------------------------------------
    DUT : bit_sender
    PORT MAP(
        -- list connections between master ports and signals
        i_clk => i_clk,
        i_data => i_data,
        i_data_valid => i_data_valid,
        i_enable => i_enable,
        o_data_out => o_data_out,
        o_send_done => o_send_done
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

        i_enable <= '0';
        i_data_valid <= '0';
        i_data <= X"F00002";
        WAIT FOR 1 us;
        i_enable <= '1';
        i_data_valid <= '0';
        i_data <= X"F0C022";
        WAIT FOR 1 us;
        i_data_valid <= '1';
        WAIT FOR 10 us;
        i_enable <= '0';
        i_data <= X"F0FFF2";
        WAIT FOR 10 us;
        i_enable <= '1';
        WAIT FOR 20 us;
        i_data <= X"70CCA2";
        WAIT FOR 20 us;
        -- wait; -- end of test
        REPORT"TEST SUCCESSFUL";

    END PROCESS;

END rtl;