; tfree0.g
; called when tool 0 is freed

;Drop the bed
G91
G1 Z4 F1000
G90

M564 S0 ; allow movement outside the normal limits

;mesh levelling off
G29 S2

;Purge nozzle
M98 P"purge.g"

;Move In
G53 G1 X-9 Y150 F1000
G53 G1 X-9 Y180 F1000
G53 G1 X-9 Y210 F1000
G53 G1 X-9 Y226.2 F500

;Take a Photo
;M98 P"/macros/Camera"

;Open Coupler
M98 P"/macros/Coupler - Unlock"

;fan off
M106 P2 S0

;Move Out
G53 G1 X-9 Y150 F500

M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again
