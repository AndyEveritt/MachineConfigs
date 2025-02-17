;Drop Bed
G91
G1 Z3 F1500
G90 

M83

var prime_heights = {7.5, 7.5}
var prime_x = 330
var prime_y = 133

var brush_x_min = 312
var brush_x_max = 328
var brush_y_min = 142
var brush_y_max = 164

var brush_width = {var.brush_x_max - var.brush_x_min}
var brush_length = {var.brush_y_max - var.brush_y_min}
var increment = 2

; set brush height
if {state.currentTool} = -1
	abort "Attempting to prime with no tool selected"
if {state.currentTool} >= 2
	abort "Priming this tool is not supported"

; Move brush down for clearance
var prime_height = var.prime_heights[{state.currentTool}]
G1 B{var.prime_height + 10} F3000

M280 P1 S140		; Move wipe arm

M106 S0.33	; Cooling on

;Park for prime/purge
G1 X{var.brush_x_min} Y{var.brush_y_max} F18000
G1 X{var.prime_x + 7.5} Y{var.prime_y + 5} F10000
G1 B{var.prime_height} F3000

;Prime
G1 E3 F600											; Initial Vertical Purge
G4 P200												; Dwell for .20s
G1 X{var.prime_x} Y{var.prime_y} F10000				; Position Nozzle for Initial Purge

G1 E12 F720											; Vertical Pebble Purge

G1 B{var.prime_height + 2} F1500					; Move Nozzle Away From Purge Platform
M106 S1												; Cooling 
G1 E6 F360	 										; Pebble Purge
G1 E1 F240											; Final Slow Pebble Purge
G4 P4000											; Dwell
G1 E-0.2											; Retract
G1 B{var.prime_height + 3} F1500					; Move Nozzle Away From Purge Platform
G4 P500												; Dwell
G1 X{var.brush_x_min} Y{var.brush_y_max} B{var.prime_height + 1} F10000		; Move Nozzle Across Silicone Brush
M280 P1 S10											; Servo Wipe
G4 P200												; Dwell
M280 P1 S140										; Servo Return

M106 R2									; Cooling Off

;Flick

;Brush Out
;G1 X{var.brush_x_min} Y{var.brush_y_min} F10000
;while {move.axes[1].userPosition < var.brush_y_max}
;	G1 X{var.brush_x_max} Y{move.axes[1].userPosition + 2 * var.increment} F5000
;	G1 X{var.brush_x_min} Y{move.axes[1].userPosition + 2 * var.increment} F5000

;Brush Down
G1 B{var.prime_height + 10} F3000
;G1 R2 X0 Y0 Z2 F20000
;G1 E0.4 F300