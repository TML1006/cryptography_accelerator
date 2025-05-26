onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sbox_testbench/CLOCK_PERIOD
add wave -noupdate /sbox_testbench/byte0
add wave -noupdate /sbox_testbench/byte1
add wave -noupdate /sbox_testbench/byte2
add wave -noupdate /sbox_testbench/byte3
add wave -noupdate /sbox_testbench/clk
add wave -noupdate /sbox_testbench/s0
add wave -noupdate /sbox_testbench/s1
add wave -noupdate /sbox_testbench/s2
add wave -noupdate /sbox_testbench/s3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {1 ns}
