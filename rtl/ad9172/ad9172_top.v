module ad9172_top( 
    input clk_50m_bufg,      
    input rst_glb,
    input dac_ready,
    // dds_for_7_series_iq
    input [15:0] DDS_MODE_VIO,
    input [31:0] DDS_FIN_MHz_VIO,
    input [31:0] DDS_FIN_HEX_VIO,
    input [31:0] DDS_PRT_WIDTH_VIO,
    input [31:0] DDS_PRT_CYCLE_VIO,
    input [14:0] DDS_AMP_MULTIP_VIO,
    input [9:0] DDS_ATT_0p1dB_VIO,
    input [31:0] DDS_FREQHOPSPEED_VIO,
    input [15:0] DDS_FREQHOP_kHz_VIO,
    input [15:0] DDS_FREQHOP_START_MHz_VIO,
    input [15:0] DDS_FREQHOP_STOP_MHz_VIO,
    input [19:0] DDS_IMD_INTERVAL_kHz_VIO,
    
    // iob_module
    input iob_refclk_p,
    input iob_refclk_n,
    input iob_sysref_p,
    input iob_sysref_n,
    input iob_glblclk_p,
    input iob_glblclk_n,
    output refclk,
    output sysref_o,
    output clk_user_bufg,

    // dds_for_7_series_iq
    output pulse_user, 
    output [255:0] dds_rsv_port_o,
    output [15:0] i0,
    output [15:0] i1,
    output [15:0] i2,
    output [15:0] i3,
    output [15:0] i4,
    output [15:0] i5,
    output [15:0] i6,
    output [15:0] i7,
    output [15:0] i8,
    output [15:0] i9,
    output [15:0] i10,
    output [15:0] i11,
    output [15:0] i12,
    output [15:0] i13,
    output [15:0] i14,
    output [15:0] i15,
    output [15:0] q0,
    output [15:0] q1,
    output [15:0] q2,
    output [15:0] q3,
    output [15:0] q4,
    output [15:0] q5,
    output [15:0] q6,
    output [15:0] q7,
    output [15:0] q8,
    output [15:0] q9,
    output [15:0] q10,
    output [15:0] q11,
    output [15:0] q12,
    output [15:0] q13,
    output [15:0] q14,
    output [15:0] q15,

    // da_channel
    output [15:0] da0i_ch00,
    output [15:0] da0i_ch01,
    output [15:0] da0i_ch02,
    output [15:0] da0i_ch03,
    output [15:0] da1i_ch00,
    output [15:0] da1i_ch01,
    output [15:0] da1i_ch02,
    output [15:0] da1i_ch03,
    output [15:0] da0q_ch00,
    output [15:0] da0q_ch01,
    output [15:0] da0q_ch02,
    output [15:0] da0q_ch03,
    output [15:0] da1q_ch00,
    output [15:0] da1q_ch01,
    output [15:0] da1q_ch02,
    output [15:0] da1q_ch03,
    output [15:0] da0i_ch04,

    // data_reshape
    output [7:0] iob_txp,
    output [7:0] iob_txn,
    output [255:0] dac_tx_tdata,
    output dac_axi_awready,
    output dac_axi_wready,

    // sim
    output [1:0] tx_sync_dac,
    output [11:0] dac_axi_awaddr,
    output dac_axi_awvalid,
    output [31:0] dac_axi_wdata,
    output [3:0] dac_axi_wstrb,
    output dac_axi_wvalid,
    output [1:0] dac_axi_bresp,
    output dac_axi_bvalid,
    output dac_axi_bready,
    output [11:0] dac_axi_araddr,
    output dac_axi_arvalid,
    output dac_axi_arready,
    output [31:0] dac_axi_rdata,
    output [1:0] dac_axi_rresp,
    output dac_axi_rvalid,
    output dac_axi_rready,
    output dac_ready_negedge,
    output tx_reset_done_dac,
    output [3:0] jesd204_da_gt0_tx_txcharisk,
    output [31:0] jesd204_da_gt0_tx_txdata,
    output [15:0] cnt_timing,
    output rst_int
);

