# i8080 emulator in bash

Some rights reserved! Vintage technology preserved.

---

[Previous](../intelmcs85tales) | [Index](../../../../) | [Next]
--- | --- | ---

---

## What is it?
An Intel 8080 CPU based vintage machine emulator that loads 2k basic
(re)published by Oscar Toledo. Used only STDIO via IN/OUT statements,
no storage or other peripherals are implemented. Quick and dirty code,
unoptimized and slow, corrected dozens of bugs, but still might be buggy!
I wrote this in bash, tested under :
"GNU bash, version 4.3.48(1)-release (x86_64-pc-linux-gnu)"

- [i8080.sh](./i8080.sh)

## Example session

```
$ bash i8080.sh
Quick and dirty i8080 emulator by NASZVADI Peter, 2019.
Press Ctrl+C to quit anytime!
Initializing upper memory to NOPs
Initializing register values
Starting CPU emulation


OK
>PRINT "Interactive mode (statements must be allcaps!)"
Interactive mode (statements must be allcaps!)

OK
>PRINT 42+100
   142

OK
>10 FOR I=1 TO 3
>20 PRINT "Random number:",RND(6)
>30 NEXT I
>LIST
  10 FOR I=1 TO 3
  20 PRINT "Random number:",RND(6)
  30 NEXT I

OK
>RUN
Random number:     4
Random number:     6
Random number:     1

OK
>
$ # Ctrl-C is pressed, session terminated
```

## External links

- https://nanochess.org/emulator.html
- http://ioccc.org/2006/toledo2/hint.text
- http://www.classiccmp.org/dunfield/r/8080.txt
- https://en.wikipedia.org/wiki/Intel_8080
- https://virtuallyfun.com/wordpress/2010/06/17/toledo-8080-emulator/

## Have fun!

[Previous](../intelmcs85tales) | [Index](../../../../) | [Next]
--- | --- | ---
