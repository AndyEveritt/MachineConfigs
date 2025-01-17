var taskName = param.V
var time = state.upTime

while (iterations < #global.tasks)
    if (global.tasks[iterations][0] != var.taskName)
        continue
    
    var task = global.tasks[iterations]
    set global.tasks[iterations][3] = var.time
    echo "Running task '"^var.taskName^"'"
    M98 P"{var.task[2]}"
    M99

echo "Task '"^var.taskName^"' not found"
