; homez.g
; called to home the Z axis

M98 P"/macros/Coupler - Unlock"	;Open Coupler

G91 				; Relative mode
G1 H2 Z5 F5000			; Lower the bed
G90				; back to absolute positioning

G1 X150 Y100 F10000		; Position the endstop above the bed centre

M564 S0

G91 				; Relative mode
G30
;G4 P500				; wait 500msec
;G1 H1 Z-300 F1000		; Move Z down until the switch triggers (first pass)

;G4 P500				; wait 500msec
;G1 Z5 F5000			; Lift Z

;G4 P500				; wait 500msec
;G1 H1 Z-300 F300		; Move Z down until the switch triggers (second pass)

G4 P500				; wait 500msec
G1 Z5 F5000			; Drop the Bed

G90				; Back to absolute positioning
G29 S1			; load height map

M564 S1
