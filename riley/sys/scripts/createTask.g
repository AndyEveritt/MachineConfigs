var taskName = param.V
var interval = param.F
var script = param.S

if (var.taskName == "")
    echo "Task name not specified"
    M99

var task = {var.taskName, var.interval, var.script, 0}
echo "Created task '"^var.taskName^"' to run every "^var.interval^"s (script: '"^var.script^"')"

if (global.tasks == null)
    set global.tasks = {var.task,}
else
    while (iterations < #global.tasks)
        if (global.tasks[iterations][0] == var.taskName)
            echo "Task '"^var.taskName^"' already exists"
            M99
    M98 P"scripts/concatArrays.g" A{global.tasks} B{var.task,}
    set global.tasks = global.ret
