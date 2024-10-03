var tool = state.currentTool
var nozzleDiameter = global.nozzleDiameters[var.tool]
var extruderDrive = tools[var.tool].extruders[0]

if (var.nozzleDiameter == 0.6)
    M572 D{var.extruderDrive} S0.01
else
    M572 D{var.extruderDrive} S0.03