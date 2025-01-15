-makelib ies/xil_defaultlib -sv \
  "E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
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
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

