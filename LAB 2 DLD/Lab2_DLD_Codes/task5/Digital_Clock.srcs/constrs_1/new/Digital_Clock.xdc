############################################
## 7-SEGMENT SEGMENTS
############################################
set_property PACKAGE_PIN L18 [get_ports {CA}]
set_property PACKAGE_PIN T11 [get_ports {CB}]
set_property PACKAGE_PIN P15 [get_ports {CC}]
set_property PACKAGE_PIN K13 [get_ports {CD}]
set_property PACKAGE_PIN K16 [get_ports {CE}]
set_property PACKAGE_PIN R10 [get_ports {CF}]
set_property PACKAGE_PIN T10 [get_ports {CG}]
set_property IOSTANDARD LVCMOS33 [get_ports {CA CB CC CD CE CF CG}]

############################################
## DECIMAL POINT
############################################
set_property PACKAGE_PIN H15 [get_ports {DP}]
set_property IOSTANDARD LVCMOS33 [get_ports {DP}]

############################################
## 7-SEGMENT DIGIT ENABLE (ANODES)
############################################
set_property PACKAGE_PIN J17 [get_ports {AN[0]}]
set_property PACKAGE_PIN J18 [get_ports {AN[1]}]
set_property PACKAGE_PIN T9  [get_ports {AN[2]}]
set_property PACKAGE_PIN J14 [get_ports {AN[3]}]
set_property PACKAGE_PIN P14 [get_ports {AN[4]}]
set_property PACKAGE_PIN T14 [get_ports {AN[5]}]
set_property PACKAGE_PIN K2  [get_ports {AN[6]}]
set_property PACKAGE_PIN U13 [get_ports {AN[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[0] AN[1] AN[2] AN[3] AN[4] AN[5] AN[6] AN[7]}]

############################################
## CLOCK
############################################
set_property PACKAGE_PIN E3 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -period 10.0 -name sys_clk_pin [get_ports {clk}]

############################################
## RESET BUTTON
############################################
set_property PACKAGE_PIN C12 [get_ports {rst}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst}]