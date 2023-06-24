var tool = {param.T}
var increment = -{param.Z}
var current_height = {move.axes[2].userPosition}

if var.tool==0 | var.tool==1
	G10 P{var.tool} Z{tools[{var.tool}].offsets[2] + var.increment}
	echo "T",{var.tool}, " Z offset: ", {tools[{var.tool}].offsets[2]}
else
	echo {var.tool}, " is not a valid tool number"

if {state.currentTool}=={var.tool}
	G1 Z{var.current_height} F1000

M500 P10