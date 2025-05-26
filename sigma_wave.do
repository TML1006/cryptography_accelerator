onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /sigma_testbench/x
add wave -noupdate -radix hexadecimal /sigma_testbench/out
add wave -noupdate -radix hexadecimal /sigma_testbench/op
add wave -noupdate -radix hexadecimal /sigma_testbench/clk
add wave -noupdate -radix hexadecimal /sigma_testbench/DUT/rot00
add wave -noupdate -radix hexadecimal /sigma_testbench/DUT/rot01
add wave -noupdate -radix hexadecimal /sigma_testbench/DUT/rot02
add wave -noupdate -radix hexadecimal /sigma_testbench/DUT/rot10
add wave -noupdate -radix hexadecimal /sigma_testbench/DUT/rot11
add wave -noupdate -radix hexadecimal /sigma_testbench/DUT/rot12
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ps} 0}
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
WaveRestoreZoom {0 ps} {5 ps}
