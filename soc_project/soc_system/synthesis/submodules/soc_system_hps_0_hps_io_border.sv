// (C) 2001-2020 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


module soc_system_hps_0_hps_io_border(
// gpio_loanio
  output wire [29 - 1 : 0 ] gpio_loanio_loanio0_i
 ,input wire [29 - 1 : 0 ] gpio_loanio_loanio0_oe
 ,input wire [29 - 1 : 0 ] gpio_loanio_loanio0_o
 ,output wire [29 - 1 : 0 ] gpio_loanio_loanio1_i
 ,input wire [29 - 1 : 0 ] gpio_loanio_loanio1_oe
 ,input wire [29 - 1 : 0 ] gpio_loanio_loanio1_o
 ,output wire [9 - 1 : 0 ] gpio_loanio_loanio2_i
 ,input wire [9 - 1 : 0 ] gpio_loanio_loanio2_oe
 ,input wire [9 - 1 : 0 ] gpio_loanio_loanio2_o
// memory
 ,output wire [15 - 1 : 0 ] mem_a
 ,output wire [3 - 1 : 0 ] mem_ba
 ,output wire [1 - 1 : 0 ] mem_ck
 ,output wire [1 - 1 : 0 ] mem_ck_n
 ,output wire [1 - 1 : 0 ] mem_cke
 ,output wire [1 - 1 : 0 ] mem_cs_n
 ,output wire [1 - 1 : 0 ] mem_ras_n
 ,output wire [1 - 1 : 0 ] mem_cas_n
 ,output wire [1 - 1 : 0 ] mem_we_n
 ,output wire [1 - 1 : 0 ] mem_reset_n
 ,inout wire [32 - 1 : 0 ] mem_dq
 ,inout wire [4 - 1 : 0 ] mem_dqs
 ,inout wire [4 - 1 : 0 ] mem_dqs_n
 ,output wire [1 - 1 : 0 ] mem_odt
 ,output wire [4 - 1 : 0 ] mem_dm
 ,input wire [1 - 1 : 0 ] oct_rzqin
// hps_io
 ,output wire [1 - 1 : 0 ] hps_io_emac1_inst_TX_CLK
 ,output wire [1 - 1 : 0 ] hps_io_emac1_inst_TXD0
 ,output wire [1 - 1 : 0 ] hps_io_emac1_inst_TXD1
 ,output wire [1 - 1 : 0 ] hps_io_emac1_inst_TXD2
 ,output wire [1 - 1 : 0 ] hps_io_emac1_inst_TXD3
 ,input wire [1 - 1 : 0 ] hps_io_emac1_inst_RXD0
 ,inout wire [1 - 1 : 0 ] hps_io_emac1_inst_MDIO
 ,output wire [1 - 1 : 0 ] hps_io_emac1_inst_MDC
 ,input wire [1 - 1 : 0 ] hps_io_emac1_inst_RX_CTL
 ,output wire [1 - 1 : 0 ] hps_io_emac1_inst_TX_CTL
 ,input wire [1 - 1 : 0 ] hps_io_emac1_inst_RX_CLK
 ,input wire [1 - 1 : 0 ] hps_io_emac1_inst_RXD1
 ,input wire [1 - 1 : 0 ] hps_io_emac1_inst_RXD2
 ,input wire [1 - 1 : 0 ] hps_io_emac1_inst_RXD3
 ,inout wire [1 - 1 : 0 ] hps_io_qspi_inst_IO0
 ,inout wire [1 - 1 : 0 ] hps_io_qspi_inst_IO1
 ,inout wire [1 - 1 : 0 ] hps_io_qspi_inst_IO2
 ,inout wire [1 - 1 : 0 ] hps_io_qspi_inst_IO3
 ,output wire [1 - 1 : 0 ] hps_io_qspi_inst_SS0
 ,output wire [1 - 1 : 0 ] hps_io_qspi_inst_CLK
 ,inout wire [1 - 1 : 0 ] hps_io_sdio_inst_CMD
 ,inout wire [1 - 1 : 0 ] hps_io_sdio_inst_D0
 ,inout wire [1 - 1 : 0 ] hps_io_sdio_inst_D1
 ,output wire [1 - 1 : 0 ] hps_io_sdio_inst_CLK
 ,inout wire [1 - 1 : 0 ] hps_io_sdio_inst_D2
 ,inout wire [1 - 1 : 0 ] hps_io_sdio_inst_D3
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D0
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D1
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D2
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D3
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D4
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D5
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D6
 ,inout wire [1 - 1 : 0 ] hps_io_usb1_inst_D7
 ,input wire [1 - 1 : 0 ] hps_io_usb1_inst_CLK
 ,output wire [1 - 1 : 0 ] hps_io_usb1_inst_STP
 ,input wire [1 - 1 : 0 ] hps_io_usb1_inst_DIR
 ,input wire [1 - 1 : 0 ] hps_io_usb1_inst_NXT
 ,output wire [1 - 1 : 0 ] hps_io_spim0_inst_CLK
 ,output wire [1 - 1 : 0 ] hps_io_spim0_inst_MOSI
 ,input wire [1 - 1 : 0 ] hps_io_spim0_inst_MISO
 ,output wire [1 - 1 : 0 ] hps_io_spim0_inst_SS0
 ,output wire [1 - 1 : 0 ] hps_io_spim1_inst_CLK
 ,output wire [1 - 1 : 0 ] hps_io_spim1_inst_MOSI
 ,input wire [1 - 1 : 0 ] hps_io_spim1_inst_MISO
 ,output wire [1 - 1 : 0 ] hps_io_spim1_inst_SS0
 ,input wire [1 - 1 : 0 ] hps_io_uart0_inst_RX
 ,output wire [1 - 1 : 0 ] hps_io_uart0_inst_TX
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO09
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO28
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO35
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO40
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO42
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO43
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO48
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO61
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_GPIO62
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO00
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO41
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO51
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO52
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO53
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO54
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO55
 ,inout wire [1 - 1 : 0 ] hps_io_gpio_inst_LOANIO56
);

