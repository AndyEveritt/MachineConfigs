; homex.g
; called to home the x axis
; DC42 reduced stall sensitivity from 4 to 2
; DC42 replaced G1 S parameters by H
; DC42 removed redundant G4 and M574 commands

; Check tool detect switch
; if sensors.gpIn[0] != null && sensors.gpIn[0].value = 1
;     M291 S1 T5 P{"Please return tool to dock before homing"} R"Cannot home"
;     abort

G91 				; use relative positioning

;G1 H2 X0.5 Y0.5 F10000	; energise motors to ensure they are not stalled

M400 				; make sure everything has stopped before we change the motor currents
M913 X20 Y20 		; drop motor currents to 25%

G1 H2 Z3 F5000		; Lower the bed
G1 H1 X-400 F5000 	; move left 400mm, stopping at the endstop
G1 H1 X2 F2000 	; move away from end
G1 H2 Z-3 F1200		; lift the bed
G90 				; back to absolute positioning

M400 				; make sure everything has stopped before we reset the motor currents
M913 X100 Y100 		; motor currents back to 100%
