; tpost0.g
; called after tool 0 has been selected


M106 R1	; restore print cooling fan speed

;mesh levelling on
G29 S1

if job.file.fileName != null
    ;heatup
    M116 P0
    ;prime nozzle
    M98 P"prime.g"

G1 R2 X0 Y0 Z2 F24000

if job.file.fileName != null
    if global.nozzleDiameters[0] <= 0.4
        G1 E0.5 F300
    else
        G1 E0.8 F300

