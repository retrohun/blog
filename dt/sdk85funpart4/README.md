# SDK-85 fun - part 4

Some rights reserved! Vintage technology preserved.

---

[Previous](../sdk85funpart3) | [Index](../../../../) | [Next]
--- | --- | ---

---

# MCS-85 secondary rom bank 101 

An example session - continued from [SDK-85 fun - part 1](dt/sdk85funpart1)

### Howto boot custom rom bank from Intel MCS-85 monitor

If MAME/MESS64 is used, press space twice to get over intro
screen! Other steps are same in both virtual or baremetal
environments.

![MESS64-SDK85-1.PNG](mess64-sdk85-1.png)

![MESS64-SDK85-2.PNG](mess64-sdk85-2.png)

Below is the sdk85's greetings, "POST screen" meaning evboard is okay
and ready to use.

![MESS64-SDK85-3.PNG](mess64-sdk85-3.png)

###

The stack pointer and program counter MUST have been initialized before
work! Let's assign values 20C2H and 0800H to SP and PC respectively:

Examine registers:

- ![MESS64-SDK85-4.PNG](mess64-sdk85-4.png)

Jump through F register:

- ![MESS64-SDK85-5.PNG](mess64-sdk85-5.png)

Jump through again:

- ![MESS64-SDK85-6.PNG](mess64-sdk85-6.png)

And again:

- ![MESS64-SDK85-7.PNG](mess64-sdk85-7.png)

Still not stack pointer:

- ![MESS64-SDK85-8.PNG](mess64-sdk85-8.png)

At least!

- ![MESS64-SDK85-9.PNG](mess64-sdk85-9.png)
- ![MESS64-SDK85-10.PNG](mess64-sdk85-10.png)
- ![MESS64-SDK85-11.PNG](mess64-sdk85-11.png)
- ![MESS64-SDK85-12.PNG](mess64-sdk85-12.png)
- ![MESS64-SDK85-13.PNG](mess64-sdk85-13.png)
- ![MESS64-SDK85-14.PNG](mess64-sdk85-14.png)

Now PC register is set:

- ![MESS64-SDK85-15.PNG](mess64-sdk85-15.png)
- ![MESS64-SDK85-16.PNG](mess64-sdk85-16.png)
- ![MESS64-SDK85-17.PNG](mess64-sdk85-17.png)
- ![MESS64-SDK85-18.PNG](mess64-sdk85-18.png)
- ![MESS64-SDK85-19.PNG](mess64-sdk85-19.png)
- ![MESS64-SDK85-20.PNG](mess64-sdk85-20.png)

Pressing "Next" finishes examining CPU registers, then "Go" and
"Exec" should have been pressed in order to boot secondary rom
bank:

- ![MESS64-SDK85-21.PNG](mess64-sdk85-21.png)
- ![MESS64-SDK85-22.PNG](mess64-sdk85-22.png)
- ![MESS64-SDK85-23.PNG](mess64-sdk85-23.png)

Till this, every steps are the same regardless of the contents
of the custom rom bank, entry points - PC values may vary.

### Having fun with custom mastermind ROM

"0" to press in order to start a new game

- ![MESS64-SDK85-24.PNG](mess64-sdk85-24.png)

First 3 guesses are cut, just 2 finals were kept before winning
the game. Next-to-last try is "5 6 2 1"

- ![MESS64-SDK85-25.PNG](mess64-sdk85-25.png)
- ![MESS64-SDK85-26.PNG](mess64-sdk85-26.png)
- ![MESS64-SDK85-27.PNG](mess64-sdk85-27.png)
- ![MESS64-SDK85-28.PNG](mess64-sdk85-28.png)

"Two bulls one cow" :-) Two black sticks and one white:

- ![MESS64-SDK85-29.PNG](mess64-sdk85-29.png)

"6 4 2 1" succeeded!

- ![MESS64-SDK85-30.PNG](mess64-sdk85-30.png)
- ![MESS64-SDK85-31.PNG](mess64-sdk85-31.png)
- ![MESS64-SDK85-32.PNG](mess64-sdk85-32.png)
- ![MESS64-SDK85-33.PNG](mess64-sdk85-33.png)

Machine celebrates winner blinking seven segment LED display:

- ![MESS64-SDK85-34.GIF](mess64-sdk85-34.gif)

Button "3" must be pressed in order to continue and show number
of tries:

- ![MESS64-SDK85-35.PNG](mess64-sdk85-35.png)

Pressing zero restarts the game:

- ![MESS64-SDK85-36.PNG](mess64-sdk85-36.png)

Have fun!

### Keyboard layout incompatibility notes with new MAME

MAME developers silently(?) changed the keyboard mapping in sdk85.
For the curious a rosetta table is below, the latest valid
mappings are in sdk85.cpp in MAME's source repository.

| MCS-85 | Old mapping | New mapping |
| ------ | ----------- | ----------- |
|   0    |      0      |      0      |
|   1    |      1      |      1      |
|   2    |      2      |      2      |
| 3  I   |      3      |      3      |
| 4 SPH  |      4      |      4      |
| 5 SPL  |      5      |      5      |
| 6 PCH  |      6      |      6      |
| 7 PCL  |      7      |      7      |
| 8  H   |      8      |      8      |
| 9  L   |      9      |      9      |
|   A    |      A      |      A      |
|   B    |      B      |      B      |
|   C    |      C      |      C      |
|   D    |      D      |      D      |
|   E    |      E      |      E      |
|   F    |      F      |      F      |
|  Exec  |      Q      |      .      |
|   Go   |      R      |      G      |
|  Next  |      Up     |      ,      |
|  Exam  |      Y      |      X      |
|  Subst |      T      |      S      |
| Single |      U      |      /      |

### Remarks

Apologies about the screenshots: it was a bit new to us (or
just forgotten decades ago) that 4-5-6-7 buttons are shortcuts
for SP and PC when examining registers!

According to our knowledge, there is no official working
MCS-85 secondary rom bank support in MAME, hopefully it will
change in the near future!

Have fun!

## Links

- [Wiki docs](https://en.wikipedia.org/wiki/Intel_System_Development_Kit#SDK-85)
- [MAME source repository](https://github.com/mamedev/mame)

---

[Previous](../sdk85funpart3) | [Index](../../../../) | [Next]
--- | --- | ---
