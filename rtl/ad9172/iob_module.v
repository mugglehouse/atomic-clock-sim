module iob_module(
clk_50m_bufg,
rst_glb,

iob_refclk_p,     
iob_refclk_n,     
iob_sysref_p,     
iob_sysref_n,     
iob_glblclk_p,
iob_glblclk_n,
iob_dac_sync204_p,
iob_dac_sync204_n,

/*   iob_strobe    ,
  iob_strobe_dir, */

multi_board_sync_enable,
adda_ready,
rst_sync,
clk_cfg_done,
close_sysref,               
clk_slow_bufg,
clk_dac_cfg,    
gt_refclk,
gt_refclk_copy,
clk_user_bufg,         
sysref,           
clk_glbl_bufg,
glblclk_freq_correct,
gtref_freq_correct,
      
dac_sync, 
dac0_cnt_lose_sync,
dac1_cnt_lose_sync

/*   strobe_i  ,  
  strobe_o  ,  
  strobe_dir */

);

input                 clk_50m_bufg                 ;
input                 clk_user_bufg                ;  
input                 rst_glb                      ;

	
input                 iob_refclk_p                 ;     
input                 iob_refclk_n                 ;     
input                 iob_sysref_p                 ;     
input                 iob_sysref_n                 ;     
input                 iob_glblclk_p                ;
input                 iob_glblclk_n                ;     
input       [1:0]     iob_dac_sync204_p            ;
input       [1:0]     iob_dac_sync204_n            ;
/* inout                 iob_strobe                   ;
output                iob_strobe_dir               ; */

input                 multi_board_sync_enable      ;
input                 adda_ready                   ;
input                 rst_sync                     ;
input                 clk_cfg_done                 ;

output                close_sysref                 ;                  
output                clk_slow_bufg                ; 
output                clk_dac_cfg                  ;   
output                gt_refclk                    ; 
output                gt_refclk_copy               ;
         
output                sysref                       ;                 
output                clk_glbl_bufg                ;
output                glblclk_freq_correct         ;
output                gtref_freq_correct           ;
      
output     [1:0]      dac_sync                     ;
output     [7:0]      dac0_cnt_lose_sync           ;
output     [7:0]      dac1_cnt_lose_sync           ;

/* input                 strobe_i                     ; 
output                strobe_o                     ;
input                 strobe_dir                   ; */
//-----freerunning spi clock--------//
reg        [15:0]     cnt_div                      ;
reg                   clk_slow                     ;

wire sysref_ibufds;

always@(posedge clk_50m_bufg or posedge rst_glb)
begin
	if(rst_glb)
	  begin
	  	cnt_div <= 0;
	  	clk_slow <= 0;
	  end
	else if(cnt_div==9)  //50��Ƶ
	  begin
	  	cnt_div <= 0;
	  	clk_slow <= ~clk_slow;
	  end
	else
	  begin
	  	cnt_div <= cnt_div + 1;
	  	clk_slow <= clk_slow;
	  end
end

reg               adda_ready_d1             ;
reg               adda_ready_d2             ;
reg               rst_sync_d1               ;
reg               rst_sync_d2               ;
reg               clk_cfg_done_d1           ;
reg               clk_cfg_done_d2           ;
reg               clk_slow_sync             ;
reg               clk_slow_sync_d1          ;
wire              clk_slow_mux              ;
reg   [15:0]      cnt_div_sync              ;
reg               clk_50m_sync              ;
reg               clk_50m_sync_d1           ;
reg   [3:0]       cnt_dac_sync              ;
reg   [2:0]       cnt_clk_slow_nege         ;
(*MARK_DEBUG = "true"*)
reg   [3:0]       state                     ;
(*MARK_DEBUG = "true"*)
reg               close_sysref              ;
(*MARK_DEBUG = "true"*)
reg               clk_sel                   ;
(*MARK_DEBUG = "true"*)
reg               enable_dac_cfg_sync       ; 
reg               sync_clk                  ;
reg   [15:0]      cnt_timing                ; 
reg               sysref_d1                 ; 
reg               sysref_d2                 ; 
reg               sysref                    ;
wire              valid_freq_out_glb        ;
(*MARK_DEBUG = "true"*)
wire    [31:0]    freq_out_glb              ;
wire              valid_freq_out_gtref      ;
(*MARK_DEBUG = "true"*)
wire    [31:0]    freq_out_gtref            ;
(*MARK_DEBUG = "true"*)
wire    [31:0]    freq_out_sysref           ;

