; tfree0.g
; called when tool 0 is freed

;Drop the bed
G91
G1 Z4 F1000
G90

;mesh levelling off
G29 S2

;Purge nozzle
M98 Ppurgeb.g

;Drop the brush
;G1 B45 F5000

;Move In
G53 G1 X-12.5 Y150 F50000
G53 G1 X-12.5 Y180 F50000
G53 G1 X-12.5 Y210 F50000
G53 G1 X-12.5 Y228.25 F5000

;Take a Photo
M98 P/macros/Camera

;Open Coupler
M98 P/macros/Coupler - Unlock

;fan off
M106 P2 S0

;Move Out
G53 G1 X-12.5 Y150 F50000
