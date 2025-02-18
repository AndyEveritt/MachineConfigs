; homex.g
; called to home the x axis

var motorCurrent = move.axes[0].current
var zCurrent = move.axes[2].current
var zPos = move.axes[2].userPosition

M120                ; push stack
G91 				; use relative positioning

G1 H2 X0.05 F10000	; energise motors to ensure they are not stalled

M400 				; make sure everything has stopped before we change the motor currents
M906 X350 Z300 		    ; drop motor currents

G1 H4 Z3 F5000		; move Z, stopping motion if stall detected
G1 H1 X-200 F5000 	; move stopping at the endstop
G1 X2 F2000 	    ; move away from end
G1 H1 X-200 F5000 	; move stopping at the endstop
G1 X2 F2000 	    ; move away from end
G90 				; back to absolute positioning
G1 H2 Z{var.zPos} F1200		; return to original Z position

M400 				; make sure everything has stopped before we reset the motor currents
M906 X{var.motorCurrent} Z{var.zCurrent}    		; motor currents back to 100%

G1 X0 F5000
M121 				; pop stack