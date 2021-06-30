; tpre2.g
; called before tool 2 is selected

;Unlock Coupler
M98 P"/macros/Coupler - Unlock"

M564 S0 ; allow movement outside the normal limits

;Move to location
G1 X221.7 Y150 F10000
;Move in
G1 X221.7 Y215 F2000
;Collect
G1 X221.7 Y242.2 F2000

;Close Coupler
M98 P"/macros/Coupler - Lock"

;WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
;if you are using non-standard length hotends ensure the bed is lowered enough BEFORE undocking the tool!
G91
G1 Z10 F1000
G90

;Move Out
G1 X221.7 Y150 F2500

; set X/Y max for this tool
M208 X-27.3:336.5 Y172 Z5.3:295

; apply the normal limits again
M564 S1