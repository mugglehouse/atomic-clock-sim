`timescale 1ns/1ps

module tb_top ();

// 1. 信号定义
parameter CLK_PERIOD = 20 ;
reg sys_clk;
reg sys_rst_n;
wire [15:0] dds_triangle;    // DAC输出信号
wire [15:0] dac_dds_data; // 三角波输出信号

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
triangle_wave u_triangle_wave (
    .clk(sys_clk),
    .rst_n(sys_rst_n),
    .DDS_VC_FREQ_VIO(32'd800000),
    .pcw(10'd0),
    .DDS_VC_AMP_VIO(16'd12500), // 三角波一定要设置的
    .DDS_VC_DC_OFFSET_VIO(16'd12500),
    // .DC_OFFSET(16'd0),
    .dds_triangle(dds_triangle),
    .dac_dds_data(dac_dds_data)
);

endmodule //tb_dds_top