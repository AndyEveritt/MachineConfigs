; Run all tasks at the interval specified

while (iterations < #global.tasks)
    var task = global.tasks[iterations]
    var taskName = var.task[0]
    var interval = var.task[1]
    var script = var.task[2]
    var lastRunTime = var.task[3]
    
    if (var.interval <= 0)
        continue
    if (var.script == null || var.script == "")
        continue
    
    var timeSinceLastRun = state.upTime - var.lastRunTime

    if (var.timeSinceLastRun >= var.interval)
        echo "Running task '"^var.taskName^"' at "^state.upTime^" (last run: "^var.lastRunTime^")"
        set global.tasks[iterations][3] = state.upTime
        
        M98 P{var.script}