assign hps_io_emac1_inst_MDIO = intermediate[1] ? intermediate[0] : 'z;
assign hps_io_qspi_inst_IO0 = intermediate[3] ? intermediate[2] : 'z;
assign hps_io_qspi_inst_IO1 = intermediate[5] ? intermediate[4] : 'z;
assign hps_io_qspi_inst_IO2 = intermediate[7] ? intermediate[6] : 'z;
assign hps_io_qspi_inst_IO3 = intermediate[9] ? intermediate[8] : 'z;
assign hps_io_sdio_inst_CMD = intermediate[11] ? intermediate[10] : 'z;
assign hps_io_sdio_inst_D0 = intermediate[13] ? intermediate[12] : 'z;
assign hps_io_sdio_inst_D1 = intermediate[15] ? intermediate[14] : 'z;
assign hps_io_sdio_inst_D2 = intermediate[17] ? intermediate[16] : 'z;
assign hps_io_sdio_inst_D3 = intermediate[19] ? intermediate[18] : 'z;
assign hps_io_usb1_inst_D0 = intermediate[21] ? intermediate[20] : 'z;
assign hps_io_usb1_inst_D1 = intermediate[23] ? intermediate[22] : 'z;
assign hps_io_usb1_inst_D2 = intermediate[25] ? intermediate[24] : 'z;
assign hps_io_usb1_inst_D3 = intermediate[27] ? intermediate[26] : 'z;
assign hps_io_usb1_inst_D4 = intermediate[29] ? intermediate[28] : 'z;
assign hps_io_usb1_inst_D5 = intermediate[31] ? intermediate[30] : 'z;
assign hps_io_usb1_inst_D6 = intermediate[33] ? intermediate[32] : 'z;
assign hps_io_usb1_inst_D7 = intermediate[35] ? intermediate[34] : 'z;
assign hps_io_spim0_inst_MOSI = intermediate[37] ? intermediate[36] : 'z;
assign hps_io_spim1_inst_MOSI = intermediate[39] ? intermediate[38] : 'z;
assign hps_io_gpio_inst_GPIO09 = intermediate[41] ? intermediate[40] : 'z;
assign hps_io_gpio_inst_GPIO28 = intermediate[43] ? intermediate[42] : 'z;
assign hps_io_gpio_inst_GPIO35 = intermediate[45] ? intermediate[44] : 'z;
assign hps_io_gpio_inst_GPIO40 = intermediate[47] ? intermediate[46] : 'z;
assign hps_io_gpio_inst_GPIO42 = intermediate[49] ? intermediate[48] : 'z;
assign hps_io_gpio_inst_GPIO43 = intermediate[51] ? intermediate[50] : 'z;
assign hps_io_gpio_inst_GPIO48 = intermediate[53] ? intermediate[52] : 'z;
assign hps_io_gpio_inst_GPIO61 = intermediate[55] ? intermediate[54] : 'z;
assign hps_io_gpio_inst_GPIO62 = intermediate[57] ? intermediate[56] : 'z;
assign hps_io_gpio_inst_LOANIO00 = intermediate[59] ? intermediate[58] : 'z;
assign hps_io_gpio_inst_LOANIO41 = intermediate[61] ? intermediate[60] : 'z;
assign hps_io_gpio_inst_LOANIO51 = intermediate[63] ? intermediate[62] : 'z;
assign hps_io_gpio_inst_LOANIO52 = intermediate[65] ? intermediate[64] : 'z;
assign hps_io_gpio_inst_LOANIO53 = intermediate[67] ? intermediate[66] : 'z;
assign hps_io_gpio_inst_LOANIO54 = intermediate[69] ? intermediate[68] : 'z;
assign hps_io_gpio_inst_LOANIO55 = intermediate[71] ? intermediate[70] : 'z;
assign hps_io_gpio_inst_LOANIO56 = intermediate[73] ? intermediate[72] : 'z;

