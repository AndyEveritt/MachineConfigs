; tpre.g
; called before tool N is selected

;Ensure no tool is selected
;T-1

;Set tool detect switch trigger
; M581 T2 P0 S0

; Check tool detect switch
M98 P"tooldetectpre.g"

if !move.axes[2].homed
    T-1 P0
    M99 "Aborting tool change because Z axis not homed"

M98 P"scripts/maybehome.g" X1 Y1 C1 B1
;M98 P"scripts/maybehome.g" Z1

;Unlock Coupler
M98 P"/macros/Tool Control/Coupler - Unlock"

M564 S0 ; allow movement outside the normal limits

var tool_x = param.X
var tool_y = param.Y

var pickup_speed = 1000
var movein_speed = 10000
var movement_speed = 24000

;Move to location
G1 X{var.tool_x} Y{var.tool_y - 30} F{var.movement_speed}
;Move in
G1 Y{var.tool_y - 10} F{var.movein_speed}
;Collect
G1 Y{var.tool_y} F{var.pickup_speed}

;Close Coupler
M98 P"/macros/Tool Control/Coupler - Lock"

M98 P"scripts/setLedColor.g" R255 U255 B255

;WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
;if you are using non-standard length hotends ensure the bed is lowered enough BEFORE undocking the tool!
G91
G1 Z15 F1000
G1 Y-5 F1000
G90

; Check tool detect switch
M98 P"tooldetectpost.g"

;Move Out
G1 Y{var.tool_y - 15} F{var.pickup_speed}
G1 Y{var.tool_y - 100} F{var.movein_speed}

; Check tool detect switch
M98 P"tooldetectpost.g"

; apply the normal limits again
M564 S1
