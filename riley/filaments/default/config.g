var tool = state.currentTool
var nozzleDiameter = global.nozzleDiameters[var.tool]
var extruderDrive = tools[var.tool].extruders[0]

M572 D{var.extruderDrive} S0.03