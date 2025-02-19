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
    
    var currentTime = 1000 * state.upTime + state.msUpTime
    var timeSinceLastRun = var.currentTime - var.lastRunTime

    if (var.timeSinceLastRun >= var.interval)
        if (global.debug)
            echo "Running task '"^var.taskName^"' at "^var.currentTime^" (last run: "^var.lastRunTime^")", "interval: " ^ {var.timeSinceLastRun}
        set global.tasks[iterations][3] = var.currentTime
        
        M98 P{var.script}