assign da0i_ch00 = i0  ;
assign da0i_ch01 = i4  ;
assign da0i_ch02 = i8  ;
assign da0i_ch03 = i12 ;
assign da1i_ch00 = i0  ;
assign da1i_ch01 = i4  ;
assign da1i_ch02 = i8  ;
assign da1i_ch03 = i12 ;
assign da0q_ch00 = q0  ;
assign da0q_ch01 = q4  ;
assign da0q_ch02 = q8  ;
assign da0q_ch03 = q12 ;
assign da1q_ch00 = q0  ;
assign da1q_ch01 = q4  ;
assign da1q_ch02 = q8  ;
assign da1q_ch03 = q12 ;


dds_for_7_series_iq                u_dds_for_7_series_iq(
  .DDS_CLK_FREQ_MHz                 (100                            ),// I，100Mhz，输入的时钟频率                             
  .rst_glb                          (rst_glb                    ),// I,全局复位信号
  .clk_user_bufg                    (clk_user_bufg                  ),// I,全局时钟输入，由外部提供clk_glbl_o
  .pulse_user                       (pulse_user                     ),// O,脉冲信号输出模式下的脉冲输出，指示有效输出位置，高有效,用于 DAC 输出延迟测试
  .i0                               (i0                             ),// O,I和Q路输出
  .i1                               (i1                             ),
  .i2                               (i2                             ),
  .i3                               (i3                             ),
  .i4                               (i4                             ),
  .i5                               (i5                             ),
  .i6                               (i6                             ),
  .i7                               (i7                             ),
  .i8                               (i8                             ),
  .i9                               (i9                             ), 
  .i10                              (i10                            ),
  .i11                              (i11                            ),
  .i12                              (i12                            ),
  .i13                              (i13                            ),
  .i14                              (i14                            ),
  .i15                              (i15                            ),
  .q0                               (q0                             ),
  .q1                               (q1                             ),
  .q2                               (q2                             ),
  .q3                               (q3                             ),
  .q4                               (q4                             ),
  .q5                               (q5                             ),
  .q6                               (q6                             ),
  .q7                               (q7                             ),
  .q8                               (q8                             ),
  .q9                               (q9                             ),
  .q10                              (q10                            ),
  .q11                              (q11                            ),
  .q12                              (q12                            ),
  .q13                              (q13                            ),
  .q14                              (q14                            ),
  .q15                              (q15                            ),
  //-----control signal------------ 
  .DDS_MODE_VIO                     (DDS_MODE_VIO                   ),
  .DDS_FIN_MHz_VIO                  (DDS_FIN_MHz_VIO                ),
  .DDS_FIN_HEX_VIO                  (DDS_FIN_HEX_VIO                ),
  .DDS_PRT_WIDTH_VIO                (DDS_PRT_WIDTH_VIO              ), 
  .DDS_PRT_CYCLE_VIO                (DDS_PRT_CYCLE_VIO              ),
  .DDS_AMP_MULTIP_VIO               (DDS_AMP_MULTIP_VIO             ),
  .DDS_ATT_0p1dB_VIO                (DDS_ATT_0p1dB_VIO              ),                            
  .DDS_FREQHOPSPEED_VIO             (DDS_FREQHOPSPEED_VIO           ),
  .DDS_FREQHOP_kHz_VIO              (DDS_FREQHOP_kHz_VIO            ),
  .DDS_FREQHOP_START_MHz_VIO        (DDS_FREQHOP_START_MHz_VIO      ),
  .DDS_FREQHOP_STOP_MHz_VIO         (DDS_FREQHOP_STOP_MHz_VIO       ), 
  .DDS_IMD_INTERVAL_kHz_VIO         (DDS_IMD_INTERVAL_kHz_VIO       ),
    
  .dds_rsv_port_o                   (dds_rsv_port_o                 ) // O,保留端口out
);


