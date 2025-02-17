M291 R"Temperature" P"Enter temperature" J1 S6 L160 H350
var temperature = input

M98 P"scripts/load.g" F"default" T{var.temperature}