wire [74 - 1 : 0] intermediate;

wire [135 - 1 : 0] floating;

cyclonev_hps_peripheral_emac emac1_inst(
 .EMAC_GMII_MDO_I({
    hps_io_emac1_inst_MDIO[0:0] // 0:0
  })
,.EMAC_GMII_MDO_OE({
    intermediate[1:1] // 0:0
  })
,.EMAC_PHY_TXD({
    hps_io_emac1_inst_TXD3[0:0] // 3:3
   ,hps_io_emac1_inst_TXD2[0:0] // 2:2
   ,hps_io_emac1_inst_TXD1[0:0] // 1:1
   ,hps_io_emac1_inst_TXD0[0:0] // 0:0
  })
,.EMAC_CLK_TX({
    hps_io_emac1_inst_TX_CLK[0:0] // 0:0
  })
,.EMAC_PHY_RXDV({
    hps_io_emac1_inst_RX_CTL[0:0] // 0:0
  })
,.EMAC_PHY_RXD({
    hps_io_emac1_inst_RXD3[0:0] // 3:3
   ,hps_io_emac1_inst_RXD2[0:0] // 2:2
   ,hps_io_emac1_inst_RXD1[0:0] // 1:1
   ,hps_io_emac1_inst_RXD0[0:0] // 0:0
  })
,.EMAC_GMII_MDO_O({
    intermediate[0:0] // 0:0
  })
,.EMAC_GMII_MDC({
    hps_io_emac1_inst_MDC[0:0] // 0:0
  })
,.EMAC_PHY_TX_OE({
    hps_io_emac1_inst_TX_CTL[0:0] // 0:0
  })
,.EMAC_CLK_RX({
    hps_io_emac1_inst_RX_CLK[0:0] // 0:0
  })
);


