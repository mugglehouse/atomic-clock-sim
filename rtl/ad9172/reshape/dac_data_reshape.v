//////////////////////////////////////////////////////////////////////////////////
//     FileName: dac_data_reshape.v                                                            
//     SvnProperties:                                                             
//         $URL: http://svn.hq.org/svn/PR1104/DEVELOP/03_FPGAPrj_for_VIVADO/HQGF_4_DRFMJ1G/V1/branches/interp12_960MSPS/src/inf/204b/dac_data_reshape.v                                                                
//         $Author: yujiahe $                                                     
//         $Revision:  16946                                                           
//         $Date: 2020-03-01                                                      
//                                                                                
//////////////////////////////////////////////////////////////////////////////////

module dac_data_reshape(
clk_user_bufg,
rst,         
//sync_pulse,
qstack_version,
dac_ready,
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
dac_tx_tdata_o,
//fifo_ovf,
//fifo_udf,
dac_ready_negedge,
DAC_DATA_MUX_VIO
);

input               clk_user_bufg               ;  //250M
input               rst                         ;
//input               sync_pulse                  ;
input               qstack_version              ;
input               dac_ready                   ;
input  [15:0]       da0i_ch00                   ;
input  [15:0]   	  da0i_ch01                   ;
input  [15:0]   	  da0i_ch02                   ;
input  [15:0]   	  da0i_ch03                   ;
input  [15:0]       da1i_ch00                   ;
input  [15:0]   	  da1i_ch01                   ;
input  [15:0]   	  da1i_ch02                   ;
input  [15:0]   	  da1i_ch03                   ;
input  [15:0]       da0q_ch00                   ;
input  [15:0]   	  da0q_ch01                   ;
input  [15:0]   	  da0q_ch02                   ;
input  [15:0]   	  da0q_ch03                   ;
input  [15:0]       da1q_ch00                   ;
input  [15:0]   	  da1q_ch01                   ;
input  [15:0]   	  da1q_ch02                   ;
input  [15:0]   	  da1q_ch03                   ;
output [255:0]      dac_tx_tdata_o              ;   // output
//output              fifo_ovf                    ;
//output              fifo_udf                    ;
output              dac_ready_negedge           ;
//----------------
input               DAC_DATA_MUX_VIO            ;

reg    [15:0]       da0i_ch00_d1                ;
reg    [15:0]   	  da0i_ch01_d1                ;
reg    [15:0]   	  da0i_ch02_d1                ;
reg    [15:0]   	  da0i_ch03_d1                ;
reg    [15:0]       da1i_ch00_d1                ;
reg    [15:0]   	  da1i_ch01_d1                ;
reg    [15:0]   	  da1i_ch02_d1                ;
reg    [15:0]   	  da1i_ch03_d1                ;
reg    [15:0]       da0q_ch00_d1                ;
reg    [15:0]   	  da0q_ch01_d1                ;
reg    [15:0]   	  da0q_ch02_d1                ;
reg    [15:0]   	  da0q_ch03_d1                ;
reg    [15:0]       da1q_ch00_d1                ;
reg    [15:0]   	  da1q_ch01_d1                ;
reg    [15:0]   	  da1q_ch02_d1                ;
reg    [15:0]   	  da1q_ch03_d1                ;

reg                 dac_ready_d1                ;
reg                 dac_ready_d2                ;
(* MARK_DEBUG = "true" *)                           
reg                 dac_ready_negedge           ;

wire   [6:0]        wr_data_level               ;

