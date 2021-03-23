; Check tool detect switch

; picking new tool up
if state.currentTool == -1
    if sensors.gpIn[0] != null && sensors.gpIn[0].value == 1
        M291 S3 P{"Another tool already on tool head. Will set tool to T-1"} R"Tool Change Error"
        ;Unlock Coupler
        M98 P"/macros/Tool Control/Coupler - Unlock"
        M400
        T-1 P0
        M98 P"resetaxislimit.g"
        echo "applied normal limits"
        M564 S1								; apply the normal limits again
        abort "aborting"
    

; dropping tool at dock
else
    if sensors.gpIn[0] != null && sensors.gpIn[0].value == 0
        M291 S3 P{"No tool on toolhead. Will set tool to T-1"} R"Tool Change Error"
        ;Unlock Coupler
        M98 P"/macros/Tool Control/Coupler - Unlock"
        M400
        T-1 P0
        M98 P"resetaxislimit.g"
        echo "applied normal limits"
        M564 S1								; apply the normal limits again
        abort "aborting"