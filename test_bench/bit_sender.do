cd ~/git/VGA_Ambilight/test_bench
vlib work
vmap work work
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/source/functions.vhd 
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/source/bit_sender.vhd
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/test_bench/bit_sender_tb.vhd
vsim work.bit_sender_tb
add wave *
add wave -position insertpoint  sim:/bit_sender_tb/DUT/r_data_in_reg
configure wave -timelineunits ns
force -freeze sim:/bit_sender_tb/i_clk 1 0, 0 {10 ns} -r 20000
run 60 us
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
WaveRestoreZoom {0 ps} {60 us}