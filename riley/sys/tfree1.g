; tfree0.g
; called when tool 0 is freed

;Cancel tool detect switch trigger
; M581 T2 P-1

; Check tool detect switch
M98 P"tooldetect.g"

;Drop the bed
G91
G1 Z4 F1000
G90

M564 S0 ; allow movement outside the normal limits

;mesh levelling off
G29 S2

;Purge nozzle
if heat.heaters[2].active > heat.coldExtrudeTemperature
    M98 P"purge.g"

;Move In
G53 G1 X81.1 Y150 F5000
G53 G1 X81.1 Y180 F5000
G53 G1 X81.1 Y210 F5000
G53 G1 X81.1 Y226.8 F2000

;Take a Photo
;M98 P"/macros/Camera"

;Open Coupler
M98 P"/macros/Tool Control/Coupler - Unlock"

;fan off
M106 P2 S0

;Move Out
G53 G1 X81.1 Y150 F2000

M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again
