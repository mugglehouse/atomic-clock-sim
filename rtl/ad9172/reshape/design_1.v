//////////////////////////////////////////////////////////////////////////////////
//     FileName: design_1.v                                                            
//     SvnProperties:                                                             
//         $URL: http://svn.hq.org/svn/PR1104/DEVELOP/03_FPGAPrj_for_VIVADO/HQGF_4_DRFMJ1G/V1/branches/interp12_960MSPS/src/inf/204b/bd/design_1.v                                                                
//         $Author: yujiahe $                                                     
//         $Revision:  16946                                                           
//         $Date: 2020-03-01                                                      
//                                                                                
//////////////////////////////////////////////////////////////////////////////////
//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
//Date        : Mon Nov 04 16:30:27 2019
//Host        : hqrd051 running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1(
clk_50m_bufg,
gt_refclk,

s_axi_aresetn,
s_axi_dac_araddr,
s_axi_dac_arready,
s_axi_dac_arvalid,
s_axi_dac_awaddr,
s_axi_dac_awready,
s_axi_dac_awvalid,
s_axi_dac_bready,
s_axi_dac_bresp,
s_axi_dac_bvalid,
s_axi_dac_rdata,
s_axi_dac_rready,
s_axi_dac_rresp,
s_axi_dac_rvalid,
s_axi_dac_wdata,
s_axi_dac_wready,
s_axi_dac_wstrb,
s_axi_dac_wvalid,

s_axis_tx_tdata,
s_axis_tx_tready,

tx_core_clk,
tx_reset,
tx_reset_done_dac,
tx_sync,
tx_sysref,
txn_out,
txp_out,

jesd204_da_gt0_tx_txcharisk,
jesd204_da_gt0_tx_txdata
);

input                     clk_50m_bufg      ;
input                     gt_refclk         ;                                                 
                         
input                     s_axi_aresetn     ;
input       [11:0]        s_axi_dac_araddr  ;
output                    s_axi_dac_arready ;
input                     s_axi_dac_arvalid ;
input       [11:0]        s_axi_dac_awaddr  ;
output                    s_axi_dac_awready ;
input                     s_axi_dac_awvalid ;
input                     s_axi_dac_bready  ;
output      [1:0]         s_axi_dac_bresp   ;
output                    s_axi_dac_bvalid  ;
output      [31:0]        s_axi_dac_rdata   ;
input                     s_axi_dac_rready  ;
output      [1:0]         s_axi_dac_rresp   ;
output                    s_axi_dac_rvalid  ;
input       [31:0]        s_axi_dac_wdata   ;
output                    s_axi_dac_wready  ;
input       [3:0]         s_axi_dac_wstrb   ;
input                     s_axi_dac_wvalid  ;
                         
input       [255:0]       s_axis_tx_tdata   ;
output                    s_axis_tx_tready  ;
                         
input                     tx_core_clk       ;
input                     tx_reset          ;
output                    tx_reset_done_dac ;
input                     tx_sync           ;
input                     tx_sysref         ;
output      [7:0]         txn_out           ;
output      [7:0]         txp_out           ;

output      [3:0]         jesd204_da_gt0_tx_txcharisk;
output      [31:0]        jesd204_da_gt0_tx_txdata;

wire        [3:0]         jesd204_da_gt0_tx_txcharisk;
wire        [31:0]        jesd204_da_gt0_tx_txdata;
wire        [3:0]         jesd204_da_gt1_tx_txcharisk;
wire        [31:0]        jesd204_da_gt1_tx_txdata;
wire        [3:0]         jesd204_da_gt2_tx_txcharisk;
wire        [31:0]        jesd204_da_gt2_tx_txdata;
wire        [3:0]         jesd204_da_gt3_tx_txcharisk;
wire        [31:0]        jesd204_da_gt3_tx_txdata;
wire        [3:0]         jesd204_da_gt4_tx_txcharisk;
wire        [31:0]        jesd204_da_gt4_tx_txdata;
wire        [3:0]         jesd204_da_gt5_tx_txcharisk;
wire        [31:0]        jesd204_da_gt5_tx_txdata;
wire        [3:0]         jesd204_da_gt6_tx_txcharisk;
wire        [31:0]        jesd204_da_gt6_tx_txdata;
wire        [3:0]         jesd204_da_gt7_tx_txcharisk;
wire        [31:0]        jesd204_da_gt7_tx_txdata;
wire        [2:0]         jesd204_da_gt_prbssel_out  ;
wire                      jesd204_da_tx_reset_gt     ;
wire        [7:0]         jesd204_phy_0_txn_out      ;
wire        [7:0]         jesd204_phy_0_txp_out      ;

