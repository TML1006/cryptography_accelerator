onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal -childformat {{{/shiftRows_testbench/in[3]} -radix hexadecimal} {{/shiftRows_testbench/in[2]} -radix hexadecimal} {{/shiftRows_testbench/in[1]} -radix hexadecimal} {{/shiftRows_testbench/in[0]} -radix hexadecimal}} -expand -subitemconfig {{/shiftRows_testbench/in[3]} {-radix hexadecimal} {/shiftRows_testbench/in[2]} {-radix hexadecimal} {/shiftRows_testbench/in[1]} {-radix hexadecimal} {/shiftRows_testbench/in[0]} {-radix hexadecimal}} /shiftRows_testbench/in
add wave -noupdate -radix hexadecimal -childformat {{{/shiftRows_testbench/out[3]} -radix hexadecimal} {{/shiftRows_testbench/out[2]} -radix hexadecimal} {{/shiftRows_testbench/out[1]} -radix hexadecimal} {{/shiftRows_testbench/out[0]} -radix hexadecimal}} -expand -subitemconfig {{/shiftRows_testbench/out[3]} {-radix hexadecimal} {/shiftRows_testbench/out[2]} {-radix hexadecimal} {/shiftRows_testbench/out[1]} {-radix hexadecimal} {/shiftRows_testbench/out[0]} {-radix hexadecimal}} /shiftRows_testbench/out
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
