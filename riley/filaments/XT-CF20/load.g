M291 P"Please wait while the nozzle is being heated up" R"Loading XT-CF20" T5 ; Display message
G10 S260 ; Set current tool temperature to 260C
M116 ; Wait for the temperatures to be reached
G1 X334 Y100 F30000
M291 P"Feeding filament..." R"Loading XT-CF20" T5 ; Display new message
G1 E100 F300 ; Prime
G4 P1000 ; Wait one second
G1 E-10 F900 ; Retract 10mm of filament at 1800mm/min
M98 P"prime.g"
M400 ; Wait for moves to complete
M292 ; Hide the message