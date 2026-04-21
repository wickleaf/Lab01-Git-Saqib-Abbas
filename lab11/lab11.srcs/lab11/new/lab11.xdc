set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 20.000 -name sys_clk_pin -waveform {0.000 10.000} [get_ports clk]

set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property IOSTANDARD LVCMOS33 [get_ports {out_PC[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_ALUResult[*]}]