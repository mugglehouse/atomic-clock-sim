vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 \
"E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt/example_design/jesd204_phy_dac_gt_tx_startup_fsm.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt/example_design/jesd204_phy_dac_gt_rx_startup_fsm.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt_init.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt_cpll_railing.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt_gt.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt_multi_gt.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt/example_design/jesd204_phy_dac_gt_sync_block.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/ip_0/jesd204_phy_dac_gt.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/synth/jesd204_phy_dac_block.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/synth/jesd204_phy_dac_sync_block.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/synth/jesd204_phy_dac_support.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/synth/jesd204_phy_dac_gt_common_wrapper.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/synth/jesd204_phy_dac_gtwizard_0_common.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_phy_dac/synth/jesd204_phy_dac.v" \

vlog -work xil_defaultlib "glbl.v"