cyclonev_hps_peripheral_qspi qspi_inst(
 .QSPI_MO2({
    intermediate[6:6] // 0:0
  })
,.QSPI_MI3({
    hps_io_qspi_inst_IO3[0:0] // 0:0
  })
,.QSPI_MO1({
    intermediate[4:4] // 0:0
  })
,.QSPI_MO0({
    intermediate[2:2] // 0:0
  })
,.QSPI_MI2({
    hps_io_qspi_inst_IO2[0:0] // 0:0
  })
,.QSPI_MI1({
    hps_io_qspi_inst_IO1[0:0] // 0:0
  })
,.QSPI_MI0({
    hps_io_qspi_inst_IO0[0:0] // 0:0
  })
,.QSPI_MO_EN_N({
    intermediate[9:9] // 3:3
   ,intermediate[7:7] // 2:2
   ,intermediate[5:5] // 1:1
   ,intermediate[3:3] // 0:0
  })
,.QSPI_SS_N({
    hps_io_qspi_inst_SS0[0:0] // 0:0
  })
,.QSPI_SCLK({
    hps_io_qspi_inst_CLK[0:0] // 0:0
  })
,.QSPI_MO3({
    intermediate[8:8] // 0:0
  })
);


cyclonev_hps_peripheral_sdmmc sdio_inst(
 .SDMMC_DATA_I({
    hps_io_sdio_inst_D3[0:0] // 3:3
   ,hps_io_sdio_inst_D2[0:0] // 2:2
   ,hps_io_sdio_inst_D1[0:0] // 1:1
   ,hps_io_sdio_inst_D0[0:0] // 0:0
  })
,.SDMMC_CMD_O({
    intermediate[10:10] // 0:0
  })
,.SDMMC_CCLK({
    hps_io_sdio_inst_CLK[0:0] // 0:0
  })
,.SDMMC_DATA_O({
    intermediate[18:18] // 3:3
   ,intermediate[16:16] // 2:2
   ,intermediate[14:14] // 1:1
   ,intermediate[12:12] // 0:0
  })
,.SDMMC_CMD_OE({
    intermediate[11:11] // 0:0
  })
,.SDMMC_CMD_I({
    hps_io_sdio_inst_CMD[0:0] // 0:0
  })
,.SDMMC_DATA_OE({
    intermediate[19:19] // 3:3
   ,intermediate[17:17] // 2:2
   ,intermediate[15:15] // 1:1
   ,intermediate[13:13] // 0:0
  })
);


cyclonev_hps_peripheral_usb usb1_inst(
 .USB_ULPI_STP({
    hps_io_usb1_inst_STP[0:0] // 0:0
  })
,.USB_ULPI_DATA_I({
    hps_io_usb1_inst_D7[0:0] // 7:7
   ,hps_io_usb1_inst_D6[0:0] // 6:6
   ,hps_io_usb1_inst_D5[0:0] // 5:5
   ,hps_io_usb1_inst_D4[0:0] // 4:4
   ,hps_io_usb1_inst_D3[0:0] // 3:3
   ,hps_io_usb1_inst_D2[0:0] // 2:2
   ,hps_io_usb1_inst_D1[0:0] // 1:1
   ,hps_io_usb1_inst_D0[0:0] // 0:0
  })
,.USB_ULPI_NXT({
    hps_io_usb1_inst_NXT[0:0] // 0:0
  })
,.USB_ULPI_DIR({
    hps_io_usb1_inst_DIR[0:0] // 0:0
  })
,.USB_ULPI_DATA_O({
    intermediate[34:34] // 7:7
   ,intermediate[32:32] // 6:6
   ,intermediate[30:30] // 5:5
   ,intermediate[28:28] // 4:4
   ,intermediate[26:26] // 3:3
   ,intermediate[24:24] // 2:2
   ,intermediate[22:22] // 1:1
   ,intermediate[20:20] // 0:0
  })
,.USB_ULPI_CLK({
    hps_io_usb1_inst_CLK[0:0] // 0:0
  })
,.USB_ULPI_DATA_OE({
    intermediate[35:35] // 7:7
   ,intermediate[33:33] // 6:6
   ,intermediate[31:31] // 5:5
   ,intermediate[29:29] // 4:4
   ,intermediate[27:27] // 3:3
   ,intermediate[25:25] // 2:2
   ,intermediate[23:23] // 1:1
   ,intermediate[21:21] // 0:0
  })
);


