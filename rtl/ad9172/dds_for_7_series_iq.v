/*******************************************************************************************
 * FileProperties:
 *     FileName: dds_for_dac_test.v
 *     SvnProperties:
 *         $URL: http://192.168.0.155/svn/PR1104/PRIVATE/17_FPGAPrj_for_VIVADO/HQGF_4D_DRFMJ5G/branches/mode0/src/top/dds_for_dac_test.v
 *         $Author: lianming $
 *         $Revision: 18602 $
 *         $Date: 2020年6月1日 20:49:49 周二
*******************************************************************************************/
//***********************************************
//sample_rate(MHz)=clk_user_bufg*16ch=300MHz*16ch=4800MSPS
//DDS_FREQ_COEF_1MHz: 1MHz dds code
// = 21'd894785 = round(2^32/sample_rate*1) 
//DDS_FREQ_COEF_1kHz: 1kHz dds code 
// = 21'd894 = round(2^32/sample_rate*1000)
//DDS_CLK_FREQ_MHz >64MHz
//***********************************************

module dds_for_7_series_iq(
DDS_CLK_FREQ_MHz             ,             
rst_glb                      ,
clk_user_bufg                ,
pulse_user                   , // for DAC sync test
i0                           ,
i1                           ,
i2                           ,
i3                           ,
i4                           ,
i5                           ,
i6                           ,
i7                           ,
i8                           ,
i9                           , 
i10                          ,
i11                          ,
i12                          ,
i13                          ,
i14                          ,
i15                          ,
q0                           ,
q1                           ,
q2                           ,
q3                           ,
q4                           ,
q5                           ,
q6                           ,
q7                           ,
q8                           ,
q9                           ,
q10                          ,
q11                          ,
q12                          ,
q13                          ,
q14                          ,
q15                          ,
//-------control_signal----
DDS_MODE_VIO                 , //4'h0:singletone test;  4'h1:prt dac;  4'h2:freq sweep test;  4'h3: IMD test;  
DDS_FIN_MHz_VIO              ,//singletone test freq in MHz
DDS_FIN_HEX_VIO              ,//singletone test freq code in hex 

DDS_PRT_WIDTH_VIO            , //pulse width for singletone test
DDS_PRT_CYCLE_VIO            , //pulse cycle for singletone test     

DDS_AMP_MULTIP_VIO           , //fine amplitude control in lenear 0~3ff
DDS_ATT_0p1dB_VIO            , //coarse amplitude control in 0.1 dB
                           
DDS_FREQHOPSPEED_VIO         , //freq hop timer 
DDS_FREQHOP_kHz_VIO          , //freq hop step in kHz
DDS_FREQHOP_START_MHz_VIO    , //freq sweep test start freq in MHz
DDS_FREQHOP_STOP_MHz_VIO     , //Freq sweep test stop freq in MHz
DDS_IMD_INTERVAL_kHz_VIO     , //DAC IMD test               

dds_rsv_port_o               
);

