var id = param.V            ; name of the global variable
var defaultValue = param.X	; value to save if the global variable does not exist

; Create file if does not exist
if (!fileexists({"/sys/globals/"^var.id}))
	M98 P"scripts/persistentGlobal.g" V{var.id} X{var.defaultValue}

; Load persistant global variable
M98 P{"globals/"^var.id}