cyclonev_hps_peripheral_spi_master spim0_inst(
 .SPI_MASTER_RXD({
    hps_io_spim0_inst_MISO[0:0] // 0:0
  })
,.SPI_MASTER_TXD({
    intermediate[36:36] // 0:0
  })
,.SPI_MASTER_SSI_OE_N({
    intermediate[37:37] // 0:0
  })
,.SPI_MASTER_SCLK({
    hps_io_spim0_inst_CLK[0:0] // 0:0
  })
,.SPI_MASTER_SS_0_N({
    hps_io_spim0_inst_SS0[0:0] // 0:0
  })
);


cyclonev_hps_peripheral_spi_master spim1_inst(
 .SPI_MASTER_RXD({
    hps_io_spim1_inst_MISO[0:0] // 0:0
  })
,.SPI_MASTER_TXD({
    intermediate[38:38] // 0:0
  })
,.SPI_MASTER_SSI_OE_N({
    intermediate[39:39] // 0:0
  })
,.SPI_MASTER_SCLK({
    hps_io_spim1_inst_CLK[0:0] // 0:0
  })
,.SPI_MASTER_SS_0_N({
    hps_io_spim1_inst_SS0[0:0] // 0:0
  })
);


cyclonev_hps_peripheral_uart uart0_inst(
 .UART_RXD({
    hps_io_uart0_inst_RX[0:0] // 0:0
  })
,.UART_TXD({
    hps_io_uart0_inst_TX[0:0] // 0:0
  })
);


