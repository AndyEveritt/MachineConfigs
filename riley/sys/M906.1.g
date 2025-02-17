var extruder = {param.E}
var value = {param.S}

echo "E"^{var.extruder}, "V"^{var.value}

var currents = {move.extruders[0].current, move.extruders[1].current}

set var.currents[var.extruder] = var.value
M906 E{var.currents}
M906