var id = param.V                    ; name of the global variable
var value = param.X                 ; value to save
var filepath = "globals/"^{var.id}  ; internal file path where the global variable is saved

; Save the global variable as a file so it is persistent
echo > {var.filepath} "if exists(global."^{var.id}^")"
echo >> {var.filepath} "    set global."^{var.id}^" = "^{var.value}
echo >> {var.filepath} "else"
echo >> {var.filepath} "    global "^{var.id}^" = "^{var.value}

M98 P{var.filepath} ; load the global variable