localparam       DAC_BITWIDTH = 16    ;
input wire [10:0]             DDS_CLK_FREQ_MHz           ;
input                         rst_glb                    ;
input                         clk_user_bufg              ;
output reg                    pulse_user                 ;     
output reg [DAC_BITWIDTH-1:0] i0                         ;  
output reg [DAC_BITWIDTH-1:0] i1                         ;  
output reg [DAC_BITWIDTH-1:0] i2                         ;  
output reg [DAC_BITWIDTH-1:0] i3                         ;  
output reg [DAC_BITWIDTH-1:0] i4                         ;  
output reg [DAC_BITWIDTH-1:0] i5                         ;  
output reg [DAC_BITWIDTH-1:0] i6                         ;  
output reg [DAC_BITWIDTH-1:0] i7                         ;  
output reg [DAC_BITWIDTH-1:0] i8                         ;  
output reg [DAC_BITWIDTH-1:0] i9                         ;  
output reg [DAC_BITWIDTH-1:0] i10                        ;  
output reg [DAC_BITWIDTH-1:0] i11                        ;  
output reg [DAC_BITWIDTH-1:0] i12                        ;  
output reg [DAC_BITWIDTH-1:0] i13                        ;  
output reg [DAC_BITWIDTH-1:0] i14                        ;  
output reg [DAC_BITWIDTH-1:0] i15                        ;  
output reg [DAC_BITWIDTH-1:0] q0                         ;  
output reg [DAC_BITWIDTH-1:0] q1                         ;  
output reg [DAC_BITWIDTH-1:0] q2                         ;  
output reg [DAC_BITWIDTH-1:0] q3                         ;  
output reg [DAC_BITWIDTH-1:0] q4                         ;  
output reg [DAC_BITWIDTH-1:0] q5                         ;  
output reg [DAC_BITWIDTH-1:0] q6                         ;  
output reg [DAC_BITWIDTH-1:0] q7                         ;  
output reg [DAC_BITWIDTH-1:0] q8                         ;  
output reg [DAC_BITWIDTH-1:0] q9                         ;  
output reg [DAC_BITWIDTH-1:0] q10                        ;  
output reg [DAC_BITWIDTH-1:0] q11                        ;  
output reg [DAC_BITWIDTH-1:0] q12                        ;  
output reg [DAC_BITWIDTH-1:0] q13                        ;  
output reg [DAC_BITWIDTH-1:0] q14                        ;  
output reg [DAC_BITWIDTH-1:0] q15                        ;
//------control_singal------------------
input        [31:00]          DDS_PRT_WIDTH_VIO          ;
input        [31:00]          DDS_PRT_CYCLE_VIO          ;
                                                         
input        [14:00]          DDS_AMP_MULTIP_VIO         ;
input        [09:00]          DDS_ATT_0p1dB_VIO          ;
                                                         
input        [31:00]          DDS_FREQHOPSPEED_VIO       ;
input signed [15:00]          DDS_FREQHOP_kHz_VIO        ;
input signed [15:00]          DDS_FREQHOP_START_MHz_VIO  ;
input signed [15:00]          DDS_FREQHOP_STOP_MHz_VIO   ;
input signed [19:00]          DDS_IMD_INTERVAL_kHz_VIO   ;
input        [03:00]          DDS_MODE_VIO               ;
input signed [15:00]          DDS_FIN_MHz_VIO            ;
input        [31:00]          DDS_FIN_HEX_VIO            ; 

output wire  [255:0]          dds_rsv_port_o             ;


(* MARK_DEBUG = "true" *) 
reg signed  [31:0]            dds_freq_code              ; 
wire        [22:0]            DDS_FREQ_COEF_1MHz         ;
wire        [22:0]            DDS_FREQ_COEF_1kHz         ;

reg         [31:0]            DDS_FREQHOPSPEED_VIO_count ;
(* MARK_DEBUG = "true" *)                               
reg                           dds_freqhop_flag           ;
reg  signed [31:0]            dds_freq_setup             ; 
(* use_dsp48="yes" *)(* MARK_DEBUG = "true" *)
reg  signed [38:0]            dds_freq_setup_39bit       ; 

reg signed [31:0]             dds_freq_min               ,
                              dds_freq_max               ;
(* use_dsp48 = "yes"*)                                   
reg  signed [38:0]            dds_freq_min_39bit         ,
                              dds_freq_max_39bit         ;
(* use_dsp48="yes" *)(* MARK_DEBUG = "true" *)                                   
reg  signed [38:0]            dds_freq_hop_1024kHz       ; 
reg  signed [31:0]            dds_freq_hop_kHz           ;  
(* use_dsp48="yes" *)                                   
reg  signed [42:0]            dds_freq_imd_1024kHz       ;
reg signed [31:0]             dds_freq_imd_kHz           ;  
reg signed [31:0]             dds_freq_imd_pinc          ;                  
(* MARK_DEBUG = "true" *)
reg        [31:00]            prt_counter                ;
reg                           prt_dac_mute               ;
reg                           dac_mute                   ;
reg        [15:00]            dds_delay_reg              ;
reg  signed[15:0]             dds_out [31:0]             ;
wire signed[15:0]             dac_in  [31:0]             ;
wire       [14:0]             value_multip_input         ;
wire       [31:0]             dds_freq_code_mux          ;
wire       [31:00]            DDS_PRT_WIDTH_VIO_mux      ;     
wire       [31:00]            DDS_PRT_CYCLE_VIO_mux      ;
                  
