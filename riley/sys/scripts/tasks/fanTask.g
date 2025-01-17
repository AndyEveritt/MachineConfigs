;----------------------------------------------------------------------------------------------------------------------
; Tool Fans
;----------------------------------------------------------------------------------------------------------------------

var tools = {0, 1}
var currentTool = state.currentTool
var threshold = 60
var tolerance = 1

while (iterations < #var.tools)
    if (var.currentTool == var.tools[iterations])
        continue

    var heater = tools[var.tools[iterations]].heaters[0]
    var fan = tools[var.tools[iterations]].fans[0]
    var currentTemp = heat.heaters[var.heater].current
    if (var.currentTemp > var.threshold && var.currentTemp > tools[var.tools[iterations]].standby[0] + var.tolerance)
        M106 P{var.fan} S255
    else
        M106 P{var.fan} S0