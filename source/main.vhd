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

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY main IS
    PORT (
        i_clk : IN STD_LOGIC; --  main clock on PCB
        o_led : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- LEDS on DE0 board
        --------------------------------------------
        --  Output to LED strip
        --------------------------------------------        
        o_led_data : OUT STD_LOGIC; -- Output to LED strip  [ GPIO 0 PIN 1 -> PIN_V12]
        --------------------------------------------
        --  Connection to ADC
        --------------------------------------------        
        i_ADC_DOUT : IN STD_LOGIC; -- sampled data
        o_ADC_DIN : OUT STD_LOGIC; -- 6 configuration bits for ADC operation mode
        o_ADC_SCLK : OUT STD_LOGIC; -- ADC clk
        o_ADC_CONVST : OUT STD_LOGIC := '0'; -- conversion start (chip select)
        --------------------------------------------
        --  Connection to vga_sync_pulse_counter
        --------------------------------------------  
        i_v_sync : IN STD_LOGIC;
        i_h_sync : IN STD_LOGIC;
        --------------------------------------------
        --  HPS connections
        --------------------------------------------
        hps_io_hps_io_emac1_inst_TX_CLK : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CLK
        hps_io_hps_io_emac1_inst_TXD0 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD0
        hps_io_hps_io_emac1_inst_TXD1 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD1
        hps_io_hps_io_emac1_inst_TXD2 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD2
        hps_io_hps_io_emac1_inst_TXD3 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD3
        hps_io_hps_io_emac1_inst_RXD0 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD0
        hps_io_hps_io_emac1_inst_MDIO : INOUT STD_LOGIC := 'X'; -- hps_io_emac1_inst_MDIO
        hps_io_hps_io_emac1_inst_MDC : OUT STD_LOGIC; -- hps_io_emac1_inst_MDC
        hps_io_hps_io_emac1_inst_RX_CTL : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CTL
        hps_io_hps_io_emac1_inst_TX_CTL : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CTL
        hps_io_hps_io_emac1_inst_RX_CLK : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CLK
        hps_io_hps_io_emac1_inst_RXD1 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD1
        hps_io_hps_io_emac1_inst_RXD2 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD2
        hps_io_hps_io_emac1_inst_RXD3 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD3
        hps_io_hps_io_sdio_inst_CMD : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_CMD
        hps_io_hps_io_sdio_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D0
        hps_io_hps_io_sdio_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D1
        hps_io_hps_io_sdio_inst_CLK : OUT STD_LOGIC; -- hps_io_sdio_inst_CLK
        hps_io_hps_io_sdio_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D2
        hps_io_hps_io_sdio_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D3
        hps_io_hps_io_usb1_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D0
        hps_io_hps_io_usb1_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D1
        hps_io_hps_io_usb1_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D2
        hps_io_hps_io_usb1_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D3
        hps_io_hps_io_usb1_inst_D4 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D4
        hps_io_hps_io_usb1_inst_D5 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D5
        hps_io_hps_io_usb1_inst_D6 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D6
        hps_io_hps_io_usb1_inst_D7 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D7
        hps_io_hps_io_usb1_inst_CLK : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_CLK
        hps_io_hps_io_usb1_inst_STP : OUT STD_LOGIC; -- hps_io_usb1_inst_STP
        hps_io_hps_io_usb1_inst_DIR : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_DIR
        hps_io_hps_io_usb1_inst_NXT : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_NXT
        hps_io_hps_io_spim1_inst_CLK : OUT STD_LOGIC; -- hps_io_spim1_inst_CLK
        hps_io_hps_io_spim1_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim1_inst_MOSI
        hps_io_hps_io_spim1_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim1_inst_MISO
        hps_io_hps_io_spim1_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim1_inst_SS0
        hps_io_hps_io_uart0_inst_RX : IN STD_LOGIC := 'X'; -- hps_io_uart0_inst_RX
        hps_io_hps_io_uart0_inst_TX : OUT STD_LOGIC; -- hps_io_uart0_inst_TX
        hps_io_hps_io_i2c0_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SDA
        hps_io_hps_io_i2c0_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SCL
        hps_io_hps_io_i2c1_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SDA
        hps_io_hps_io_i2c1_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SCL
        hps_io_hps_io_gpio_inst_GPIO09 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO09
        hps_io_hps_io_gpio_inst_GPIO35 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO35
        hps_io_hps_io_gpio_inst_GPIO40 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO40
        hps_io_hps_io_gpio_inst_GPIO53 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO53
        hps_io_hps_io_gpio_inst_GPIO54 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO54
        hps_io_hps_io_gpio_inst_GPIO61 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO61
        memory_mem_a : OUT STD_LOGIC_VECTOR(14 DOWNTO 0); -- mem_a
        memory_mem_ba : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- mem_ba
        memory_mem_ck : OUT STD_LOGIC; -- mem_ck
        memory_mem_ck_n : OUT STD_LOGIC; -- mem_ck_n
        memory_mem_cke : OUT STD_LOGIC; -- mem_cke
        memory_mem_cs_n : OUT STD_LOGIC; -- mem_cs_n
        memory_mem_ras_n : OUT STD_LOGIC; -- mem_ras_n
        memory_mem_cas_n : OUT STD_LOGIC; -- mem_cas_n
        memory_mem_we_n : OUT STD_LOGIC; -- mem_we_n
        memory_mem_reset_n : OUT STD_LOGIC; -- mem_reset_n
        memory_mem_dq : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- mem_dq
        memory_mem_dqs : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs
        memory_mem_dqs_n : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs_n
        memory_mem_odt : OUT STD_LOGIC; -- mem_odt
        memory_mem_dm : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- mem_dm
        memory_oct_rzqin : IN STD_LOGIC := 'X' -- oct_rzqin
    );
