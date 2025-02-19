M98 P"scripts/createTask.g" V"ledTask" F1000 S"scripts/tasks/ledTask.g"
M98 P"scripts/createTask.g" V"fanTask" F1000 S"scripts/tasks/fanTask.g"

while true
    ; Run all tasks at the interval specified
    M98 P"scripts/rtosLoop.g"
    ; M98 P"scripts/tasks/ledTask.g"
    ; M98 P"scripts/tasks/fanTask.g"

    G4 P{global.daemonTick}
