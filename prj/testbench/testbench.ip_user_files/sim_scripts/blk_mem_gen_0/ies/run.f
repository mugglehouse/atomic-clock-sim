-makelib ies/xil_defaultlib -sv \
  "E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "E:/vivado/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/blk_mem_gen_v8_3_5 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_3.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../testbench.srcs/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

