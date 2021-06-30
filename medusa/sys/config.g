; Configuration file for Duet WiFi
; executed by the firmware on start-up

; General preferences
M111 S0 						; Debugging off
G21 							; Work in millimetres
G90 							; Send absolute coordinates...
M83 							; ...but relative extruder moves
M555 P2 						; Set firmware compatibility to look like Marlin

; Network
M550 P"Medusa" 						; Set machine name
M552 S1 P"E3D"						; Enable Networking
M586 P0 S1 						; Enable HTTP
M586 P1 S0 						; Disable FTP
M586 P2 S0 						; Disable Telnet

M667 S1 						; Select CoreXY mode

; Disable Heaters for use with PWM.
; M307 H7 A-1 C-1 D-1 					; disable heater 7 for use with TC Servo.

; Endstops
M574 X1 Y1 S3 					; Set X / Y endstop stall detection
M574 B2 S3 						; Set B endstop stall detection, max endstop
M574 Z1 S2 						; Set Z endstop probe
M558 P8 C"zstop" H3 F360 I0 T20000 			; Set Z probe type to switch, the axes for which it is used and the dive height + speeds
G31 P200 X0 Y0 Z0	 				; Set Z probe trigger value, offset and trigger height
M557 X10:290 Y20:180 S40 				; Define mesh grid

; Drive direction
M569 P0 S0 						; Drive 0 X
M569 P1 S0 						; Drive 1 Y
M569 P2 S0 						; Drive 2 Z
M569 P3 S1 						; Drive 3 E0
M569 P4 S0 						; Drive 4 E1
M569 P5 S1 						; Drive 5 E2
M569 P6 S0 						; Drive 6 E3
M569 P7 S0 						; Drive 7 Right Brush
M569 P8 S1 						; Drive 8 UNUSED
M569 P9 S0 						; Drive 9 COUPLER

M584 X0 Y1 Z2 B7 C9 E3:4:5:6 				; Apply custom drive mapping
M98 P"resetaxislimit.g"                                 ; Set axis maxima & minima
M208 C0:240				                                ; Set C axis maxima & minima
M208 B0:54				                                ; Set B axis maxima & minima
M350 E16:16:16:16 C8 I0 					; Configure microstepping without interpolation
M350 X16 Y16 B16 Z16 I256				; Configure microstepping with interpolation
M92 X100 Y100 Z1600 B1600 C100 E396:396:1608:540		; Set steps per mm Hermes - 409, Prusa - 1636,
M566 X400 Y400 Z8 B8 C2 E20:20:20:20				; Set maximum instantaneous speed changes (mm/min)
M203 X35000 Y35000 Z1200 B1200 C5000 E5000:5000:5000:5000	; Set maximum speeds (mm/min)
M201 X6000 Y6000 Z400 B400 C500 E2500:2500:2500:2500		; Set accelerations (mm/s^2)
M906 X2000 Y2000 Z1330 B1330 C500 E1330:0:400:0 I30 	; Set motor currents (mA) and motor idle factor in percent old E1330:1680:300:300
M84 S120 						; Set idle timeout

;Stall Detection
M915 C S5 F0 H200 R0

;Stall Detection
M915 X Y S5 F0 H400 R0
M915 H200 B S3 R0 F0

; Heaters
M308 S0 P"bedtemp" Y"thermistor" T100000 B4725 C7.06e-8 A"Bed"			; Set thermistor + ADC parameters for heater 0
M950 H0 C"bedheat" T0
M143 H0 S255 						; Set temperature limit for heater 0 to 255C
M140 H0									            ; Bed heater is heater 0

M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.06e-8 A"HC"  			; Set thermistor
M950 H1 C"e0heat" T1
M143 H1 S305 						; Set temperature limit for heater 1 to 300C

M308 S3 P"duex.cs5" Y"rtd-max31865" A"No extruder"  			; Set thermistor
M950 H3 C"duex.e2heat" T3
M143 H3 S300 						; Set temperature limit for heater 3 to 300C

; Fans
M950 F0 C"fan0"                 ; T0 HE
M950 F1 C"fan1"                 ; T0 PCF
M950 F4 C"duex.fan5"                 ; T2 HE
M950 F5 C"duex.fan6"                 ; T2 PCF
M106 P0 S255 H1 T70				; T0 HE
M106 P1 S0						; T0 PCF
M106 P4 S255 H3 T70				; T2 HE
M106 P5 S0						; T2 PCF

; Tools
M563 P0 S"T0 - Hemera" D0 H1 F1 	; Define tool 0
;G10 P0 X0 Y0 Z0 					; Set tool 0 axis offsets
G10 P0 R0 S0 						; Set initial tool 0 active and standby temperatures to 0C

M563 P2 S"T2 - NOTHING" D2 H3 F5 	; Define tool 2
;G10 P2 X0 Y0 Z0 					; Set tool 2 axis offsets
G10 P2 R0 S0 						; Set initial tool 2 active and standby temperatures to 0C

M950 S0 C"duex.pwm4"
M280 P0 S40

M593 F40.5						; cancel ringing at 40.5Hz
;M376 H15						; bed compensation taper
G29 S1							; load height map

;Tool offsets
G10 P0 X19.3 Y44 Z-8.52	 		;T0 0.18
G10 P2 X-8.1 Y39.2 Z-5.15 		;T2

;deselect tools
T-1

;M572 D0 S0.2 						; pressure advance T0
;M572 D1 S0.2 						; pressure advance T1
;M572 D2 S0.2 						; pressure advance T2
;M572 D3 S0.2 						; pressure advance T3

G29 S2							; Disable Mesh Bed Leveling Compensation
M501