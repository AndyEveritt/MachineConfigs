; Configuration file for Duet WiFi / Ethernet running RRF3 on E3D Tool Changer
; executed by the firmware on start-up

; General preferences
M111 S0 						; Debugging off
G21 							; Work in millimetres
G90 							; Send absolute coordinates...
M83 							; ...but relative extruder moves
M555 P2 						; Set firmware compatibility to look like Marlin
M575 P1 B57600 S1
M550 P"Riley"

;M667 S1 						; Select CoreXY mode	
M669 K1

M569.1 P2.0 T3 R30 I50 D0 V0 A0
M569.1 P3.0 T3 R30 I50 D0 V0 A0

; Drive direction
M569 P0 S1 						; Drive 0 Z
M569 P2.0 S0 D4						; Drive 1 Y
M569 P3.0 S0 D4						; Drive 2 X
M569 P5.0 S0 						; Drive 3 E0
M569 P6.0 S0 						; Drive 4 E1
M569 P5 S1						; Drive 5 Brush
M569 P4.0 S1 					; Drive 1.2 COUPLER

M584 X3.0 Y2.0 Z0 C4.0 B5			; Axis to driver mapping
M584 E5.0:6.0         				; set extruder drivers

M98 P"resetaxislimit.g"                                 ; Set axis maxima & minima
M208 C0:120				                                ; Set axis maxima & minima
M92 X100 Y100 Z1600 C200 B1600 E396:396				            ; Set steps per mm assuming x16 microstepping
M350 E16:16 I1 									        ; Configure microstepping with interpolation
M350 C16 I1
M350 X16 Y16 Z16 I1										; Configure microstepping with interpolation
M566 X700 Y700 Z20 C2 B200 E100:100           			; Set maximum instantaneous speed changes (mm/min)
M203 X35000 Y35000 Z2000 C10000 B3500 E5000:5000        ; Set maximum speeds (mm/min)
M201 X4000 Y4000 Z400 C500 B500 E1000:1000            	; Set accelerations (mm/s^2)
M906 X2000 Y2000 Z1330 C500 B1000 E1340:1340 I30        ; Set motor currents (mA) and motor idle factor in percent
M84 B C S10 											; Set idle timeout
M84 X Y Z S120 											; Set idle timeout

; Endstops
M574 X1 P"4.io1.in" S1 							; Set X / Y endstop stall detection
M574 Y2 P"4.io0.in" S1 							; Set X / Y endstop stall detection
M574 Z0 								; No Z endstop
M574 B2 S3		 						; Set B endstop stall detection
M574 C1 S3								; Stall detect coupler at low end of its range

; Z probe
M558 K0 P8 A1 C"4.io2.in" H3 F360 T50000 	; Set Z probe type to switch, the axes for which it is used and the dive height + speeds
G31 K0 P200 X0 Y0 Z0	 					; Set Z probe trigger value, offset and trigger height
M98 P"resetmeshgrid.g" 			; Define mesh grid

; Tool probe
M558 K1 P8 C"!io3.in" H5 F360 T1000
G31 K1 P200 Z0

;Stall Detection
M915 C S6 F1 H200 R0					; Coupler
M915 H200 B S3 R0 F0					; Brushes

;Stall Detection
M915 X Y S1 F0 H280 R0					; X / Y Axes

; Heaters and temperature sensors
; Bed heater
M308 S0 P"temp0" Y"thermistor" A"Bed" T100000 B4725 C7.06e-8 	; Set thermistor 
M950 H0 C"out1" T0						            ; Bed heater
M143 H0 S225 							            ; Set temperature limit for heater 0 to 225C
M140 H0									            ; Bed heater is heater 0

; Tool 0 heater
M308 S1 P"5.temp0" Y"thermistor" A"Revo 60W" T100000 B4725 C7.06e-8 	; Set thermistor
M950 H1 C"5.out0" T1						; Extruder 0 heater
M143 H1 S300 							; Set temperature limit for heater 1 to 300C

; Tool 1 heater
M308 S2 P"6.temp0" Y"thermistor" A"Revo 60W" T100000 B4725 C7.06e-8 	; Set thermistor
M950 H2 C"6.out0" T2						; Extruder 0 heater
M143 H2 S300 							; Set temperature limit for heater 1 to 300C

; Tool 0 Fans
M950 F1 C"5.out1"							; T0 HE
M950 F2 C"5.out2"							; T0 PCF
M106 P1 S255 H1 T70						; T0 HE
M106 P2 S0								; T0 PCF

; Tool 1 Fans
M950 F3 C"6.out1"							; T1 HE
M950 F4 C"6.out2"							; T1 PCF
M106 P3 S255 H2 T70						; T1 HE
M106 P4 S0								; T1 PCF

; Tool 0 - Hemera
M563 P0 S"T0 - Hemera XS" D0 H1 F2 		; Define tool 0
G10 P0 X0 Y0 Z0 					    ; Reset tool 0 axis offsets
G10 P0 R0 S0 							; Reset initial tool 0 active and standby temperatures to 0C

; Tool 1 - Hemera
M563 P1 S"T1 - Hemera XS" D1 H2 F4 		; Define tool 1
G10 P1 X0 Y0 Z0 					    ; Reset tool 1 axis offsets
G10 P1 R0 S0 							; Reset initial tool 1 active and standby temperatures to 0C

; Tool 2 - ASMBL
;M950 R0 C"io4.out" L100000 Q50
M563 P2 S"T2 - ASMBL"
M950 S0 C"io4.out" Q50
M280 P0 S40

; Tool 3 - Microscope
M563 P3 S"T3 - Microscope" 				; Define tool 3
G10 P3 X0 Y0 Z0 					    ; Reset tool 3 axis offsets


M593 F50								; cancel ringing at 50Hz (https://forum.e3d-online.com/threads/accelerometer-and-resonance-measurements-of-the-motion-system.3445/)
M376 H15								; bed compensation taper

; Bowden tubes are ~700mm long so PA on the Bowden tools almost certainly needs to be increased
;M572 D0 S0.05 							; pressure advance T0

; Set up the tool detect switch.
M950 J0 C"io1.in"					; GpIn 0 = tool detect switch

; Tool offset configuration
M501 								; load config-override.g
echo "Z Offsets [T0: ", {tools[0].offsets[2]}, ", T1: ", {tools[1].offsets[2]}, "]"

; Home brush
G28 B

; Load persistant global variables
M98 P"globals/lastTool"

G4 S0.5
if (!exists(global.lastTool))
	M98 P"persistantglobal.g" V"lastTool" X-2

; Set last active tool
if {global.lastTool} == -2
	M291 S2 P"Unknown tool loaded" R"Tool Detected"
	G92 C96
elif {global.lastTool} >= 0
	M291 S2 P{"Tool Loaded on Power Off, automatically setting tool to T"^{global.lastTool}} R"Power Resume Tool Auto Set"
	T{global.lastTool} P0
	G92 C96
else
	G4 S1
	G28 C 							; home coupler

; Declare global variables
global prev_max_speed_x = null
global prev_max_speed_y = null
global prev_max_speed_z = null
global prev_max_accel_x = null
global prev_max_accel_y = null
global prev_max_accel_z = null
global prev_z_height = null
