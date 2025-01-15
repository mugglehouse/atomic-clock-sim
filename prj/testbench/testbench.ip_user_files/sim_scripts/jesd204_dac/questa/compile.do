vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/jesd204_v7_1_1

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap jesd204_v7_1_1 msim/jesd204_v7_1_1

vlog -work xil_defaultlib -64 -sv \
"E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work jesd204_v7_1_1 -64 \
"../../../ipstatic/hdl/jesd204_v7_1_rfs.v" \

vlog -work xil_defaultlib -64 \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac_block.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_address_decoder.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac_register_decode.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_axi_lite_ipif.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_counter_f.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_pselect_f.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_slave_attachment.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac_reset_block.v" \
"../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac.v" \

vlog -work xil_defaultlib "glbl.v"

