var tick = 250 ; in ms

M98 P"scripts/createTask.g" V"ledTask" F1 S"scripts/tasks/ledTask.g"
M98 P"scripts/createTask.g" V"fanTask" F5 S"scripts/tasks/fanTask.g"

var ms = 0  ; current milliseconds counter
while true
    ; Run all tasks at the interval specified
    M98 P"scripts/rtosLoop.g"
    ; M98 P"scripts/tasks/ledTask.g"
    ; M98 P"scripts/tasks/fanTask.g"

    G4 P{var.tick}
