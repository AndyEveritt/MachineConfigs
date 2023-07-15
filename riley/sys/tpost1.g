; tpost0.g
; called after tool 0 has been selected


if job.file.fileName != null
    ;heatup
    M116 P1
    ;prime nozzle
    M98 P"prime.g"

M106 R1	; restore print cooling fan speed

;mesh levelling on
G29 S1
