vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/jesd204_v7_1_1

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap jesd204_v7_1_1 activehdl/jesd204_v7_1_1

vlog -work xil_defaultlib  -sv2k12 \
"E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work jesd204_v7_1_1  -v2k5 \
"../../../ipstatic/hdl/jesd204_v7_1_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
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

