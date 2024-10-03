; tfree.g
; called when tool N is freed

;Cancel tool detect switch trigger
; M581 T2 P-1

; Check tool detect switch
M98 P"tooldetectpre.g"

;Drop the bed
if (move.axes[2].machinePosition < move.axes[2].max)
	G53 G1 Z{min(move.axes[2].machinePosition + 3, move.axes[2].max)} F2000

;mesh levelling off
G29 S2

var tool_x = param.X
var tool_y = param.Y

var drop_off_speed = 1000
var movein_speed = 10000
var movement_speed = 24000

;Purge nozzle
if job.file.fileName != null
    ;M98 P"purge.g"
	G1 E-8 F900

;Move to location
G53 G1 X{var.tool_x} Y{var.tool_y - 80} F{var.movement_speed} ;Using machine coordinates

M564 S0 ; allow movement outside the normal limits

;Move in
G53 G1 Y{var.tool_y - 20} F{var.movein_speed} ;Using machine coordinates
;Deposit
G53 G1 Y{var.tool_y} F{var.drop_off_speed} ;Usimg machine coordinates

;Take a Photo
;M98 P"/macros/Camera"

;Open Coupler
M98 P"/macros/Tool Control/Coupler - Unlock"

M98 P"scripts/setLedColor.g" R0 U0 B0

; Check tool detect switch
G91
G1 Y-5 F{var.drop_off_speed}
G90
M98 P"tooldetectpost.g"

;Move Out
G53 G1 Y180 F{var.movein_speed}

M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again

;fan off
;M106 P2 S0

if (state.nextTool == -1)
	G53 G1 X154 Y200 F{var.movement_speed}
