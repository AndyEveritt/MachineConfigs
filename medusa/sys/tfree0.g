; tfree0.g
; called when tool 0 is freed

;Drop the bed
G91
G1 Z4 F1000
G90

M564 S0 ; allow movement outside the normal limits

G29 S2 ;mesh levelling off

;Purge nozzle
if heat.heaters[1].active > heat.coldExtrudeTemperature
	M98 P"purger.g"

;Move to location
G53 G1 X-6 Y150 F10000 ;Using machine coordinates
;Move in
G53 G1 X-6 Y215 F2000 ;Using machine coordinates
;Deposit
G53 G1 X-6 Y226.3 F2000 ;Usimg machine coordinates

;Open Coupler
M98 P"/macros/Coupler - Unlock"

;fan off
M106 P1 S0

;Move Out
G53 G1 X-6 Y150 F3000

M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again
