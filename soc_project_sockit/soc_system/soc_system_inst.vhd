	component soc_system is
		port (
			clk_clk                          : in    std_logic                     := 'X';             -- clk
			clk_100m_clk                     : out   std_logic;                                        -- clk
			d_out_in                         : out   std_logic_vector(66 downto 0);                    -- in
			d_out_out                        : in    std_logic_vector(66 downto 0) := (others => 'X'); -- out
			d_out_oe                         : in    std_logic_vector(66 downto 0) := (others => 'X'); -- oe
			hps_io_hps_io_emac1_inst_TX_CLK  : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0    : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1    : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2    : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3    : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO    : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC     : out   std_logic;                                        -- hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL  : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL  : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK  : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3    : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
			hps_io_hps_io_qspi_inst_IO0      : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO0
			hps_io_hps_io_qspi_inst_IO1      : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO1
			hps_io_hps_io_qspi_inst_IO2      : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO2
			hps_io_hps_io_qspi_inst_IO3      : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO3
			hps_io_hps_io_qspi_inst_SS0      : out   std_logic;                                        -- hps_io_qspi_inst_SS0
			hps_io_hps_io_qspi_inst_CLK      : out   std_logic;                                        -- hps_io_qspi_inst_CLK
			hps_io_hps_io_sdio_inst_CMD      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK      : out   std_logic;                                        -- hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7       : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK      : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP      : out   std_logic;                                        -- hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR      : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT      : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
			hps_io_hps_io_spim0_inst_CLK     : out   std_logic;                                        -- hps_io_spim0_inst_CLK
			hps_io_hps_io_spim0_inst_MOSI    : out   std_logic;                                        -- hps_io_spim0_inst_MOSI
			hps_io_hps_io_spim0_inst_MISO    : in    std_logic                     := 'X';             -- hps_io_spim0_inst_MISO
			hps_io_hps_io_spim0_inst_SS0     : out   std_logic;                                        -- hps_io_spim0_inst_SS0
			hps_io_hps_io_spim1_inst_CLK     : out   std_logic;                                        -- hps_io_spim1_inst_CLK
			hps_io_hps_io_spim1_inst_MOSI    : out   std_logic;                                        -- hps_io_spim1_inst_MOSI
			hps_io_hps_io_spim1_inst_MISO    : in    std_logic                     := 'X';             -- hps_io_spim1_inst_MISO
			hps_io_hps_io_spim1_inst_SS0     : out   std_logic;                                        -- hps_io_spim1_inst_SS0
			hps_io_hps_io_uart0_inst_RX      : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX      : out   std_logic;                                        -- hps_io_uart0_inst_TX
			hps_io_hps_io_gpio_inst_GPIO09   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
			hps_io_hps_io_gpio_inst_GPIO28   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO28
			hps_io_hps_io_gpio_inst_GPIO35   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
			hps_io_hps_io_gpio_inst_GPIO40   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO40
			hps_io_hps_io_gpio_inst_GPIO42   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO42
			hps_io_hps_io_gpio_inst_GPIO43   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO43
			hps_io_hps_io_gpio_inst_GPIO48   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO48
			hps_io_hps_io_gpio_inst_GPIO61   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO61
			hps_io_hps_io_gpio_inst_GPIO62   : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO62
			hps_io_hps_io_gpio_inst_LOANIO00 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO00
			hps_io_hps_io_gpio_inst_LOANIO41 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO41
			hps_io_hps_io_gpio_inst_LOANIO51 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO51
			hps_io_hps_io_gpio_inst_LOANIO52 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO52
			hps_io_hps_io_gpio_inst_LOANIO53 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO53
			hps_io_hps_io_gpio_inst_LOANIO54 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO54
			hps_io_hps_io_gpio_inst_LOANIO55 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO55
			hps_io_hps_io_gpio_inst_LOANIO56 : inout std_logic                     := 'X';             -- hps_io_gpio_inst_LOANIO56
			memory_mem_a                     : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                    : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                    : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                  : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                   : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                  : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                 : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                 : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                  : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n               : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                    : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                 : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                   : out   std_logic;                                        -- mem_odt
			memory_mem_dm                    : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin                 : in    std_logic                     := 'X';             -- oct_rzqin
			ram_mm_address                   : in    std_logic_vector(12 downto 0) := (others => 'X'); -- address
			ram_mm_chipselect                : in    std_logic                     := 'X';             -- chipselect
			ram_mm_clken                     : in    std_logic                     := 'X';             -- clken
			ram_mm_write                     : in    std_logic                     := 'X';             -- write
			ram_mm_readdata                  : out   std_logic_vector(31 downto 0);                    -- readdata
			ram_mm_writedata                 : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			ram_mm_byteenable                : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			reset_reset_n                    : in    std_logic                     := 'X'              -- reset_n
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			clk_clk                          => CONNECTED_TO_clk_clk,                          --      clk.clk
			clk_100m_clk                     => CONNECTED_TO_clk_100m_clk,                     -- clk_100m.clk
			d_out_in                         => CONNECTED_TO_d_out_in,                         --    d_out.in
			d_out_out                        => CONNECTED_TO_d_out_out,                        --         .out
			d_out_oe                         => CONNECTED_TO_d_out_oe,                         --         .oe
			hps_io_hps_io_emac1_inst_TX_CLK  => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CLK,  --   hps_io.hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD0,    --         .hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD1,    --         .hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD2,    --         .hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3    => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD3,    --         .hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD0,    --         .hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO    => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDIO,    --         .hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC     => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDC,     --         .hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL  => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CTL,  --         .hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL  => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CTL,  --         .hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK  => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CLK,  --         .hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD1,    --         .hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD2,    --         .hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3    => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD3,    --         .hps_io_emac1_inst_RXD3
			hps_io_hps_io_qspi_inst_IO0      => CONNECTED_TO_hps_io_hps_io_qspi_inst_IO0,      --         .hps_io_qspi_inst_IO0
			hps_io_hps_io_qspi_inst_IO1      => CONNECTED_TO_hps_io_hps_io_qspi_inst_IO1,      --         .hps_io_qspi_inst_IO1
			hps_io_hps_io_qspi_inst_IO2      => CONNECTED_TO_hps_io_hps_io_qspi_inst_IO2,      --         .hps_io_qspi_inst_IO2
			hps_io_hps_io_qspi_inst_IO3      => CONNECTED_TO_hps_io_hps_io_qspi_inst_IO3,      --         .hps_io_qspi_inst_IO3
			hps_io_hps_io_qspi_inst_SS0      => CONNECTED_TO_hps_io_hps_io_qspi_inst_SS0,      --         .hps_io_qspi_inst_SS0
			hps_io_hps_io_qspi_inst_CLK      => CONNECTED_TO_hps_io_hps_io_qspi_inst_CLK,      --         .hps_io_qspi_inst_CLK
			hps_io_hps_io_sdio_inst_CMD      => CONNECTED_TO_hps_io_hps_io_sdio_inst_CMD,      --         .hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D0,       --         .hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D1,       --         .hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK      => CONNECTED_TO_hps_io_hps_io_sdio_inst_CLK,      --         .hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D2,       --         .hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3       => CONNECTED_TO_hps_io_hps_io_sdio_inst_D3,       --         .hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D0,       --         .hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D1,       --         .hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D2,       --         .hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D3,       --         .hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D4,       --         .hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D5,       --         .hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D6,       --         .hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7       => CONNECTED_TO_hps_io_hps_io_usb1_inst_D7,       --         .hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK      => CONNECTED_TO_hps_io_hps_io_usb1_inst_CLK,      --         .hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP      => CONNECTED_TO_hps_io_hps_io_usb1_inst_STP,      --         .hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR      => CONNECTED_TO_hps_io_hps_io_usb1_inst_DIR,      --         .hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT      => CONNECTED_TO_hps_io_hps_io_usb1_inst_NXT,      --         .hps_io_usb1_inst_NXT
			hps_io_hps_io_spim0_inst_CLK     => CONNECTED_TO_hps_io_hps_io_spim0_inst_CLK,     --         .hps_io_spim0_inst_CLK
			hps_io_hps_io_spim0_inst_MOSI    => CONNECTED_TO_hps_io_hps_io_spim0_inst_MOSI,    --         .hps_io_spim0_inst_MOSI
			hps_io_hps_io_spim0_inst_MISO    => CONNECTED_TO_hps_io_hps_io_spim0_inst_MISO,    --         .hps_io_spim0_inst_MISO
			hps_io_hps_io_spim0_inst_SS0     => CONNECTED_TO_hps_io_hps_io_spim0_inst_SS0,     --         .hps_io_spim0_inst_SS0
			hps_io_hps_io_spim1_inst_CLK     => CONNECTED_TO_hps_io_hps_io_spim1_inst_CLK,     --         .hps_io_spim1_inst_CLK
			hps_io_hps_io_spim1_inst_MOSI    => CONNECTED_TO_hps_io_hps_io_spim1_inst_MOSI,    --         .hps_io_spim1_inst_MOSI
			hps_io_hps_io_spim1_inst_MISO    => CONNECTED_TO_hps_io_hps_io_spim1_inst_MISO,    --         .hps_io_spim1_inst_MISO
			hps_io_hps_io_spim1_inst_SS0     => CONNECTED_TO_hps_io_hps_io_spim1_inst_SS0,     --         .hps_io_spim1_inst_SS0
			hps_io_hps_io_uart0_inst_RX      => CONNECTED_TO_hps_io_hps_io_uart0_inst_RX,      --         .hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX      => CONNECTED_TO_hps_io_hps_io_uart0_inst_TX,      --         .hps_io_uart0_inst_TX
			hps_io_hps_io_gpio_inst_GPIO09   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO09,   --         .hps_io_gpio_inst_GPIO09
			hps_io_hps_io_gpio_inst_GPIO28   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO28,   --         .hps_io_gpio_inst_GPIO28
			hps_io_hps_io_gpio_inst_GPIO35   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO35,   --         .hps_io_gpio_inst_GPIO35
			hps_io_hps_io_gpio_inst_GPIO40   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO40,   --         .hps_io_gpio_inst_GPIO40
			hps_io_hps_io_gpio_inst_GPIO42   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO42,   --         .hps_io_gpio_inst_GPIO42
			hps_io_hps_io_gpio_inst_GPIO43   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO43,   --         .hps_io_gpio_inst_GPIO43
			hps_io_hps_io_gpio_inst_GPIO48   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO48,   --         .hps_io_gpio_inst_GPIO48
			hps_io_hps_io_gpio_inst_GPIO61   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO61,   --         .hps_io_gpio_inst_GPIO61
			hps_io_hps_io_gpio_inst_GPIO62   => CONNECTED_TO_hps_io_hps_io_gpio_inst_GPIO62,   --         .hps_io_gpio_inst_GPIO62
			hps_io_hps_io_gpio_inst_LOANIO00 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO00, --         .hps_io_gpio_inst_LOANIO00
			hps_io_hps_io_gpio_inst_LOANIO41 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO41, --         .hps_io_gpio_inst_LOANIO41
			hps_io_hps_io_gpio_inst_LOANIO51 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO51, --         .hps_io_gpio_inst_LOANIO51
			hps_io_hps_io_gpio_inst_LOANIO52 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO52, --         .hps_io_gpio_inst_LOANIO52
			hps_io_hps_io_gpio_inst_LOANIO53 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO53, --         .hps_io_gpio_inst_LOANIO53
			hps_io_hps_io_gpio_inst_LOANIO54 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO54, --         .hps_io_gpio_inst_LOANIO54
			hps_io_hps_io_gpio_inst_LOANIO55 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO55, --         .hps_io_gpio_inst_LOANIO55
			hps_io_hps_io_gpio_inst_LOANIO56 => CONNECTED_TO_hps_io_hps_io_gpio_inst_LOANIO56, --         .hps_io_gpio_inst_LOANIO56
			memory_mem_a                     => CONNECTED_TO_memory_mem_a,                     --   memory.mem_a
			memory_mem_ba                    => CONNECTED_TO_memory_mem_ba,                    --         .mem_ba
			memory_mem_ck                    => CONNECTED_TO_memory_mem_ck,                    --         .mem_ck
			memory_mem_ck_n                  => CONNECTED_TO_memory_mem_ck_n,                  --         .mem_ck_n
			memory_mem_cke                   => CONNECTED_TO_memory_mem_cke,                   --         .mem_cke
			memory_mem_cs_n                  => CONNECTED_TO_memory_mem_cs_n,                  --         .mem_cs_n
			memory_mem_ras_n                 => CONNECTED_TO_memory_mem_ras_n,                 --         .mem_ras_n
			memory_mem_cas_n                 => CONNECTED_TO_memory_mem_cas_n,                 --         .mem_cas_n
			memory_mem_we_n                  => CONNECTED_TO_memory_mem_we_n,                  --         .mem_we_n
			memory_mem_reset_n               => CONNECTED_TO_memory_mem_reset_n,               --         .mem_reset_n
			memory_mem_dq                    => CONNECTED_TO_memory_mem_dq,                    --         .mem_dq
			memory_mem_dqs                   => CONNECTED_TO_memory_mem_dqs,                   --         .mem_dqs
			memory_mem_dqs_n                 => CONNECTED_TO_memory_mem_dqs_n,                 --         .mem_dqs_n
			memory_mem_odt                   => CONNECTED_TO_memory_mem_odt,                   --         .mem_odt
			memory_mem_dm                    => CONNECTED_TO_memory_mem_dm,                    --         .mem_dm
			memory_oct_rzqin                 => CONNECTED_TO_memory_oct_rzqin,                 --         .oct_rzqin
			ram_mm_address                   => CONNECTED_TO_ram_mm_address,                   --   ram_mm.address
			ram_mm_chipselect                => CONNECTED_TO_ram_mm_chipselect,                --         .chipselect
			ram_mm_clken                     => CONNECTED_TO_ram_mm_clken,                     --         .clken
			ram_mm_write                     => CONNECTED_TO_ram_mm_write,                     --         .write
			ram_mm_readdata                  => CONNECTED_TO_ram_mm_readdata,                  --         .readdata
			ram_mm_writedata                 => CONNECTED_TO_ram_mm_writedata,                 --         .writedata
			ram_mm_byteenable                => CONNECTED_TO_ram_mm_byteenable,                --         .byteenable
			reset_reset_n                    => CONNECTED_TO_reset_reset_n                     --    reset.reset_n
		);

