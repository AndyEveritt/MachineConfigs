var Red = 0
var Green = 0
var Blue = 0
var Brightness = 255

if exists(param.R)
    set var.Red = param.R

if exists(param.U)
    set var.Green = param.U

if exists(param.B)
    set var.Blue = param.B

if exists(param.P)
    set var.Brightness = param.P

M150 E0 R0 U0 B0 P0 S1 F1                                   ; we don't want the first LED on because of its physical position
M150 E0 R{var.Red} U{var.Green} B{var.Blue} P{var.Brightness} S6 F0