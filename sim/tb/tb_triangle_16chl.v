`timescale 1ns/1ps

module tb_top ();

// 1. 信号定义
parameter CLK_PERIOD = 20 ;
reg sys_clk;
reg sys_rst_n;
wire [15:0] tri_pos0;
wire [15:0] tri_pos1;
wire [15:0] tri_pos2;
wire [15:0] tri_pos3;
wire [15:0] tri_pos4;
wire [15:0] tri_pos5;
wire [15:0] tri_pos6;
wire [15:0] tri_pos7;
wire [15:0] tri_pos8;
wire [15:0] tri_pos9;
wire [15:0] tri_pos10;
wire [15:0] tri_pos11;
wire [15:0] tri_pos12;
wire [15:0] tri_pos13;
wire [15:0] tri_pos14;
wire [15:0] tri_pos15;
wire [15:0] tri_neg0;
wire [15:0] tri_neg1;
wire [15:0] tri_neg2;
wire [15:0] tri_neg3;
wire [15:0] tri_neg4;
wire [15:0] tri_neg5;
wire [15:0] tri_neg6;
wire [15:0] tri_neg7;
wire [15:0] tri_neg8;
wire [15:0] tri_neg9;
wire [15:0] tri_neg10;
wire [15:0] tri_neg11;
wire [15:0] tri_neg12;
wire [15:0] tri_neg13;
wire [15:0] tri_neg14;
wire [15:0] tri_neg15;

// 2. 系统时钟沿
always #(CLK_PERIOD/2) sys_clk=~sys_clk;

// 3. 仿真模块
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
end

// 4. 例化被测模块
triangle_16chl u_triangle_16chl (
    .clk(sys_clk),
    .rst_n(sys_rst_n),
    .DDS_FREQ_VIO(32'd80000),
    .DDS_PCW_VIO(10'd0),
    .DDS_AMP_VIO(16'd12500),
    .DDS_DC_OFFSET_VIO(16'd0),
    .tri_pos0(tri_pos0),
    .tri_pos1(tri_pos1),
    .tri_pos2(tri_pos2),
    .tri_pos3(tri_pos3),
    .tri_pos4(tri_pos4),
    .tri_pos5(tri_pos5),
    .tri_pos6(tri_pos6),
    .tri_pos7(tri_pos7),
    .tri_pos8(tri_pos8),
    .tri_pos9(tri_pos9),
    .tri_pos10(tri_pos10),
    .tri_pos11(tri_pos11),
    .tri_pos12(tri_pos12),
    .tri_pos13(tri_pos13),
    .tri_pos14(tri_pos14),
    .tri_pos15(tri_pos15),
    .tri_neg0(tri_neg0),
    .tri_neg1(tri_neg1),
    .tri_neg2(tri_neg2),
    .tri_neg3(tri_neg3),
    .tri_neg4(tri_neg4),
    .tri_neg5(tri_neg5),
    .tri_neg6(tri_neg6),
    .tri_neg7(tri_neg7),
    .tri_neg8(tri_neg8),
    .tri_neg9(tri_neg9),
    .tri_neg10(tri_neg10),
    .tri_neg11(tri_neg11),
    .tri_neg12(tri_neg12),
    .tri_neg13(tri_neg13),
    .tri_neg14(tri_neg14),
    .tri_neg15(tri_neg15)
);

endmodule //tb_dds_top