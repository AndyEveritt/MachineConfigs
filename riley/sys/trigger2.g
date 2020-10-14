; trigger2.g
; called when tool detect switch goes from high (pressed) to low (not pressed)

M291 S3 P{"No tool on toolhead. Will set tool to T-1"} R"Tool Detect Fault"
T-1 P0                              ; set tool to standby
M581 T2 P-1                         ; disable trigger
M98 P"resetaxislimit.g"
M564 S1								; apply the normal limits again
abort