wire        [11:0]        s_axi_1_ARADDR      ;
wire                      s_axi_1_ARREADY     ;
wire                      s_axi_1_ARVALID     ;
wire        [11:0]        s_axi_1_AWADDR      ;
wire                      s_axi_1_AWREADY     ;
wire                      s_axi_1_AWVALID     ;
wire                      s_axi_1_BREADY      ;
wire        [1:0]         s_axi_1_BRESP       ;
wire                      s_axi_1_BVALID      ;
wire        [31:0]        s_axi_1_RDATA       ;
wire                      s_axi_1_RREADY      ;
wire        [1:0]         s_axi_1_RRESP       ;
wire                      s_axi_1_RVALID      ;
wire        [31:0]        s_axi_1_WDATA       ;
wire                      s_axi_1_WREADY      ;
wire        [3:0]         s_axi_1_WSTRB       ;
wire                      s_axi_1_WVALID      ;
wire                      s_axi_aclk_1        ;
wire                      s_axi_aresetn_1     ;
wire        [255:0]       s_axis_tx_1_1_TDATA ;
wire                      s_axis_tx_1_1_TREADY;
wire                      tx_core_clk_1       ;
wire                      tx_reset_1          ;
wire                      tx_sync_1           ;
wire                      rx_core_clk_phy     ;

wire                      rx_reset_gt_phy     ;
wire                      rx_sys_reset_phy    ;
wire        [7:0]         rxn_in_phy          ;
wire        [7:0]         rxp_in_phy          ;
  
wire                      tx_sysref           ;
wire                      tx_sysref_d1        ;

wire jesd204_phy_0_tx_reset_done;

assign gt_refclk_1 = gt_refclk;

assign s_axi_1_ARADDR = s_axi_dac_araddr[11:0];
assign s_axi_1_ARVALID = s_axi_dac_arvalid;
assign s_axi_1_AWADDR = s_axi_dac_awaddr[11:0];
assign s_axi_1_AWVALID = s_axi_dac_awvalid;
assign s_axi_1_BREADY = s_axi_dac_bready;
assign s_axi_1_RREADY = s_axi_dac_rready;
assign s_axi_1_WDATA = s_axi_dac_wdata[31:0];
assign s_axi_1_WSTRB = s_axi_dac_wstrb[3:0];
assign s_axi_1_WVALID = s_axi_dac_wvalid;
assign s_axi_aclk_1 = clk_50m_bufg;

assign s_axi_aresetn_1 = s_axi_aresetn;
assign s_axi_dac_arready = s_axi_1_ARREADY;
assign s_axi_dac_awready = s_axi_1_AWREADY;
assign s_axi_dac_bresp[1:0] = s_axi_1_BRESP;
assign s_axi_dac_bvalid = s_axi_1_BVALID;
assign s_axi_dac_rdata[31:0] = s_axi_1_RDATA;
assign s_axi_dac_rresp[1:0] = s_axi_1_RRESP;
assign s_axi_dac_rvalid = s_axi_1_RVALID;
assign s_axi_dac_wready = s_axi_1_WREADY;
assign s_axis_tx_1_1_TDATA = s_axis_tx_tdata[255:0];
assign s_axis_tx_tready = s_axis_tx_1_1_TREADY;
assign tx_core_clk_1 = tx_core_clk;
assign tx_reset_1 = tx_reset;
assign tx_reset_done_dac = jesd204_phy_0_tx_reset_done;
assign tx_sync_1 = tx_sync;
assign txn_out[7:0] = jesd204_phy_0_txn_out;
assign txp_out[7:0] = jesd204_phy_0_txp_out;
assign tx_sysref_d1 = tx_sysref;

