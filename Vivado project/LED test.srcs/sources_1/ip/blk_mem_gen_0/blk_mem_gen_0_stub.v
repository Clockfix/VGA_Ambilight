// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Sat Dec 19 21:43:15 2020
// Host        : home-PC running 64-bit Linux Mint 20
// Command     : write_verilog -force -mode synth_stub {/home/imants/programs/git/VGA_Ambilight/Vivado project/LED
//               test.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_stub.v}
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.1" *)
module blk_mem_gen_0(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[9:0],dina[23:0],clkb,enb,addrb[9:0],doutb[23:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [9:0]addra;
  input [23:0]dina;
  input clkb;
  input enb;
  input [9:0]addrb;
  output [23:0]doutb;
endmodule
