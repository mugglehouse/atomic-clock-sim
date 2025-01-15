`timescale 1ns/1ps

module tb_top ();

// 1. 信号定义
parameter CLK_PERIOD = 20 ;
reg sys_clk;
reg sys_rst_n;
reg [31:0] pinc;
wire [15:0]cos0;
wire [15:0]cos1;
wire [15:0]cos10;
wire [15:0]cos11;
wire [15:0]cos12;
wire [15:0]cos13;
wire [15:0]cos14;
wire [15:0]cos15;
wire [15:0]cos2;
wire [15:0]cos3;
wire [15:0]cos4;
wire [15:0]cos5;
wire [15:0]cos6;
wire [15:0]cos7;
wire [15:0]cos8;
wire [15:0]cos9;
wire [15:0]sin0;
wire [15:0]sin1;
wire [15:0]sin10;
wire [15:0]sin11;
wire [15:0]sin12;
wire [15:0]sin13;
wire [15:0]sin14;
wire [15:0]sin15;
wire [15:0]sin2;
wire [15:0]sin3;
wire [15:0]sin4;
wire [15:0]sin5;
wire [15:0]sin6;
wire [15:0]sin7;
wire [15:0]sin8;
wire [15:0]sin9;

// 2. 系统时钟沿
always #(CLK_PERIOD/2) sys_clk=~sys_clk;

// 常用频率对应的PINC值（时钟100MHz）
// 1MHz: 43_000_000
// 10MHz: 429_500_000
// 20MHz: 859_000_000
// 25MHz: 1_073_750_000

// 3. 仿真模块
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b1;
    pinc <= 32'd0;
    #200
    sys_rst_n <= 1'b0;
    pinc <= 32'd43000000;
end

// 4. 例化被测模块
dds_16chl u_dds_16chl (
    .rst(sys_rst_n),
    .pinc(pinc),
    .clk(sys_clk),
    .cos0(cos0),
    .cos1(cos1),
    .cos10(cos10),
    .cos11(cos11),
    .cos12(cos12),
    .cos13(cos13),
    .cos14(cos14),
    .cos15(cos15),
    .cos2(cos2),
    .cos3(cos3),
    .cos4(cos4),
    .cos5(cos5),
    .cos6(cos6),
    .cos7(cos7),
    .cos8(cos8),
    .cos9(cos9),
    .sin0(sin0),
    .sin1(sin1),
    .sin10(sin10),
    .sin11(sin11),
    .sin12(sin12),
    .sin13(sin13),
    .sin14(sin14),
    .sin15(sin15),
    .sin2(sin2),
    .sin3(sin3),
    .sin4(sin4),
    .sin5(sin5),
    .sin6(sin6),
    .sin7(sin7),
    .sin8(sin8),
    .sin9(sin9)
);

endmodule //tb_dds_top