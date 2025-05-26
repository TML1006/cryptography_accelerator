onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /aesUnit_testbench/A
add wave -noupdate -radix hexadecimal /aesUnit_testbench/B
add wave -noupdate -radix hexadecimal /aesUnit_testbench/aesResult
add wave -noupdate -radix hexadecimal /aesUnit_testbench/finalRound
add wave -noupdate -radix hexadecimal /aesUnit_testbench/keyAssist
add wave -noupdate /aesUnit_testbench/encryption
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 191
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
WaveRestoreZoom {0 ps} {11 ps}