ad9172_inf                         u_ad9172_inf(
	.rst_glb                          (rst_glb                          ), // I
	.clk_50m_bufg                     (clk_50m_bufg                     ), // I
	.clk_user_bufg                    (clk_user_bufg                    ), // I
  .iob_refclk_p                    (iob_refclk_p                     ), // I
  .iob_refclk_n                    (iob_refclk_n                     ), // I
  .iob_sysref_p                    (iob_sysref_p                     ), // I
  .iob_sysref_n                    (iob_sysref_n                     ), // I
  .iob_glblclk_p                  (iob_glblclk_p                   ), // I
  .iob_glblclk_n                  (iob_glblclk_n                   ), // I
  .refclk                           (refclk                  ), // O
  .sysref_o(sysref_o), // O
  .clk_glbl_o(clk_user_bufg), // O
  .dac_ready(dac_ready), // I
	//------------------shared ports----------------------------//      
  .iob_txp                          (iob_txp                          ), // O
  .iob_txn                          (iob_txn                          ), // O
  .dac_tx_tdata                     (dac_tx_tdata                     ), // O
  .dac_axi_awready                  (dac_axi_awready                  ), // O
  .dac_axi_wready                   (dac_axi_wready                   ), // O
  //----------------user ports--------------------------------//      
  .qstack_version                   (1'b1                             ),  // 0 for qstack5 1 for qstack4

  .da0i_ch00                        (da0i_ch00                   ), // I
  .da0i_ch01                        (da0i_ch01                   ),
  .da0i_ch02                        (da0i_ch02                   ),
  .da0i_ch03                        (da0i_ch03                   ),
  .da1i_ch00                        (da1i_ch00                   ),
  .da1i_ch01                        (da1i_ch01                   ),
  .da1i_ch02                        (da1i_ch02                   ),
  .da1i_ch03                        (da1i_ch03                   ),
  .da0q_ch00                        (da0q_ch00                   ),
  .da0q_ch01                        (da0q_ch01                   ),
  .da0q_ch02                        (da0q_ch02                   ),
  .da0q_ch03                        (da0q_ch03                   ),
  .da1q_ch00                        (da1q_ch00                   ),
  .da1q_ch01                        (da1q_ch01                   ),
  .da1q_ch02                        (da1q_ch02                   ),
  .da1q_ch03                        (da1q_ch03                   ),
  //------------------simulation-----------------------------//
  .tx_sync_dac                      (tx_sync_dac                         ), // O
  .dac_axi_awaddr                   (dac_axi_awaddr                      ), // O
  .dac_axi_awvalid                  (dac_axi_awvalid                     ), // O
  .dac_axi_wdata                    (dac_axi_wdata                       ), // O
  .dac_axi_wstrb                    (dac_axi_wstrb                       ), // O
  .dac_axi_wvalid                   (dac_axi_wvalid                      ), // O
  .dac_axi_bresp                    (dac_axi_bresp                       ), // I
  .dac_axi_bvalid                   (dac_axi_bvalid                      ), // I
  .dac_axi_bready                   (dac_axi_bready                      ), // O
  .dac_axi_araddr                   (dac_axi_araddr                      ), // O
  .dac_axi_arvalid                  (dac_axi_arvalid                     ), // O
  .dac_axi_arready                  (dac_axi_arready                     ), // I
  .dac_axi_rdata                    (dac_axi_rdata                       ), // I
  .dac_axi_rresp                    (dac_axi_rresp                       ), // I
  .dac_axi_rvalid                   (dac_axi_rvalid                      ), // I
  .dac_axi_rready                   (dac_axi_rready                      ), // O
  .dac_ready_negedge                (dac_ready_negedge                   ), // O
  .tx_reset_done_dac                (tx_reset_done_dac                   ), // O
  .jesd204_da_gt0_tx_txcharisk      (jesd204_da_gt0_tx_txcharisk         ), // O
  .jesd204_da_gt0_tx_txdata         (jesd204_da_gt0_tx_txdata            ),  // O
  .cnt_timing (cnt_timing),
  .rst_int(rst_int)
);

endmodule