; homey.g
; called to home the Y axis

G91 			; use relative positioning

G1 H2 X-1 Y1

M400 			; make sure everything has stopped before we make changes

M913 X20 Y20 		; drop motor currents to 25%
M915 X Y S3 F0 H280 R0  	; set X and Y to sensitivity 1, do nothing when stall, unfiltered


G1 H2 Z3 F5000		; lift Z 3mm
G1 H1 Y-400 F3000 	; move to the front 400mm, stopping at the endstop
G1 H1 Y2 F2000 		; move away from end
G1 H2 Z-3 F1200		; lower Z
G90 			; back to absolute positioning

M400 			; make sure everything has stopped before we reset the motor currents
M913 X100 Y100 		; motor currents back to 100%
G4 P100			; wait 400ms
