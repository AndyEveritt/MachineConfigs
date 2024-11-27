echo "filament error from filament monitor: "^{param.B}^"."^{param.D}^" : code "^{param.P}^", "^{param.S}
if param.P == 4 ; too little movement
    if job.file.fileName != ""
        M25 ; pause