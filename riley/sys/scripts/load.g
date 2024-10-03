var filament = param.F
var temperature = param.T

M291 P"Please wait while the nozzle is being heated up" R{"Loading "^var.filament} T5 ; Display message
G10 S{var.temperature} ; Set current tool temperature to 260C
M116 ; Wait for the temperatures to be reached
G1 X334 Y100 F30000
M291 P"Feeding filament..." R{"Loading "^var.filament} T5 ; Display new message
G1 E25 F900
G1 E60 F300
G4 P500 ; Wait
M98 P"prime.g"
M400 ; Wait for moves to complete
M291 P"Finished" R{"Loading "^var.filament} T5 ; Display new message
