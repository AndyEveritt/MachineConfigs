; homey.g
; called to home the Y axis

M400 				; make sure everything has stopped before we change the motor currents
M913 X20 Y20 		; drop motor currents to 20%
M564 S0 ; allow movement outside the normal limits
G91 				; use relative positioning
G1 H2 X0.5 Y-0.5 F10000	; energise motors and move them 0.5mm in the +Y direction to ensure they are not stalled
G1 H2 Z3 F5000		; lower bed 3mm
G1 H1 Y-400 F3000 	; move to the front 400mm, stopping at the endstop
G1 Y2 F2000 		; move away from end
G1 H2 Z-3 F1200		; lift bed
G90 				; back to absolute positioning

M400 				; make sure everything has stopped before we reset the motor currents
M913 X100 Y100 		; motor currents back to 100%
M564 S1								; apply the normal limits again
