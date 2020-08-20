; homeall.g
; called to home all axes

; while iterations < 4
;   if iterations < #sensors.gpIn && sensors.gpIn[iterations] != null && sensors.gpIn[iterations].value = 0
;     M291 S1 T5 P{"Please return tool "^iterations^" to dock before homing"} R"Cannot home"
;     abort

M98 P"homec.g"			; Home C (ToolHead)
M98 P"homey.g"			; Home Y
M98 P"homex.g"			; Home X
M98 P"homez.g"			; Home Z

G1 X150 Y-49 F15000		; Park