# Clock constraint for 100 MHz clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0 5} [get_ports clk]

# Reset button
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Button constraints
set_property PACKAGE_PIN T17 [get_ports btnL]
set_property IOSTANDARD LVCMOS33 [get_ports btnL]

set_property PACKAGE_PIN U17 [get_ports btnR]
set_property IOSTANDARD LVCMOS33 [get_ports btnR]

set_property PACKAGE_PIN V17 [get_ports btnU]
set_property IOSTANDARD LVCMOS33 [get_ports btnU]

set_property PACKAGE_PIN W17 [get_ports btnD]
set_property IOSTANDARD LVCMOS33 [get_ports btnD]

# Speaker output
set_property PACKAGE_PIN A17 [get_ports speaker]
set_property IOSTANDARD LVCMOS33 [get_ports speaker]
set_property DRIVE 12 [get_ports speaker]
set_property SLEW SLOW [get_ports speaker]
