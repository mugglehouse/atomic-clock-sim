//`define SYSREF_CALI
`define RESET_MODULE_EN
module ad9172_inf(
clk_50m_bufg,
rst_glb,
iob_refclk_p,
iob_refclk_n,
iob_sysref_p,
iob_sysref_n,
iob_glblclk_p,
iob_glblclk_n,
// output
clk_user_bufg,
refclk,
sysref_o,
clk_glbl_o,
dac_ready,
//-------shared ports-------//
iob_txp,
iob_txn,
dac_tx_tdata,
dac_axi_awready,
dac_axi_wready,
//--------user ports---------//
qstack_version,  //0 for QSTACK5, 1 for QSTACK4
da0i_ch00,
da0i_ch01,
da0i_ch02,
da0i_ch03,
da1i_ch00,
da1i_ch01,
da1i_ch02,
da1i_ch03,
da0q_ch00,
da0q_ch01,
da0q_ch02,
da0q_ch03,
da1q_ch00,
da1q_ch01,
da1q_ch02,
da1q_ch03,
// simulation
tx_sync_dac,
dac_axi_awaddr,
dac_axi_awvalid,
dac_axi_wdata,
dac_axi_wstrb,
dac_axi_wvalid,
dac_axi_bresp,
dac_axi_bvalid,
dac_axi_bready,
dac_axi_araddr,
dac_axi_arvalid,
dac_axi_arready,
dac_axi_rdata,
dac_axi_rresp,
dac_axi_rvalid,
dac_axi_rready,
dac_ready_negedge,
tx_reset_done_dac,
jesd204_da_gt0_tx_txcharisk,
jesd204_da_gt0_tx_txdata,
cnt_timing,
rst_int
);

input            	clk_50m_bufg              ;
input            	rst_glb                   ; // 0 高有效
input             clk_user_bufg             ; 

input  dac_ready;
//-------------shared ports-----------------//
output [7:0]      iob_txp                   ; 
output [7:0]      iob_txn                   ;
output [255:0]   dac_tx_tdata              ;
output  dac_axi_awready;
output  dac_axi_wready;

// iob_module
input  iob_refclk_p;
input  iob_refclk_n;
input  iob_sysref_p;
input  iob_sysref_n;
input  iob_glblclk_p;
input  iob_glblclk_n;

output sysref_o; 
output refclk;
output clk_glbl_o;

// reset_ctrl_global
output rst_int;

//---------------user ports-----------------//
input             qstack_version            ; // 1
input  [15:0]     da0i_ch00                 ; // ok
input  [15:0]   	da0i_ch01                 ;
input  [15:0]   	da0i_ch02                 ;
input  [15:0]   	da0i_ch03                 ;
input  [15:0]     da1i_ch00                 ;
input  [15:0]   	da1i_ch01                 ;
input  [15:0]   	da1i_ch02                 ;
input  [15:0]   	da1i_ch03                 ;
input  [15:0]     da0q_ch00                 ;
input  [15:0]   	da0q_ch01                 ;
input  [15:0]   	da0q_ch02                 ;
input  [15:0]   	da0q_ch03                 ;
input  [15:0]     da1q_ch00                 ;
input  [15:0]   	da1q_ch01                 ;
input  [15:0]   	da1q_ch02                 ;
input  [15:0]   	da1q_ch03                 ;

// simulation
output [1:0] tx_sync_dac;
output [11:0] dac_axi_awaddr;
output dac_axi_awvalid;
output [31:0] dac_axi_wdata;
output [3:0] dac_axi_wstrb;
output dac_axi_wvalid;
output [1:0] dac_axi_bresp;
output dac_axi_bvalid;
output dac_axi_bready;
output [11:0] dac_axi_araddr;
output dac_axi_arvalid;
output dac_axi_arready;
output [31:0] dac_axi_rdata;
output [1:0] dac_axi_rresp;
output dac_axi_rvalid;
output dac_axi_rready;
output dac_ready_negedge;
output tx_reset_done_dac;
output [3:0] jesd204_da_gt0_tx_txcharisk;
output [31:0] jesd204_da_gt0_tx_txdata;
output [15:0] cnt_timing;

assign rst_int = rst_glb;

iob_module                    u_iob_module(
	.clk_50m_bufg                (clk_50m_bufg              ), 
	.clk_user_bufg               (clk_user_bufg             ),
	.rst_glb                     (rst_glb                   ),
	.iob_refclk_p                (iob_refclk_p              ), // I 生成refclk
	.iob_refclk_n                (iob_refclk_n              ), // I
	.iob_sysref_p                (iob_sysref_p              ), // I 生成sysref_o  
	.iob_sysref_n                (iob_sysref_n              ), // I
	.iob_glblclk_p               (iob_glblclk_p             ), // I 生成clk_user_bufg的
	.iob_glblclk_n               (iob_glblclk_n             ), // I
	.iob_dac_sync204_p           (0         ), // I
	.iob_dac_sync204_n           (0         ), // I


	.multi_board_sync_enable     (0   ),// I
	.adda_ready                  (dac_ready                 ), 
	.rst_sync                    (0                  ), // I
	.clk_cfg_done                (1         ), // I
	.close_sysref                (        ), // O
	.clk_slow_bufg               (             ), // O
	.clk_dac_cfg                 (             ), // O，multi_board_sync_enable_o: 1:40.96Mhz 0:50Mhz
	.gt_refclk                   (refclk                    ), // O /////
	.gt_refclk_copy              (              ), // O
	.sysref                      (sysref_o                  ), // O /////
	.clk_glbl_bufg               (clk_glbl_o                ), // O
	.glblclk_freq_correct        (     ), // O
	.gtref_freq_correct          (        ), // O
	
	.dac_sync                    (              ), // O
  .dac0_cnt_lose_sync          (        ), // O
  .dac1_cnt_lose_sync          (       ) // O
);


// rst_int
// reset_ctrl_global             u_reset_ctrl_global(
// 	.clk                         (clk_50m_bufg             ),
// 	.clk_user_bufg               (clk_user_bufg            ),
// 	.rst                         (rst_glb   ),
// 	.dac_ready                   (dac_ready                ), 
// 	.multi_board_sync_enable_i   (0                        ), 
// 	.multi_board_sync_enable_o   (                         ),
//   .dac_data_mux                (                         ),
//   .dac_status                  (1'b1               ),
//   .ad_sig_detected             (1'b1                     ),
//   .rst_int                     (rst_int                  )
// );


//------------------DAC IP config------------------------//
dac_204b_cfg_module           u_dac_204b_cfg_module(
  .clk                         (clk_50m_bufg              ),
  .rst                         (rst_int                    ),
  .axi_awaddr                  (dac_axi_awaddr            ), // O
  .axi_awvalid                 (dac_axi_awvalid           ), // O
  .axi_awready                 (dac_axi_awready           ), // I 0
  .axi_wdata                   (dac_axi_wdata             ), // O 有数
  .axi_wstrb                   (dac_axi_wstrb             ), // O
  .axi_wvalid                  (dac_axi_wvalid            ), // O
  .axi_wready                  (dac_axi_wready            ), // I 0
  .axi_bresp                   (dac_axi_bresp             ), // I
  .axi_bvalid                  (dac_axi_bvalid            ), // I
  .axi_bready                  (dac_axi_bready            ), // O 1
  .axi_araddr                  (dac_axi_araddr            ), // O
  .axi_arvalid                 (dac_axi_arvalid           ), // O
  .axi_arready                 (dac_axi_arready           ), // I 1
  .axi_rdata                   (dac_axi_rdata             ), // I
  .axi_rresp                   (dac_axi_rresp             ), // I
  .axi_rvalid                  (dac_axi_rvalid            ), // I
  .axi_rready                  (dac_axi_rready            ), // O
  .cnt_timing                  (cnt_timing)
);

//------------------DAC signale gen------------------------//
dac_data_reshape              u_dac_data_reshape(
	.clk_user_bufg               (clk_user_bufg                  ), // input
	.rst                         (0), // input 仿真显示1 initial_done
	.qstack_version              (qstack_version                 ), // input 1   0 for QSTACK5, 1 for QSTACK4  
	.dac_ready                   (dac_ready), // input 仿真显示为0
	.da0i_ch00                   (da1i_ch00                      ), // input
	.da0i_ch01                   (da1i_ch01                      ), 
	.da0i_ch02                   (da1i_ch02                      ),
	.da0i_ch03                   (da1i_ch03                      ),
	.da1i_ch00                   (da0i_ch00                      ),
	.da1i_ch01                   (da0i_ch01                      ),
	.da1i_ch02                   (da0i_ch02                      ),
	.da1i_ch03                   (da0i_ch03                      ),
	.da0q_ch00                   (da1q_ch00                      ),
	.da0q_ch01                   (da1q_ch01                      ),
	.da0q_ch02                   (da1q_ch02                      ),
	.da0q_ch03                   (da1q_ch03                      ),
	.da1q_ch00                   (da0q_ch00                      ),
	.da1q_ch01                   (da0q_ch01                      ),
	.da1q_ch02                   (da0q_ch02                      ),
	.da1q_ch03                   (da0q_ch03                      ),
	.dac_tx_tdata_o              (dac_tx_tdata                   ), // output
	.dac_ready_negedge           (dac_ready_negedge              ), // output
  // assign  dac_tx_tdata_o = DAC_DATA_MUX_VIO ? {8{32'hFF7FFF7F}} : dac_tx_tdata;
	.DAC_DATA_MUX_VIO            (0               )  // I
);

// 增加了rst_int
design_1                      u_design_1(
  .gt_refclk                   (refclk                         ), // input/////////
  .clk_50m_bufg                (clk_50m_bufg                   ), // input
  .s_axi_dac_araddr            (dac_axi_araddr                 ), // input
  .s_axi_aresetn               (~rst_int                       ), // input
  .s_axi_dac_arready           (dac_axi_arready                ), // output 1
  .s_axi_dac_arvalid           (dac_axi_arvalid                ), // input
  .s_axi_dac_awaddr            (dac_axi_awaddr                 ), // input
  .s_axi_dac_awready           (dac_axi_awready                ), // output 0
  .s_axi_dac_awvalid           (dac_axi_awvalid                ), // input
  .s_axi_dac_bready            (dac_axi_bready                 ), // input  1
  .s_axi_dac_bresp             (dac_axi_bresp                  ), // output
  .s_axi_dac_bvalid            (dac_axi_bvalid                 ), // output
  .s_axi_dac_rdata             (dac_axi_rdata                  ), // output
  .s_axi_dac_rready            (dac_axi_rready                 ), // input
  .s_axi_dac_rresp             (dac_axi_rresp                  ), // output
  .s_axi_dac_rvalid            (dac_axi_rvalid                 ), // output
  .s_axi_dac_wdata             (dac_axi_wdata                  ), // input
  .s_axi_dac_wready            (dac_axi_wready                 ), // output 0
  .s_axi_dac_wstrb             (dac_axi_wstrb                  ), // input
  .s_axi_dac_wvalid            (dac_axi_wvalid                 ), // input
  .tx_reset_done_dac           (tx_reset_done_dac              ), // output
  .s_axis_tx_tdata             (dac_tx_tdata                   ), // input
  .s_axis_tx_tready            (                               ), // output
  .tx_core_clk                 (clk_user_bufg                  ), // input
  .tx_reset                    (0), //  /////////////////////////initial_done
  .tx_sync                     (&tx_sync_dac[1:0]              ), // output
  .tx_sysref                   (sysref_o                      ), // input/////////////
  .txp_out                     (iob_txp[7:0]                   ), // output
  .txn_out                     (iob_txn[7:0]                   ), // output
  //-----debug---------------------------
  .jesd204_da_gt0_tx_txcharisk (jesd204_da_gt0_tx_txcharisk    ), // output
  .jesd204_da_gt0_tx_txdata    (jesd204_da_gt0_tx_txdata       )   // output    
);

endmodule