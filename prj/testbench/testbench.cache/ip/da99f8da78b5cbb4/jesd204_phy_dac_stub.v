// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Mon Jan 13 15:58:12 2025
// Host        : LAPTOP-3JN8PSQD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ jesd204_phy_dac_stub.v
// Design      : jesd204_phy_dac
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tfbg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "jesd204_phy_v3_2_1,Vivado 2016.4" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(tx_sys_reset, rx_sys_reset, tx_reset_gt, 
  rx_reset_gt, tx_reset_done, rx_reset_done, cpll_refclk, rxencommaalign, tx_core_clk, 
  txoutclk, rx_core_clk, rxoutclk, drpclk, gt_prbssel, gt0_txdata, gt0_txcharisk, gt1_txdata, 
  gt1_txcharisk, gt2_txdata, gt2_txcharisk, gt3_txdata, gt3_txcharisk, gt4_txdata, 
  gt4_txcharisk, gt5_txdata, gt5_txcharisk, gt6_txdata, gt6_txcharisk, gt7_txdata, 
  gt7_txcharisk, gt0_rxdata, gt0_rxcharisk, gt0_rxdisperr, gt0_rxnotintable, gt1_rxdata, 
  gt1_rxcharisk, gt1_rxdisperr, gt1_rxnotintable, gt2_rxdata, gt2_rxcharisk, gt2_rxdisperr, 
  gt2_rxnotintable, gt3_rxdata, gt3_rxcharisk, gt3_rxdisperr, gt3_rxnotintable, gt4_rxdata, 
  gt4_rxcharisk, gt4_rxdisperr, gt4_rxnotintable, gt5_rxdata, gt5_rxcharisk, gt5_rxdisperr, 
  gt5_rxnotintable, gt6_rxdata, gt6_rxcharisk, gt6_rxdisperr, gt6_rxnotintable, gt7_rxdata, 
  gt7_rxcharisk, gt7_rxdisperr, gt7_rxnotintable, rxn_in, rxp_in, txn_out, txp_out)
/* synthesis syn_black_box black_box_pad_pin="tx_sys_reset,rx_sys_reset,tx_reset_gt,rx_reset_gt,tx_reset_done,rx_reset_done,cpll_refclk,rxencommaalign,tx_core_clk,txoutclk,rx_core_clk,rxoutclk,drpclk,gt_prbssel[2:0],gt0_txdata[31:0],gt0_txcharisk[3:0],gt1_txdata[31:0],gt1_txcharisk[3:0],gt2_txdata[31:0],gt2_txcharisk[3:0],gt3_txdata[31:0],gt3_txcharisk[3:0],gt4_txdata[31:0],gt4_txcharisk[3:0],gt5_txdata[31:0],gt5_txcharisk[3:0],gt6_txdata[31:0],gt6_txcharisk[3:0],gt7_txdata[31:0],gt7_txcharisk[3:0],gt0_rxdata[31:0],gt0_rxcharisk[3:0],gt0_rxdisperr[3:0],gt0_rxnotintable[3:0],gt1_rxdata[31:0],gt1_rxcharisk[3:0],gt1_rxdisperr[3:0],gt1_rxnotintable[3:0],gt2_rxdata[31:0],gt2_rxcharisk[3:0],gt2_rxdisperr[3:0],gt2_rxnotintable[3:0],gt3_rxdata[31:0],gt3_rxcharisk[3:0],gt3_rxdisperr[3:0],gt3_rxnotintable[3:0],gt4_rxdata[31:0],gt4_rxcharisk[3:0],gt4_rxdisperr[3:0],gt4_rxnotintable[3:0],gt5_rxdata[31:0],gt5_rxcharisk[3:0],gt5_rxdisperr[3:0],gt5_rxnotintable[3:0],gt6_rxdata[31:0],gt6_rxcharisk[3:0],gt6_rxdisperr[3:0],gt6_rxnotintable[3:0],gt7_rxdata[31:0],gt7_rxcharisk[3:0],gt7_rxdisperr[3:0],gt7_rxnotintable[3:0],rxn_in[7:0],rxp_in[7:0],txn_out[7:0],txp_out[7:0]" */;
  input tx_sys_reset;
  input rx_sys_reset;
  input tx_reset_gt;
  input rx_reset_gt;
  output tx_reset_done;
  output rx_reset_done;
  input cpll_refclk;
  input rxencommaalign;
  input tx_core_clk;
  output txoutclk;
  input rx_core_clk;
  output rxoutclk;
  input drpclk;
  input [2:0]gt_prbssel;
  input [31:0]gt0_txdata;
  input [3:0]gt0_txcharisk;
  input [31:0]gt1_txdata;
  input [3:0]gt1_txcharisk;
  input [31:0]gt2_txdata;
  input [3:0]gt2_txcharisk;
  input [31:0]gt3_txdata;
  input [3:0]gt3_txcharisk;
  input [31:0]gt4_txdata;
  input [3:0]gt4_txcharisk;
  input [31:0]gt5_txdata;
  input [3:0]gt5_txcharisk;
  input [31:0]gt6_txdata;
  input [3:0]gt6_txcharisk;
  input [31:0]gt7_txdata;
  input [3:0]gt7_txcharisk;
  output [31:0]gt0_rxdata;
  output [3:0]gt0_rxcharisk;
  output [3:0]gt0_rxdisperr;
  output [3:0]gt0_rxnotintable;
  output [31:0]gt1_rxdata;
  output [3:0]gt1_rxcharisk;
  output [3:0]gt1_rxdisperr;
  output [3:0]gt1_rxnotintable;
  output [31:0]gt2_rxdata;
  output [3:0]gt2_rxcharisk;
  output [3:0]gt2_rxdisperr;
  output [3:0]gt2_rxnotintable;
  output [31:0]gt3_rxdata;
  output [3:0]gt3_rxcharisk;
  output [3:0]gt3_rxdisperr;
  output [3:0]gt3_rxnotintable;
  output [31:0]gt4_rxdata;
  output [3:0]gt4_rxcharisk;
  output [3:0]gt4_rxdisperr;
  output [3:0]gt4_rxnotintable;
  output [31:0]gt5_rxdata;
  output [3:0]gt5_rxcharisk;
  output [3:0]gt5_rxdisperr;
  output [3:0]gt5_rxnotintable;
  output [31:0]gt6_rxdata;
  output [3:0]gt6_rxcharisk;
  output [3:0]gt6_rxdisperr;
  output [3:0]gt6_rxnotintable;
  output [31:0]gt7_rxdata;
  output [3:0]gt7_rxcharisk;
  output [3:0]gt7_rxdisperr;
  output [3:0]gt7_rxnotintable;
  input [7:0]rxn_in;
  input [7:0]rxp_in;
  output [7:0]txn_out;
  output [7:0]txp_out;
endmodule
