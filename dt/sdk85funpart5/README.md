# SDK-85 fun - part 5

Some rights reserved! Vintage technology preserved.

---

[Previous](../randomupdates3) | [Index](../../../../) | [Next]
--- | --- | ---

---

## A bit messy to use mess cli...

But certainly possible, so figured out how to invoke from command line a
freshly built mess, specifying custom option rom to the Intel MCS-85 machine:

```
github.com/retrohun/mame$ git log -1 --no-color --oneline
6a397596342 (HEAD -> master, origin/master, origin/HEAD) generalplus_gpl16250_nand.cpp: fixed MT08270

github.com/retrohun/mame$ ./mess -version|awk 1
0.242 (mame0236-2186-g6a397596342)

github.com/retrohun/mame$ sha1sum ~/mess/roms/sdk85/sdk85.a14 ~/mess/roms/sdk85/mastermind.a15
54e218560fbec009ac3de5cfb64b920241ef2eeb  ~/mess/roms/sdk85/sdk85.a14
0ea8df1bea26f6d043d315e516f8bc151ed12ad1  ~/mess/roms/sdk85/mastermind.a15

github.com/retrohun/mame$ cksum ~/mess/roms/sdk85/sdk85.a14 ~/mess/roms/sdk85/mastermind.a15
2306435352 2048 ~/mess/roms/sdk85/sdk85.a14
3810006495 2048 ~/mess/roms/sdk85/mastermind.a15

github.com/retrohun/mame$ ./mess sdk85 -rom ~/mess/roms/sdk85/mastermind.a15
Average speed: 100.00% (234 seconds)
```
## Launching Mastermind option rom game from monitor

A reset could be handy via pressing F1. A side effect of this is that it will
set up the stack pointer! The remaining keycombinations are according to the
latest MAME/MESS keyboard assingments:

| MCS-85 | Mapping | Remarks       |
| ------ | ------- | ------------- |
|  Exam  |    X    | examine regs. |
| 6 PCH  |    6    | PC high byte  |
|   0    |    0    |     08..H     |
| 8  H   |    8    |               |
|  Next  |    ,    | then PC LSB   |
|   0    |    0    |     ..00H     |
|   0    |    0    |   = 0800H     |
|  Next  |    ,    | exit examin.  |
|   Go   |    G    |               |
|  Exec  |    .    |      run      |

Game starts after pressing button "0", at each game end, should press "3".
Yet another 8 bit demoscene platform was born!

## Links

- 8085 compiler [pasm8085-beta4.pl](../sdk85funpart1/pasm8085-beta4.pl)
- rom source code [mastermind_a15.d85](../sdk85funpart3/mastermind_a15.d85)
- [Intel MCS-85 tales](../intelmcs85tales)
- [SDK-85 fun - part 1](../sdk85funpart1)
- [SDK-85 fun - part 3](../sdk85funpart3)
- [SDK-85 fun - part 4](../sdk85funpart4)
- [MAME source repository](https://github.com/mamedev/mame)
- [Wiki docs](https://en.wikipedia.org/wiki/Intel_System_Development_Kit#SDK-85)

Have fun!

---

[Previous](../randomupdates3) | [Index](../../../../) | [Next]
--- | --- | ---
