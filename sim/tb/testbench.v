`timescale 1ns/1ps

module tb_top ();

// 1. 信号定义
// 时钟周期参数定义 (单位:ns)
localparam CLK_100M_PERIOD = 10;    // 100MHz = 1/(10ns)
localparam CLK_10M_PERIOD  = 100;   // 10MHz = 1/(100ns) 
localparam CLK_300M_PERIOD = 3.33;  // 300MHz = 1/(3.33ns)
localparam CLK_50M_PERIOD  = 20;    // 50MHz = 1/(20ns)
localparam CLK_1M_PERIOD   = 1000;  // 1MHz = 1/(1000ns)
reg sys_clk;
reg sys_rst_n;
reg dac_ready;

reg iob_refclk_p; // 100MHz
reg iob_refclk_n;
reg iob_sysref_p; // 10MHz
reg iob_sysref_n;
reg iob_glblclk_p; // 300MHz
reg iob_glblclk_n;

wire clk_user_bufg;
wire refclk;
wire sysref_o;
wire rst_int;

reg [15:0] DDS_MODE_VIO;
reg [31:0] DDS_FIN_MHz_VIO;
reg [31:0] DDS_FIN_HEX_VIO;
reg [31:0] DDS_PRT_WIDTH_VIO;
reg [31:0] DDS_PRT_CYCLE_VIO;
reg [14:0] DDS_AMP_MULTIP_VIO;
reg [9:0] DDS_ATT_0p1dB_VIO;
reg [31:0] DDS_FREQHOPSPEED_VIO;
reg [15:0] DDS_FREQHOP_kHz_VIO;
reg [15:0] DDS_FREQHOP_START_MHz_VIO;
reg [15:0] DDS_FREQHOP_STOP_MHz_VIO;
reg [19:0] DDS_IMD_INTERVAL_kHz_VIO;

wire pulse_user;
wire   [255:0]      dds_rsv_port_o              ;
wire [15:0]         i0, i1, i2, i3, 
                    i4, i5, i6, i7, 
                    i8, i9,i10,i11,
                    i12,i13,i14,i15            ;
wire [15:0]         q0, q1, q2, q3, 
                    q4, q5, q6, q7, 
                    q8, q9,q10,q11,
                    q12,q13,q14,q15            ;
wire [15:0] da0i_ch00, da0i_ch01, da0i_ch02, da0i_ch03, da1i_ch00, da1i_ch01, da1i_ch02, da1i_ch03, da0q_ch00, da0q_ch01, da0q_ch02, da0q_ch03, da1q_ch00, da1q_ch01, da1q_ch02, da1q_ch03;

// 

wire [7:0] iob_txp;
wire [7:0] iob_txn;
wire [255:0] dac_tx_tdata;

wire [15:0] cnt_timing;

wire dac_axi_awready;
wire dac_axi_arready;
wire dac_axi_wready;
wire dac_axi_rready;

wire dac_axi_rvalid;
wire dac_axi_wvalid;
wire dac_axi_bvalid;
wire dac_axi_bready;
wire dac_axi_arvalid;
wire dac_axi_awvalid;

wire [3:0] dac_axi_wstrb;
wire [1:0] dac_axi_bresp;
wire [1:0] dac_axi_rresp;

wire [11:0] dac_axi_awaddr;
wire [31:0] dac_axi_wdata;
wire [11:0] dac_axi_araddr;
wire [31:0] dac_axi_rdata;



// sim
wire [1:0] tx_sync_dac;

wire dac_ready_negedge;
wire tx_reset_done_dac;
wire [3:0] jesd204_da_gt0_tx_txcharisk;
wire [31:0] jesd204_da_gt0_tx_txdata;


// 添加监控计数器和信号
reg [31:0] axi_writes_count;
reg [31:0] data_transfers_count;
reg cfg_done;



// 2. 系统时钟沿
always #(CLK_50M_PERIOD/2) sys_clk=~sys_clk;

always #(CLK_100M_PERIOD/2) begin
    iob_refclk_p <= ~iob_refclk_p;
    iob_refclk_n <= ~iob_refclk_n;
end

always #(CLK_10M_PERIOD/2) begin
    iob_sysref_p <= ~iob_sysref_p;
    iob_sysref_n <= ~iob_sysref_n;
end

always #(CLK_300M_PERIOD/2) begin
    iob_glblclk_p <= ~iob_glblclk_p;
    iob_glblclk_n <= ~iob_glblclk_n;
end

// 3. 仿真模块
initial begin
    sys_clk <= 1'b0;
    dac_ready <= 1'b0;
    sys_rst_n <= 1'b1;
    
    iob_refclk_p = 1'b0;  
    iob_refclk_n = 1'b1;  // 差分对初始值相反
    
    iob_sysref_p = 1'b0;
    iob_sysref_n = 1'b1;
    
    iob_glblclk_p = 1'b0;
    iob_glblclk_n = 1'b1;

    DDS_MODE_VIO <= 16'd0;
    DDS_FIN_MHz_VIO <= 32'd0;
    DDS_FIN_HEX_VIO <= 32'd0;
    DDS_PRT_WIDTH_VIO <= 32'd0;
    DDS_PRT_CYCLE_VIO <= 32'd0;
    DDS_AMP_MULTIP_VIO <= 15'd0;
    DDS_ATT_0p1dB_VIO <= 10'd0;
    DDS_FREQHOPSPEED_VIO <= 32'd0;
    DDS_FREQHOP_kHz_VIO <= 16'd0;
    DDS_FREQHOP_START_MHz_VIO <= 16'd0;
    DDS_FREQHOP_STOP_MHz_VIO <= 16'd0;
    DDS_IMD_INTERVAL_kHz_VIO <= 20'd0;

    axi_writes_count = 0;
    data_transfers_count = 0;
    cfg_done = 0;

    #200
    sys_rst_n <= 1'b0;
    dac_ready <= 1'b1;
    DDS_MODE_VIO <= 16'd0;
    DDS_FIN_MHz_VIO <= 32'd10;
    DDS_FIN_HEX_VIO <= 32'h0;
    DDS_PRT_WIDTH_VIO <= 32'd0;
    DDS_PRT_CYCLE_VIO <= 32'd0;
    DDS_AMP_MULTIP_VIO <= 15'd0;
    DDS_ATT_0p1dB_VIO <= 10'd0;
    DDS_FREQHOPSPEED_VIO <= 32'd0;
    DDS_FREQHOP_kHz_VIO <= 16'd0;
    DDS_FREQHOP_START_MHz_VIO <= 16'd0;
    DDS_FREQHOP_STOP_MHz_VIO <= 16'd0;
    DDS_IMD_INTERVAL_kHz_VIO <= 20'd0;

end

// AXI写操作监控
initial begin
    forever @(posedge sys_clk) begin
        if(dac_axi_wvalid && dac_axi_wready) begin
            axi_writes_count = axi_writes_count + 1;
            $display("[%0t] AXI Write: Addr=0x%h, Data=0x%h", 
                    $time, dac_axi_awaddr, dac_axi_wdata);
        end
        
        if(|dac_tx_tdata) begin
            data_transfers_count = data_transfers_count + 1;
            $display("[%0t] DAC Data: 0x%h", $time, dac_tx_tdata);
        end
    end
end

// 状态检查
initial begin
    wait(dac_ready);
    $display("[%0t] DAC Ready Asserted", $time);
    
    @(posedge tx_reset_done_dac);
    $display("[%0t] DAC Reset Done", $time);
    
    // 配置完成检查
    wait(dac_axi_arready);
    #1000;
    if(axi_writes_count == 0) 
        $display("Error: No AXI writes detected!");
    if(data_transfers_count == 0)
        $display("Error: No DAC data transfers!");
    cfg_done = 1;
end

// 添加波形记录
initial begin
    $dumpfile("dac_sim.vcd");
    $dumpvars(0, tb_top);
end

// 4. 例化被测模块
ad9172_top u_ad9172_top (
    // input
    .clk_50m_bufg(sys_clk),
    .rst_glb(sys_rst_n),
    .iob_refclk_p(iob_refclk_p),
    .iob_refclk_n(iob_refclk_n),
    .iob_sysref_p(iob_sysref_p),
    .iob_sysref_n(iob_sysref_n),
    .iob_glblclk_p(iob_glblclk_p),
    .iob_glblclk_n(iob_glblclk_n),
    .clk_user_bufg(clk_user_bufg),
    .refclk(refclk),
    .sysref_o(sysref_o),
    .DDS_MODE_VIO(DDS_MODE_VIO),
    .DDS_FIN_MHz_VIO(DDS_FIN_MHz_VIO),
    .DDS_FIN_HEX_VIO(DDS_FIN_HEX_VIO),
    .DDS_PRT_WIDTH_VIO(DDS_PRT_WIDTH_VIO),
    .DDS_PRT_CYCLE_VIO(DDS_PRT_CYCLE_VIO),
    .DDS_AMP_MULTIP_VIO(DDS_AMP_MULTIP_VIO),
    .DDS_ATT_0p1dB_VIO(DDS_ATT_0p1dB_VIO),
    .DDS_FREQHOPSPEED_VIO(DDS_FREQHOPSPEED_VIO),
    .DDS_FREQHOP_kHz_VIO(DDS_FREQHOP_kHz_VIO),
    .DDS_FREQHOP_START_MHz_VIO(DDS_FREQHOP_START_MHz_VIO),
    .DDS_FREQHOP_STOP_MHz_VIO(DDS_FREQHOP_STOP_MHz_VIO),
    .DDS_IMD_INTERVAL_kHz_VIO(DDS_IMD_INTERVAL_kHz_VIO),
    // output
    .pulse_user(pulse_user),
    .dds_rsv_port_o(dds_rsv_port_o),
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
    // channel
    .da0i_ch00(da0i_ch00),
    .da0i_ch01(da0i_ch01),
    .da0i_ch02(da0i_ch02),
    .da0i_ch03(da0i_ch03),
    .da1i_ch00(da1i_ch00),
    .da1i_ch01(da1i_ch01),
    .da1i_ch02(da1i_ch02),
    .da1i_ch03(da1i_ch03),
    .da0q_ch00(da0q_ch00),
    .da0q_ch01(da0q_ch01),
    .da0q_ch02(da0q_ch02),
    .da0q_ch03(da0q_ch03),
    .da1q_ch00(da1q_ch00),
    .da1q_ch01(da1q_ch01),
    .da1q_ch02(da1q_ch02),
    .da1q_ch03(da1q_ch03),
    // share
    .iob_txp(iob_txp),
    .iob_txn(iob_txn),
    .dac_tx_tdata(dac_tx_tdata),
    .dac_axi_awready(dac_axi_awready),
    .dac_axi_wready(dac_axi_wready),
    // sim
    .tx_sync_dac(tx_sync_dac),
    .dac_axi_awaddr(dac_axi_awaddr),
    .dac_axi_awvalid(dac_axi_awvalid),
    .dac_axi_wstrb(dac_axi_wstrb),
    .dac_axi_wvalid(dac_axi_wvalid),
    .dac_axi_wdata(dac_axi_wdata),
    .dac_axi_bresp(dac_axi_bresp),
    .dac_axi_bvalid(dac_axi_bvalid),
    .dac_axi_bready(dac_axi_bready),
    .dac_axi_araddr(dac_axi_araddr),
    .dac_axi_arvalid(dac_axi_arvalid),
    .dac_axi_arready(dac_axi_arready),
    .dac_axi_rdata(dac_axi_rdata),
    .dac_axi_rresp(dac_axi_rresp),
    .dac_axi_rvalid(dac_axi_rvalid),
    .dac_axi_rready(dac_axi_rready),
    .dac_ready_negedge(dac_ready_negedge),
    .tx_reset_done_dac(tx_reset_done_dac),
    .jesd204_da_gt0_tx_txcharisk(jesd204_da_gt0_tx_txcharisk),
    .jesd204_da_gt0_tx_txdata(jesd204_da_gt0_tx_txdata),
    .cnt_timing (cnt_timing),
    .rst_int(rst_int)
);

endmodule //tb_dds_top