cd ~/git/VGA_Ambilight/test_bench
vlib work
vlib altera
vmap work work
vcom -2008 -reportprogress 300 -work work /home/imants/git/VGA_Ambilight/source/ram2port/ram2port.vhd
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/source/functions.vhd 
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/source/led_ram.vhd
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/source/sender_fsm.vhd
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/source/bit_sender.vhd
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/source/output_module.vhd
vcom -2008 -reportprogress 300 -work work ~/git/VGA_Ambilight/test_bench/output_module_tb.vhd
vsim work.output_module_tb
add wave -position insertpoint  sim:/output_module_tb/i_clk
add wave *
add wave -position insertpoint  sim:/output_module_tb/DUT/sender_fsm_inst/state_reg
add wave -radix hexadecimal -position insertpoint  sim:/output_module_tb/DUT/sender_fsm_inst/r_timer_reg
add wave -radix hexadecimal -position insertpoint  sim:/output_module_tb/DUT/sender_fsm_inst/r_count_reg
add wave -radix hexadecimal -position insertpoint  sim:/output_module_tb/DUT/led_ram_inst/o_data
add wave -radix hexadecimal -position insertpoint  sim:/output_module_tb/DUT/led_ram_inst/i_rd_addr
add wave -radix hexadecimal -position insertpoint  sim:/output_module_tb/DUT/sender_fsm_inst/i_active_leds
force -freeze sim:/output_module_tb/DUT/sender_fsm_inst/i_active_leds 0000001000 0
add wave -radix hexadecimal -position insertpoint  sim:/output_module_tb/DUT/bit_sender_inst/r_data_in_reg
add wave -position end  sim:/output_module_tb/DUT/bit_sender_inst/w_en_data_in
configure wave -timelineunits ns
force -freeze sim:/output_module_tb/i_clk 1 0, 0 {10 ns} -r 20000
run 500 us
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
WaveRestoreZoom {0 ps} {60 us}