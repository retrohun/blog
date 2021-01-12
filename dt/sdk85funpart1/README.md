# SDK-85 fun - part 1

Some rights reserved! Vintage technology preserved.

---

[Previous](../custombootromfun) | [Index](../../../../) | [Next]
--- | --- | ---

---

As many retrocomputing enthusiasts, we also collect vintage computers and
parts, luckily got 2 Intel MCS-85 evboards, often referred as "SDK-85", one
is working, the other is untested. Our goal is to develop a custom rom image
for the rom bank 1 which is empty now. Planned to get some 8755 writable rom
chip for this purpose, but couldn't find any kind of firmware around. Felt
motivated, modified and rewritten a mastermind game (uses bank 0!) delivered
with Mamedev's [MAME](https://github.com/mamedev/mame)

## Origins 'n' stuff

In the past, got a scanned version of a 8355 rom chip content, namely the
official intel monitor image source code. Due to obvious reasons, it was full
of typos and errors - OCR cannot deal with zeros and letter "O" and so on. So
after entered manually, found out that we ain't got no 8085 compilers :) So
quickly wrote one in perl that even handles EQU directives and formulas
needed by the source. Here you are:

- [pasm8085-beta4.pl](./pasm8085-beta4.pl)

Bet it is worth to mention that I've never had any Z80/8085 experience before
when I wrote this assembler. It had only one (completed) job - successfully
compiled the scanned and manually corrected source code! :)

To be continued!

Have fun!

## Links

- [Wiki docs](https://en.wikipedia.org/wiki/Intel_System_Development_Kit#SDK-85)
- [MAME source repository](https://github.com/mamedev/mame)

---

[Previous](../custombootromfun) | [Index](../../../../) | [Next]
--- | --- | ---
