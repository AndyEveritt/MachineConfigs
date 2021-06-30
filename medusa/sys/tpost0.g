; tpost0.g
; called after tool 0 has been selected

M116 P0     ;Wait until tool is at temp

;Prime nozzle
if heat.heaters[1].active > heat.coldExtrudeTemperature
	M98 P"primer.g"

M106 P1 R1	; restore print cooling fan speed

;mesh levelling on
G29 S1