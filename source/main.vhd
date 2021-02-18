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
        i_clk : IN STD_LOGIC;
        -- o_led : OUT STD_LOGIC;
        o_led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
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
        hps_io_hps_io_qspi_inst_IO0 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO0
        hps_io_hps_io_qspi_inst_IO1 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO1
        hps_io_hps_io_qspi_inst_IO2 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO2
        hps_io_hps_io_qspi_inst_IO3 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO3
        hps_io_hps_io_qspi_inst_SS0 : OUT STD_LOGIC; -- hps_io_qspi_inst_SS0
        hps_io_hps_io_qspi_inst_CLK : OUT STD_LOGIC; -- hps_io_qspi_inst_CLK
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
        hps_io_hps_io_spim0_inst_CLK : OUT STD_LOGIC; -- hps_io_spim0_inst_CLK
        hps_io_hps_io_spim0_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim0_inst_MOSI
        hps_io_hps_io_spim0_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim0_inst_MISO
        hps_io_hps_io_spim0_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim0_inst_SS0
        hps_io_hps_io_spim1_inst_CLK : OUT STD_LOGIC; -- hps_io_spim1_inst_CLK
        hps_io_hps_io_spim1_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim1_inst_MOSI
        hps_io_hps_io_spim1_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim1_inst_MISO
        hps_io_hps_io_spim1_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim1_inst_SS0
        hps_io_hps_io_uart0_inst_RX : IN STD_LOGIC := 'X'; -- hps_io_uart0_inst_RX
        hps_io_hps_io_uart0_inst_TX : OUT STD_LOGIC; -- hps_io_uart0_inst_TX
        -- hps_io_hps_io_i2c1_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SDA
        -- hps_io_hps_io_i2c1_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SCL
        hps_io_hps_io_gpio_inst_GPIO09 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO09
        hps_io_hps_io_gpio_inst_GPIO28 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO28
        hps_io_hps_io_gpio_inst_GPIO35 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO35
        hps_io_hps_io_gpio_inst_GPIO40 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO40
        hps_io_hps_io_gpio_inst_GPIO42 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO42
        hps_io_hps_io_gpio_inst_GPIO43 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO43
        hps_io_hps_io_gpio_inst_GPIO48 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO48
        hps_io_hps_io_gpio_inst_GPIO61 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO61
        hps_io_hps_io_gpio_inst_GPIO62 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO62
        hps_io_hps_io_gpio_inst_LOANIO00 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO00
        hps_io_hps_io_gpio_inst_LOANIO41 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO41
        hps_io_hps_io_gpio_inst_LOANIO51 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO51
        hps_io_hps_io_gpio_inst_LOANIO52 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO52
        hps_io_hps_io_gpio_inst_LOANIO53 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO53
        hps_io_hps_io_gpio_inst_LOANIO54 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO54
        hps_io_hps_io_gpio_inst_LOANIO55 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO55
        hps_io_hps_io_gpio_inst_LOANIO56 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO56
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
        HPS_reset_n : IN STD_LOGIC := 'X' --CONNECTED_TO_reset_reset_n, --    reset.reset_n
    );
END main;

