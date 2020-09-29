; tpost0.g
; called after tool 0 has been selected

;heatup
M116 P1

;prime nozzle
if heat.heaters[2].active > heat.coldExtrudeTemperature
    M98 P"prime.g"

M106 R1	; restore print cooling fan speed

;mesh levelling on
G29 S1
