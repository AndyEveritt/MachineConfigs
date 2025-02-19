; Resume macro file
M83

while (iterations < #heat.heaters)
    if (heat.heaters[iterations].state == "fault")
        M291 R"Resuming" P{"Heater " ^ iterations ^ " is faulted, reset fault"} S4 K{"Abort", "Reset Fault"}
        if (input == 0)
            abort
        if (input == 1)
            echo "Reseting heater", iterations, "fault..."
            M562 P{iterations}

while (iterations < #tools)
    var state = tools[iterations].state
    if (var.state == "active")
        M568 P{iterations} A2
    elif (var.state == "standby")
        M568 P{iterations} A1
    else
        M568 P{iterations} A0

M116 ; wait for temperatures to restore
if {state.currentTool} != -1
    M98 P"prime.g"
G1 R1 X0 Y0 Z2 F5000 ; go to 5mm above position of the last print move
G1 R1 X0 Y0 Z0 ; go back to the last print move
;if {state.currentTool} != -1
;    G1 E3 F3600 ; extrude 3mm of filament