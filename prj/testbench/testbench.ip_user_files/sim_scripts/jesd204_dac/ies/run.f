-makelib ies/xil_defaultlib -sv \
  "E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/jesd204_v7_1_1 \
  "../../../ipstatic/hdl/jesd204_v7_1_rfs.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac_block.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_address_decoder.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac_register_decode.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_axi_lite_ipif.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_counter_f.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_pselect_f.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/axi_ipif/jesd204_dac_slave_attachment.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac_reset_block.v" \
  "../../../../testbench.srcs/sources_1/ip/jesd204_dac/synth/jesd204_dac.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

