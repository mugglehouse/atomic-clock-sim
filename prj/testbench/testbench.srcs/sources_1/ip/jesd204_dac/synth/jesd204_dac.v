//----------------------------------------------------------------------------
// Title : JESD204 Wrapper
// Project : JESD204
//----------------------------------------------------------------------------
// File : jesd204_dac.v
//----------------------------------------------------------------------------
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//----------------------------------------------------------------------------

`timescale 1ns / 1ps

(* CORE_GENERATION_INFO = "jesd204_dac,jesd204_v7_1_1,{x_ipProduct=Vivado 2016.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=jesd204,x_ipVersion=7.1,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,x_ipLicense=jesd204@2016.10(bought),C_COMPONENT_NAME=jesd204_dac,C_FAMILY=kintex7,C_NODE_IS_TRANSMIT=1,C_LANES=8,C_SPEEDGRADE=-1,C_LMFC_BUFFER_SIZE=6,C_SupportLevel=0,C_USE_RPAT=false,C_USE_JSPAT=false,C_TransceiverControl=false,c_sub_core_name=jesd204_dac_phy,C_GT_Line_Rate=4,C_GT_REFCLK_FREQ=100.000,C_DRPCLK_FREQ=50,C_SYSREF_SAMPLING_EDGE=1,C_PLL_SELECTION=0,C_Global_clk_sel=false,C_DEFAULT_SCR=0,C_DEFAULT_F=2,C_DEFAULT_K=32,C_DEFAULT_SYSREF_ALWAYS=0,C_DEFAULT_SYSREF_REQUIRED=0,C_AXICLK_FREQ=50,C_Transceiver=GTXE2}" *)
(* X_CORE_INFO = "jesd204_v7_1_1,Vivado 2016.4" *)

(* DowngradeIPIdentifiedWarnings = "yes" *)
module jesd204_dac
(


  // Tx
  input          tx_reset,
  input          tx_core_clk,
 
  input          tx_sysref,
  input          tx_sync,


  // Tx AXI-S interface for each lane
  output         tx_aresetn,

  output  [3:0]  tx_start_of_frame,
  output  [3:0]  tx_start_of_multiframe,

  output         tx_tready,
  input  [255:0]  tx_tdata,

   // Ports Required for GT
  output         tx_reset_gt,
  input          tx_reset_done,
  // Lane 0
  output  [31:0] gt0_txdata,
  output  [3:0]  gt0_txcharisk,

  // Lane 1
  output  [31:0] gt1_txdata,
  output  [3:0]  gt1_txcharisk,

  // Lane 2
  output  [31:0] gt2_txdata,
  output  [3:0]  gt2_txcharisk,

  // Lane 3
  output  [31:0] gt3_txdata,
  output  [3:0]  gt3_txcharisk,

  // Lane 4
  output  [31:0] gt4_txdata,
  output  [3:0]  gt4_txcharisk,

  // Lane 5
  output  [31:0] gt5_txdata,
  output  [3:0]  gt5_txcharisk,

  // Lane 6
  output  [31:0] gt6_txdata,
  output  [3:0]  gt6_txcharisk,

  // Lane 7
  output  [31:0] gt7_txdata,
  output  [3:0]  gt7_txcharisk,

  output  [2:0]  gt_prbssel_out,



  // AXI-Lite Control/Status
  input          s_axi_aclk,
  input          s_axi_aresetn,
  input  [11:0]  s_axi_awaddr,
  input          s_axi_awvalid,
  output         s_axi_awready,
  input  [31:0]  s_axi_wdata,
  input   [3:0]  s_axi_wstrb,
  input          s_axi_wvalid,
  output         s_axi_wready,
  output  [1:0]  s_axi_bresp,
  output         s_axi_bvalid,
  input          s_axi_bready,
  input  [11:0]  s_axi_araddr,
  input          s_axi_arvalid,
  output         s_axi_arready,
  output [31:0]  s_axi_rdata,
  output  [1:0]  s_axi_rresp,
  output         s_axi_rvalid,
  input          s_axi_rready
  );

  //------------------------------------------------------------
  // Instantiate the JESD204 core
  //------------------------------------------------------------
jesd204_dac_block #(
  .C_COMPONENT_NAME            ("jesd204_dac"),
  .C_FAMILY                    ("kintex7"),
  .C_NODE_IS_TRANSMIT          (1),
  .C_LANES                     (8)
  )
  inst(

  // Tx
  .tx_reset               (tx_reset),
  .tx_core_clk            (tx_core_clk),

  .tx_sysref              (tx_sysref),
  .tx_sync                (tx_sync),


  .tx_aresetn             (tx_aresetn),

  .tx_start_of_frame      (tx_start_of_frame),
  .tx_start_of_multiframe (tx_start_of_multiframe),

  .tx_tdata               (tx_tdata),
  .tx_tready              (tx_tready),


  // Ports Required for GT
  .tx_reset_gt            (tx_reset_gt),
  .tx_reset_done          (tx_reset_done),

  // Lane 0
  .gt0_txdata              (gt0_txdata),
  .gt0_txcharisk           (gt0_txcharisk),

  // Lane 1
  .gt1_txdata              (gt1_txdata),
  .gt1_txcharisk           (gt1_txcharisk),

  // Lane 2
  .gt2_txdata              (gt2_txdata),
  .gt2_txcharisk           (gt2_txcharisk),

  // Lane 3
  .gt3_txdata              (gt3_txdata),
  .gt3_txcharisk           (gt3_txcharisk),

  // Lane 4
  .gt4_txdata              (gt4_txdata),
  .gt4_txcharisk           (gt4_txcharisk),

  // Lane 5
  .gt5_txdata              (gt5_txdata),
  .gt5_txcharisk           (gt5_txcharisk),

  // Lane 6
  .gt6_txdata              (gt6_txdata),
  .gt6_txcharisk           (gt6_txcharisk),

  // Lane 7
  .gt7_txdata              (gt7_txdata),
  .gt7_txcharisk           (gt7_txcharisk),

  .gt_prbssel_out         (gt_prbssel_out),


  // AXI-Lite Control/Status
  .s_axi_aclk             (s_axi_aclk),
  .s_axi_aresetn          (s_axi_aresetn),
  .s_axi_awaddr           (s_axi_awaddr),
  .s_axi_awvalid          (s_axi_awvalid),
  .s_axi_awready          (s_axi_awready),
  .s_axi_wdata            (s_axi_wdata),
  .s_axi_wstrb            (s_axi_wstrb),
  .s_axi_wvalid           (s_axi_wvalid),
  .s_axi_wready           (s_axi_wready),
  .s_axi_bresp            (s_axi_bresp),
  .s_axi_bvalid           (s_axi_bvalid),
  .s_axi_bready           (s_axi_bready),
  .s_axi_araddr           (s_axi_araddr),
  .s_axi_arvalid          (s_axi_arvalid),
  .s_axi_arready          (s_axi_arready),
  .s_axi_rdata            (s_axi_rdata),
  .s_axi_rresp            (s_axi_rresp),
  .s_axi_rvalid           (s_axi_rvalid),
  .s_axi_rready           (s_axi_rready)
  );

endmodule
