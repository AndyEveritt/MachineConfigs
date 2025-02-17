; tpre0.g
; called before tool 0 is selected

var tool_x = 86.8
var tool_y = 216.4

M98 P"scripts/tpre.g" X{var.tool_x} Y{var.tool_y}

; set Y max for this tool
M208 X-14:323 Y138