always@(posedge clk_user_bufg or posedge rst_glb)
begin
	if(rst_glb)
	  begin
	  	rst_sync_d1 <= 0;
	  	rst_sync_d2 <= 0;
	  	adda_ready_d1 <= 0;
	  	adda_ready_d2 <= 0;
	  	clk_cfg_done_d1 <= 0;
	  	clk_cfg_done_d2 <= 0;
	  	clk_slow_sync_d1 <= 0;
      clk_50m_sync_d1<=0;
	  	sysref_d1 <= 0;
	  	sysref <= 0;
	  	sysref_d2 <= 0;
	  end
	else
	  begin
	  	rst_sync_d1 <= rst_sync;
	  	rst_sync_d2 <= rst_sync_d1;
	  	adda_ready_d1 <= adda_ready;
	  	adda_ready_d2 <= adda_ready_d1;
	  	clk_cfg_done_d1 <= clk_cfg_done;
	  	clk_cfg_done_d2 <= clk_cfg_done_d1;
	  	clk_slow_sync_d1 <= clk_slow_sync;
      clk_50m_sync_d1<=clk_50m_sync;
	  	sysref_d1 <= sysref_ibufds;
	  	sysref <= sysref_d1;
	  	sysref_d2 <= sysref; 
	  end
end

assign clk_slow_mux = (clk_sel&&multi_board_sync_enable) ? clk_slow_sync : clk_slow;
assign clk_dac_cfg_mux = (clk_sel&&multi_board_sync_enable) ? clk_50m_sync  : clk_50m_bufg;

always@(posedge clk_glbl_bufg or posedge rst_glb)
begin
	if(rst_glb)
	  begin
	  	cnt_div_sync <= 0;
	  	clk_slow_sync <= 0;
	  end
	else if(sync_clk)
	  begin
	  	cnt_div_sync <= 0;
	  	clk_slow_sync <= 0;
	  end
	else if(cnt_div_sync==149)  //300��Ƶ,1MHz
	  begin
	  	cnt_div_sync <= 0;
	  	clk_slow_sync <= ~clk_slow_sync;
	  end
	else
	  begin
	  	cnt_div_sync <= cnt_div_sync + 1;
	  	clk_slow_sync <= clk_slow_sync;
	  end
end

always@(posedge clk_glbl_bufg or posedge rst_glb)
begin
	if(rst_glb)
	  begin
	  	cnt_dac_sync <= 0;
	  	clk_50m_sync <= 0;
	  end
	else if(sync_clk)
	  begin
	  	cnt_dac_sync <= 0;
	  	clk_50m_sync <= 0;
	  end
	else if(cnt_dac_sync==4)  // 204.8MHz/40.96MHz=5
	  begin
	  	cnt_dac_sync <= 0;
	  	clk_50m_sync <= ~clk_50m_sync;
	  end
	else
	  begin
	  	cnt_dac_sync <= cnt_dac_sync + 1;
	  	clk_50m_sync <= clk_50m_sync;
	  end
end

parameter  ST_IDLE                    = 4'h0,
           ST_CLK_CFG_DONE            = 4'h1,
           ST_GET_SYNC0               = 4'h2,
           ST_GAP0                    = 4'h3,
           ST_CHANGE_CLK              = 4'h4,
           ST_GET_SYNC1               = 4'h5,
           ST_WAIT_SPICLK_NEGE0       = 4'h6,
           ST_GAP1                    = 4'h7,
           ST_ENABLE_DAC_CFG          = 4'h8,
           ST_WAIT_ADDA_READY         = 4'h9,
           ST_GET_SYNC2               = 4'ha,
           ST_WAIT_SPICLK_NEGE1       = 4'hb,
           ST_CLOSE_SYSYREF           = 4'hc;
               
