; tfree0.g
; called when tool 0 is freed

;Cancel tool detect switch trigger
; M581 T2 P-1

; Check tool detect switch
;M98 tooldetectpre.g"

;Drop the bed
if (move.axes[2].machinePosition < move.axes[2].max)
	G53 G1 Z{min(move.axes[2].machinePosition + 3, move.axes[2].max)} F2000

M564 S0 ; allow movement outside the normal limits

;mesh levelling off
G29 S2

var tool_x = 80.6
var tool_y = 226.8

var drop_off_speed = 2000
var movein_speed = 5000
var movement_speed = 15000

;Purge nozzle
if heat.heaters[2].active > heat.coldExtrudeTemperature
    ;M98 P"purge.g"
	G1 E-8 F300

;Move to location
G53 G1 X{var.tool_x} Y{var.tool_y - 60} F{var.movement_speed} ;Using machine coordinates
;Move in
G53 G1 Y{var.tool_y - 20} F{var.movein_speed} ;Using machine coordinates
;Deposit
G53 G1 Y{var.tool_y} F{var.drop_off_speed} ;Usimg machine coordinates

;Take a Photo
;M98 P"/macros/Camera"

;Open Coupler
M98 P"/macros/Tool Control/Coupler - Unlock"

;fan off
M106 P4 S0

; Check tool detect switch
G91
G1 Y-5 F1000
G90

;M98 tooldetectpost.g"

;Move Out
G53 G1 Y180 F10000

M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again

if (state.nextTool == -1)
	G53 G1 X154 Y200 F{var.movement_speed}
