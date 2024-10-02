; homeb.g
; called to home the brush axis

M400 			; make sure everything has stopped before we make changes

M915 H200 B S5 R0 F0 	; set B to sensitivity 15, do nothing when stall, unfiltered......Disabled as EB3HC does not support motor stall

G91 			; use relative positioning
G1 H2 B-1 F3000		; make sure not at bottom of axis, won't move at low current otherwise
M913 B80; drop motor currents

G1 H1 B65 F3000 	; move to the bottom
var lastHome = move.axes[3].machinePosition
;echo "B =", var.lastHome

while true
    G1 H2 B-5 F1000		; back up 5mm
    G1 H4 B65 F3000 	; move to the bottom
    if abs(move.axes[3].machinePosition - var.lastHome) < 0.1
        break
    set var.lastHome = move.axes[3].machinePosition
    break
    ;echo "["^iterations^"] B =", var.lastHome
    
G1 H2 B-5 F1000		; back up 5mm
G92 B55				; set 0 position
G90 			; back to absolute positioning

M280 P1 S140		; Move wipe arm

M400 			; make sure everything has stopped before we reset the motor currents
G4 P100			; wait 400ms
M913 B100 		; motor currents back to 100%