cyclonev_hps_peripheral_gpio gpio_inst(
 .LOANIO0_O({
    gpio_loanio_loanio0_o[28:0] // 28:0
  })
,.GPIO2_PORTA_O({
    intermediate[56:56] // 4:4
   ,intermediate[54:54] // 3:3
   ,floating[2:0] // 2:0
  })
,.GPIO0_PORTA_O({
    intermediate[42:42] // 28:28
   ,floating[20:3] // 27:10
   ,intermediate[40:40] // 9:9
   ,floating[28:21] // 8:1
   ,intermediate[58:58] // 0:0
  })
,.LOANIO2_O({
    gpio_loanio_loanio2_o[8:0] // 8:0
  })
,.LOANIO0_I({
    gpio_loanio_loanio0_i[28:0] // 28:0
  })
,.GPIO2_PORTA_I({
    hps_io_gpio_inst_GPIO62[0:0] // 4:4
   ,hps_io_gpio_inst_GPIO61[0:0] // 3:3
   ,floating[31:29] // 2:0
  })
,.GPIO0_PORTA_I({
    hps_io_gpio_inst_GPIO28[0:0] // 28:28
   ,floating[49:32] // 27:10
   ,hps_io_gpio_inst_GPIO09[0:0] // 9:9
   ,floating[57:50] // 8:1
   ,hps_io_gpio_inst_LOANIO00[0:0] // 0:0
  })
,.GPIO2_PORTA_OE({
    intermediate[57:57] // 4:4
   ,intermediate[55:55] // 3:3
   ,floating[60:58] // 2:0
  })
,.LOANIO2_I({
    gpio_loanio_loanio2_i[8:0] // 8:0
  })
,.GPIO0_PORTA_OE({
    intermediate[43:43] // 28:28
   ,floating[78:61] // 27:10
   ,intermediate[41:41] // 9:9
   ,floating[86:79] // 8:1
   ,intermediate[59:59] // 0:0
  })
,.LOANIO0_OE({
    gpio_loanio_loanio0_oe[28:0] // 28:0
  })
,.GPIO1_PORTA_O({
    intermediate[72:72] // 27:27
   ,intermediate[70:70] // 26:26
   ,intermediate[68:68] // 25:25
   ,intermediate[66:66] // 24:24
   ,intermediate[64:64] // 23:23
   ,intermediate[62:62] // 22:22
   ,floating[88:87] // 21:20
   ,intermediate[52:52] // 19:19
   ,floating[92:89] // 18:15
   ,intermediate[50:50] // 14:14
   ,intermediate[48:48] // 13:13
   ,intermediate[60:60] // 12:12
   ,intermediate[46:46] // 11:11
   ,floating[96:93] // 10:7
   ,intermediate[44:44] // 6:6
   ,floating[102:97] // 5:0
  })
,.LOANIO1_O({
    gpio_loanio_loanio1_o[28:0] // 28:0
  })
,.LOANIO1_OE({
    gpio_loanio_loanio1_oe[28:0] // 28:0
  })
,.GPIO1_PORTA_I({
    hps_io_gpio_inst_LOANIO56[0:0] // 27:27
   ,hps_io_gpio_inst_LOANIO55[0:0] // 26:26
   ,hps_io_gpio_inst_LOANIO54[0:0] // 25:25
   ,hps_io_gpio_inst_LOANIO53[0:0] // 24:24
   ,hps_io_gpio_inst_LOANIO52[0:0] // 23:23
   ,hps_io_gpio_inst_LOANIO51[0:0] // 22:22
   ,floating[104:103] // 21:20
   ,hps_io_gpio_inst_GPIO48[0:0] // 19:19
   ,floating[108:105] // 18:15
   ,hps_io_gpio_inst_GPIO43[0:0] // 14:14
   ,hps_io_gpio_inst_GPIO42[0:0] // 13:13
   ,hps_io_gpio_inst_LOANIO41[0:0] // 12:12
   ,hps_io_gpio_inst_GPIO40[0:0] // 11:11
   ,floating[112:109] // 10:7
   ,hps_io_gpio_inst_GPIO35[0:0] // 6:6
   ,floating[118:113] // 5:0
  })
,.LOANIO1_I({
    gpio_loanio_loanio1_i[28:0] // 28:0
  })
,.LOANIO2_OE({
    gpio_loanio_loanio2_oe[8:0] // 8:0
  })
,.GPIO1_PORTA_OE({
    intermediate[73:73] // 27:27
   ,intermediate[71:71] // 26:26
   ,intermediate[69:69] // 25:25
   ,intermediate[67:67] // 24:24
   ,intermediate[65:65] // 23:23
   ,intermediate[63:63] // 22:22
   ,floating[120:119] // 21:20
   ,intermediate[53:53] // 19:19
   ,floating[124:121] // 18:15
   ,intermediate[51:51] // 14:14
   ,intermediate[49:49] // 13:13
   ,intermediate[61:61] // 12:12
   ,intermediate[47:47] // 11:11
   ,floating[128:125] // 10:7
   ,intermediate[45:45] // 6:6
   ,floating[134:129] // 5:0
  })
);


hps_sdram hps_sdram_inst(
 .mem_dq({
    mem_dq[31:0] // 31:0
  })
,.mem_odt({
    mem_odt[0:0] // 0:0
  })
,.mem_ras_n({
    mem_ras_n[0:0] // 0:0
  })
,.mem_dqs_n({
    mem_dqs_n[3:0] // 3:0
  })
,.mem_dqs({
    mem_dqs[3:0] // 3:0
  })
,.mem_dm({
    mem_dm[3:0] // 3:0
  })
,.mem_we_n({
    mem_we_n[0:0] // 0:0
  })
,.mem_cas_n({
    mem_cas_n[0:0] // 0:0
  })
,.mem_ba({
    mem_ba[2:0] // 2:0
  })
,.mem_a({
    mem_a[14:0] // 14:0
  })
,.mem_cs_n({
    mem_cs_n[0:0] // 0:0
  })
,.mem_ck({
    mem_ck[0:0] // 0:0
  })
,.mem_cke({
    mem_cke[0:0] // 0:0
  })
,.oct_rzqin({
    oct_rzqin[0:0] // 0:0
  })
,.mem_reset_n({
    mem_reset_n[0:0] // 0:0
  })
,.mem_ck_n({
    mem_ck_n[0:0] // 0:0
  })
);

endmodule

