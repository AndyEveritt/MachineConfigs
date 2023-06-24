; homey.g
; called to home the Y axis

; Check tool detect switch
; if sensors.gpIn[0] != null && sensors.gpIn[0].value = 1
;     M291 S1 T5 P{"Please return tool to dock before homing"} R"Cannot home"
;     abort

M400 				; make sure everything has stopped before we change the motor currents
M913 X25 Y25 		; drop motor currents to 20%
M564 S0 ; allow movement outside the normal limits
G91 				; use relative positioning
G1 H2 X0.5 Y-0.5 F8000	; energise motors and move them 0.5mm in the +Y direction to ensure they are not stalled
G1 H2 Z3 F5000		; lower bed 3mm
G1 H1 Y-400 F5000 	; move to the front 400mm, stopping at the endstop
G1 Y2 F2000 		; move away from end
G1 H1 Y-400 F3000 	; move to the front 400mm, stopping at the endstop
G1 H2 Z-3 F1200		; lift bed
G90 				; back to absolute positioning

M400 				; make sure everything has stopped before we reset the motor currents
M913 X100 Y100 		; motor currents back to 100%
M564 S1								; apply the normal limits again
