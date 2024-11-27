var tool = state.currentTool
var nozzleDiameter = global.nozzleDiameters[var.tool]
var extruderDrive = tools[var.tool].filamentExtruder

if (global.nozzleHF[var.tool])
    if (var.nozzleDiameter <= 0.25)
        M572 D{var.extruderDrive} S{global.defaultPA}
    elif (var.nozzleDiameter <= 0.4)
        M572 D{var.extruderDrive} S0.02
    elif (var.nozzleDiameter <= 0.6)
        M572 D{var.extruderDrive} S{global.defaultPA}
    elif (var.nozzleDiameter <= 0.8)
        M572 D{var.extruderDrive} S{global.defaultPA}
    else
        M572 D{var.extruderDrive} S{global.defaultPA}
else
    if (var.nozzleDiameter <= 0.25)
        M572 D{var.extruderDrive} S{global.defaultPA}
    elif (var.nozzleDiameter <= 0.4)
        M572 D{var.extruderDrive} S{global.defaultPA}
    elif (var.nozzleDiameter <= 0.6)
        M572 D{var.extruderDrive} S{global.defaultPA}
    elif (var.nozzleDiameter <= 0.8)
        M572 D{var.extruderDrive} S{global.defaultPA}
    else
        M572 D{var.extruderDrive} S{global.defaultPA}