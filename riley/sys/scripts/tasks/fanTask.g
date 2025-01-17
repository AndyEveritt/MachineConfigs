;----------------------------------------------------------------------------------------------------------------------
; Tool Fans
;----------------------------------------------------------------------------------------------------------------------
echo "Running tool fans task"

var tools = {0, 1}
var tool = state.currentTool

while (iterations < #var.tools)
    if (var.tool != var.tools[iterations])
        var heater = tools[var.tools[iterations]].heaters[0]
        var fan = tools[var.tools[iterations]].fans[0]
        var currentTemp = heat.heaters[var.heater].current
        if (var.currentTemp > 80 && var.currentTemp > tools[var.tools[iterations]].standby[0] + 1)
            M106 P{var.fan} S255
        else
            M106 P{var.fan} S0