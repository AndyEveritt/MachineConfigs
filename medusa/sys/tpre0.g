; tpre0.g
; called before tool 0 is selected

;Unlock Coupler
M98 P"/macros/Coupler - Unlock"

M564 S0 ; allow movement outside the normal limits

;Move to location
G1 X-6 Y150 F10000
;Move in
G1 X-6 Y215 F2000
;Collect
G1 X-6 Y226.3 F2000

;Close Coupler
M98 P"/macros/Coupler - Lock"

;WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
;if you are using non-standard length hotends ensure the bed is lowered enough BEFORE undocking the tool!
G91
G1 Z10 F1000
G90

;Move Out
G1 X-6 Y150 F2500

; set X/Y max for this tool
M208 X-17.5:317.5 Y154 Z5.49:295

; apply the normal limits again
M564 S1