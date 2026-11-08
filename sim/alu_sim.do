vlib work
vcom src/alu.vhd
vsim work.alu
add wave -radix binary /alu/*
force A 00001001
force B 00000000
force OP 000
run 100 ns
force OP 001
run 100 ns
force OP 010
run 100 ns
force OP 011
run 100 ns
force OP 100
run 100 ns
force OP 101
run 100 ns
force OP 110
run 100 ns
force OP 111
run 100 ns
wave zoom full
