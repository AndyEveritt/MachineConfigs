; tpre0.g
; called before tool 0 is selected

;Ensure no tool is selected
;T-1

;Unlock Coupler
M98 P"/macros/Coupler - Unlock"

M564 S0 ; allow movement outside the normal limits

;Move to location
G1 X-12.5 Y180 F5000

;Move in
G1 X-12.5 Y220 F5000

;Collect
G1 X-12.5 Y229.8 F250

;Close Coupler
M98 P"/macros/Coupler - Lock"

;WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
;if you are using non-standard length hotends ensure the bed is lowered enough BEFORE undocking the tool!
G91
G1 Z13.5 F1000
G90

;Move Out
G1 X-12.5 Y150 B4.25 F400

; set Y max for this tool
M208 X-17.5:312.5 Y158

; apply the normal limits again
M564 S1
