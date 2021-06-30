; tpost2.g
; called after tool 2 has been selected

M116 P2     ;Wait until tool is at temp

;Prime nozzle
;if heat.heaters[1].active > heat.coldExtrudeTemperature
;    M98 P"primer.g"

M106 P5 R1	; restore print cooling fan speed

;mesh levelling on
G29 S1