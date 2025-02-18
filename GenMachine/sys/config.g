;Gen5X V1 

; Globals
global board = "6HC" ; Main board type
global configVersion = 0.1 ; Configuration version
global closedLoop = false ; Closed loop enabled
global accelerometer = false ; Accelerometer enabled

global ret = null   ; Return variable for subroutines

; General preferences
G90                                         ; Send absolute coordinates...
M83                                         ; ...but relative extruder moves
M555 P2 				    ; Set firmware compatibility to look like Marlin

;--------------------------------------------------------------------------------

;*** Expansion Board CAN configuration
if (global.closedLoop)
    G4 S1 ; wait for expansion board to start

    M569.1 P50.0 T2 C1000 S200 R100 I0 D0 E4:6 
    M569.1 P51.0 T2 C1000 S200 R100 I0 D0 E4:6 

    M569 P50.0 D4 S1
    M569 P51.0 D4 S1

    M584 W50.0 A51.0 R1

    M350 W16 A64 I1
    M906 W800 A1500

    M917 W0 A0

    M92 W26.667 A106.67


;---------------------------------------------------------------------------------

; Load board specific configuration
M98 P{"boards/" ^ global.board ^ ".g"} ; Load the board specific configuration

;Kinematics Profile for 5-axis (cartesian)
M669 K0 X1:0:0:0:0 Y0:-1:0:0:0 Z0:0:1:0:0 U0:0:0:1:0 V0:0:0:0:1

;Microstepping and Speed
M350 X32 U64 V64 I1                 			; Configure microstepping with interpolation
M350 Y128 I0
M350 Z16 E16 I1

; U/V 80t gearing 
M92 X160.00 Y640.00 Z400.00 E2682.00 U106.67 V106.67 		    ; Set steps per mm and steps per degree                     xy were 80 steps per mm with 16 microstepping
M566 X900.00 Y400.00 Z60.00 E150.00 U300 V300 P1     	    ; Set maximum instantaneous speed changes (mm/min) (jerk settings) 
M203 X5000.00 Y5000.00 Z3000.00 E1200.00 U3000.00 V3000.00  	    ; Set maximum speeds (mm/min)
M201 X1800.00 Y780.00 Z820.00 E3000.00 U300.00 V300.00   	    ; Set accelerations (mm/s^2)
M906 X750.00 Y900.00 Z750.00 E500.00 U1000.00 V600.00 I30            ; Set motor currents (mA) and motor idle factor in percent
M84 S30                                    			    ; Set idle timeout

; Input Shaping
;M593 P"ZVDDD" F17

;Axis Limit
M208 X-116:64   Y-65:65  Z-1:125 U-200:200 V-12000:12000					; Centre of the rotating bed is set to origin 0,0
M564 H0								; allow unhomed movement


; Endstops for each Axis
M574 X1 S3				    ; Set endstops controlled by motor load detection
M574 Y1 S3                  ; Set endstops controlled by motor load detection
M574 Z2 S3                  ; Configure Z axis endstop


; Stallgaurd Sensitivity
M915 X S3 F0 H400 R1		                ; Set X axis Sensitivity
M915 Y S3 F0 H400 R1		                ; Set Y axis Sensitivity
M915 Z S3 F0 H400 R1		                ; Set Z axis Sensitivity


; Z-Probe (E3D PZ Probe)
M575 P1 B9600 S7                        ; UART for configuration
M558 P8 R0.5 F3000 C"!io3.in" B1 A2 H6  ; pp sensor digital mode connected on io0.in
G31 X0 Y0 Z0.00 P600                      ; Set the probe height and threshold (smaller number = further away from bed)

; Heatbed Heaters and Thermistor Bed 
M140 H-1 ; Disable heated bed


; HotEnd Heaters and Thermistor HotEnd           
M308 S1 P"temp1" Y"thermistor" T100000 B4725 C7.06e-8 ; sensor 0
M950 H1 C"out1" T1					; Create HotEnd Heater
M307 H1 B0 S1.00        ; Disable bang-bang and set PWM limit
M143 H1 S280                            ; Set temperature limit for heater 1 to 285C HotEnd

M307 H1 R3.556 K0.459:0.000 D2.49 E1.35 S1.00 B0 V24.2  ; Autotuning result

; Test thermistor 
M308 S3 A"Test Thermistor" P"temp3" Y"thermistor" T100000 B3950


; Fans
M950 F0 C"out4" Q22500
M106 P0 S0 H-1 

M950 F1 C"out9" Q500				; Creates HOTEND Fan
M106 P1 S0 H1 T40              ; HOTEND Fan Settings


if (global.accelerometer)
    M955 P0 C"spi.cs1+spi.cs0" ; all wires connected to temp DB connector, no temperature daughterboard

; Tools
M563 P0 D0 H1 F1                            ; Define tool 0 Heater Block 1
G10 P0 X0 Y0 Z0                             ; Set tool 0 axis offsets
G10 P0 R0 S0                                ; Set initial tool 0 active and standby temperatures to 0C

; Light configuration
M950 E0 C"led" T1 Q3000000 U16  ; create a RGB Neopixel LED strip on the LED port and set SPI frequency to 3MHz