END main;

ARCHITECTURE rtl OF main IS
    -- signal declaration
    -- <your code goes here>
    SIGNAL w_clock_40m : STD_LOGIC; -- main clock 40MHz from HPS to FPGA
    SIGNAL w_clock_100m : STD_LOGIC; -- main clock 100MHz from HPS to FPGA
    SIGNAL w_hps_reset_n : STD_LOGIC; -- main reset for HPS and FPGA

    --------------------------------------------
    --  ADC output buss
    --------------------------------------------

    SIGNAL w_adc_data : STD_LOGIC_VECTOR(11 DOWNTO 0);

    --------------------------------------------
    --  LED memory wires
    --------------------------------------------

    SIGNAL w_fpga_ram_address : STD_LOGIC_VECTOR(9 DOWNTO 0); -- address
    SIGNAL w_fpga_ram_readdata : STD_LOGIC_VECTOR(31 DOWNTO 0); --         .readdata

    --------------------------------------------
    --  SoC HPS system component
    --------------------------------------------
    COMPONENT soc_system IS
        PORT (
            clk_clk : IN STD_LOGIC := 'X'; -- clk
            hps_io_hps_io_emac1_inst_TX_CLK : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3 : OUT STD_LOGIC; -- hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO : INOUT STD_LOGIC := 'X'; -- hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC : OUT STD_LOGIC; -- hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL : OUT STD_LOGIC; -- hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3 : IN STD_LOGIC := 'X'; -- hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK : OUT STD_LOGIC; -- hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7 : INOUT STD_LOGIC := 'X'; -- hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP : OUT STD_LOGIC; -- hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT : IN STD_LOGIC := 'X'; -- hps_io_usb1_inst_NXT
            hps_io_hps_io_spim1_inst_CLK : OUT STD_LOGIC; -- hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX : IN STD_LOGIC := 'X'; -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX : OUT STD_LOGIC; -- hps_io_uart0_inst_TX
            hps_io_hps_io_i2c0_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SDA
            hps_io_hps_io_i2c0_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c0_inst_SCL
            hps_io_hps_io_i2c1_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SDA
            hps_io_hps_io_i2c1_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO09 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO09
            hps_io_hps_io_gpio_inst_GPIO35 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO35
            hps_io_hps_io_gpio_inst_GPIO40 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO40
            hps_io_hps_io_gpio_inst_GPIO53 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO54
            hps_io_hps_io_gpio_inst_GPIO61 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO61
            i_vga_ram_clk_clk : IN STD_LOGIC := 'X'; -- clk
            i_vga_ram_rst_reset : IN STD_LOGIC := 'X'; -- reset
            i_vga_ram_rst_reset_req : IN STD_LOGIC := 'X'; -- reset_req
            memory_mem_a : OUT STD_LOGIC_VECTOR(14 DOWNTO 0); -- mem_a
            memory_mem_ba : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- mem_ba
            memory_mem_ck : OUT STD_LOGIC; -- mem_ck
            memory_mem_ck_n : OUT STD_LOGIC; -- mem_ck_n
            memory_mem_cke : OUT STD_LOGIC; -- mem_cke
            memory_mem_cs_n : OUT STD_LOGIC; -- mem_cs_n
            memory_mem_ras_n : OUT STD_LOGIC; -- mem_ras_n
            memory_mem_cas_n : OUT STD_LOGIC; -- mem_cas_n
            memory_mem_we_n : OUT STD_LOGIC; -- mem_we_n
            memory_mem_reset_n : OUT STD_LOGIC; -- mem_reset_n
            memory_mem_dq : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- mem_dq
            memory_mem_dqs : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs
            memory_mem_dqs_n : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- mem_dqs_n
            memory_mem_odt : OUT STD_LOGIC; -- mem_odt
            memory_mem_dm : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- mem_dm
            memory_oct_rzqin : IN STD_LOGIC := 'X'; -- oct_rzqin
            o_clock_100m_clk : OUT STD_LOGIC; -- clk
            o_clock_40m_clk : OUT STD_LOGIC; -- clk
            led_ram_address : IN STD_LOGIC_VECTOR(10 DOWNTO 0) := (OTHERS => 'X'); -- address
            led_ram_chipselect : IN STD_LOGIC := 'X'; -- chipselect
            led_ram_clken : IN STD_LOGIC := 'X'; -- clken
            led_ram_write : IN STD_LOGIC := 'X'; -- write
            led_ram_readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- readdata
            led_ram_writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- writedata
            led_ram_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- byteenable
            vga_ram_address : IN STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => 'X'); -- address
            vga_ram_chipselect : IN STD_LOGIC := 'X'; -- chipselect
            vga_ram_clken : IN STD_LOGIC := 'X'; -- clken
            vga_ram_write : IN STD_LOGIC := 'X'; -- write
            vga_ram_readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- readdata
            vga_ram_writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- writedata
            vga_ram_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- byteenable
            reset_reset_n : IN STD_LOGIC := 'X' -- reset_n
        );
    END COMPONENT soc_system;

