; Configuration file for Duet WiFi / Ethernet running RRF3 on E3D Tool Changer
; executed by the firmware on start-up

; General preferences
M111 S0 						; Debugging off
G21 							; Work in millimetres
G90 							; Send absolute coordinates...
M83 							; ...but relative extruder moves
M555 P2 						; Set firmware compatibility to look like Marlin
M575 P1 B57600 S1

M667 S1 						; Select CoreXY mode	

; Drive direction
M569 P0 S1 						; Drive 0 Z
M569 P1 S0 						; Drive 1 Y
M569 P2 S0 						; Drive 2 X
M569 P3 S0 						; Drive 3 E0
M569 P4 S0 						; Drive 4 E1
M569 P5 S0 						; Drive 5 COUPLER

M584 X2 Y1 Z0 C5				; Axis to driver mapping
M584 E3         				; set extruder drivers

M98 P"resetaxislimit.g"                                 ; Set axis maxima & minima
M208 C0:240				                                ; Set axis maxima & minima
M92 X100 Y100 Z1600 C200 E396				            ; Set steps per mm assuming x16 microstepping
M350 E16 I1 									        ; Configure microstepping with interpolation
M350 C16 I1
M350 X16 Y16 Z16 I1										; Configure microstepping with interpolation
M566 X400 Y400 Z8 C2 E200           					; Set maximum instantaneous speed changes (mm/min)
M203 X35000 Y35000 Z1200 C10000 E5000               	; Set maximum speeds (mm/min)
M201 X6000 Y6000 Z400 C500 E2500            			; Set accelerations (mm/s^2)
M906 X2000 Y2000 Z1330 C500 E1340 I30               	; Set motor currents (mA) and motor idle factor in percent
M84 C S10 												; Set idle timeout
M84 X Y Z S120 											; Set idle timeout

; Endstops
M574 X1 Y1 S3 							; Set X / Y endstop stall detection
M574 Z0 								; No Z endstop
M574 C1 S3								; Stall detect coupler at low end of its range

; Z probe
M558 P8 C"io0.in" H3 F360 I0 T20000 	; Set Z probe type to switch, the axes for which it is used and the dive height + speeds
G31 P200 X0 Y0 Z0	 					; Set Z probe trigger value, offset and trigger height
M557 X10:290 Y20:180 S40 			; Define mesh grid

;Stall Detection
M915 C S6 F1 H200 R0					; Coupler

;Stall Detection
M915 X Y S1 F0 H280 R0					; X / Y Axes

; Heaters and temperature sensors
; Bed heater
M308 S0 P"temp0" Y"thermistor" T100000 B4725 C7.06e-8 	; Set thermistor 
M950 H0 C"out1" T0						            ; Bed heater
M143 H0 S225 							            ; Set temperature limit for heater 0 to 225C
M140 H0									            ; Bed heater is heater 0

; Tool 0 heater
M308 S1 P"temp1" Y"thermistor" A"HC" T100000 B4725 C7.06e-8 	; Set thermistor
M950 H1 C"out2" T1						; Extruder 0 heater
M143 H1 S300 							; Set temperature limit for heater 1 to 300C

; Fans
M950 F1 C"out8"							; T0 HE
M950 F2 C"out7"							; T0 PCF
M106 P1 S255 H1 T70						; T0 HE
M106 P2 S0								; T0 PCF

; Tools
M563 P0 S"T0 - Hemera" D0 H1 F2 					; Define tool 0
G10 P0 X0 Y0 Z0 					    ; Reset tool 0 axis offsets
G10 P0 R0 S0 							; Reset initial tool 0 active and standby temperatures to 0C

; Tool offsets, adding to vales brings the plane closer to the tool
G10 P0 X19.5 Y42.5 Z-6.09				; T0 (X0 | Y0 | Z0)

M593 F50								; cancel ringing at 50Hz (https://forum.e3d-online.com/threads/accelerometer-and-resonance-measurements-of-the-motion-system.3445/)
M376 H15								; bed compensation taper

; Bowden tubes are ~700mm long so PA on the Bowden tools almost certainly needs to be increased
M572 D0 S0.05 							; pressure advance T0

; Set up the dock indicator switches on the Hemera tools. These are wired NO so invert the pin.
; M950 J2 C"22.!^io0.in"					; GpIn 2 = tool 2 dock switch
; M950 J3 C"23.!^io0.in"					; GpIn 2 = tool 2 dock switch
