//----------------------------------------------------------------------------
// Title : Block Level
// Project : JESD204
//----------------------------------------------------------------------------
// File : jesd204_block.v
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

(* DowngradeIPIdentifiedWarnings = "yes" *)
module jesd204_dac_block #(
  // AXI port dependant parameters
  parameter  C_COMPONENT_NAME            = "jesd204_dac",
  parameter  C_FAMILY                    = "kintex7",
  parameter  C_NODE_IS_TRANSMIT          = 1,
  parameter  C_LANES                     = 8
)(

  // Tx
  input          tx_reset,
  input          tx_core_clk,

  input          tx_sysref,
  input          tx_sync,

  // Tx AXI interface
  output         tx_aresetn,

  output         tx_tready,
  input  [255:0]  tx_tdata,

  output [3:0]   tx_start_of_frame,
  output [3:0]   tx_start_of_multiframe,

  // Ports Required for GT
  output         tx_reset_gt,
  input          tx_reset_done,
  output   [2:0] gt_prbssel_out,

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


  // AXI-Lite Control/Status
  input          s_axi_aclk,
  input          s_axi_aresetn,
  input [11:0]   s_axi_awaddr,
  input          s_axi_awvalid,
  output         s_axi_awready,
  input [31:0]   s_axi_wdata,
  input [3:0]    s_axi_wstrb,
  input          s_axi_wvalid,
  output         s_axi_wready,
  output[1:0]    s_axi_bresp,
  output         s_axi_bvalid,
  input          s_axi_bready,
  input [11:0]   s_axi_araddr,
  input          s_axi_arvalid,
  output         s_axi_arready,
  output[31:0]   s_axi_rdata,
  output[1:0]    s_axi_rresp,
  output         s_axi_rvalid,
  input          s_axi_rready
);

  // Configuration Registers for AXI
  reg [11:0]   tx_cfg_lanes_in_use;
  reg [7:0]    tx_cfg_octets_per_frame;
  reg [4:0]    tx_cfg_frames_per_multi;
  reg          tx_cfg_reset_i;
  reg          tx_cfg_sticky_reset;
  reg          tx_cfg_scr_enable;
  reg          tx_cfg_support_lane_sync;
  reg          tx_cfg_sysref_always;
  reg [4:0]    tx_cfg_test_modes;
  reg [1:0]    tx_cfg_subclass;
  wire         tx_cfg_sync;
  reg          tx_cfg_sysref_resync;

  wire         tx_sysref_captured;
  wire         tx_sysref_captured_sync;
  wire         tx_sysref_captured_i;
  wire         in_sync;  

  wire [255:0]  txdata;
  wire  [31:0]  txcharisk;

  // Signals for link test modes
  wire [31:0]  rpat_data_out = 32'h00000000;
  wire [31:0]  jspat_data_out = 32'h00000000;
  wire         enable_D21_5_pattern;
  wire         enable_D21_5_pattern_sync;
  
  wire         enable_prbs_patterns;
  wire         enable_prbs_patterns_sync;  
  reg  [2:0]   tx_cfg_test_modes_r;
  
  wire         tx_core_rst;
  wire         tx_core_rst_i;

  // Tx Configuration Data
  reg [7:0]    tx_cfg_multi_frames;
  reg [7:0]    tx_cfg_did;
  reg [3:0]    tx_cfg_bid;
  reg [7:0]    tx_cfg_m;
  reg [1:0]    tx_cfg_cs;
  reg [4:0]    tx_cfg_n;
  reg [4:0]    tx_cfg_np;
  reg [4:0]    tx_cfg_s;
  reg          tx_cfg_hd;
  reg [7:0]    tx_cfg_res1;
  reg [7:0]    tx_cfg_res2;
  reg [4:0]    tx_cfg_cf;
  reg          tx_cfg_adjdir;
  reg          tx_cfg_phadj;
  reg [3:0]    tx_cfg_adjcnt;
  reg [4:0]    tx_cfg_lid0  = 5'h00;
  reg [4:0]    tx_cfg_lid1  = 5'h01;
  reg [4:0]    tx_cfg_lid2  = 5'h02;
  reg [4:0]    tx_cfg_lid3  = 5'h03;
  reg [4:0]    tx_cfg_lid4  = 5'h04;
  reg [4:0]    tx_cfg_lid5  = 5'h05;
  reg [4:0]    tx_cfg_lid6  = 5'h06;
  reg [4:0]    tx_cfg_lid7  = 5'h07;

  // Watchdog timer for GT
  reg          tx_wd_disable;
  reg   [19:0] tx_rst_wd_cnt;
  reg          tx_reset_wd;


  // AXI Signals
  wire         Bus2IP_Clk;
  wire         Bus2IP_Resetn;
  wire  [3:0]  Bus2IP_BE;
  wire         Bus2IP_RdCE;
  wire         Bus2IP_WrCE;
  wire [31:0]  Bus2IP_Data;
  wire [31:0]  IP2Bus_Data_configs;
  wire [31:0]  IP2Bus_Data_laneID;
  wire [31:0]  IP2Bus_Data_settings;
  wire [11:0]  Bus2IP_Addr;
  reg  [31:0]  IP2Bus_Data;
  reg          IP2Bus_RdAck;
  reg          IP2Bus_RdAck_r;
  reg          IP2Bus_RdAck_rr;
  wire [2:0]   chip_select;
  wire [15:0]  bank0_read;
  wire [15:0]  bank1_read;
  wire [191:0] bank2_read;
  wire [15:0]  bank0_write;
  wire [15:0]  bank1_write;
  wire [15:0]  bank2_write;

  reg          tx_sysref_r;
  reg  [3:0]   tx_sysref_delay;

  jesd204_v7_1_1_top #(
    .C_COMPONENT_NAME            (C_COMPONENT_NAME),
    .C_FAMILY                    (C_FAMILY),
    .C_NODE_IS_TRANSMIT          (1),
    .C_LANES                     (C_LANES)
    )
  i_jesd204_dac (
    // Clk and Reset
    .clk                     (tx_core_clk),
    .rst                     (tx_core_rst),

    // Tx
    .multi_frames            (tx_cfg_multi_frames),
    .tx_cfg_f                (tx_cfg_octets_per_frame),       // Octets per Frame
    .tx_cfg_k                (tx_cfg_frames_per_multi),       // Frames per Multiframe,
    .tx_cfg_scr              (tx_cfg_scr_enable),     // scram enable,
    .tx_cfg_did              (tx_cfg_did),     // Device ID
    .tx_cfg_bid              (tx_cfg_bid),     // Bank ID
    .tx_cfg_m                (tx_cfg_m),       // Converters per device
    .tx_cfg_cs               (tx_cfg_cs),      // Control Bits per Sample
    .tx_cfg_n                (tx_cfg_n),       // Converter Resolution
    .tx_cfg_np               (tx_cfg_np),      // Bits per sample
    .tx_cfg_s                (tx_cfg_s),       // Smaples per Frame Cycle
    .tx_cfg_hd               (tx_cfg_hd),      // high Density Format
    .tx_cfg_res1             (tx_cfg_res1),    // Reserved
    .tx_cfg_res2             (tx_cfg_res2),    // Reserved
    .tx_cfg_cf               (tx_cfg_cf),      // Control Words per Frame Cycle per Link
    // Used only in Subclass 2
    .tx_cfg_adjcnt           (tx_cfg_adjcnt),
    .tx_cfg_adjdir           (tx_cfg_adjdir),
    .tx_cfg_phadj            (tx_cfg_phadj),

    .tx_cfg_cs_all           (1'b0),           // Set to 1 to checksum all bytes (deviation from JESD204 spec)
    // Lane IDs
    .tx_cfg_lid0             (tx_cfg_lid0),    
    .tx_cfg_lid1             (tx_cfg_lid1),
    .tx_cfg_lid2             (tx_cfg_lid2),
    .tx_cfg_lid3             (tx_cfg_lid3),
    .tx_cfg_lid4             (tx_cfg_lid4),
    .tx_cfg_lid5             (tx_cfg_lid5),
    .tx_cfg_lid6             (tx_cfg_lid6),
    .tx_cfg_lid7             (tx_cfg_lid7),

    .tx_sync                 (tx_sync),

    .txdatain                (tx_tdata),
    .txready                 (tx_tready),

    .txdata                  (txdata),
    .txcharisk               (txcharisk),

    // Common
    .support_lane_sync       (tx_cfg_support_lane_sync),
    .active_lanes            (tx_cfg_lanes_in_use),
    .test_modes              (tx_cfg_test_modes[1:0]),
    .subclass                (tx_cfg_subclass),
    .lmfc_pulse_delay        (tx_sysref_delay),
    .sysref_captured         (tx_sysref_captured_i),

    .start_of_frame          (tx_start_of_frame),
    .start_of_multiframe     (tx_start_of_multiframe),
    .end_of_frame            (),
    .end_of_multiframe       (),

    .sysref_always           (tx_cfg_sysref_always),
    .sysref_resync           (tx_cfg_sysref_resync),  //Require sysref to gain sync again if lost
    .sysref_in               (tx_sysref_r),

    .sysref_out              (),

    // Rx ports (unused)
    .octets_per_frame        (8'b0),
    .scram_enable            (1'b0),
    .frames_per_multiframe   (5'b0),
    .rx_buffer_delay         (10'b0),
    .rx_buffer_adjust        (),
    .disable_error_reporting (1'b0),
    .early_release           (1'b0),
    .init0                   (),
    .init1                   (),
    .init2                   (),
    .init3                   (),
    .test_err_count          (),
    .test_ila_count          (),
    .test_mf_count           (),

    .rxdata                  (256'b0),
    .rxcharisk               (32'b0),
    .rxdisperr               (32'b0),
    .rxnotintable            (32'b0),
    .rxstatus                (),
    .rxstatus2               (),
    .rxstatus_read           (1'b0),
    .rxstatus2_read          (1'b0),

    .rx_sync                 (),
    .in_sync                 (in_sync),
    .encommaalign            (),

    .rxdataout               (),
    .rxdatavalid             (),
    .frame_error             ()
  );

  // Multiplexers for transceiver input data
  
  assign gt0_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[31:0];

  assign gt0_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[3:0];
  
  assign gt1_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[63:32];

  assign gt1_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[7:4];
  
  assign gt2_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[95:64];

  assign gt2_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[11:8];
  
  assign gt3_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[127:96];

  assign gt3_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[15:12];
  
  assign gt4_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[159:128];

  assign gt4_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[19:16];
  
  assign gt5_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[191:160];

  assign gt5_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[23:20];
  
  assign gt6_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[223:192];

  assign gt6_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[27:24];
  
  assign gt7_txdata     =  (tx_cfg_test_modes[2:0] == 3'b101) ? rpat_data_out :
                           (tx_cfg_test_modes[2:0] == 3'b111) ? jspat_data_out : txdata[255:224];

  assign gt7_txcharisk  =  (tx_cfg_test_modes[2]) ? 4'h0 : txcharisk[31:28];

  // Enable signals to set PRBSSEL to correct value
  assign enable_D21_5_pattern = (tx_cfg_test_modes[2:0] == 3'b011)  ? 1'b1 : 1'b0;
  assign enable_prbs_patterns = (tx_cfg_test_modes[4] == 1'b1)  ? 1'b1 : 1'b0;


  // Synchronizing the enable signals to the tx_core_clk domain
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_D21_5_pattern_enable  (
  .dest_clk (tx_core_clk),	
  .src_clk  (1'd0),	
  .src_in   (enable_D21_5_pattern),
  .dest_out (enable_D21_5_pattern_sync)
  );
  
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_prbs_patterns_enable  (
  .dest_clk (tx_core_clk),	
  .src_clk  (1'd0),	
  .src_in   (enable_prbs_patterns),
  .dest_out (enable_prbs_patterns_sync)
  );

  //Set PRBSSEL output to correct value depending on enable signal
  always @(posedge tx_core_clk)
    tx_cfg_test_modes_r <= tx_cfg_test_modes[2:0];
    
  assign gt_prbssel_out = (enable_D21_5_pattern_sync)  ? 3'b110 : 
                          (enable_prbs_patterns_sync)  ? tx_cfg_test_modes_r : 3'b000;
  assign tx_aresetn = ~tx_core_rst;


  jesd204_dac_axi_lite_ipif #(
    .C_S_AXI_DATA_WIDTH           (32),
    .C_S_AXI_MIN_SIZE             (32'h0000_0FFF),
    .C_DPHASE_TIMEOUT             (64),
    .C_NUM_ADDRESS_RANGES         (1),
    .C_TOTAL_NUM_CE               (1),
    .C_USE_WSTRB                  (1),
    .C_ARD_ADDR_RANGE_ARRAY       ({32'h0000_0000,32'h0000_0FFF}),
    .C_ARD_NUM_CE_ARRAY           ({8'd1}),
    .C_FAMILY                     ("virtex7")
  ) i_axi_lite_ipif (
    .S_AXI_ACLK    (s_axi_aclk),
    .S_AXI_ARESETN (s_axi_aresetn),
    .S_AXI_AWADDR  (s_axi_awaddr),
    .S_AXI_AWVALID (s_axi_awvalid),
    .S_AXI_AWREADY (s_axi_awready),
    .S_AXI_WDATA   (s_axi_wdata),
    .S_AXI_WSTRB   (s_axi_wstrb),
    .S_AXI_WVALID  (s_axi_wvalid),
    .S_AXI_WREADY  (s_axi_wready),
    .S_AXI_BRESP   (s_axi_bresp),
    .S_AXI_BVALID  (s_axi_bvalid),
    .S_AXI_BREADY  (s_axi_bready),
    .S_AXI_ARADDR  (s_axi_araddr), // 12 bit
    .S_AXI_ARVALID (s_axi_arvalid),
    .S_AXI_ARREADY (s_axi_arready),
    .S_AXI_RDATA   (s_axi_rdata),
    .S_AXI_RRESP   (s_axi_rresp),
    .S_AXI_RVALID  (s_axi_rvalid),
    .S_AXI_RREADY  (s_axi_rready),

    // Controls to the IP/ipif
    .Bus2IP_Clk    (Bus2IP_Clk),
    .Bus2IP_Resetn (Bus2IP_Resetn),
    .Bus2IP_Addr   (Bus2IP_Addr),
    .Bus2IP_RNW    (),
    .Bus2IP_BE     (Bus2IP_BE),
    .Bus2IP_CS     (),
    .Bus2IP_RdCE   (Bus2IP_RdCE),
    .Bus2IP_WrCE   (Bus2IP_WrCE),
    .Bus2IP_Data   (Bus2IP_Data),
    .IP2Bus_Data   (IP2Bus_Data),
    .IP2Bus_WrAck  (Bus2IP_WrCE),
    .IP2Bus_RdAck  (IP2Bus_RdAck),
    .IP2Bus_Error  (1'b0)
  );

  jesd204_dac_register_decode i_register_decode (
    .bus2ip_addr  (Bus2IP_Addr),
    .bus2ip_rdce  (Bus2IP_RdCE),
    .bus2ip_wrce  (Bus2IP_WrCE),
    .chip_select  (chip_select),
    .bank0_read   (bank0_read),
    .bank1_read   (bank1_read),
    .bank2_read   (bank2_read),
    .bank0_write  (bank0_write),
    .bank1_write  (bank1_write),
    .bank2_write  (bank2_write)
  );

  // AXI Lite interface - Configuration Registers

  // 0x04 Reset
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_reset_i      <= 1'b1;
      //sticky reset defaults to unset
      tx_cfg_sticky_reset <= 1'b0;
      tx_wd_disable       <= 1'b1;
    end
    else if (bank0_write[1])
    begin
      if (Bus2IP_BE[0])
      begin
        //Self clearing reset bit OR sticky reset bit
        tx_cfg_reset_i      <= Bus2IP_Data[0] | Bus2IP_Data[1];
        //Store sticky bit
        tx_cfg_sticky_reset <= Bus2IP_Data[1];
      end
      if (Bus2IP_BE[2])
        tx_wd_disable       <= Bus2IP_Data[16];
    end
    else
      //Clear the reset unless the sticky bit is set
      tx_cfg_reset_i <= tx_cfg_sticky_reset;

  // 0x08 ILA Support
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_support_lane_sync <= 1'h1;
    end
    else if (bank0_write[2])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_support_lane_sync <= Bus2IP_Data[0];
    end

  // 0x0C Scrambling
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_scr_enable <= 1'b0;
    end
    else if (bank0_write[3])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_scr_enable <= Bus2IP_Data[0];
    end

  // 0x10 SYSREF Handling (Subclass 1 mode only)
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_sysref_always <= 1'b0;
      tx_sysref_delay <= 4'b0000;
      tx_cfg_sysref_resync <= 1'b0;
    end
    else if (bank0_write[4])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_sysref_always <= Bus2IP_Data[0];
      if (Bus2IP_BE[1])
        tx_sysref_delay <= Bus2IP_Data[11:8];
      if (Bus2IP_BE[2])
        tx_cfg_sysref_resync <= Bus2IP_Data[16];
    end

  // 0x14 Multiframes in the ILA Sequence
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_multi_frames <= 8'h3;
    end
    else if (bank0_write[5])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_multi_frames <= Bus2IP_Data[7:0];
    end

  // 0x18 Test Modes
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_test_modes <= 5'b00000;
    end
    else if (bank0_write[6])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_test_modes <= Bus2IP_Data[4:0];     
    end

  // 0x20 Octets per Frame
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_octets_per_frame <= 8'd1;
    end
    else if (bank0_write[8])
    begin
      if (Bus2IP_BE[0])
       tx_cfg_octets_per_frame <= Bus2IP_Data[7:0];
    end

  // 0x24 Frames per Multiframe
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_frames_per_multi <= 5'd31;
    end
    else if (bank0_write[9])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_frames_per_multi <= Bus2IP_Data[4:0];
    end

  // 0x28 Active Lanes
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lanes_in_use <= 12'd255;
    end
    else if (bank0_write[10])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_lanes_in_use[7:0] <= Bus2IP_Data[7:0];
      if (Bus2IP_BE[1])
        tx_cfg_lanes_in_use[11:8] <= Bus2IP_Data[11:8];  
    end

  // 0x2C Subclass
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_subclass <= 2'b01;
    end
    else if (bank0_write[11])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_subclass <= Bus2IP_Data[1:0];
        
    end

  // 0x400-0x42C Lane IDs for lanes 0-12
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid0 <= 5'd0;
    end
    else if (bank1_write[0])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid0 <= Bus2IP_Data[4:0];
      end
    end
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid1 <= 5'd1;
    end
    else if (bank1_write[1])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid1 <= Bus2IP_Data[4:0];
      end
    end
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid2 <= 5'd2;
    end
    else if (bank1_write[2])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid2 <= Bus2IP_Data[4:0];
      end
    end
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid3 <= 5'd3;
    end
    else if (bank1_write[3])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid3 <= Bus2IP_Data[4:0];
      end
    end
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid4 <= 5'd4;
    end
    else if (bank1_write[4])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid4 <= Bus2IP_Data[4:0];
      end
    end
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid5 <= 5'd5;
    end
    else if (bank1_write[5])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid5 <= Bus2IP_Data[4:0];
      end
    end
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid6 <= 5'd6;
    end
    else if (bank1_write[6])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid6 <= Bus2IP_Data[4:0];
      end
    end
  
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_lid7 <= 5'd7;
    end
    else if (bank1_write[7])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_lid7 <= Bus2IP_Data[4:0];
      end
    end
    
    
  // 0x80C ILA Config Data for transmission : DID, BID
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_did[7:0] <= 8'd0;
      tx_cfg_bid[3:0] <= 4'd0;
    end
    else if (bank2_write[3])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_did[7:0] <= Bus2IP_Data[7:0];
      end
      if (Bus2IP_BE[1])
      begin
        tx_cfg_bid[3:0] <= Bus2IP_Data[11:8];
      end
    end

  // 0x810 ILA Config Data for transmission : M, N, N', CS
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_m[7:0]  <= 8'd0;
      tx_cfg_n[4:0]  <= 5'd0;
      tx_cfg_np[4:0] <= 5'd0;
      tx_cfg_cs[1:0] <= 2'd0;
    end
    else if (bank2_write[4])
    begin
      if (Bus2IP_BE[0])
      begin
        tx_cfg_m  <= Bus2IP_Data[7:0];
      end
      if (Bus2IP_BE[1])
      begin
        tx_cfg_n  <= Bus2IP_Data[12:8];
      end
      if (Bus2IP_BE[2])
      begin
        tx_cfg_np[4:0] <= Bus2IP_Data[20:16];
      end
      if (Bus2IP_BE[3])
      begin
        tx_cfg_cs[1:0] <= Bus2IP_Data[25:24];
      end
    end

  // 0x814 ILA Config Data for transmission : S, HD, CF
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_s[4:0]  <= 5'd0;
      tx_cfg_hd      <= 1'b0;
      tx_cfg_cf[4:0] <= 5'd0;
    end
    else if (bank2_write[5])
    begin
      if (Bus2IP_BE[1])
      begin
        tx_cfg_s[4:0]  <= Bus2IP_Data[12:8];
      end
      if (Bus2IP_BE[2])
      begin
        tx_cfg_hd <= Bus2IP_Data[16];
      end
      if (Bus2IP_BE[3])
      begin
        tx_cfg_cf[4:0]   <= Bus2IP_Data[28:24];
      end
    end

  // 0x818 ILA Config Data for transmission : RES1, RES2
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
     tx_cfg_res1[7:0] <= 8'd0;
     tx_cfg_res2[7:0] <= 8'd0;
    end
    else if (bank2_write[6])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_res1[7:0] <= Bus2IP_Data[7:0];
      if (Bus2IP_BE[1])
        tx_cfg_res2[7:0] <= Bus2IP_Data[15:8];
    end

  // 0x81C ILA Config Data for transmission : ADJDIR, PHADJ, ADJCNT (Subclass 2 only)
  always @(posedge Bus2IP_Clk)
    if (~Bus2IP_Resetn)
    begin
      tx_cfg_adjdir   <= 1'b0;
      tx_cfg_phadj    <= 1'b0;
      tx_cfg_adjcnt   <= 4'd0;
    end
    else if (bank2_write[7])
    begin
      if (Bus2IP_BE[0])
        tx_cfg_adjcnt   <= Bus2IP_Data[3:0];
      if (Bus2IP_BE[1])
      begin
        tx_cfg_phadj    <= Bus2IP_Data[8];
      end
      if (Bus2IP_BE[2])
      begin
        tx_cfg_adjdir   <= Bus2IP_Data[16];
      end
    end

  // Register Bank 0 : 0x000 - 0x03F : Configuration
  assign IP2Bus_Data_configs = bank0_read[0] ? {8'd7, 8'd1, 8'd1, 8'h00} :
                               bank0_read[1] ? {15'h0, tx_wd_disable, 15'h0, tx_core_rst_i} :
                               bank0_read[2] ? {30'h0, tx_cfg_support_lane_sync} :
                               bank0_read[3] ? {31'h0, tx_cfg_scr_enable} :
                               bank0_read[4] ? {15'h0, tx_cfg_sysref_resync, 4'h0, tx_sysref_delay, 7'h0, tx_cfg_sysref_always} :
                               bank0_read[5] ? {24'h0, tx_cfg_multi_frames} :
                               bank0_read[6] ? {27'h0, tx_cfg_test_modes} :
                               bank0_read[8] ? {24'h0, tx_cfg_octets_per_frame} :
                               bank0_read[9] ? {27'h0, tx_cfg_frames_per_multi} :
                               bank0_read[10] ? {20'h0, tx_cfg_lanes_in_use} :
                               bank0_read[11] ? {30'h0, tx_cfg_subclass} :
                               bank0_read[14] ? {15'h0, tx_sysref_captured, 15'h0, tx_cfg_sync} :
                               32'h00000000;
  
  // Register Bank 1 : 0x400 - 0x43F : Lane IDs
  assign IP2Bus_Data_laneID  = 
                               bank1_read[0] ? {27'h0, tx_cfg_lid0} : 
                               bank1_read[1] ? {27'h0, tx_cfg_lid1} : 
                               bank1_read[2] ? {27'h0, tx_cfg_lid2} : 
                               bank1_read[3] ? {27'h0, tx_cfg_lid3} : 
                               bank1_read[4] ? {27'h0, tx_cfg_lid4} : 
                               bank1_read[5] ? {27'h0, tx_cfg_lid5} : 
                               bank1_read[6] ? {27'h0, tx_cfg_lid6} : 
                               bank1_read[7] ? {27'h0, tx_cfg_lid7} :                                
                               32'h00000000;

  // Register Bank 2 : 0x800 - 0xAFF : ILA Config Data for transmission
  assign IP2Bus_Data_settings = bank2_read[3] ? {24'h0, tx_cfg_bid, tx_cfg_did[7:0]} :
                                bank2_read[4] ? {6'h0, tx_cfg_cs, 3'b0, tx_cfg_np, 3'b0, tx_cfg_n, tx_cfg_m} :
                                bank2_read[5] ? {3'h0, tx_cfg_cf[4:0], 7'h0, tx_cfg_hd, 3'h0, tx_cfg_s, 8'h0} :
                                bank2_read[6] ? {16'h0, tx_cfg_res2[7:0], tx_cfg_res1[7:0]} :
                                bank2_read[7] ? {15'b0, tx_cfg_adjdir, 7'b0, tx_cfg_phadj, 4'h0, tx_cfg_adjcnt}:
                                32'h00000000;

  // Assign AXI Bus output depending on CS
  always @(posedge Bus2IP_Clk)
    if (chip_select[0])
      IP2Bus_Data <= IP2Bus_Data_configs;
    else if (chip_select[1])
      IP2Bus_Data <= IP2Bus_Data_laneID;
    else // if (chip_select[2])
      IP2Bus_Data <= IP2Bus_Data_settings;

    
  always @(posedge Bus2IP_Clk)
    if (Bus2IP_RdCE == 1'b1) begin
      IP2Bus_RdAck_r    <= 1'b1;
      IP2Bus_RdAck_rr   <= IP2Bus_RdAck_r;
      IP2Bus_RdAck      <= IP2Bus_RdAck_rr;      
    end
    else
    begin
      IP2Bus_RdAck    <= 1'b0;
      IP2Bus_RdAck_r    <= 1'b0;
      IP2Bus_RdAck_rr    <= 1'b0;
    end    
    
             
  // Instantiate reset block
  jesd204_dac_reset_block  i_jesd204_dac_reset_block (
    .axi_clk           (Bus2IP_Clk),
    .core_clk          (tx_core_clk),
    .reset             (tx_reset), 
    .cfg_reset         (tx_cfg_reset_i), 
    .gt_reset_done     (tx_reset_done),
    .cfg_sync          (tx_cfg_sync),
    .wd_disable        (tx_wd_disable),
    .core_reset_reg    (tx_core_rst_i),
    .core_reset_sync   (tx_core_rst),
    .gt_reset          (tx_reset_gt)
  );
   
  // Clock Domain Synchronizers 
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_tx_sysref_captured  (
  .dest_clk (Bus2IP_Clk),	
  .src_clk  (1'd0),	
  .src_in   (tx_sysref_captured_i),
  .dest_out (tx_sysref_captured_sync)
  );
      
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_tx_sync  (
  .dest_clk (Bus2IP_Clk),	
  .src_clk  (1'd0),	
  .src_in   (in_sync),
  .dest_out (tx_cfg_sync)
  );
    
  assign tx_sysref_captured = (tx_cfg_subclass == 2'h1) ? tx_sysref_captured_sync : 1'b0;

  // Capture SYSREF
  always @(posedge tx_core_clk)
    tx_sysref_r <= tx_sysref;

endmodule
