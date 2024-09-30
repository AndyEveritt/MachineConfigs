if exists(param.X) && (!move.axes[0].homed)
    G28 X
if exists(param.Y) && (!move.axes[1].homed)
    G28 Y
if exists(param.Z) && (!move.axes[2].homed)
    G28 Z
if exists(param.C) && (!move.axes[4].homed)
    G28 C
if exists(param.B) && (!move.axes[3].homed)
    G28 B
