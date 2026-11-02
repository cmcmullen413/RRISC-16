onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_DP_Memory/CLK
add wave -noupdate -expand -group A -radix hexadecimal /tb_DP_Memory/ADDR_A
add wave -noupdate -expand -group A -radix hexadecimal /tb_DP_Memory/IN_A
add wave -noupdate -expand -group A -radix hexadecimal /tb_DP_Memory/OUT_A
add wave -noupdate -expand -group A /tb_DP_Memory/WE_A
add wave -noupdate -expand -group B -radix hexadecimal /tb_DP_Memory/ADDR_B
add wave -noupdate -expand -group B -radix hexadecimal /tb_DP_Memory/IN_B
add wave -noupdate -expand -group B -radix hexadecimal /tb_DP_Memory/OUT_B
add wave -noupdate -expand -group B /tb_DP_Memory/WE_B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {128 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 83
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
WaveRestoreZoom {0 ps} {993 ps}
