@echo off
set xv_path=E:\\vivado\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto d36e16917e8149768415d342fa7e922c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L jesd204_v7_1_1 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_top_behav xil_defaultlib.tb_top xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
