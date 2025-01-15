module triangle_16chl (
    input wire clk,              // 系统时钟
    input wire rst_n,            // 低电平有效复位信号
    input wire [31:0] DDS_FREQ_VIO,       // 输出频率
    input wire [9:0] DDS_PCW_VIO,        // 相位控制字
    input wire [15:0] DDS_AMP_VIO,     // 幅度控制（0-65535）, //幅度控制字
    input wire [15:0] DDS_DC_OFFSET_VIO,     // 直流偏置
    output [15:0] tri_pos0,
    output [15:0] tri_pos1,
    output [15:0] tri_pos2,
    output [15:0] tri_pos3,
    output [15:0] tri_pos4,
    output [15:0] tri_pos5,
    output [15:0] tri_pos6,
    output [15:0] tri_pos7,
    output [15:0] tri_pos8,
    output [15:0] tri_pos9,
    output [15:0] tri_pos10,
    output [15:0] tri_pos11,
    output [15:0] tri_pos12,
    output [15:0] tri_pos13,
    output [15:0] tri_pos14,
    output [15:0] tri_pos15,
    output [15:0] tri_neg0,
    output [15:0] tri_neg1,
    output [15:0] tri_neg2,
    output [15:0] tri_neg3,
    output [15:0] tri_neg4,
    output [15:0] tri_neg5,
    output [15:0] tri_neg6,
    output [15:0] tri_neg7,
    output [15:0] tri_neg8,
    output [15:0] tri_neg9,
    output [15:0] tri_neg10,
    output [15:0] tri_neg11,
    output [15:0] tri_neg12,
    output [15:0] tri_neg13,
    output [15:0] tri_neg14,
    output [15:0] tri_neg15
);

wire [9:0] pcw;
wire [15:0] tri_pos [15:0]; // 16个正向三角波输出
wire [15:0] tri_neg [15:0]; // 16个反向三角波输出
assign pcw = DDS_PCW_VIO;

genvar i;
generate
    for(i=0; i<16; i=i+1) begin: DDS_POS_GEN
        dds_triangle_wave u_dds_triangle_wave_pos (
            .clk(clk),
            .rst_n(~rst_n),
            .DDS_VC_FREQ_VIO(DDS_FREQ_VIO),
            .pcw(DDS_PCW_VIO + (i*16)),
            .DDS_VC_AMP_VIO(DDS_AMP_VIO),
            .DDS_VC_DC_OFFSET_VIO(DDS_DC_OFFSET_VIO),
            .dac_dds_data(tri_pos[i])  // 直接连接到对应的tri_pos输出
        );
    end
endgenerate

genvar j;
generate
    for(j=0; j<16; j=j+1) begin: DDS_NEG_GEN
        dds_triangle_wave u_dds_triangle_wave_neg (
            .clk(clk),
            .rst_n(~rst_n),
            .DDS_VC_FREQ_VIO(DDS_FREQ_VIO),
            .pcw(DDS_PCW_VIO + 512 + (j*16)),
            .DDS_VC_AMP_VIO(DDS_AMP_VIO),
            .DDS_VC_DC_OFFSET_VIO(DDS_DC_OFFSET_VIO),
            .dac_dds_data(tri_neg[j])  // 直接连接到对应的tri_pos输出
        );
    end
endgenerate

// 连接输出端口
assign tri_pos0 = tri_pos[0];
assign tri_pos1 = tri_pos[1];
assign tri_pos2 = tri_pos[2];
assign tri_pos3 = tri_pos[3];
assign tri_pos4 = tri_pos[4];
assign tri_pos5 = tri_pos[5];
assign tri_pos6 = tri_pos[6];
assign tri_pos7 = tri_pos[7];
assign tri_pos8 = tri_pos[8];
assign tri_pos9 = tri_pos[9];
assign tri_pos10 = tri_pos[10];
assign tri_pos11 = tri_pos[11];
assign tri_pos12 = tri_pos[12];
assign tri_pos13 = tri_pos[13];
assign tri_pos14 = tri_pos[14];
assign tri_pos15 = tri_pos[15];

assign tri_neg0 = tri_neg[0];
assign tri_neg1 = tri_neg[1];
assign tri_neg2 = tri_neg[2];
assign tri_neg3 = tri_neg[3];
assign tri_neg4 = tri_neg[4];
assign tri_neg5 = tri_neg[5];
assign tri_neg6 = tri_neg[6];
assign tri_neg7 = tri_neg[7];
assign tri_neg8 = tri_neg[8];
assign tri_neg9 = tri_neg[9];
assign tri_neg10 = tri_neg[10];
assign tri_neg11 = tri_neg[11];
assign tri_neg12 = tri_neg[12];
assign tri_neg13 = tri_neg[13];
assign tri_neg14 = tri_neg[14];
assign tri_neg15 = tri_neg[15];

endmodule //triangle_16chl