//-----dac_core_clk domain
wire   [255:0]      fifo_dout                   ; 
(* MARK_DEBUG = "true" *)
wire                valid_fifo_dout             ;
(* MARK_DEBUG = "true" *)
wire   [5:0]        rd_data_level               ;
(* MARK_DEBUG = "true" *)                           
reg    [255:0]      dac_tx_tdata                ;
(* MARK_DEBUG = "true" *)
reg                 fifo_rden                   ;
reg    [3:0]        state                       ; 
reg    [255:0]      fifo_dout_d1                ;
reg                 valid_fifo_dout_d1          ;
reg    [31:0]       data_lane0                  ;
reg    [31:0]       data_lane1                  ;
reg    [31:0]       data_lane2                  ;
reg    [31:0]       data_lane3                  ;
reg    [31:0]       data_lane4                  ;
reg    [31:0]       data_lane5                  ;
reg    [31:0]       data_lane6                  ;
reg    [31:0]       data_lane7                  ;
reg    [31:0]       data_lane0_reverse          ;
reg    [31:0]       data_lane1_reverse          ;
reg    [31:0]       data_lane2_reverse          ;
reg    [31:0]       data_lane3_reverse          ;
reg    [31:0]       data_lane4_reverse          ;
reg    [31:0]       data_lane5_reverse          ;
reg    [31:0]       data_lane6_reverse          ;
reg    [31:0]       data_lane7_reverse          ;

always@(posedge clk_user_bufg or posedge rst)
begin
	if(rst)
	  begin
	  	dac_ready_d1 <= 0;
	  	dac_ready_d2 <= 0;
  	
      da0i_ch00_d1 <= 0;
      da0i_ch01_d1 <= 0;
      da0i_ch02_d1 <= 0;
      da0i_ch03_d1 <= 0;
      da1i_ch00_d1 <= 0;
      da1i_ch01_d1 <= 0;
      da1i_ch02_d1 <= 0;
      da1i_ch03_d1 <= 0;
      da0q_ch00_d1 <= 0;
      da0q_ch01_d1 <= 0;
      da0q_ch02_d1 <= 0;
      da0q_ch03_d1 <= 0;
      da1q_ch00_d1 <= 0;
      da1q_ch01_d1 <= 0;
      da1q_ch02_d1 <= 0;
      da1q_ch03_d1 <= 0;
	  end
	else
	  begin
	  	dac_ready_d1 <= dac_ready;
	  	dac_ready_d2 <= dac_ready_d1;
	  	da0i_ch00_d1 <= da0i_ch00;
      da0i_ch01_d1 <= da0i_ch01;
      da0i_ch02_d1 <= da0i_ch02;
      da0i_ch03_d1 <= da0i_ch03;
      da1i_ch00_d1 <= da1i_ch00;
      da1i_ch01_d1 <= da1i_ch01;
      da1i_ch02_d1 <= da1i_ch02;
      da1i_ch03_d1 <= da1i_ch03;
      da0q_ch00_d1 <= da0q_ch00;
      da0q_ch01_d1 <= da0q_ch01;
      da0q_ch02_d1 <= da0q_ch02;
      da0q_ch03_d1 <= da0q_ch03;
      da1q_ch00_d1 <= da1q_ch00;
      da1q_ch01_d1 <= da1q_ch01;
      da1q_ch02_d1 <= da1q_ch02;
      da1q_ch03_d1 <= da1q_ch03;
	  end
end

always@(posedge clk_user_bufg or posedge rst)
begin
	if(rst)
	  begin
      dac_ready_negedge <= 0;
    end
  else
    begin
    	dac_ready_negedge <= dac_ready_d2&&(~dac_ready_d1);
    end
end