jesd204_dac                           u_jesd204_dac(
  .gt0_txcharisk                       (jesd204_da_gt0_tx_txcharisk ),
  .gt0_txdata                          (jesd204_da_gt0_tx_txdata    ),
  .gt1_txcharisk                       (jesd204_da_gt1_tx_txcharisk ),
  .gt1_txdata                          (jesd204_da_gt1_tx_txdata    ),
  .gt2_txcharisk                       (jesd204_da_gt2_tx_txcharisk ),
  .gt2_txdata                          (jesd204_da_gt2_tx_txdata    ),
  .gt3_txcharisk                       (jesd204_da_gt3_tx_txcharisk ),
  .gt3_txdata                          (jesd204_da_gt3_tx_txdata    ),
  .gt4_txcharisk                       (jesd204_da_gt4_tx_txcharisk ),
  .gt4_txdata                          (jesd204_da_gt4_tx_txdata    ),
  .gt5_txcharisk                       (jesd204_da_gt5_tx_txcharisk ),
  .gt5_txdata                          (jesd204_da_gt5_tx_txdata    ),
  .gt6_txcharisk                       (jesd204_da_gt6_tx_txcharisk ),
  .gt6_txdata                          (jesd204_da_gt6_tx_txdata    ),
  .gt7_txcharisk                       (jesd204_da_gt7_tx_txcharisk ),
  .gt7_txdata                          (jesd204_da_gt7_tx_txdata    ),
  .gt_prbssel_out                      (jesd204_da_gt_prbssel_out   ),
  .s_axi_aclk                          (s_axi_aclk_1),
  .s_axi_araddr                        (s_axi_1_ARADDR),
  .s_axi_aresetn                       (s_axi_aresetn_1),
  .s_axi_arready                       (s_axi_1_ARREADY),
  .s_axi_arvalid                       (s_axi_1_ARVALID),
  .s_axi_awaddr                        (s_axi_1_AWADDR),
  .s_axi_awready                       (s_axi_1_AWREADY),
  .s_axi_awvalid                       (s_axi_1_AWVALID),
  .s_axi_bready                        (s_axi_1_BREADY),
  .s_axi_bresp                         (s_axi_1_BRESP),
  .s_axi_bvalid                        (s_axi_1_BVALID),
  .s_axi_rdata                         (s_axi_1_RDATA),
  .s_axi_rready                        (s_axi_1_RREADY),
  .s_axi_rresp                         (s_axi_1_RRESP),
  .s_axi_rvalid                        (s_axi_1_RVALID),
  .s_axi_wdata                         (s_axi_1_WDATA),
  .s_axi_wready                        (s_axi_1_WREADY),
  .s_axi_wstrb                         (s_axi_1_WSTRB),
  .s_axi_wvalid                        (s_axi_1_WVALID),
  .tx_core_clk                         (tx_core_clk_1),
  .tx_reset                            (tx_reset_1),
  .tx_reset_done                       (jesd204_phy_0_tx_reset_done),
  .tx_reset_gt                         (jesd204_da_tx_reset_gt),
  .tx_sync                             (tx_sync_1),
  .tx_sysref                           (tx_sysref_d1),
  .tx_tdata                            (s_axis_tx_1_1_TDATA),
  .tx_tready                           (s_axis_tx_1_1_TREADY),
  .tx_aresetn                          (),
  .tx_start_of_frame                   (),
  .tx_start_of_multiframe              ()
);

