; homec.g
; called to home the C axis (coupler)


M564 S1
G91
M400 			; make sure everything has stopped before we make changes
G4 P100			; wait 400ms

;crashc
G1 H2 C-1000 F10000
G92 C-125
G90
M400
M913 C100           ; XY MOTORS TO 100% CURRENT
G1 C0 F10000
 
;Open Coupler
M98 P"/macros/Coupler - Unlock"