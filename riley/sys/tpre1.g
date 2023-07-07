; tpre0.g
; called before tool 0 is selected

;Ensure no tool is selected
;T-1

;Set tool detect switch trigger
; M581 T2 P0 S0

; Check tool detect switch
;M98 tooldetectpre.g"

;Unlock Coupler
M98 P"/macros/Tool Control/Coupler - Unlock"

M564 S0 ; allow movement outside the normal limits

var tool_x = 88.2
var tool_y = 216.4

var pickup_speed = 1000
var movein_speed = 5000
var movement_speed = 15000

;Move to location
G1 X{var.tool_x} Y{var.tool_y - 30} F{var.movement_speed}
;Move in
G1 Y{var.tool_y - 10} F{var.movein_speed}
;Collect
G1 Y{var.tool_y} F{var.pickup_speed}

;Close Coupler
M98 P"/macros/Tool Control/Coupler - Lock"

;WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
;if you are using non-standard length hotends ensure the bed is lowered enough BEFORE undocking the tool!
G91
G1 Z15 F1000
G1 Y-5 F1000
G90

; Check tool detect switch
;M98 tooldetectpost.g"

;Move Out
G1 Y{var.tool_y - 15} F{var.pickup_speed}
G1 Y{var.tool_y - 100} F{var.movein_speed}

; set Y max for this tool
M208 X-14:323 Y138

; apply the normal limits again
M564 S1
