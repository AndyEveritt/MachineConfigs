; tpost.g
; called after tool N has been selected


M106 R1	; restore print cooling fan speed

;mesh levelling on
G29 S1

if job.file.fileName != null
    ;heatup
    M116 P{state.currentTool}
    ;prime nozzle
    M98 P"prime.g"

; return to previous position
G1 R2 X0 Y0 Z2 F24000

; load filament config
M703

if job.file.fileName != null
    if global.nozzleDiameters[{state.currentTool}] <= 0.4
        G1 E0.5 F300
    else
        G1 E0.8 F300

