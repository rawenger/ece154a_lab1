onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider <NULL>
add wave -noupdate -radix unsigned /alu_tb/dut/f
add wave -noupdate -divider <NULL>
add wave -noupdate /alu_tb/dut/a
add wave -noupdate -divider <NULL>
add wave -noupdate /alu_tb/dut/b
add wave -noupdate -divider <NULL>
add wave -noupdate /alu_tb/dut/y
add wave -noupdate -divider <NULL>
add wave -noupdate -radix binary /alu_tb/dut/zero
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {221 ns}
