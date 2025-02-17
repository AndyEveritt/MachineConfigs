; stop.g
; called when M0 (Stop) is run e.g. when a print completes
T-1

; Turn off heaters
G10 P0 R0 S0
G10 P1 R0 S0
M140 S-273.1

; Move to park position
G91 G1 Z20 F600
M98 P"/macros/Park"
