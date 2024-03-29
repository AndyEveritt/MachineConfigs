;Drop Bed
G91
G1 Z3 F1500
G90

; set brush height
if {state.currentTool} = -1
	abort "Attempting to prime with no tool selected"
if {state.currentTool} = 0
	G1 B1.5
if {state.currentTool} = 1
	G1 B1.5

var brush_x_min = 320
var brush_x_max = 332
var brush_y_min = 126
var brush_y_max = 164

var wiper_x = 325
var wiper_y = 112

var brush_width = {var.brush_x_max - var.brush_x_min}
var brush_length = {var.brush_y_max - var.brush_y_min}

var prime_x = {var.wiper_x}
var prime_y = {var.wiper_y - 7}

;brush in
G1 X{var.brush_x_min} Y{var.brush_y_max} F10000
G1 X{var.brush_x_min + 0.25*var.brush_width} Y{var.brush_y_min} F10000
G1 X{var.brush_x_min + 0.5*var.brush_width} Y{var.brush_y_max} F10000
G1 X{var.brush_x_min + 0.75*var.brush_width} Y{var.brush_y_min} F10000
G1 X{var.brush_x_max} Y{var.brush_y_max} F10000

;Run in
G1 X{var.brush_x_min + 0.5*var.brush_width} Y{var.brush_y_min} F10000

;Park for prime/purge
G1 X{var.prime_x} Y{var.prime_y} F10000

;Purge
G92 E0
G1 F200
G1 E10 F200
G92 E0
G1 E-8 F2750
G4 S4

;Flick
G1 X{var.wiper_x - 2} Y{var.wiper_y - 10} F20000
G1 X{var.wiper_x}     Y{var.wiper_y + 5}
G1 X{var.wiper_x + 2} Y{var.wiper_y - 10} F20000
G1 X{var.wiper_x}     Y{var.wiper_y + 5}
G1 X{var.wiper_x - 2} Y{var.wiper_y - 10} F20000
G1 X{var.wiper_x}     Y{var.wiper_y + 5}
G1 X{var.wiper_x + 2} Y{var.wiper_y - 10} F20000
G1 X{var.wiper_x}     Y{var.wiper_y + 5}

;Brush Out
G1 X{var.brush_x_min} Y{var.brush_y_max} F10000
G1 X{var.brush_x_min + 0.25*var.brush_width} Y{var.brush_y_min} F10000
G1 X{var.brush_x_min + 0.5*var.brush_width} Y{var.brush_y_max} F10000
G1 X{var.brush_x_min + 0.75*var.brush_width} Y{var.brush_y_min} F10000
G1 X{var.brush_x_max} Y{var.brush_y_max} F10000

;Brush Down
G1 B20 F2000

G1 X315
