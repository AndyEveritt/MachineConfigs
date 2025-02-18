; Drive Mappings: smart drivers
M569 P0.0 S1 D2         ; Drive 1 goes backward: X Axis
M569 P0.1 S0 D2         ; Drive 1 goes backwards: Y Axis
M569 P0.2 S0 D2         ; Drive 2 goes backwards: Z Z Axis
M569 P0.3 S1 D2         ; Drive 3 goes forwards: E0
M569 P0.4 S0 D2         ; Drive 4 goes anti-clockwise: U Axis
M569 P0.5 S1 D2         ; Drive 5 goes anti-clockwise: V Axis

M584 X0.0 Y0.1 Z0.2 E0.3 ; My Driver Mapping
M584 U0.4 V0.5 R1