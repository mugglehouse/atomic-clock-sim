onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+jesd204_dac -L xil_defaultlib -L xpm -L jesd204_v7_1_1 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.jesd204_dac xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {jesd204_dac.udo}

run -all

endsim

quit -force
