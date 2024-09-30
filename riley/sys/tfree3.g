; tfree3.g
; called when tool 3 is freed

;Cancel tool detect switch trigger
; M581 T2 P-1

; Check tool detect switch
;M98 P"tooldetectpre.g"

;Drop the bed
var current_z = {move.axes[2].userPosition}

if (move.axes[2].machinePosition < move.axes[2].max)
	G53 G1 Z{min(move.axes[2].machinePosition + 3, move.axes[2].max)} F2000

M564 S0 ; allow movement outside the normal limits

;mesh levelling off
G29 S2

var tool_x = 308.4
var tool_y = 211.3

var drop_off_speed = 2000
var movein_speed = 5000
var movement_speed = 8000

;Move to location
G53 G1 X{var.tool_x - 60} Y{var.tool_y - 57} F{var.movement_speed} ; To avoid the brush
G53 G1 X{var.tool_x} F{var.movein_speed} ;Using machine coordinates
;Move in
G53 G1 Y{var.tool_y - 20} F{var.movein_speed} ;Using machine coordinates
;Deposit
G53 G1 Y{var.tool_y} F{var.drop_off_speed} ;Usimg machine coordinates

;Open Coupler
M98 P"/macros/Tool Control/Coupler - Unlock"

M98 P"scripts/setLedColor.g" R0 U0 B0

; Reset acceleration and speed limits
M203 X{global.prev_max_speed_x} Y{global.prev_max_speed_y} Z{global.prev_max_speed_z}        ; Set maximum speeds (mm/min)
M201 X{global.prev_max_accel_x} Y{global.prev_max_accel_y} Z{global.prev_max_accel_z}        ; Set accelerations (mm/s^2)

; Check tool detect switch
G91
;G1 Y-5 F1000
G90

M98 P"tooldetectpost.g"

;Move Out
G53 G1 Y180 F10000

M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again

if (state.nextTool == -1)
	G53 G1 X154 Y200 F{var.movement_speed}
	G53 G1 Z{var.current_z} F1000

echo {move.axes[2].userPosition}
