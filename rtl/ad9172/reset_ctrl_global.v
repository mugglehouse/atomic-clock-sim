//////////////////////////////////////////////////////////////////////////////////
//     FileName: reset_ctrl_global.v                                                            
//     SvnProperties:                                                             
//         $URL:  http://svn.hq.org/svn/PR1104/DEVELOP/03_FPGAPrj_for_VIVADO/HQGF_4_DRFMJ1G/V1/branches/interp12_960MSPS/src/inf/reset/reset_ctrl_global.v                                                               
//         $Author: yujiahe $                                                     
//         $Revision:  16946                                                           
//         $Date: 2020-03-01                                                      
//                                                                                
//////////////////////////////////////////////////////////////////////////////////
module reset_ctrl_global(
	clk,
	clk_user_bufg,
	rst,
	dac_ready,
	multi_board_sync_enable_i,
	multi_board_sync_enable_o,
	dac_data_mux,
	ad_sig_detected,
	dac_status,
	rst_int
);

input                   clk                       ;
input                   clk_user_bufg             ;
input                   rst                       ;
input                   dac_ready                 ;
input                   multi_board_sync_enable_i ;
output                  multi_board_sync_enable_o ;
output                  dac_data_mux              ;
input                   ad_sig_detected           ; 
input                   dac_status                ;
output                  rst_int                   ;
  
reg                     dac_ready_d1              ;
(* MARK_DEBUG = "true" *)                             
reg                     dac_ready_d2              ;
reg                     multi_board_sync_enable_o ; 
(* MARK_DEBUG = "true" *)                           
reg                     dac_data_mux              ;
(* MARK_DEBUG = "true" *)                             
reg                     rst_int                   ;
(* MARK_DEBUG = "true" *)                             
reg                     get_sample_flag           ;
reg                     ad_sig_detected_d1        ;
(* MARK_DEBUG = "true" *)                             
reg                     ad_sig_detected_d2        ;
reg    [31:0]           cnt_timing                ;
(* MARK_DEBUG = "true" *)                             
reg    [3:0]            state                     ;
reg                     get_sample_flag_d1        ;
reg                     get_sample_flag_d2        ;
reg                     dac_status_d1             ;
reg                     dac_status_d2             ;

//---------------clk domain------------//
always@(posedge clk or posedge rst)
begin
	if(rst)
	  begin
	  	dac_ready_d1 <= 0;
	  	dac_ready_d2 <= 0;
	  	ad_sig_detected_d1 <= 0;
	  	ad_sig_detected_d2 <= 0;
	  	dac_status_d1 <= 0;
	  	dac_status_d2 <= 0;
	  end
	else
	  begin
	  	dac_ready_d1 <= dac_ready;
	  	dac_ready_d2 <= dac_ready_d1;
	  	ad_sig_detected_d1 <= ad_sig_detected;
	  	ad_sig_detected_d2 <= ad_sig_detected_d1;
	  	dac_status_d1 <= dac_status;
	  	dac_status_d2 <= dac_status_d1;
	  end
end

//-----------clk_user_bufg domain------------//
always@(posedge clk_user_bufg or posedge rst)
begin
	if(rst)
	  begin
	  	get_sample_flag_d1 <= 0;
	  	get_sample_flag_d2 <= 0;
	  end
	else
	  begin
	  	get_sample_flag_d1 <= get_sample_flag;
	  	get_sample_flag_d2 <= get_sample_flag_d1;
	  end
end

parameter               ST_IDLE                 = 4'h0,
                        ST_CHECK_READY          = 4'h1,
                        ST_GAP0                 = 4'h2,
                        ST_GET_ADC_SAMPLE       = 4'h3,
                        ST_GAP1                 = 4'h4,
                        ST_JUDGE_ADC_SAMPLE     = 4'h5,
                        ST_RESET_MULTI_BOARD    = 4'h6,
                        ST_CHECK_READY2         = 4'h7,
                        ST_RESET                = 4'h8,
                        ST_SET_NORMAL           = 4'h9;

