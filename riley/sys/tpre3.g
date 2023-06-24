; tpre3.g
; called before tool 3 is selected

;Ensure no tool is selected
;T-1

;Set tool detect switch trigger
; M581 T2 P0 S0

; Check tool detect switch
;M98 tooldetectpre.g"

;Unlock Coupler
M98 P"/macros/Tool Control/Coupler - Unlock"

M564 S0 ; allow movement outside the normal limits

var tool_x = 308.4
var tool_y = 211.3

var pickup_speed = 2000
var movein_speed = 5000
var moveout_speed = 5000
var movement_speed = 15000

;Move to location
G1 X{var.tool_x} Y{var.tool_y - 30} F{var.movement_speed}
;Move in
G1 Y{var.tool_y - 10} F{var.movein_speed}
;Collect
G1 Y{var.tool_y} F{var.pickup_speed}

;Close Coupler
M98 P"/macros/Tool Control/Coupler - Lock"

set global.prev_max_speed_x = {move.axes[0].speed}
set global.prev_max_speed_y = {move.axes[1].speed}
set global.prev_max_speed_z = {move.axes[2].speed}
set global.prev_max_accel_x = {move.axes[0].acceleration}
set global.prev_max_accel_y = {move.axes[1].acceleration}
set global.prev_max_accel_z = {move.axes[2].acceleration}
;set global.prev_z_height = {move.axes[2].userPosition}

M203 X6000 Y6000 Z1000        ; Set maximum speeds (mm/min)
M201 X1000 Y1000 Z100      	  ; Set accelerations (mm/s^2)

;WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
;if you are using non-standard length hotends ensure the bed is lowered enough BEFORE undocking the tool!
var z_clearance = 130
if {move.axes[2].machinePosition + {var.z_clearance} < move.axes[2].max}
	G91
	G1 Z{var.z_clearance} F1000
	G90
else
	M291 S2 P"Bed can not move low enough. Risk of collision with part!" R"Risk of collision with part!"
	abort
	;G1 Z{move.axes[2].max} F1000

; Check tool detect switch
;M98 tooldetectpost.g"

;Move Out
G1 B10										; Move brush to clearance position
G1 Y{var.tool_y - 15} F{var.pickup_speed}
G1 Y{var.tool_y - 57} F{var.moveout_speed}
G1 X{var.tool_x - 60} F{var.moveout_speed}

; set Y max for this tool
M208 X19:282 Y-48:120 B0:10

; apply the normal limits again
M564 S1
