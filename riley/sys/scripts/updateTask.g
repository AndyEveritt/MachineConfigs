var taskName = param.V
var interval = exists(param.F) ? param.F : null
var script = exists(param.S) ? param.S : null

if (var.taskName == "")
    echo "Task name not specified"
    M99

if (var.script == "")
    echo "var.Script not specified"
    M99

while (iterations < #global.tasks)
    if (global.tasks[iterations][0] != var.taskName)
        continue
    
    if (var.interval != null)
        echo "Setting task '"^var.taskName^"' interval to "^var.interval^"s"
        set global.tasks[iterations][1] = var.interval


    if (var.script != null)
        echo "Setting task '"^var.taskName^"' script to '"^var.script^"'"
        set global.tasks[iterations][2] = var.script

