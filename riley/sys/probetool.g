var tool = {param.T}

if var.tool==0 | var.tool==1
	T{var.tool}
	G29 S2						; mesh levelling off
	G91
	G1 Z5 F1000
	G90
	;M98 P"brush.g"
	;G1 X290 Y20 F10000
	G30 K1 S-2
	G1 Z5 F1000
	M500 P10
	G10 P{state.currentTool}
	G29 S1						; mesh levelling on
else
	echo {var.tool}, " is not a valid tool number"
