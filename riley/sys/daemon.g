while true
;----------------------------------------------------------------------------------------------------------------------
; Temperature LED Indicator
;----------------------------------------------------------------------------------------------------------------------
    var minTemp = 0
    var maxTemp = 350
    var targetTemp = 0
    var currentTemp = 0
    var tool = state.currentTool

    if (var.tool == -1)
        set var.maxTemp = heat.heaters[0].max
        set var.currentTemp = heat.heaters[0].current
        if (heat.heaters[0].state == "active")
            set var.targetTemp = heat.heaters[0].active
        elif (heat.heaters[0].state == "standby")
            set var.targetTemp = heat.heaters[0].standby

    else
        if exists(tools[var.tool].heaters[0])
            var heater = tools[var.tool].heaters[0]
            set var.maxTemp = heat.heaters[var.heater].max
            set var.currentTemp = heat.heaters[var.heater].current
            if (heat.heaters[var.heater].state == "active")
                set var.targetTemp = heat.heaters[var.heater].active
            elif (heat.heaters[var.heater].state == "standby")
                set var.targetTemp = heat.heaters[var.heater].standby
        
    ; echo "Tool:", var.tool, "Target:", var.targetTemp, "Current:", var.currentTemp, "Max:", var.maxTemp

    var RGB = {0, 0, 0}

    if (var.targetTemp > 0 || var.currentTemp > 30)
        if (var.currentTemp >= var.targetTemp)
            var ratio = (var.currentTemp - var.targetTemp) / (var.maxTemp - var.targetTemp)
            set var.RGB[0] = var.ratio                  ; red
            set var.RGB[1] = (1 - var.ratio) * 0.2      ; green
        elif (var.currentTemp < var.targetTemp)
            var ratio = (var.currentTemp) / (var.targetTemp)
            set var.RGB[1] = var.ratio * 0.2            ; green
            set var.RGB[2] = 1 - var.ratio              ; blue

    set var.RGB[0] = floor(var.RGB[0] * 255)
    set var.RGB[1] = floor(var.RGB[1] * 255)
    set var.RGB[2] = floor(var.RGB[2] * 255)
    ; echo "RGB:", var.RGB

    M150 E0 R{var.RGB[0]} U{var.RGB[1]} B{var.RGB[2]} P50 S1 F0


;----------------------------------------------------------------------------------------------------------------------
; Tool Fans
;----------------------------------------------------------------------------------------------------------------------
    var tools = {0, 1}
    while (iterations < #var.tools)
        if (var.tool != var.tools[iterations])
            var heater = tools[var.tools[iterations]].heaters[0]
            var fan = tools[var.tools[iterations]].fans[0]
            set var.currentTemp = heat.heaters[var.heater].current
            if (var.currentTemp > 80 && var.currentTemp > tools[var.tools[iterations]].standby[0] + 1)
                M106 P{var.fan} S255
            else
                M106 P{var.fan} S0


;----------------------------------------------------------------------------------------------------------------------

    G4 P2
