module dds_triangle_wave (
    input wire clk,              // 系统时钟
    input wire rst_n,            // 低电平有效复位信号
    input wire [31:0] DDS_VC_FREQ_VIO,       // 输出频率
    input wire [9:0] pcw,        // 相位控制字
    input wire [15:0] DDS_VC_AMP_VIO,     // 幅度控制（0-65535）, //幅度控制字
    input wire [15:0] DDS_VC_DC_OFFSET_VIO,     // 直流偏置
    output reg [15:0] dac_dds_data // 
);

reg [15:0] dds_triangle;

// 参数定义
parameter ADDR_WIDTH = 10;  // ROM地址宽度
parameter DATA_WIDTH = 16;  // ROM数据宽度

// 内部信号定义
reg [31:0] phase_acc;  // 相位累加器
wire [ADDR_WIDTH-1:0] rom_addr;
wire [15:0] rom_dout;
wire [31:0] scaled_output;

// 1. 相位累加器（fcw）
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        phase_acc <= 32'd0;
    else
        phase_acc <= phase_acc + DDS_VC_FREQ_VIO;
end

// 2. 计算ROM地址（pcw）
assign rom_addr = phase_acc[31:22] + pcw;

// 3. 实例化ROM IP核
blk_mem_gen_0 u_blk_mem_gen_0 (
    .clka(clk),               // input wire clka
    .wea(),               // input wire [0 : 0] wea (写使能信号，ROM中不需要)
    .addra(rom_addr),  // input wire [11 : 0] addra (ROM地址线)
    .dina(),             // input wire [15 : 0] dina (数据输入，ROM中不需要)
    .douta(rom_dout)     // output wire [15 : 0] douta (读取的波形数据)
);

// 4. 幅度调整（amplitude）
assign scaled_output = $signed(rom_dout) * $signed({1'b0, DDS_VC_AMP_VIO});
// 输出调整（使用适当的位移和舍入）
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        dds_triangle <= 16'd0;
    else
        dds_triangle <= scaled_output[30:15] + scaled_output[14];// 使用算术右移和舍入
end

// 叠加直流信号
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dac_dds_data <= DDS_VC_DC_OFFSET_VIO;
    end else begin
        // 需要将其加上DC_OFFSET以得到最终输出
        dac_dds_data <= DDS_VC_DC_OFFSET_VIO + {{1{dds_triangle[15]}}, dds_triangle[15:1]};
    end
end

endmodule //triangle_wave