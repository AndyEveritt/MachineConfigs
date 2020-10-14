; Check tool detect switch
if sensors.gpIn[0] != null && sensors.gpIn[0].value = 0
    M291 S3 P{"No tool on toolhead. Will set tool to T-1"} R"Tool Change Error"
    T-1 P0
    M98 P"resetaxislimit.g"
    M564 S1								; apply the normal limits again
    abort