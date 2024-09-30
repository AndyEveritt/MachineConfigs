; Check tool detect switch
G4 P0.15

; picking new tool up
if state.currentTool == -1
    if sensors.endstops[1].triggered == false
        M291 S2 P{"No tool on toolhead. Will set tool to T-1"} R"Tool Change Error"
        ;Unlock Coupler
        M98 P"/macros/Tool Control/Coupler - Unlock"
        M400
        T-1 P0
        M98 P"resetaxislimit.g"
        echo "applied normal limits"
        M564 S1								; apply the normal limits again
        ;abort "aborting"

; dropping tool at dock
else
    if sensors.endstops[1].triggered == true
        M291 S2 P{"Tool not docked properly. Will set tool to T-1"} R"Tool Change Error"
        ;Unlock Coupler
        M98 P"/macros/Tool Control/Coupler - Unlock"
        M400
        T-1 P0
        M98 P"resetaxislimit.g"
        echo "applied normal limits"
        M564 S1								; apply the normal limits again
        ;abort "aborting"
