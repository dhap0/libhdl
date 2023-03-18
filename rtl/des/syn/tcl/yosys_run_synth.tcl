puts "=================== Flow Vars ==================="

#set_flow_var cell_library_path "cmos_cells.lib" "Path to cell library"
set top_module "$env(TOP_MODULE)" 
set synth_out_dir "$env(SYNTH_OUT_DIR)"
set pre_map_out "./${synth_out_dir}/generated/${top_module}.pre_map.v"
set netlist_out "./${synth_out_dir}/generated/${top_module}_netlist.v"
set rpt_out "./${synth_out_dir}/reports"

yosys "read_verilog -sv $synth_out_dir/generated/*.v"

yosys "synth -top $top_module"
yosys "opt -purge"

yosys "write_verilog $pre_map_out"


#yosys "dfflibmap -liberty $synth_cell_library_path"
yosys "opt"


yosys "clean"
yosys "write_verilog $netlist_out"

#if { $lr_synth_timing_run } {
#  # Produce netlist that OpenSTA can use
#  yosys "setundef -zero"
#  yosys "splitnets"
#  yosys "clean"
#  yosys "write_verilog -noattr -noexpr -nohex -nodec $synth_sta_netlist_out"
#}

yosys "check"

yosys "write_json ./${synth_out_dir}/generated/design.json"