always@(posedge clk_glbl_bufg or posedge rst_glb)
begin
	if(rst_glb)
	  begin
	  	close_sysref <= 0; 
	  	clk_sel <= 0;
	  	cnt_timing <= 0;
	  	enable_dac_cfg_sync <= 0; 
	  	sync_clk <= 0;
	  	//-----------//
	  	state <= ST_IDLE;
	  end
	else
	  begin
	  	case(state)
	  	ST_IDLE:
	  	  begin
	  	  	close_sysref <= 0;
	  	  	clk_sel <= clk_sel;
	  	  	cnt_timing <= 0;
	  	  	enable_dac_cfg_sync <= 0;
	  	  	sync_clk <= 0;
	  	  	//-----------------//
	  	  	state <= ST_CLK_CFG_DONE;
	  	  end
	  	ST_CLK_CFG_DONE:
	  	  begin
	  	  	if(clk_cfg_done_d2)
	  	  	  state <= ST_GET_SYNC0;
	  	  end
	  	ST_GET_SYNC0:
	  	  begin
	  	  	if(rst_sync_d1&&(~rst_sync_d2))
	  	  	  begin
	  	  	  	sync_clk <= 1;
	  	  	  	//-------------//
	  	  	    state <= ST_GAP0;
	  	  	  end
	  	  end
	  	ST_GAP0:
	  	  begin
	  	  	sync_clk <= 0;
	  	  	if(cnt_timing[12])
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	//-----------//
	  	  	  	state <= ST_CHANGE_CLK;
	  	  	  end
	  	  	else
	  	  	  begin
	  	  	  	cnt_timing <= cnt_timing + 1;
	  	  	  end
	  	  end
	  	ST_CHANGE_CLK:
	  	  begin
	  	  	clk_sel <= 1;
	  	  	//---------//
	  	  	state <= ST_GET_SYNC1;
	  	  end
	  	ST_GET_SYNC1:
	  	  begin
	  	  	if(rst_sync_d1&&(~rst_sync_d2))
	  	  	  state <= ST_WAIT_SPICLK_NEGE0;
	  	  end
	  	ST_WAIT_SPICLK_NEGE0:
	  	  begin
	  	  	if(clk_slow_sync_d1&&(~clk_slow_sync))  //negedge
	  	  	  state <= ST_ENABLE_DAC_CFG;
	  	  end
	  	ST_ENABLE_DAC_CFG:
	  	  begin
	  	  	if(clk_slow_sync_d1&&(~clk_slow_sync))  //negedge
	  	  	  begin
	  	  	  	state <= ST_WAIT_ADDA_READY;
	  	  	  end
	  	  	else
	  	  	  begin
	  	  	    enable_dac_cfg_sync <= 1;
	  	  	  end
	  	  end
	  	ST_WAIT_ADDA_READY:
	  	  begin
	  	  	if(adda_ready_d2)
	  	  	  state <= ST_GET_SYNC2;
	  	  end
	  	ST_GET_SYNC2:
	  	  begin
	  	  	if(rst_sync_d1&&(~rst_sync_d2))
	  	  	  state <= ST_WAIT_SPICLK_NEGE1;
	  	  end
	  	ST_WAIT_SPICLK_NEGE1:
	  	  begin
	  	  	if(clk_slow_sync_d1&&(~clk_slow_sync))  //negedge
	  	  	  state <= ST_CLOSE_SYSYREF;
	  	  end	
	  	ST_CLOSE_SYSYREF:
	  	  begin
			state <= state;
	  	  	if(clk_slow_sync_d1&&(~clk_slow_sync))  //negedge
	  	  	  begin
	  	  	  	close_sysref <= 0;
	  	  	  	//-------------//
	  	  	  end
	  	  	else
	  	  	  close_sysref <= 1;
	  	  end
	  	default: 
	  	  begin
	  	  	state <= ST_IDLE;
	  	  end
	  	endcase
	  end
end

assign gt_refclk_copy = gt_refclk;
//-----------clk_slow
BUFG              u0_bufg(
	.I               (clk_slow_mux                 ),
	.O               (clk_slow_bufg                )
);

BUFG              u1_dac_cfg_bufg(
	.I               (clk_dac_cfg_mux              ),
	.O               (clk_dac_cfg                  )
);

//-----------ql_gt_refclk
IBUFDS_GTE2       u0_ibufds_gte2(
  .O               (gt_refclk                   ),
  .ODIV2           (                            ),//gt_refclk_odiv2             ),
  .CEB             (1'b0                        ),
  .I               (iob_refclk_p                ),
  .IB              (iob_refclk_n                )
);
/*
BUFG              u_bufg(
	.I               (gt_refclk_odiv2             ),
	.O               (gt_refclk_copy              )
);
*/
//-----------sysref
IBUFDS          #(
	.DIFF_TERM     ("TRUE"                       ) 
)               u2_ibufds(
	.O             (sysref_ibufds                ),
	.I             (iob_sysref_p                 ),
	.IB            (iob_sysref_n                 )
);

