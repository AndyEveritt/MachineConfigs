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
;M98 P"purge.g"

;Drop the brush
;G1 B45 F5000

;Move In
G53 G1 X-12.5 Y150 F500
G53 G1 X-12.5 Y180 F500
G53 G1 X-12.5 Y210 F500
G53 G1 X-12.5 Y229.8 F100

;Take a Photo
;M98 P"/macros/Camera"

;Open Coupler
M98 P"/macros/Coupler - Unlock"

;fan off
M106 P2 S0

;Move Out
G53 G1 X-12.5 Y150 F100

M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again
