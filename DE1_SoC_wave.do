onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate -group Selector {/DE1_SoC_testbench/SW[9]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[7]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[6]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[5]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[4]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[3]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[2]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[1]}
add wave -noupdate -group A {/DE1_SoC_testbench/SW[0]}
add wave -noupdate -expand -group Start {/DE1_SoC_testbench/KEY[3]}
add wave -noupdate -group Reset {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate -expand -group {Result / Loc} /DE1_SoC_testbench/HEX1
add wave -noupdate -expand -group {Result / Loc} /DE1_SoC_testbench/HEX0
add wave -noupdate -expand -group Done {/DE1_SoC_testbench/LEDR[9]}
add wave -noupdate /DE1_SoC_testbench/dut/task2/max
add wave -noupdate /DE1_SoC_testbench/dut/task2/min
add wave -noupdate /DE1_SoC_testbench/dut/task2/address
add wave -noupdate /DE1_SoC_testbench/dut/task2/dataOut
add wave -noupdate /DE1_SoC_testbench/dut/found
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1330786 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1211769 ps} {1568819 ps}