wire signed [15:0]  i0_dds0, i1_dds0, i2_dds0, i3_dds0, 
                    i4_dds0, i5_dds0, i6_dds0, i7_dds0, 
                    i8_dds0, i9_dds0,i10_dds0,i11_dds0,
                    i12_dds0,i13_dds0,i14_dds0,i15_dds0;                    
                    

wire signed [15:0]  q0_dds0 , q1_dds0, q2_dds0, q3_dds0, 
                    q4_dds0 , q5_dds0, q6_dds0, q7_dds0, 
                    q8_dds0 , q9_dds0,q10_dds0,q11_dds0,
                    q12_dds0,q13_dds0,q14_dds0,q15_dds0;   
                    


wire  signed [15:0] i0_dds1, i1_dds1, i2_dds1, i3_dds1, 
                    i4_dds1, i5_dds1, i6_dds1, i7_dds1, 
                    i8_dds1, i9_dds1,i10_dds1,i11_dds1, 
                    i12_dds1,i13_dds1,i14_dds1,i15_dds1;
                                                        
                                                        
wire signed [15:0]  q0_dds1 , q1_dds1, q2_dds1, q3_dds1,
                    q4_dds1 , q5_dds1, q6_dds1, q7_dds1,
                    q8_dds1 , q9_dds1,q10_dds1,q11_dds1,
                    q12_dds1,q13_dds1,q14_dds1,q15_dds1;

wire  signed [16:0] i0_imd, i1_imd, i2_imd, i3_imd, 
                    i4_imd, i5_imd, i6_imd, i7_imd, 
                    i8_imd, i9_imd,i10_imd,i11_imd, 
                    i12_imd,i13_imd,i14_imd,i15_imd;
                                                        
                                                        
wire signed [16:0]  q0_imd , q1_imd, q2_imd, q3_imd,
                    q4_imd , q5_imd, q6_imd, q7_imd,
                    q8_imd , q9_imd,q10_imd,q11_imd,
                    q12_imd,q13_imd,q14_imd,q15_imd;

assign i0_imd  =i0_dds0  +i0_dds1 +1;//+1 for round operation next
assign i1_imd  =i1_dds0  +i1_dds1 +1;
assign i2_imd  =i2_dds0  +i2_dds1 +1;
assign i3_imd  =i3_dds0  +i3_dds1 +1;
assign i4_imd  =i4_dds0  +i4_dds1 +1;
assign i5_imd  =i5_dds0  +i5_dds1 +1;
assign i6_imd  =i6_dds0  +i6_dds1 +1;
assign i7_imd  =i7_dds0  +i7_dds1 +1;
assign i8_imd  =i8_dds0  +i8_dds1 +1;
assign i9_imd  =i9_dds0  +i9_dds1 +1;
assign i10_imd =i10_dds0 +i10_dds1+1;
assign i11_imd =i11_dds0 +i11_dds1+1;
assign i12_imd =i12_dds0 +i12_dds1+1;
assign i13_imd =i13_dds0 +i13_dds1+1;
assign i14_imd =i14_dds0 +i14_dds1+1;  
assign i15_imd =i15_dds0 +i15_dds1+1;  

assign q0_imd  =q0_dds0  +q0_dds1 +1;
assign q1_imd  =q1_dds0  +q1_dds1 +1;
assign q2_imd  =q2_dds0  +q2_dds1 +1;
assign q3_imd  =q3_dds0  +q3_dds1 +1;
assign q4_imd  =q4_dds0  +q4_dds1 +1;
assign q5_imd  =q5_dds0  +q5_dds1 +1;
assign q6_imd  =q6_dds0  +q6_dds1 +1;
assign q7_imd  =q7_dds0  +q7_dds1 +1;
assign q8_imd  =q8_dds0  +q8_dds1 +1;
assign q9_imd  =q9_dds0  +q9_dds1 +1;
assign q10_imd =q10_dds0 +q10_dds1+1;
assign q11_imd =q11_dds0 +q11_dds1+1;
assign q12_imd =q12_dds0 +q12_dds1+1;
assign q13_imd =q13_dds0 +q13_dds1+1;
assign q14_imd =q14_dds0 +q14_dds1+1;
assign q15_imd =q15_dds0 +q15_dds1+1;

