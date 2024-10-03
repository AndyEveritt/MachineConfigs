var tool = exists(param.T) ? param.T : max(state.currentTool, 0)
var newDiameters = global.nozzleDiameters
set var.newDiameters[var.tool] = param.D

M98 P"persistantglobal.g" V"nozzleDiameters" X{var.newDiameters}
