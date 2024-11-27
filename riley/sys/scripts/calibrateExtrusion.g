; Inputs
var tool = param.T
var maxSpeed = exists(param.S) ? param.S : 20
var dist = exists(param.D) ? param.D : 20
var minExtrusionThreshold = exists(param.E) ? param.E : 0.95

; Configuration
var baseSpeed = 1
var debug = true

; Internal variables
var speeds = {1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1}
var speedInc = var.maxSpeed / #var.speeds
while (iterations < #var.speeds)
    set var.speeds[iterations] = var.speedInc * (iterations + 1)

var drive = tools[var.tool].filamentExtruder
var flows = var.speeds ; must be same length as var.speeds
var eMulti = var.speeds ; must be same length as var.speeds
var numMeasurements = 0

; Calibrate default extrusion percentage
if (#var.speeds != #var.eMulti)
    abort "var.speeds must have the same length as var.eMulti"

echo "Calibrating extrusion rate for T"^var.tool^" using filament \""^move.extruders[tools[var.tool].filamentExtruder].filament^"\""
echo "Settings: distance = "^var.dist^"mm, base speed = "^var.baseSpeed^"mm/s, min extrusion threshold = "^{var.minExtrusionThreshold * 100}^"%"
echo "Speeds: "^var.speeds^"mm/s"

if (sensors.filamentMonitors[var.drive].type != "rotatingMagnet")
    abort "Must be a rotating magnet encoder"
if (sensors.filamentMonitors[var.drive].enableMode != 2)
    abort "Encoder mode must be S2"
if (sensors.filamentMonitors[var.drive].configured.allMoves != true)
    abort "Encoder must be active for all moves (A2)"


T{var.tool}
M221 D{var.drive} S100
M592 D{var.drive} A0 B0
G1 X334 Y100 F30000
; M591 D{var.drive} P3 S2 A1  ; set magnetic encoder to record during all moves
M400
G1 E{var.dist} F{var.baseSpeed * 60}
M400
var flow = sensors.filamentMonitors[var.drive].lastPercentage / 100
var baseFlowModifier = {100 / var.flow}
echo "Setting base extrusion factor override for drive "^var.drive^" = "^var.baseFlowModifier
M221 D{var.drive} S{var.baseFlowModifier}

; Collect non linear data
while iterations < #var.speeds
    G1 E{var.dist} F{var.speeds[iterations] * 60}
    M400
    set var.flow = sensors.filamentMonitors[var.drive].lastPercentage / 100
    set var.flows[iterations] = var.flow
    set var.eMulti[iterations] = 1 / var.flow
    echo "Flow at "^var.speeds[iterations]^"mm/s = "^{var.flow * 100}^"%, requires extrusion multiplier of "^{var.eMulti[iterations] * 100}^"%"

    if (var.flow < var.minExtrusionThreshold)
        set var.numMeasurements = iterations
        break

echo "Number of measurements = "^var.numMeasurements
echo "Flows: "^var.flows
echo "Required extrusion multipliers: "^var.eMulti

; Quadratic regression
; https://www.statisticshowto.com/quadratic-regression/
var x = 0
var y = 1
var x2 = 0
var x3 = 0
var x4 = 0
var xy = 0
var x2y = 0

while (iterations < var.numMeasurements)
    set var.x = var.x + var.speeds[iterations]
    set var.y = var.y + var.eMulti[iterations]
    set var.x2 = var.x2 + (var.speeds[iterations] * var.speeds[iterations])
    set var.x3 = var.x3 + (var.speeds[iterations] * var.speeds[iterations] * var.speeds[iterations])
    set var.x4 = var.x4 + (var.speeds[iterations] * var.speeds[iterations] * var.speeds[iterations] * var.speeds[iterations])
    set var.xy = var.xy + (var.speeds[iterations] * var.eMulti[iterations])
    set var.x2y = var.x2y + (var.speeds[iterations] * var.speeds[iterations] * var.eMulti[iterations])

if var.debug
    echo "x = "^var.x
    echo "y = "^var.y
    echo "x2 = "^var.x2
    echo "x3 = "^var.x3
    echo "x4 = "^var.x4
    echo "xy = "^var.xy
    echo "x2y = "^var.x2y

; add 100% flow at 0 speed
set var.numMeasurements = var.numMeasurements + 1

; a*var.x4 + b*var.x3 + c*var.x2 = var.x2y
; a*var.x3 + b*var.x2 + c*var.x = var.xy
; a*var.x2 + b*var.x + c*var.numMeasurements = var.y

; Because we have normalised the base extrusion multiplier with a slow extrusion rate
; c ~= 1
var c = 1

; Therefore
; a*var.x4 + b*var.x3 = var.x2y - var.x2
; a*var.x3 + b*var.x2 = var.xy - var.x
; a*var.x2 + b*var.x = var.y - var.numMeasurements

; a = (var.y - var.numMeasurements - b*var.x) / var.x2

; ((var.y - var.numMeasurements - b*var.x) / var.x2)*var.x3 + b*var.x2 = var.xy - var.x
; ((var.y - var.numMeasurements - b*var.x)*var.x3 / var.x2) + b*var.x2 = var.xy - var.x

var b = ((var.xy - var.x) - (((var.y - var.numMeasurements)*var.x3)/var.x2))/(var.x2 - ((var.x * var.x3)/var.x2))
var a = ((var.y - var.numMeasurements) - (var.b * var.x))/var.x2

if var.debug
    echo "a = "^var.a
    echo "b = "^var.b
    echo "c = "^var.c

; Note var.a and var.b are flipped because M592 uses the equation (1 + min(L, Av + Bv^2)) which has different coefficients to that uses to solve the quadratic regression
echo "Setting non linear extrusion multiplier with: M592 D"^var.drive^" A"^var.b^" B"^var.a
M592 D{var.drive} A{var.b} B{var.a}

; M591 D{var.drive} P3 S1 A1  ; only monitor filament during prints