assign  DDS_FREQ_COEF_1MHz    = 32'hffffffff/(DDS_CLK_FREQ_MHz*16);
assign  DDS_FREQ_COEF_1kHz    = 32'h418937/(DDS_CLK_FREQ_MHz*16);

always@(posedge clk_user_bufg or posedge rst_glb)
begin
   if(rst_glb)
   begin
     DDS_FREQHOPSPEED_VIO_count <=0;
     dds_freqhop_flag       <=0;
   end

   else if(DDS_FREQHOPSPEED_VIO_count>=DDS_FREQHOPSPEED_VIO)
   begin
     DDS_FREQHOPSPEED_VIO_count <= 0;
     dds_freqhop_flag       <= 1;
   end
   else
   begin
     DDS_FREQHOPSPEED_VIO_count <= DDS_FREQHOPSPEED_VIO_count + 1;
     dds_freqhop_flag       <= 0;
   end     
end  


always@(posedge clk_user_bufg)
begin
	dds_freq_setup_39bit   <=  DDS_FREQ_COEF_1MHz * DDS_FIN_MHz_VIO;
  dds_freq_setup         <=  DDS_FIN_HEX_VIO+dds_freq_setup_39bit[31:00] ; 

  dds_freq_min_39bit     <=  DDS_FREQ_COEF_1MHz * DDS_FREQHOP_START_MHz_VIO;
  dds_freq_min           <=  dds_freq_min_39bit[31:00] ; 

  dds_freq_max_39bit     <=  DDS_FREQ_COEF_1MHz * DDS_FREQHOP_STOP_MHz_VIO;
  dds_freq_max           <=  dds_freq_max_39bit[31:00] ; 

  dds_freq_hop_1024kHz   <=  DDS_FREQ_COEF_1kHz * DDS_FREQHOP_kHz_VIO;
  dds_freq_hop_kHz       <=  dds_freq_hop_1024kHz[31:0]              ;

  dds_freq_imd_1024kHz   <=  DDS_FREQ_COEF_1kHz * DDS_IMD_INTERVAL_kHz_VIO;  
  dds_freq_imd_kHz       <=  dds_freq_imd_1024kHz[31:0]             ;   
  dds_freq_imd_pinc      <=  dds_freq_code + dds_freq_imd_kHz        ;     
end

//-------freq sweep test ------- 
always@(posedge clk_user_bufg )
begin
  dds_delay_reg[15:00] <= {dds_delay_reg[14:0],(dds_freq_code>=dds_freq_max)||(dds_freq_code<=dds_freq_min)} ;
end 
   
