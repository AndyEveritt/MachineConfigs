var taskName = ""
var taskIndex = -1

if (exists(param.V))
    set var.taskName = param.V
else
    var taskNames = vector(#global.tasks, "")
    while (iterations < #global.tasks)
        set var.taskNames[iterations] = global.tasks[iterations][0]

    M291 R"Updating Task" P"Select task" S4 K{var.taskNames}
    set var.taskName = var.taskNames[input]
    set var.taskIndex = input

var interval = exists(param.F) ? param.F : null
var script = exists(param.S) ? param.S : null

if (var.taskName == "")
    echo "Task name not specified"
    M99

if (var.taskIndex >= 0)
    if (var.interval == null && var.script == null)
        M291 R"Updating Task" P"Enter interval (ms)" S5 F{global.tasks[var.taskIndex][1]} L0 J2
        if (result == 0)
            set var.interval = input

        M291 R"Updating Task" P"Enter script" S7 F{global.tasks[var.taskIndex][2]} J2
        if (result == 0)
            set var.script = input


while (iterations < #global.tasks)
    if (global.tasks[iterations][0] != var.taskName)
        continue
    
    if (var.interval != null)
        if (var.interval < 0)
            set var.interval = 0
        echo "Setting task '"^var.taskName^"' interval to "^var.interval^"s"
        set global.tasks[iterations][1] = var.interval


    if (var.script != null)
        echo "Setting task '"^var.taskName^"' script to '"^var.script^"'"
        set global.tasks[iterations][2] = var.script