BEGIN
    soc_system_inst : COMPONENT soc_system
        PORT MAP(
            clk_clk => i_clk, --           clk.clk
            hps_io_hps_io_emac1_inst_TX_CLK => hps_io_hps_io_emac1_inst_TX_CLK, --        hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0 => hps_io_hps_io_emac1_inst_TXD0, --              .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1 => hps_io_hps_io_emac1_inst_TXD1, --              .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2 => hps_io_hps_io_emac1_inst_TXD2, --              .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3 => hps_io_hps_io_emac1_inst_TXD3, --              .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0 => hps_io_hps_io_emac1_inst_RXD0, --              .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO => hps_io_hps_io_emac1_inst_MDIO, --              .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC => hps_io_hps_io_emac1_inst_MDC, --              .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => hps_io_hps_io_emac1_inst_RX_CTL, --              .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => hps_io_hps_io_emac1_inst_TX_CTL, --              .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => hps_io_hps_io_emac1_inst_RX_CLK, --              .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1 => hps_io_hps_io_emac1_inst_RXD1, --              .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2 => hps_io_hps_io_emac1_inst_RXD2, --              .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3 => hps_io_hps_io_emac1_inst_RXD3, --              .hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD => hps_io_hps_io_sdio_inst_CMD, --              .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0 => hps_io_hps_io_sdio_inst_D0, --              .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1 => hps_io_hps_io_sdio_inst_D1, --              .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK => hps_io_hps_io_sdio_inst_CLK, --              .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2 => hps_io_hps_io_sdio_inst_D2, --              .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3 => hps_io_hps_io_sdio_inst_D3, --              .hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0 => hps_io_hps_io_usb1_inst_D0, --              .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1 => hps_io_hps_io_usb1_inst_D1, --              .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2 => hps_io_hps_io_usb1_inst_D2, --              .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3 => hps_io_hps_io_usb1_inst_D3, --              .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4 => hps_io_hps_io_usb1_inst_D4, --              .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5 => hps_io_hps_io_usb1_inst_D5, --              .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6 => hps_io_hps_io_usb1_inst_D6, --              .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7 => hps_io_hps_io_usb1_inst_D7, --              .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK => hps_io_hps_io_usb1_inst_CLK, --              .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP => hps_io_hps_io_usb1_inst_STP, --              .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR => hps_io_hps_io_usb1_inst_DIR, --              .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT => hps_io_hps_io_usb1_inst_NXT, --              .hps_io_usb1_inst_NXT
            hps_io_hps_io_spim1_inst_CLK => hps_io_hps_io_spim1_inst_CLK, --              .hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI => hps_io_hps_io_spim1_inst_MOSI, --              .hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO => hps_io_hps_io_spim1_inst_MISO, --              .hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0 => hps_io_hps_io_spim1_inst_SS0, --              .hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX => hps_io_hps_io_uart0_inst_RX, --              .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX => hps_io_hps_io_uart0_inst_TX, --              .hps_io_uart0_inst_TX
            hps_io_hps_io_i2c0_inst_SDA => hps_io_hps_io_i2c0_inst_SDA, --              .hps_io_i2c0_inst_SDA
            hps_io_hps_io_i2c0_inst_SCL => hps_io_hps_io_i2c0_inst_SCL, --              .hps_io_i2c0_inst_SCL
            hps_io_hps_io_i2c1_inst_SDA => hps_io_hps_io_i2c1_inst_SDA, --              .hps_io_i2c1_inst_SDA
            hps_io_hps_io_i2c1_inst_SCL => hps_io_hps_io_i2c1_inst_SCL, --              .hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO09 => hps_io_hps_io_gpio_inst_GPIO09, --              .hps_io_gpio_inst_GPIO09
            hps_io_hps_io_gpio_inst_GPIO35 => hps_io_hps_io_gpio_inst_GPIO35, --              .hps_io_gpio_inst_GPIO35
            hps_io_hps_io_gpio_inst_GPIO40 => hps_io_hps_io_gpio_inst_GPIO40, --              .hps_io_gpio_inst_GPIO40
            hps_io_hps_io_gpio_inst_GPIO53 => hps_io_hps_io_gpio_inst_GPIO53, --              .hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54 => hps_io_hps_io_gpio_inst_GPIO54, --              .hps_io_gpio_inst_GPIO54
            hps_io_hps_io_gpio_inst_GPIO61 => hps_io_hps_io_gpio_inst_GPIO61, --              .hps_io_gpio_inst_GPIO61
            i_vga_ram_clk_clk => w_clock_40m, -- i_vga_ram_clk.clk
            i_vga_ram_rst_reset => '0', -- i_vga_ram_rst.reset
            i_vga_ram_rst_reset_req => '0', --              .reset_req
            memory_mem_a => memory_mem_a, --        memory.mem_a
            memory_mem_ba => memory_mem_ba, --              .mem_ba
            memory_mem_ck => memory_mem_ck, --              .mem_ck
            memory_mem_ck_n => memory_mem_ck_n, --              .mem_ck_n
            memory_mem_cke => memory_mem_cke, --              .mem_cke
            memory_mem_cs_n => memory_mem_cs_n, --              .mem_cs_n
            memory_mem_ras_n => memory_mem_ras_n, --              .mem_ras_n
            memory_mem_cas_n => memory_mem_cas_n, --              .mem_cas_n
            memory_mem_we_n => memory_mem_we_n, --              .mem_we_n
            memory_mem_reset_n => memory_mem_reset_n, --              .mem_reset_n
            memory_mem_dq => memory_mem_dq, --              .mem_dq
            memory_mem_dqs => memory_mem_dqs, --              .mem_dqs
            memory_mem_dqs_n => memory_mem_dqs_n, --              .mem_dqs_n
            memory_mem_odt => memory_mem_odt, --              .mem_odt
            memory_mem_dm => memory_mem_dm, --              .mem_dm
            memory_oct_rzqin => memory_oct_rzqin, --              .oct_rzqin
            o_clock_100m_clk => w_clock_100m, --  o_clock_100m.clk
            o_clock_40m_clk => w_clock_40m, --   o_clock_40m.clk
            led_ram_address => '1' & w_fpga_ram_address, --       led_ram.address
            led_ram_chipselect => '1', --              .chipselect
            led_ram_clken => '1', --              .clken
            led_ram_write => '0', --              .write
            led_ram_readdata => w_fpga_ram_readdata, --              .readdata
            -- led_ram_writedata               => led_ram_writedata,               --              .writedata
            led_ram_byteenable => "1111", --              .byteenable
            -- vga_ram_address                 => vga_ram_address,                 --       vga_ram.address
            vga_ram_chipselect => '1', --              .chipselect
            vga_ram_clken => '1', --              .clken
            -- vga_ram_write                   => vga_ram_write,                   --              .write
            -- vga_ram_readdata                => vga_ram_readdata,                --              .readdata
            -- vga_ram_writedata               => vga_ram_writedata,               --              .writedata
            -- vga_ram_byteenable              => vga_ram_byteenable,              --              .byteenable
            reset_reset_n => '1' --         reset.reset_n
        );

        -- --------------------------------------------
        -- --  Interconnect module
        -- --------------------------------------------
        -- interconnect_inst : ENTITY work.interconnect
        --     PORT MAP(
        --         d_out_in => w_input, -- in
        --         d_out_out => w_output, -- out
        --         d_out_oe => w_oe, -- o
        --         -- RAM
        --         i_ram_readdata => w_ram_readdata, --         .readdata
        --         o_writedata => w_ram_writedata, --         .writedata
        --         o_ram_byteenable => w_ram_byteenable, --         .byteenable
        --         o_ram_address => w_ram_address, -- address
        --         --  FPGA connections
        --         o_ram_data => w_fpga_ram_readdata, --         .readdata
        --         i_ram_address => w_fpga_ram_address, -- address
        --         i_led => w_ram_readdata(7 DOWNTO 4),
        --         -- 
        --         o_data => w_data_out --,
        --     );

        --------------------------------------------
        --  Output module
        --------------------------------------------
        output_module_inst : ENTITY work.output_module
            GENERIC MAP(
                -- generic parameters - passed here from calling entity
                g_LED_COUNT => 256,
                g_RESET_TIME => 70000 -- must be larger then 50us => 2500 * 20ns =50us
            )
            PORT MAP(
                i_clk => w_clock_100m,
                o_data_out => o_led_data,
                -- o_sent_done =>   ,
                i_ram_data => w_fpga_ram_readdata(23 DOWNTO 0),
                o_ram_addr => w_fpga_ram_address
            );

        ADC_spi_master_inst : ENTITY work.ADC_spi_master
            PORT MAP(
                ADC_clk => w_clock_40m, -- 40 MHz clock is needed
                ADC_DOUT => i_ADC_DOUT, -- sampled data
                ADC_DIN => o_ADC_DIN, -- 6 configuration bits for ADC operation mode
                ADC_SCLK => o_ADC_SCLK, -- ADC clk
                ADC_CONVST => o_ADC_CONVST, -- conversion start (chip select)
                --config_bits	=> "100010",
                test_out => w_adc_data
            );

        vga_sync_pulse_counter_inst : ENTITY work.vga_sync_pulse_counter
            PORT MAP(
                v_sync => i_v_sync,
                h_sync => i_h_sync,
                VGA_clk => w_clock_40m--,
                -- send  => 
                -- v  => 
                -- h  => 
            );

        -- reg-state logic
        -- <your code goes here>

        -- next-state logic
        -- <your code goes here>

        -- outputs
        -- <your code goes here>

        o_led <= w_adc_data(11 DOWNTO 4);
    END rtl;