always@(posedge clk_user_bufg )
begin
  if(rst_glb)
    dds_freq_code <= 0             ;
  else if(DDS_MODE_VIO!=4'h2)
    dds_freq_code <= dds_freq_setup;
  else if(dds_freqhop_flag==1)
    dds_freq_code <= (dds_freq_code>=dds_freq_max)?(dds_freq_min-dds_freq_hop_kHz) : (dds_freq_code + dds_freq_hop_kHz);
  else   
    dds_freq_code <= dds_freq_code;  
end 
  
//------prt dac----------
always@(posedge clk_user_bufg or posedge rst_glb)
begin
  if(rst_glb)
    begin
      prt_counter <= 0             ;
      prt_dac_mute <= 1            ;
    end     
  else if(prt_counter>=DDS_PRT_CYCLE_VIO_mux-1)
    begin
      prt_counter <= 0             ;
      prt_dac_mute <= 0            ;
    end
  else if(prt_counter>=DDS_PRT_WIDTH_VIO_mux-1)
    begin
      prt_counter <= prt_counter+1 ;
      prt_dac_mute <= 1            ;
    end
  else
    begin
      prt_counter <= prt_counter+1 ;
      prt_dac_mute <= 0            ;
    end
end

always@(posedge clk_user_bufg )
  if(rst_glb)
    dac_mute <= 1            ;    
  else 
    case(DDS_MODE_VIO)
      4'h0:dac_mute <= 0                  ;
      4'h1:dac_mute <= prt_dac_mute       ;
      4'h2:dac_mute <= dds_delay_reg[14]  ;
      4'h3:dac_mute <= 0                  ;
      4'h4:dac_mute <= prt_dac_mute       ;
      default:dac_mute <= 0                ;      
    endcase

dds_16chl                           u_dds0_16chl(
  .rst                                ( rst_glb              ),
  .pinc                               ( dds_freq_code_mux    ),//pinc to cos/sin output latency:12 clock cycles
  .clk                                ( clk_user_bufg        ),
  .cos0                               (  i0_dds0             ),
  .cos1                               (  i1_dds0             ),
  .cos2                               (  i2_dds0             ),
  .cos3                               (  i3_dds0             ),
  .cos4                               (  i4_dds0             ),
  .cos5                               (  i5_dds0             ),
  .cos6                               (  i6_dds0             ),
  .cos7                               (  i7_dds0             ),
  .cos8                               (  i8_dds0             ),
  .cos9                               (  i9_dds0             ), 
  .cos10                              ( i10_dds0             ),
  .cos11                              ( i11_dds0             ),
  .cos12                              ( i12_dds0             ),
  .cos13                              ( i13_dds0             ),
  .cos14                              ( i14_dds0             ),
  .cos15                              ( i15_dds0             ),
  .sin0                               (  q0_dds0             ),
  .sin1                               (  q1_dds0             ),
  .sin2                               (  q2_dds0             ),
  .sin3                               (  q3_dds0             ),
  .sin4                               (  q4_dds0             ),
  .sin5                               (  q5_dds0             ),
  .sin6                               (  q6_dds0             ),
  .sin7                               (  q7_dds0             ),
  .sin8                               (  q8_dds0             ),
  .sin9                               (  q9_dds0             ),
  .sin10                              ( q10_dds0             ),
  .sin11                              ( q11_dds0             ),
  .sin12                              ( q12_dds0             ),
  .sin13                              ( q13_dds0             ),
  .sin14                              ( q14_dds0             ),
  .sin15                              ( q15_dds0             )
);


dds_16chl                           u_dds1_16chl(
  .rst                                ( rst_glb              ),
  .pinc                               ( dds_freq_imd_pinc    ),//pinc to cos/sin output latency:12 clock cycles
  .clk                                ( clk_user_bufg        ),
  .cos0                               (  i0_dds1             ),
  .cos1                               (  i1_dds1             ),
  .cos2                               (  i2_dds1             ),
  .cos3                               (  i3_dds1             ),
  .cos4                               (  i4_dds1             ),
  .cos5                               (  i5_dds1             ),
  .cos6                               (  i6_dds1             ),
  .cos7                               (  i7_dds1             ),
  .cos8                               (  i8_dds1             ),
  .cos9                               (  i9_dds1             ), 
  .cos10                              ( i10_dds1             ),
  .cos11                              ( i11_dds1             ),
  .cos12                              ( i12_dds1             ),
  .cos13                              ( i13_dds1             ),
  .cos14                              ( i14_dds1             ),
  .cos15                              ( i15_dds1             ),
  .sin0                               (  q0_dds1             ),
  .sin1                               (  q1_dds1             ),
  .sin2                               (  q2_dds1             ),
  .sin3                               (  q3_dds1             ),
  .sin4                               (  q4_dds1             ),
  .sin5                               (  q5_dds1             ),
  .sin6                               (  q6_dds1             ),
  .sin7                               (  q7_dds1             ),
  .sin8                               (  q8_dds1             ),
  .sin9                               (  q9_dds1             ),
  .sin10                              ( q10_dds1             ),
  .sin11                              ( q11_dds1             ),
  .sin12                              ( q12_dds1             ),
  .sin13                              ( q13_dds1             ),
  .sin14                              ( q14_dds1             ),
  .sin15                              ( q15_dds1             )
);

always@(posedge clk_user_bufg )
if(dac_mute)
  begin
	  pulse_user <=0 ;
    i0 <=0 ;
    i1 <=0 ;
    i2 <=0 ;
    i3 <=0 ;
    i4 <=0 ;
    i5 <=0 ;
    i6 <=0 ;
    i7 <=0 ;
    i8 <=0 ;
    i9 <=0 ;
    i10<=0 ;
    i11<=0 ;
    i12<=0 ;
    i13<=0 ;
    i14<=0 ;
    i15<=0 ;
    q0 <=0 ;
    q1 <=0 ;
    q2 <=0 ;
    q3 <=0 ;
    q4 <=0 ;
    q5 <=0 ;
    q6 <=0 ;
    q7 <=0 ;
    q8 <=0 ;
    q9 <=0 ;
    q10<=0 ;
    q11<=0 ;
    q12<=0 ;
    q13<=0 ;
    q14<=0 ;
    q15<=0 ; 
  end
else
  begin   
  	pulse_user  <= 1    ;
    i0  <= dac_in[0 ]; 
    i1  <= dac_in[1 ]; 
    i2  <= dac_in[2 ]; 
    i3  <= dac_in[3 ]; 
    i4  <= dac_in[4 ]; 
    i5  <= dac_in[5 ]; 
    i6  <= dac_in[6 ]; 
    i7  <= dac_in[7 ]; 
    i8  <= dac_in[8 ]; 
    i9  <= dac_in[9 ]; 
    i10 <= dac_in[10]; 
    i11 <= dac_in[11]; 
    i12 <= dac_in[12]; 
    i13 <= dac_in[13]; 
    i14 <= dac_in[14]; 
    i15 <= dac_in[15]; 
    q0  <= dac_in[16]; 
    q1  <= dac_in[17]; 
    q2  <= dac_in[18]; 
    q3  <= dac_in[19]; 
    q4  <= dac_in[20]; 
    q5  <= dac_in[21]; 
    q6  <= dac_in[22]; 
    q7  <= dac_in[23]; 
    q8  <= dac_in[24]; 
    q9  <= dac_in[25]; 
    q10 <= dac_in[26]; 
    q11 <= dac_in[27]; 
    q12 <= dac_in[28]; 
    q13 <= dac_in[29]; 
    q14 <= dac_in[30]; 
    q15 <= dac_in[31]; 
  	
  end


always@(posedge clk_user_bufg )
begin	
  dds_out[0 ] <= (DDS_MODE_VIO==4'h3)?  i0_imd[16:1]:i0_dds0   ; 
  dds_out[1 ] <= (DDS_MODE_VIO==4'h3)?  i1_imd[16:1]:i1_dds0   ; 
  dds_out[2 ] <= (DDS_MODE_VIO==4'h3)?  i2_imd[16:1]:i2_dds0   ; 
  dds_out[3 ] <= (DDS_MODE_VIO==4'h3)?  i3_imd[16:1]:i3_dds0   ; 
  dds_out[4 ] <= (DDS_MODE_VIO==4'h3)?  i4_imd[16:1]:i4_dds0   ; 
  dds_out[5 ] <= (DDS_MODE_VIO==4'h3)?  i5_imd[16:1]:i5_dds0   ; 
  dds_out[6 ] <= (DDS_MODE_VIO==4'h3)?  i6_imd[16:1]:i6_dds0   ; 
  dds_out[7 ] <= (DDS_MODE_VIO==4'h3)?  i7_imd[16:1]:i7_dds0   ; 
  dds_out[8 ] <= (DDS_MODE_VIO==4'h3)?  i8_imd[16:1]:i8_dds0   ; 
  dds_out[9 ] <= (DDS_MODE_VIO==4'h3)?  i9_imd[16:1]:i9_dds0   ; 
  dds_out[10] <= (DDS_MODE_VIO==4'h3)? i10_imd[16:1]:i10_dds0  ; 
  dds_out[11] <= (DDS_MODE_VIO==4'h3)? i11_imd[16:1]:i11_dds0  ; 
  dds_out[12] <= (DDS_MODE_VIO==4'h3)? i12_imd[16:1]:i12_dds0  ; 
  dds_out[13] <= (DDS_MODE_VIO==4'h3)? i13_imd[16:1]:i13_dds0  ; 
  dds_out[14] <= (DDS_MODE_VIO==4'h3)? i14_imd[16:1]:i14_dds0  ; 
  dds_out[15] <= (DDS_MODE_VIO==4'h3)? i15_imd[16:1]:i15_dds0  ; 
  dds_out[16] <= (DDS_MODE_VIO==4'h3)?  q0_imd[16:1]:q0_dds0   ; 
  dds_out[17] <= (DDS_MODE_VIO==4'h3)?  q1_imd[16:1]:q1_dds0   ; 
  dds_out[18] <= (DDS_MODE_VIO==4'h3)?  q2_imd[16:1]:q2_dds0   ; 
  dds_out[19] <= (DDS_MODE_VIO==4'h3)?  q3_imd[16:1]:q3_dds0   ; 
  dds_out[20] <= (DDS_MODE_VIO==4'h3)?  q4_imd[16:1]:q4_dds0   ; 
  dds_out[21] <= (DDS_MODE_VIO==4'h3)?  q5_imd[16:1]:q5_dds0   ; 
  dds_out[22] <= (DDS_MODE_VIO==4'h3)?  q6_imd[16:1]:q6_dds0   ; 
  dds_out[23] <= (DDS_MODE_VIO==4'h3)?  q7_imd[16:1]:q7_dds0   ; 
  dds_out[24] <= (DDS_MODE_VIO==4'h3)?  q8_imd[16:1]:q8_dds0   ; 
  dds_out[25] <= (DDS_MODE_VIO==4'h3)?  q9_imd[16:1]:q9_dds0   ; 
  dds_out[26] <= (DDS_MODE_VIO==4'h3)? q10_imd[16:1]:q10_dds0  ; 
  dds_out[27] <= (DDS_MODE_VIO==4'h3)? q11_imd[16:1]:q11_dds0  ; 
  dds_out[28] <= (DDS_MODE_VIO==4'h3)? q12_imd[16:1]:q12_dds0  ; 
  dds_out[29] <= (DDS_MODE_VIO==4'h3)? q13_imd[16:1]:q13_dds0  ; 
  dds_out[30] <= (DDS_MODE_VIO==4'h3)? q14_imd[16:1]:q14_dds0  ; 
  dds_out[31] <= (DDS_MODE_VIO==4'h3)? q15_imd[16:1]:q15_dds0  ; 
end

//----------att control 0~50dB----------------
assign  value_multip_input = 15'h7fff-DDS_AMP_MULTIP_VIO;

genvar ind;

generate
  for( ind=0; ind<32; ind=ind+1)
    begin:u_value_att_round
      value_att_round       #(
        .IN_WIDTH            ( DAC_BITWIDTH           ),
        .OUT_WIDTH           ( DAC_BITWIDTH           )  
      )                     dac_value_att_round(                   
        .reset               ( rst_glb                ),
        .clk                 ( clk_user_bufg          ),
                                                   
        .value_multip        ( value_multip_input     ), //value_multip_reg = {1'b0,value_multip[14:00]};
        .value_0p1db_att     ( DDS_ATT_0p1dB_VIO      ), 
                                
        .value_in            ( dds_out[ind]           ),  
        .value_out           ( dac_in[ind]            )
      );
    end
endgenerate 
//---------------sync test mode DDS_MODE_VIO=4------//
assign      dds_freq_code_mux     = (DDS_MODE_VIO==4'h4)? 32'h1000_0000: dds_freq_code      ;
assign      DDS_PRT_WIDTH_VIO_mux = (DDS_MODE_VIO==4'h4)? 32'h0010_0000: DDS_PRT_WIDTH_VIO  ;
assign      DDS_PRT_CYCLE_VIO_mux = (DDS_MODE_VIO==4'h4)? 32'h0008_0000: DDS_PRT_CYCLE_VIO  ;
//---------------rsv_port_o-------------------------//
assign dds_rsv_port_o[223:0] = 224'b0;
assign dds_rsv_port_o[247:224] = 24'h01_00_00;
assign dds_rsv_port_o[255:248] = 8'b0;
   
endmodule
