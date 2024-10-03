var tool = param.T
var filament = param.F
var currentTool = state.currentTool

var loadedFilament = move.extruders[tools[var.tool].filamentExtruder].filament

if var.filament != var.loadedFilament
    if (var.loadedFilament == "")
        M291 S3 P{"Print uses "^{var.filament}^", but tool "^{var.tool}^" has no filament loaded. Continue anyway?"} R"Incorrect Filament Loaded"
    else
        M291 S3 P{"Print uses "^{var.filament}^", but tool "^{var.tool}^" has "^{var.loadedFilament}^" loaded. Continue anyway?"} R"Incorrect Filament Loaded"
    M291 S4 P{"Set loaded filament to "^{var.filament}^"?"} K{"Yes", "No"}
    if (input = 0) ; yes
        T{var.tool} P0
        if (var.loadedFilament != "")
            M702 P0
        if (!fileexists({"/filaments/"^var.filament^"/config.g"}))
            echo {"Filament "^var.filament^" does not exist. Using default filament config"}
            set var.filament = "default"
        M701 S{var.filament} P0
        M703
        T{var.currentTool} P0