ARCHITECTURE rtl OF main IS
    -- signal declaration
    -- <your code goes here>
    SIGNAL w_clock_100m : STD_LOGIC; -- main clock 100MHz from HPS to FPGA
    SIGNAL w_hps_reset_n : STD_LOGIC; -- main reset for HPS and FPGA

    SIGNAL w_oe : STD_LOGIC_VECTOR(66 DOWNTO 0); ---- HPS <-> Interconnect <-> FPGA
    SIGNAL w_output : STD_LOGIC_VECTOR(66 DOWNTO 0); ---- HPS <-> Interconnect <-> FPGA
    SIGNAL w_input : STD_LOGIC_VECTOR(66 DOWNTO 0); ---- HPS <-> Interconnect <-> FPGA

    -- RAM interconnect     HPS <-> Interconnect <-> FPGA
    SIGNAL w_ram_readdata : STD_LOGIC_VECTOR(31 DOWNTO 0); --         .readdata
    SIGNAL w_ram_writedata : STD_LOGIC_VECTOR(31 DOWNTO 0); --         .writedata
    SIGNAL w_ram_byteenable : STD_LOGIC_VECTOR(3 DOWNTO 0); --         .byteenable
    SIGNAL w_ram_address : STD_LOGIC_VECTOR(12 DOWNTO 0); -- address
    -- FPGA side
    SIGNAL w_fpga_ram_address : STD_LOGIC_VECTOR(9 DOWNTO 0); -- address
    SIGNAL w_fpga_ram_readdata : STD_LOGIC_VECTOR(23 DOWNTO 0); --         .readdata

    SIGNAL w_data_out : STD_LOGIC; -- data line for LED matrix/strip
    SIGNAL w_led_done : STD_LOGIC; -- sent done indicator

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
            hps_io_hps_io_qspi_inst_IO0 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO0
            hps_io_hps_io_qspi_inst_IO1 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO1
            hps_io_hps_io_qspi_inst_IO2 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO2
            hps_io_hps_io_qspi_inst_IO3 : INOUT STD_LOGIC := 'X'; -- hps_io_qspi_inst_IO3
            hps_io_hps_io_qspi_inst_SS0 : OUT STD_LOGIC; -- hps_io_qspi_inst_SS0
            hps_io_hps_io_qspi_inst_CLK : OUT STD_LOGIC; -- hps_io_qspi_inst_CLK
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
            hps_io_hps_io_spim0_inst_CLK : OUT STD_LOGIC; -- hps_io_spim0_inst_CLK
            hps_io_hps_io_spim0_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim0_inst_MOSI
            hps_io_hps_io_spim0_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim0_inst_MISO
            hps_io_hps_io_spim0_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim0_inst_SS0
            hps_io_hps_io_spim1_inst_CLK : OUT STD_LOGIC; -- hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI : OUT STD_LOGIC; -- hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO : IN STD_LOGIC := 'X'; -- hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0 : OUT STD_LOGIC; -- hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX : IN STD_LOGIC := 'X'; -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX : OUT STD_LOGIC; -- hps_io_uart0_inst_TX
            -- hps_io_hps_io_i2c1_inst_SDA : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SDA
            -- hps_io_hps_io_i2c1_inst_SCL : INOUT STD_LOGIC := 'X'; -- hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO09 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO09
            hps_io_hps_io_gpio_inst_GPIO28 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO28
            hps_io_hps_io_gpio_inst_GPIO35 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO35
            hps_io_hps_io_gpio_inst_GPIO40 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO40
            hps_io_hps_io_gpio_inst_GPIO42 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO42
            hps_io_hps_io_gpio_inst_GPIO43 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO43
            hps_io_hps_io_gpio_inst_GPIO48 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO48
            hps_io_hps_io_gpio_inst_GPIO61 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO61
            hps_io_hps_io_gpio_inst_GPIO62 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_GPIO62
            hps_io_hps_io_gpio_inst_LOANIO00 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO00
            hps_io_hps_io_gpio_inst_LOANIO41 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO41
            hps_io_hps_io_gpio_inst_LOANIO51 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO51
            hps_io_hps_io_gpio_inst_LOANIO52 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO52
            hps_io_hps_io_gpio_inst_LOANIO53 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO53
            hps_io_hps_io_gpio_inst_LOANIO54 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO54
            hps_io_hps_io_gpio_inst_LOANIO55 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO55
            hps_io_hps_io_gpio_inst_LOANIO56 : INOUT STD_LOGIC := 'X'; -- hps_io_gpio_inst_LOANIO56
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
            ram_mm_address : IN STD_LOGIC_VECTOR(12 DOWNTO 0) := (OTHERS => 'X'); -- address
            ram_mm_chipselect : IN STD_LOGIC := 'X'; -- chipselect
            ram_mm_clken : IN STD_LOGIC := 'X'; -- clken
            ram_mm_write : IN STD_LOGIC := 'X'; -- write
            ram_mm_readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- readdata
            ram_mm_writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- writedata
            ram_mm_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'X'); -- byteenable
            reset_reset_n : IN STD_LOGIC := 'X'; -- reset_n
            clk_100m_clk : OUT STD_LOGIC; -- clk
            -- ram_clk_clk : IN STD_LOGIC := 'X'; -- clk
            -- ram_reset_reset : IN STD_LOGIC := 'X'; -- reset
            d_out_in : OUT STD_LOGIC_VECTOR(66 DOWNTO 0); -- in
            d_out_out : IN STD_LOGIC_VECTOR(66 DOWNTO 0) := (OTHERS => 'X'); -- out
            d_out_oe : IN STD_LOGIC_VECTOR(66 DOWNTO 0) := (OTHERS => 'X') -- oe
        );
    END COMPONENT soc_system;

