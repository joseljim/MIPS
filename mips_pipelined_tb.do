onerror {resume}
vlib work
vmap work
vlog -sv defs.sv
vlog -sv alu.sv
vlog -sv controller.sv
vlog -sv extender.sv
vlog -sv instruction_decoder.sv
vlog -sv mips_pipelined.sv
vlog -sv mips_pipelined_tb.sv
vlog -sv mux2.sv
vlog -sv mux4.sv
vlog -sv next_pc_select.sv
vlog -sv ram.sv
vlog -sv regfile.sv
vlog -sv rom.sv
vsim work.mips_pipeline_tb
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_pipeline_tb/clk
add wave -noupdate -radix hexadecimal /mips_pipeline_tb/dut_mips/instruction
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[1]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[2]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[3]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[4]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[5]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[6]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[7]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[8]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[9]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[10]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[11]}
add wave -noupdate -radix hexadecimal {/mips_pipeline_tb/dut_mips/regfile0/mem[12]}
add wave -noupdate -radix hexadecimal {/mips_pipeline_tb/dut_mips/regfile0/mem[13]}
add wave -noupdate -radix hexadecimal {/mips_pipeline_tb/dut_mips/regfile0/mem[14]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[15]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[16]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[17]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[18]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[19]}
add wave -noupdate -radix hexadecimal {/mips_pipeline_tb/dut_mips/regfile0/mem[20]}
add wave -noupdate -radix hexadecimal {/mips_pipeline_tb/dut_mips/regfile0/mem[21]}
add wave -noupdate -radix hexadecimal {/mips_pipeline_tb/dut_mips/regfile0/mem[22]}
add wave -noupdate -radix hexadecimal {/mips_pipeline_tb/dut_mips/regfile0/mem[23]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/regfile0/mem[24]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/ram0/mem[50]}
add wave -noupdate -radix decimal {/mips_pipeline_tb/dut_mips/ram0/mem[51]}
add wave -noupdate -radix unsigned /mips_pipeline_tb/dut_mips/pc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {571571 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 270
configure wave -valuecolwidth 40
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
configure wave -timelineunits ps
update
WaveRestoreZoom {550668 ps} {602596 ps}
run 1200ns