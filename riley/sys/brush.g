abort "brush.g not supported"

;Drop Bed
G91
G1 Z3 F1500
G90

; set brush height
if {state.currentTool} = -1
	abort "Attempting to prime with no tool selected"
if {state.currentTool} = 0
	G1 B7
if {state.currentTool} = 1
	G1 B7

var brush_x_min = 312
var brush_x_max = 332
var brush_y_min = 126
var brush_y_max = 164

var wiper_x = 320
var wiper_y = 114.5

var brush_width = {var.brush_x_max - var.brush_x_min}
var brush_length = {var.brush_y_max - var.brush_y_min}

var prime_x = {var.wiper_x}
var prime_y = {var.wiper_y - 7}

var increment = 2

;brush in
G1 X{var.brush_x_min} Y{var.brush_y_max} F10000
while {move.axes[1].userPosition > var.brush_y_min}
	G1 X{var.brush_x_max} Y{move.axes[1].userPosition - var.increment} F10000
	G1 X{var.brush_x_min} Y{move.axes[1].userPosition - var.increment} F10000

;Run in
G1 X{var.brush_x_min + 0.5*var.brush_width} Y{var.brush_y_min} F10000

;Brush Out
G1 X{var.brush_x_min} Y{var.brush_y_min} F10000
while {move.axes[1].userPosition < var.brush_y_max}
	G1 X{var.brush_x_max} Y{move.axes[1].userPosition + var.increment} F10000
	G1 X{var.brush_x_min} Y{move.axes[1].userPosition + var.increment} F10000

;Brush Down
G91 G1 B10 F2000 G90

G1 X{var.prime_x} Y{var.prime_y} F10000