BEGIN
    soc_system_inst : COMPONENT soc_system
        PORT MAP(
            clk_clk => i_clk, --      clk.clk
            hps_io_hps_io_emac1_inst_TX_CLK => hps_io_hps_io_emac1_inst_TX_CLK, --   hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0 => hps_io_hps_io_emac1_inst_TXD0, --         .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1 => hps_io_hps_io_emac1_inst_TXD1, --         .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2 => hps_io_hps_io_emac1_inst_TXD2, --         .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3 => hps_io_hps_io_emac1_inst_TXD3, --         .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0 => hps_io_hps_io_emac1_inst_RXD0, --         .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO => hps_io_hps_io_emac1_inst_MDIO, --         .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC => hps_io_hps_io_emac1_inst_MDC, --         .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => hps_io_hps_io_emac1_inst_RX_CTL, --         .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => hps_io_hps_io_emac1_inst_TX_CTL, --         .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => hps_io_hps_io_emac1_inst_RX_CLK, --         .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1 => hps_io_hps_io_emac1_inst_RXD1, --         .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2 => hps_io_hps_io_emac1_inst_RXD2, --         .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3 => hps_io_hps_io_emac1_inst_RXD3, --         .hps_io_emac1_inst_RXD3
            hps_io_hps_io_qspi_inst_IO0 => hps_io_hps_io_qspi_inst_IO0, --         .hps_io_qspi_inst_IO0
            hps_io_hps_io_qspi_inst_IO1 => hps_io_hps_io_qspi_inst_IO1, --         .hps_io_qspi_inst_IO1
            hps_io_hps_io_qspi_inst_IO2 => hps_io_hps_io_qspi_inst_IO2, --         .hps_io_qspi_inst_IO2
            hps_io_hps_io_qspi_inst_IO3 => hps_io_hps_io_qspi_inst_IO3, --         .hps_io_qspi_inst_IO3
            hps_io_hps_io_qspi_inst_SS0 => hps_io_hps_io_qspi_inst_SS0, --         .hps_io_qspi_inst_SS0
            hps_io_hps_io_qspi_inst_CLK => hps_io_hps_io_qspi_inst_CLK, --         .hps_io_qspi_inst_CLK
            hps_io_hps_io_sdio_inst_CMD => hps_io_hps_io_sdio_inst_CMD, --         .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0 => hps_io_hps_io_sdio_inst_D0, --         .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1 => hps_io_hps_io_sdio_inst_D1, --         .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK => hps_io_hps_io_sdio_inst_CLK, --         .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2 => hps_io_hps_io_sdio_inst_D2, --         .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3 => hps_io_hps_io_sdio_inst_D3, --         .hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0 => hps_io_hps_io_usb1_inst_D0, --         .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1 => hps_io_hps_io_usb1_inst_D1, --         .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2 => hps_io_hps_io_usb1_inst_D2, --         .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3 => hps_io_hps_io_usb1_inst_D3, --         .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4 => hps_io_hps_io_usb1_inst_D4, --         .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5 => hps_io_hps_io_usb1_inst_D5, --         .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6 => hps_io_hps_io_usb1_inst_D6, --         .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7 => hps_io_hps_io_usb1_inst_D7, --         .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK => hps_io_hps_io_usb1_inst_CLK, --         .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP => hps_io_hps_io_usb1_inst_STP, --         .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR => hps_io_hps_io_usb1_inst_DIR, --         .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT => hps_io_hps_io_usb1_inst_NXT, --         .hps_io_usb1_inst_NXT
            hps_io_hps_io_spim0_inst_CLK => hps_io_hps_io_spim0_inst_CLK, --         .hps_io_spim0_inst_CLK
            hps_io_hps_io_spim0_inst_MOSI => hps_io_hps_io_spim0_inst_MOSI, --         .hps_io_spim0_inst_MOSI
            hps_io_hps_io_spim0_inst_MISO => hps_io_hps_io_spim0_inst_MISO, --         .hps_io_spim0_inst_MISO
            hps_io_hps_io_spim0_inst_SS0 => hps_io_hps_io_spim0_inst_SS0, --         .hps_io_spim0_inst_SS0
            hps_io_hps_io_spim1_inst_CLK => hps_io_hps_io_spim1_inst_CLK, --         .hps_io_spim1_inst_CLK
            hps_io_hps_io_spim1_inst_MOSI => hps_io_hps_io_spim1_inst_MOSI, --         .hps_io_spim1_inst_MOSI
            hps_io_hps_io_spim1_inst_MISO => hps_io_hps_io_spim1_inst_MISO, --         .hps_io_spim1_inst_MISO
            hps_io_hps_io_spim1_inst_SS0 => hps_io_hps_io_spim1_inst_SS0, --         .hps_io_spim1_inst_SS0
            hps_io_hps_io_uart0_inst_RX => hps_io_hps_io_uart0_inst_RX, --         .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX => hps_io_hps_io_uart0_inst_TX, --         .hps_io_uart0_inst_TX
            -- hps_io_hps_io_i2c1_inst_SDA => hps_io_hps_io_i2c1_inst_SDA, --         .hps_io_i2c1_inst_SDA
            -- hps_io_hps_io_i2c1_inst_SCL => hps_io_hps_io_i2c1_inst_SCL, --         .hps_io_i2c1_inst_SCL
            hps_io_hps_io_gpio_inst_GPIO09 => hps_io_hps_io_gpio_inst_GPIO09, --         .hps_io_gpio_inst_GPIO09
            hps_io_hps_io_gpio_inst_GPIO28 => hps_io_hps_io_gpio_inst_GPIO28, --          .hps_io_gpio_inst_GPIO28
            hps_io_hps_io_gpio_inst_GPIO35 => hps_io_hps_io_gpio_inst_GPIO35, --          .hps_io_gpio_inst_GPIO35
            hps_io_hps_io_gpio_inst_GPIO40 => hps_io_hps_io_gpio_inst_GPIO40, --          .hps_io_gpio_inst_GPIO40
            hps_io_hps_io_gpio_inst_GPIO42 => hps_io_hps_io_gpio_inst_GPIO42, --          .hps_io_gpio_inst_GPIO42
            hps_io_hps_io_gpio_inst_GPIO43 => hps_io_hps_io_gpio_inst_GPIO43, --          .hps_io_gpio_inst_GPIO43
            hps_io_hps_io_gpio_inst_GPIO48 => hps_io_hps_io_gpio_inst_GPIO48, --         .hps_io_gpio_inst_GPIO48
            hps_io_hps_io_gpio_inst_GPIO61 => hps_io_hps_io_gpio_inst_GPIO61, --         .hps_io_gpio_inst_GPIO61
            hps_io_hps_io_gpio_inst_GPIO62 => hps_io_hps_io_gpio_inst_GPIO62, --         .hps_io_gpio_inst_GPIO62
            hps_io_hps_io_gpio_inst_LOANIO00 => hps_io_hps_io_gpio_inst_LOANIO00, --         .hps_io_gpio_inst_LOANIO00
            hps_io_hps_io_gpio_inst_LOANIO41 => hps_io_hps_io_gpio_inst_LOANIO41, --         .hps_io_gpio_inst_LOANIO41
            hps_io_hps_io_gpio_inst_LOANIO51 => hps_io_hps_io_gpio_inst_LOANIO51, --         .hps_io_gpio_inst_LOANIO51
            hps_io_hps_io_gpio_inst_LOANIO52 => hps_io_hps_io_gpio_inst_LOANIO52, --         .hps_io_gpio_inst_LOANIO52
            hps_io_hps_io_gpio_inst_LOANIO53 => hps_io_hps_io_gpio_inst_LOANIO53, --         .hps_io_gpio_inst_LOANIO53
            hps_io_hps_io_gpio_inst_LOANIO54 => hps_io_hps_io_gpio_inst_LOANIO54, --         .hps_io_gpio_inst_LOANIO54
            hps_io_hps_io_gpio_inst_LOANIO55 => hps_io_hps_io_gpio_inst_LOANIO55, --         .hps_io_gpio_inst_LOANIO55
            hps_io_hps_io_gpio_inst_LOANIO56 => hps_io_hps_io_gpio_inst_LOANIO56, --         .hps_io_gpio_inst_LOANIO56
            memory_mem_a => memory_mem_a, --   memory.mem_a
            memory_mem_ba => memory_mem_ba, --         .mem_ba
            memory_mem_ck => memory_mem_ck, --         .mem_ck
            memory_mem_ck_n => memory_mem_ck_n, --         .mem_ck_n
            memory_mem_cke => memory_mem_cke, --         .mem_cke
            memory_mem_cs_n => memory_mem_cs_n, --         .mem_cs_n
            memory_mem_ras_n => memory_mem_ras_n, --         .mem_ras_n
            memory_mem_cas_n => memory_mem_cas_n, --         .mem_cas_n
            memory_mem_we_n => memory_mem_we_n, --         .mem_we_n
            memory_mem_reset_n => memory_mem_reset_n, --         .mem_reset_n
            memory_mem_dq => memory_mem_dq, --         .mem_dq
            memory_mem_dqs => memory_mem_dqs, --         .mem_dqs
            memory_mem_dqs_n => memory_mem_dqs_n, --         .mem_dqs_n
            memory_mem_odt => memory_mem_odt, --         .mem_odt
            memory_mem_dm => memory_mem_dm, --         .mem_dm
            memory_oct_rzqin => memory_oct_rzqin, --         .oct_rzqin
            ram_mm_address => w_ram_address, --      ram.address
            ram_mm_chipselect => '1', --         .chipselect
            ram_mm_clken => '1', --         .clken
            ram_mm_write => '0', --         .write
            ram_mm_readdata => w_ram_readdata, --         .readdata
            ram_mm_writedata => w_ram_writedata, --         .writedata
            ram_mm_byteenable => w_ram_byteenable, --         .byteenable
            reset_reset_n => HPS_reset_n, --CONNECTED_TO_reset_reset_n, --    reset.reset_n
            clk_100m_clk => w_clock_100m, -- clk_100m.clk
            -- ram_clk_clk => w_clock_100m, --  ram_clk.clk
            -- ram_reset_reset => '0', --  ram_rst.reset
            d_out_in => w_input, --    d_out.in
            d_out_out => w_output, --(OTHERS => '0'), --(std_logic_vector(to_unsigned(0,66)) & '1'),--o_data_out), --         .out
            d_out_oe => w_oe --(OTHERS => '1')--(std_logic_vector(to_unsigned(0,66)) & '1') --         .oe
        );

        --------------------------------------------
        --  Interconnect module
        --------------------------------------------

        interconnect_inst : ENTITY work.interconnect
            PORT MAP(
                d_out_in => w_input, -- in
                d_out_out => w_output, -- out
                d_out_oe => w_oe, -- o
                -- RAM
                i_ram_readdata => w_ram_readdata, --         .readdata
                o_writedata => w_ram_writedata, --         .writedata
                o_ram_byteenable => w_ram_byteenable, --         .byteenable
                o_ram_address => w_ram_address, -- address
                --  FPGA connections
                o_ram_data => w_fpga_ram_readdata, --         .readdata
                i_ram_address => w_fpga_ram_address, -- address
                i_led => w_ram_readdata(7 DOWNTO 4),
                -- 
                o_data => w_data_out --,
            );

        --------------------------------------------
        --  Output module
        --------------------------------------------
        output_module_inst : ENTITY work.output_module
            GENERIC MAP(
                -- generic parameters - passed here from calling entity
                g_LED_COUNT => 16 * 16,
                g_RESET_TIME => 70000 -- must be larger then 50us => 2500 * 20ns =50us
            )
            PORT MAP(
                i_clk => w_clock_100m,
                -- i_data => x"0F0000",
                -- i_wr_addr => "0000000010",
                -- i_wen => '1',
                o_data_out => w_data_out,
                o_sent_done => w_led_done,
                i_ram_data => w_fpga_ram_readdata,
                o_ram_addr => w_fpga_ram_address
            );

        -- reg-state logic
        -- <your code goes here>

        -- next-state logic
        -- <your code goes here>

        -- outputs
        -- <your code goes here>

        o_led <= w_ram_readdata(3 DOWNTO 0);
    END rtl;