//-----------glblclk_300m
IBUFDS          #(
  .DIFF_TERM     ("TRUE"                      ) 
)               u0_ibufds (
  .I             (iob_glblclk_p               ),
  .IB            (iob_glblclk_n               ),
  .O             (clk_glbl_ibuf               )
);

BUFG           u1_bufg(
  .O             (clk_glbl_bufg              ),
  .I             (clk_glbl_ibuf              )
); 

// freq_calc_100ppm                  #(
//   .CLK_STANDARD_CYCLE               (16'd50000                ),	
// 	.STANDARD_FREQ                    (20'd204800               )
// )                                 clk_glbl_freq_calc(
// 	.rst                              (rst_glb                  ),
// 	.clk_standard                     (clk_50m_bufg             ),
// 	.clk_tobe_calc                    (clk_glbl_bufg            ),  //300MHz
// 	.valid_freq_out                   (valid_freq_out_glb       ),
// 	.freq_out                         (freq_out_glb             ),
// 	//----------compare------------
// 	.compare_result                   (glblclk_freq_correct     )
// );

// freq_calc_100ppm                  #(
//   .CLK_STANDARD_CYCLE               (16'd50000                ),	
// 	.STANDARD_FREQ                    (20'd204800               )
// )                                 clk_gtref_freq_calc(
// 	.rst                              (rst_glb                  ),
// 	.clk_standard                     (clk_50m_bufg             ),
// 	.clk_tobe_calc                    (gt_refclk_copy           ),  //300MHz
// 	.valid_freq_out                   (valid_freq_out_gtref     ),
// 	.freq_out                         (freq_out_gtref           ),
// 	//----------compare------------
// 	.compare_result                   (gtref_freq_correct       )
// );

// freq_calc_100ppm                  #(
//   .CLK_STANDARD_CYCLE               (16'd50000                ),	
// 	.STANDARD_FREQ                    (20'd204800               )
// )                                 clk_sysref_freq_calc(
// 	.rst                              (rst_glb                  ),
// 	.clk_standard                     (clk_50m_bufg             ),
// 	.clk_tobe_calc                    (sysref                   ),  //6.25MHz
// 	.valid_freq_out                   (valid_freq_out_sysref    ),
// 	.freq_out                         (freq_out_sysref          ),
// 	//----------compare------------
// 	.compare_result                   (sysref_freq_correct      )
// );
//-----------dac sync
IBUFDS          #(
	.DIFF_TERM     ("TRUE"                       ) 
)               u_ibufds_dac0 (
	.O             (dac_sync[0]                  ),
	.I             (iob_dac_sync204_p[0]         ),
	.IB            (iob_dac_sync204_n[0]         )
);

IBUFDS          #(
	.DIFF_TERM     ("TRUE"                       ) 
)               u_ibufds_dac1 (
	.O             (dac_sync[1]                  ),
	.I             (iob_dac_sync204_p[1]         ),
	.IB            (iob_dac_sync204_n[1]         )
);
// lose_sync_count            dac0_lose_sync_count(
//   .clk                         (clk_50m_bufg                   ), //input   	            
//   .rst                         (~adda_ready                    ), //input                                                       
//   .cnt_tobe                    (dac_sync[0]                    ), //input   
//   .cnt_result                  (dac0_cnt_lose_sync[7:0]        )  //output  [7:0] 		
// );

// lose_sync_count            dac1_lose_sync_count(
//   .clk                         (clk_50m_bufg                   ), //input   	                                            	    
//   .rst                         (~adda_ready                    ), //input                                                       
//   .cnt_tobe                    (dac_sync[1]                    ), //input   
//   .cnt_result                  (dac1_cnt_lose_sync[7:0]        )  //output  [7:0] 		
// );

/* //----------------strobe---------
IOBUF       u_iobuf_strob(
	.I         (strobe_i             ),
	.O         (strobe_o             ),
	.IO        (iob_strobe           ),
	.T         (strobe_dir           )
);

OBUF        u_obuf_strob_dir(
	.I         (~strobe_dir          ),
	.O         (iob_strobe_dir       )
); */

endmodule