var tool = param.T
var filament = param.F
var currentTool = state.currentTool

var loadedFilament = move.extruders[tools[var.tool].filamentExtruder].filament

if var.filament != var.loadedFilament
    if (var.loadedFilament == "")
        M291 S3 P{"Print uses "^{var.filament}^", but tool "^{var.tool}^" has no filament loaded. Continue anyway?"} R"Incorrect Filament Loaded"
    else
        M291 S3 P{"Print uses "^{var.filament}^", but tool "^{var.tool}^" has "^{var.loadedFilament}^" loaded. Continue anyway?"} R"Incorrect Filament Loaded"
    M291 S4 P{"Set loaded filament to "^{var.filament}^"?"} K{"Yes (filament already loaded)", "Yes (change filament)", "No"}

    var runScripts = input == 1 ? 1 : 0

    if (input < 2) ; yes
        T{var.tool} P0
        if (var.loadedFilament != "")
            M702 P{var.runScripts}
        if (!fileexists({"/filaments/"^var.filament^"/config.g"}))
            echo {"Filament "^var.filament^" does not exist. Creating..."}
            M98 P"/macros/Create Filament" F{var.filament}

        if (var.runScripts != 0)
            while true
                M291 S4 P{"Start loading filament "^{var.filament}^"?"} R"Changing Filament" K{"Yes", "Unload again", "Cancel"}
                if (input == 0)
                    break
                if (input == 1)
                    G1 E-50 F600
                    M291 P"Retracting filament..." R{"Unloading "^var.loadedFilament} T5 ; Display another message
                    M400
                if (input == 2)
                    T{var.currentTool} P0
                    abort "Cancelling..."

        M701 S{var.filament} P{var.runScripts}
        M703
        T{var.currentTool} P0
