var tool = exists(param.T) ? param.T : max(state.currentTool, 0)
var currentDiameter = global.nozzleDiameters[var.tool]
var newDiameter = param.D
var highFlow = exists(param.H) ? param.H : global.nozzleHF[var.tool]

if (var.newDiameter != var.currentDiameter || var.highFlow != global.nozzleHF[var.tool]) 
    if (var.currentDiameter == null)
        M291 S3 P{"Print uses "^{var.highFlow ? "HF " : ""}^{var.newDiameter}^"mm nozzle, but tool "^{var.tool}^" has no nozzle installed. Continue anyway?"} R"Incorrect Nozzle Diameter"
    else
        M291 S3 P{"Print uses "^{var.highFlow ? "HF " : ""}^{var.newDiameter}^"mm nozzle, but tool "^{var.tool}^" has "^{var.highFlow ? "HF " : ""}^{var.currentDiameter}^"mm nozzle installed. Continue anyway?"} R"Incorrect Nozzle Diameter"

    M98 P"scripts/setNozzleDiameter.g" T{var.tool} D{var.newDiameter} H{var.highFlow}