always@(posedge clk_user_bufg or posedge rst)
begin
	if(rst)
	  begin
	  	data_lane0 <= 0;
	  	data_lane1 <= 0;
	  	data_lane2 <= 0;
	  	data_lane3 <= 0;
	  	data_lane4 <= 0;
	  	data_lane5 <= 0;
	  	data_lane6 <= 0;
	  	data_lane7 <= 0;
	  end
	else
	  begin
	    data_lane7 <= {da1q_ch01_d1[15:0],da1q_ch03_d1[15:0]};
	  	data_lane6 <= {da1q_ch00_d1[15:0],da1q_ch02_d1[15:0]};
	  	data_lane5 <= {da1i_ch01_d1[15:0],da1i_ch03_d1[15:0]};
	  	data_lane4 <= {da1i_ch00_d1[15:0],da1i_ch02_d1[15:0]};
	  	data_lane3 <= {da0q_ch01_d1[15:0],da0q_ch03_d1[15:0]};
	  	data_lane2 <= {da0q_ch00_d1[15:0],da0q_ch02_d1[15:0]};
	  	data_lane1 <= {da0i_ch01_d1[15:0],da0i_ch03_d1[15:0]};
	  	data_lane0 <= {da0i_ch00_d1[15:0],da0i_ch02_d1[15:0]};
	  end
end 

always@(posedge clk_user_bufg or posedge rst)
begin
	if(rst)
	  begin
	  	data_lane0_reverse <= 0;
	  	data_lane1_reverse <= 0;
	  	data_lane2_reverse <= 0;
	  	data_lane3_reverse <= 0;
	  	data_lane4_reverse <= 0;
	  	data_lane5_reverse <= 0;
	  	data_lane6_reverse <= 0;
	  	data_lane7_reverse <= 0;
	  end
	else
	  begin
	    data_lane0_reverse <= {data_lane0[8*1-1:8*0],data_lane0[8*2-1:8*1],data_lane0[8*3-1:8*2],data_lane0[8*4-1:8*3]};
	  	data_lane1_reverse <= {data_lane1[8*1-1:8*0],data_lane1[8*2-1:8*1],data_lane1[8*3-1:8*2],data_lane1[8*4-1:8*3]};
	  	data_lane2_reverse <= {data_lane2[8*1-1:8*0],data_lane2[8*2-1:8*1],data_lane2[8*3-1:8*2],data_lane2[8*4-1:8*3]};
	  	data_lane3_reverse <= {data_lane3[8*1-1:8*0],data_lane3[8*2-1:8*1],data_lane3[8*3-1:8*2],data_lane3[8*4-1:8*3]};
	  	data_lane4_reverse <= {data_lane4[8*1-1:8*0],data_lane4[8*2-1:8*1],data_lane4[8*3-1:8*2],data_lane4[8*4-1:8*3]};
	  	data_lane5_reverse <= {data_lane5[8*1-1:8*0],data_lane5[8*2-1:8*1],data_lane5[8*3-1:8*2],data_lane5[8*4-1:8*3]};
	  	data_lane6_reverse <= {data_lane6[8*1-1:8*0],data_lane6[8*2-1:8*1],data_lane6[8*3-1:8*2],data_lane6[8*4-1:8*3]};
	  	data_lane7_reverse <= {data_lane7[8*1-1:8*0],data_lane7[8*2-1:8*1],data_lane7[8*3-1:8*2],data_lane7[8*4-1:8*3]};
	  end
end
	  	
always@(posedge clk_user_bufg or posedge rst)
begin
	if(rst)
	  dac_tx_tdata <= 0;
	else if(~qstack_version)   //0 for QSTACK5
	  dac_tx_tdata <= {data_lane7_reverse,
	                   data_lane4_reverse,   //lan4 and lane6 reversed for QSTACK5
	                   data_lane5_reverse,
	                   data_lane6_reverse,
                     data_lane3_reverse,
	                   data_lane2_reverse,
	                   data_lane1_reverse,
	                   data_lane0_reverse
                     };
  else //1 for QSTACK4
    dac_tx_tdata <= {data_lane7_reverse,
	                   data_lane6_reverse,   //NOT reversed for QSTACK4
	                   data_lane5_reverse,
	                   data_lane4_reverse,
                     data_lane3_reverse,
	                   data_lane2_reverse,
	                   data_lane1_reverse,
	                   data_lane0_reverse
                     };
end

assign  dac_tx_tdata_o = DAC_DATA_MUX_VIO ? {8{32'hFF7FFF7F}} : dac_tx_tdata;

endmodule


