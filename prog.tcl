set out_dir "./.out/"
set prj vga_drv
set device xc7a100t_0

open_hw_manager
connect_hw_server -allow_non_jtag

open_hw_target

current_hw_device [get_hw_devices $device]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices $device] 0]

set_property PROBES.FILE {} [get_hw_devices $device]
set_property FULL_PROBES.FILE {} [get_hw_devices $device]
set_property PROGRAM.FILE "$out_dir/$prj.bit" [get_hw_devices $device]
program_hw_devices [get_hw_devices $device]

exit