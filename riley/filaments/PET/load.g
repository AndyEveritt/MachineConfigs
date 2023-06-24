M291 P"Please wait while the nozzle is being heated up" R"Loading PET" T5 ; Display message
G10 S250 ; Set current tool temperature to 260C
M116 ; Wait for the temperatures to be reached
G1 X334 Y100 F30000
M291 P"Feeding filament..." R"Loading PET" T5 ; Display new message
G1 E100 F300 ; Prime
G4 P500 ; Wait one second
M98 P"prime.g"
M400 ; Wait for moves to complete
M292 ; Hide the message