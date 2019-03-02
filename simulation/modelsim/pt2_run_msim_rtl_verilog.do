transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/datapath.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/ALU.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/tristate.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/test_memory.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/SLC3_2.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/reg_file.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/reg_BEN.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/reg_16.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/NZP.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/MUX4to1.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/MUX2to1.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/Mem2IO.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/ISDU.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/HexDriver.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/slc3.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/memory_contents.sv}
vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/lab6_toplevel.sv}

vlog -sv -work work +incdir+C:/intelFPGA_lite/18.0/385/385lab6/pt2 {C:/intelFPGA_lite/18.0/385/385lab6/pt2/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 5000 ns
