; homez.g
; called to home the Z axis

; Check tool detect switch
if sensors.endstops[1].triggered == true
    M291 S1 T5 P{"Please return tool to dock before homing"} R"Cannot home"
    abort

if {global.lastTool} != -1			; second check
	abort "Tool loaded"

M98 P"/macros/Tool Control/Coupler - Unlock"	;Open Coupler

G91 				; Relative mode
G1 H2 Z5 F5000			; Lower the bed
G90				; back to absolute positioning

G1 X150 Y100 F50000		; Position the endstop above the bed centre

M913 Z100

M558 F1000
G30
M558 F300
G30

G91
G4 P500				; wait 500msec
G1 Z10 F5000			; Drop the Bed
G90

M913 Z100