jesd204_phy_dac                       u_jesd204_phy_dac(     
  .drpclk                              (s_axi_aclk_1),
  .tx_core_clk                         (tx_core_clk_1),
  .txoutclk                            (),
  .rx_core_clk                         (0),
  .rxoutclk                            (),
  
  .gt_prbssel                          (jesd204_da_gt_prbssel_out),
                                                                      
  .tx_reset_done                       (jesd204_phy_0_tx_reset_done),
  .tx_reset_gt                         (jesd204_da_tx_reset_gt),
  .tx_sys_reset                        (tx_reset_1),
  .rx_reset_done                       (),
  .rx_reset_gt                         (0),
  .rx_sys_reset                        (0),
  
  .cpll_refclk                         (gt_refclk_1),
  .rxencommaalign                      (0),   
  
  
  .gt0_txcharisk                       (jesd204_da_gt0_tx_txcharisk ),
  .gt0_txdata                          (jesd204_da_gt0_tx_txdata    ),                                       
  .gt1_txcharisk                       (jesd204_da_gt1_tx_txcharisk ),
  .gt1_txdata                          (jesd204_da_gt1_tx_txdata    ),                                       
  .gt2_txcharisk                       (jesd204_da_gt2_tx_txcharisk ),
  .gt2_txdata                          (jesd204_da_gt2_tx_txdata    ),                                   
  .gt3_txcharisk                       (jesd204_da_gt3_tx_txcharisk ),
  .gt3_txdata                          (jesd204_da_gt3_tx_txdata    ),                                      
  .gt4_txcharisk                       (jesd204_da_gt4_tx_txcharisk ),
  .gt4_txdata                          (jesd204_da_gt4_tx_txdata    ),                                       
  .gt5_txcharisk                       (jesd204_da_gt5_tx_txcharisk ),
  .gt5_txdata                          (jesd204_da_gt5_tx_txdata    ),                                       
  .gt6_txcharisk                       (jesd204_da_gt6_tx_txcharisk ),
  .gt6_txdata                          (jesd204_da_gt6_tx_txdata    ),                                     
  .gt7_txcharisk                       (jesd204_da_gt7_tx_txcharisk ),
  .gt7_txdata                          (jesd204_da_gt7_tx_txdata    ),
  
  
  .gt0_rxcharisk                       (),
  .gt0_rxdisperr                       (),
  .gt0_rxnotintable                    (),
  .gt0_rxdata                          (),
                                       
  .gt1_rxcharisk                       (),
  .gt1_rxdisperr                       (),
  .gt1_rxnotintable                    (),
  .gt1_rxdata                          (),
                                       
  .gt2_rxcharisk                       (),
  .gt2_rxdisperr                       (),
  .gt2_rxnotintable                    (),
  .gt2_rxdata                          (),
                                       
  .gt3_rxcharisk                       (),
  .gt3_rxdisperr                       (),
  .gt3_rxnotintable                    (),
  .gt3_rxdata                          (),
                                       
  .gt4_rxcharisk                       (),
  .gt4_rxdisperr                       (),
  .gt4_rxnotintable                    (),
  .gt4_rxdata                          (),
                                       
  .gt5_rxcharisk                       (),
  .gt5_rxdisperr                       (),
  .gt5_rxnotintable                    (),
  .gt5_rxdata                          (),
                                       
  .gt6_rxcharisk                       (),
  .gt6_rxdisperr                       (),
  .gt6_rxnotintable                    (),
  .gt6_rxdata                          (),
                                       
  .gt7_rxcharisk                       (),
  .gt7_rxdisperr                       (),
  .gt7_rxnotintable                    (),
  .gt7_rxdata                          (),
  
  .rxn_in                              (0),
  .rxp_in                              (0),
  .txn_out                             (jesd204_phy_0_txn_out),
  .txp_out                             (jesd204_phy_0_txp_out)
);
//no adc
assign   rx_core_clk_phy     = tx_core_clk_1          ;
assign   rx_reset_gt_phy     = jesd204_da_tx_reset_gt ;
assign   rx_sys_reset_phy    = 1'b0                   ;
        
endmodule
