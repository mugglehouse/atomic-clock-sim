`timescale 1ns/1ps

module tb_top ();

// 1. 信号定义
parameter CLK_PERIOD = 20 ;
reg sys_clk;
reg sys_rst_n;

wire pulse_user;
wire [15:0] i0;
wire [15:0] i1;
wire [15:0] i2;
wire [15:0] i3;
wire [15:0] i4;
wire [15:0] i5;
wire [15:0] i6;
wire [15:0] i7;
wire [15:0] i8;
wire [15:0] i9;
wire [15:0] i10;
wire [15:0] i11;
wire [15:0] i12;
wire [15:0] i13;
wire [15:0] i14;
wire [15:0] i15;
wire [15:0] q0;
wire [15:0] q1;
wire [15:0] q2;
wire [15:0] q3;
wire [15:0] q4;
wire [15:0] q5;
wire [15:0] q6;
wire [15:0] q7;
wire [15:0] q8;
wire [15:0] q9;
wire [15:0] q10;
wire [15:0] q11;
wire [15:0] q12;
wire [15:0] q13;
wire [15:0] q14;
wire [15:0] q15;

// 2. 系统时钟沿
always #(CLK_PERIOD/2) sys_clk=~sys_clk;

// 3. 仿真模块
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b1;
    #200
    sys_rst_n <= 1'b0;
end

// 4. 例化被测模块
dds_tri_for_7_series_iq u_dds_tri_for_7_series_iq (
    .DDS_CLK_FREQ_MHz(100),
    .rst_glb(sys_rst_n),
    .clk_user_bufg(sys_clk),
    .pulse_user(pulse_user),
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .i4(i4),
    .i5(i5),
    .i6(i6),
    .i7(i7),
    .i8(i8),
    .i9(i9),
    .i10(i10),
    .i11(i11),
    .i12(i12),
    .i13(i13),
    .i14(i14),
    .i15(i15),
    .q0(q0),
    .q1(q1),
    .q2(q2),
    .q3(q3),
    .q4(q4),
    .q5(q5),
    .q6(q6),
    .q7(q7),
    .q8(q8),
    .q9(q9),
    .q10(q10),
    .q11(q11),
    .q12(q12),
    .q13(q13),
    .q14(q14),
    .q15(q15),
    .DDS_PCW_VIO(10'd0),
    .DDS_AMP_VIO(16'd12500),
    .DDS_DC_OFFSET_VIO(16'd0),
    .DDS_MODE_VIO(4'b0),
    .DDS_FIN_kHz_VIO(32'd10000),
    .DDS_FIN_HEX_VIO(32'd0),
    .DDS_PRT_WIDTH_VIO(32'd0),
    .DDS_PRT_CYCLE_VIO(32'd0),
    .DDS_AMP_MULTIP_VIO(32'd0),
    .DDS_ATT_0p1dB_VIO(32'd0),
    .DDS_FREQHOPSPEED_VIO(32'd0),
    .DDS_FREQHOP_kHz_VIO(32'd0),
    .DDS_FREQHOP_START_kHz_VIO(32'd0),
    .DDS_FREQHOP_STOP_kHz_VIO(32'd0),
    .DDS_IMD_INTERVAL_kHz_VIO(32'd0),
    .dds_rsv_port_o()
);

endmodule //tb_dds_top