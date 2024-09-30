M291 P"Please wait while the nozzle is being heated up" R"Unloading PET" T5 ; Display message
G10 S250 ; Heat up the current tool to 100C
M116 ; Wait for the temperatures to be reached
;M98 P"purge.g"
M291 P"Retracting filament..." R"Unloading PET" T5 ; Display another message
G1 E-20 F300 ; Retract 20mm of filament at 300mm/min
G1 E-100 F900 ; Retract 480mm of filament at 3000mm/min
M400 ; Wait for the moves to finish
M292 ; Hide the message again