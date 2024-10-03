; Create file if does not exist
if (!fileexists({"/sys/globals/"^param.V}))
	M98 P"persistantglobal.g" V{param.V} X{param.X}

; Load persistant global variable
M98 P{"globals/"^param.V}
