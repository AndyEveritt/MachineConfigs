; homeb.g
; called to home the brush axis

M400 			; make sure everything has stopped before we make changes

M574 B2 S3      ;has to be here, doesn't work if just in config
M915 H200 B S10 R0 F0 	; set B to sensitivity 15, do nothing when stall, unfiltered

M913 B35 		; drop motor currents to 25%

G91 			; use relative positioning
G1 H1 B65 F10000 	; move to the bottom
G1 H2 B-1 F1200		; back up 1mm
G90 			; back to absolute positioning

M400 			; make sure everything has stopped before we reset the motor currents
G4 P100			; wait 400ms
M913 B100 		; motor currents back to 100%

;G1 B50 F1200		; Move brush down (out of the way)