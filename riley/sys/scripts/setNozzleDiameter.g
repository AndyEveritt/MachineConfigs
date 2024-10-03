var tool = exists(param.T) ? param.T : max(state.currentTool, 0)
var newDiameters = global.nozzleDiameters
set var.newDiameters[var.tool] = param.D

var newHF = global.nozzleHF
var highFlow = exists(param.H) ? param.H > 0 : global.nozzleHF[var.tool]
set var.newHF[var.tool] = var.highFlow

echo "Setting T"^{var.tool}^" nozzle to "^{var.highFlow ? "HF " : ""}^{var.newDiameters[var.tool]}^"mm"

M98 P"scripts/persistentglobal.g" V"nozzleDiameters" X{var.newDiameters}
M98 P"scripts/persistentglobal.g" V"nozzleHF" X{var.newHF}