always@(posedge clk or posedge rst)
begin
	if(rst)
	  begin
	  	cnt_timing <= 0;
	  	multi_board_sync_enable_o <= 0;
	  	dac_data_mux <= 1'b0; //������Ϊ��������
	  	rst_int <= 1'b1;
	  	get_sample_flag <= 0;
	  	//-----------------//
	  	state <= ST_IDLE;
	  end
	else
	  begin
	  	case(state)
	  	ST_IDLE: 
	  	  begin
          multi_board_sync_enable_o <= 0;
	  	  	if(cnt_timing[10])
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	rst_int <= 0;  
	  	  	  	//--------------//
	  	  	  	state <= ST_CHECK_READY;
	  	  	  end
	  	  	else
	  	  	  begin
	  	  	  	cnt_timing <= cnt_timing + 1;
	  	  	  	rst_int <= 1;
	  	  	  end
	  	  end
	  	ST_CHECK_READY:
	  	  begin
	  	  	if(dac_ready_d2)
	  	  	  state <= ST_GAP0;
	  	  	else if(cnt_timing[29])  //4s
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	//-------------//
	  	  	  	state <= ST_RESET;
	  	  	  end
	  	  	else
	  	  	  cnt_timing <= cnt_timing + 1;
	  	  end
	  	ST_GAP0:
	  	  begin
          if(cnt_timing[15])
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	//-----------//
	  	  	  	state <= ST_GET_ADC_SAMPLE;
	  	  	  end
	  	  	else
	  	  	  cnt_timing <= cnt_timing + 1;
	  	  end
	  	ST_GET_ADC_SAMPLE:
	  	  begin
	  	  	if(cnt_timing[3])
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	get_sample_flag <= 0;
	  	  	  	//-------------//
	  	  	  	state <= ST_GAP1;
	  	  	  end
	  	  	else
	  	  	  begin
	  	  	  	cnt_timing <= cnt_timing + 1;
	  	  	  	get_sample_flag <= 1;
	  	  	  end
	  	  end
	  	ST_GAP1:
	  	  begin
	  	  	if(cnt_timing[5])
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	//------------//
	  	  	  	state <= ST_JUDGE_ADC_SAMPLE;
	  	  	  end
	  	  	else
	  	  	  cnt_timing <= cnt_timing + 1;
	  	  end
	  	ST_JUDGE_ADC_SAMPLE:
	  	  begin
	  	  	if(dac_status_d2)
            begin
              if(multi_board_sync_enable_i)
	  	  	      state <= ST_RESET_MULTI_BOARD;
	  	  	    else 
	  	  	      state <= ST_SET_NORMAL;
            end
	  	  	else
	  	  	  state <= ST_RESET;
	  	  end
      ST_RESET_MULTI_BOARD:
	  	  begin
	  	  	if(cnt_timing[10])
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	rst_int <= 0;
	  	  	  	//-------------//
	  	  	  	state <= ST_CHECK_READY2;
	  	  	  end
	  	  	else
	  	  	  begin
	  	  	  	cnt_timing <= cnt_timing + 1;
	  	  	  	multi_board_sync_enable_o <= 1;
	  	  	  	rst_int <= 1;
	  	  	  end
	  	  end
	  	ST_CHECK_READY2:
	  	  begin
	  	  	if(dac_ready_d2)
	  	  	  state <= ST_SET_NORMAL;
	      end
	  	ST_RESET:
	  	  begin
	  	  	if(cnt_timing[15])
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	//----------//
	  	  	  	state <= ST_IDLE;
	  	  	  end
	  	  	else
	  	  	  begin
	  	  	  	rst_int <= 1;
	  	  	  	cnt_timing <= cnt_timing + 1;
	  	  	  end
	  	  end
	  	ST_SET_NORMAL:
	  	  begin
	  	  	if(cnt_timing[28])  //��·�쳣����Լ2s����
	  	  	  begin
	  	  	  	cnt_timing <= 0;
	  	  	  	//----------//
	  	  	  	state <= ST_RESET;
	  	  	  end
	  	  	else if(dac_ready_d2==0)
	  	  	  begin
	  	  	  	cnt_timing <= cnt_timing + 1;
	  	  	  end
	  	  	else
	  	  	  cnt_timing <= 0;
	  	  end
	  	default:
	  	  begin
	  	  	state <= ST_IDLE;
	  	  end
	  	endcase
	  end
end

endmodule