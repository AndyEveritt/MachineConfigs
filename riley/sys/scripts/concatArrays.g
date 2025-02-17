; Concatenate two arrays

var left = param.A ; left array
var right = param.B ; right array

var len = #var.left + #var.right

var result = vector(var.len, 0)

while (iterations < #var.left)
    set var.result[iterations] = var.left[iterations]

while (iterations < #var.right)
    set var.result[iterations + #var.left] = var.right[iterations]

set global.ret = {var.result}
