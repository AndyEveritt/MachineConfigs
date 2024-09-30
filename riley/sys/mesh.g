T-1
G29 S2

G91
G1 Z5 F6000
G90

var probe = 1
if exists(param.K)
  set var.probe = param.K

G1 X150 Y100 F20000
G30
if var.probe=1
  G1 Z6  ; to avoid backlash
  M558.1 K{var.probe} S1.7
G29 S0 K{var.probe}
M98 P"/macros/Park"