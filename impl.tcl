# Setup dirs, parts and top entity
set out_dir "./.out/"
set build_dir "$out_dir/build"
set synth_dir "$out_dir/synth"
set impl_dir "$out_dir/impl"

file mkdir $build_dir
file mkdir $synth_dir
file mkdir $impl_dir

set prj vga_drv
set part xc7a100tcsg324-1
set top top

# Read files
read_vhdl [ glob ./src/*.vhdl ]
read_xdc ./src/constraints.xdc

# Synthesis
synth_design -top $top -part $part

# Implementation
opt_design
place_design
route_design

# Generate output and reports
write_bitstream -force $out_dir/$prj.bit

report_utilization -file "$impl_dir/${prj}_util.rpt"
report_timing_summary -file "$impl_dir/${prj}_timing.rpt"

exit