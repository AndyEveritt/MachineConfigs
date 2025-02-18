; homez.g
; called to home the Z axis

M120                ; push stack
var motorCurrent = move.axes[2].current

G90
G1 X0 Y0 F27000 ; go to bed centre

G91 				; use relative positioning

M400 				; make sure everything has stopped before we change the motor currents
M906 Z500 		    ; drop motor currents

G1 H1 Z200 F5000 	; move stopping at the endstop

M400 				; make sure everything has stopped before we reset the motor currents
M906 Z{var.motorCurrent}    		; motor currents back to 100%

G1 H2 Z-3 F1200		; lift the bed
G90 				; back to absolute positioning

M121 				; pop stack
