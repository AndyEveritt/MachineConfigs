M291 P"Nozzle heating, please wait..." R"Loading PLA" T5 ; Display message
G10 S200 ; Set temperature for tool
M116 ; Wait for temp 
M291 P"Feeding filament..." R"Loading PLA" T5 ; New message
M83 ; Extruder relative 
G1 E10 F600 ; Feed 10mm filament at 600mm/m
G1 E200 F3000 ; Feed 200mm of filament at 3000mm/min
G1 E20 F300 ; Feed 20mm filament at 300mm/min
G4 P1000 ; Wait 1 second
G1 E-10 F1800 ; Retract 10mm 
M400 ; wait to finish
M292 ; hide message

G10 S0 ; turn off heater