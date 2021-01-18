# SDK-85 fun - part 3

Some rights reserved! Vintage technology preserved.

---

[Previous](../sdk85funpart1) | [Index](../../../../) | [Next](../sdk85funpart4)
--- | --- | ---

---

## Foreword about numbering

There were two former blogentries focused on sdk85:
- [Intel MCS-85 tales](dt/intelmcs85tales)
- [SDK-85 fun - part 1](dt/sdk85funpart1)

Corollary: 1 + 1 = 3

## Fun with disassembled mastermind source

There is a modified mastermind game implementation floating around for intel
MCS-85 since 2006 with unorthodox cow-counts in. This rom image is supported
by [MAME](https://github.com/mamedev/mame), as a drop-in replacement in bank0.
After a quick disassembly, enhanced in order to print "traditional" white hits
per guess - and uses only default first ram bank0 (2000h-20FFH) and rom bank1!

## Howto start a game

First of all, you have to install an appropriate MAME version.

### MAME installation

Clone MAME git
repository, and then check out first commit that supports i8755 secondary bank
rom image, the commit is:
https://github.com/mamedev/mame/pull/5427/commits/8ca33e9

Please follow the usual build and configure steps according to your environment.
Read more about building MAME here:

- [MAME](https://github.com/mamedev/mame)

Only "mess" subtarget is necessary to build in order to save time!
After MAME install and set up, get the original intel sdk85.a14 monitor rom image
and copy the mastermind.a15 file provided below to ~/mame/roms/sdk85/mastermind.a15

### Launching MAME

After launching mame from xterm with command

```
$ mess sdk85
```

or

```
$ mess64 sdk85
```

if you have a 64bit host and compiled 64bit mess binary. It will complain about:

```
mastermind.a15 WRONG CHECKSUMS:
    EXPECTED: CRC(0538e162) SHA1(c351975e2cf515cee29fcaeb04ef47189afe5250)
       FOUND: CRC(7f99f826) SHA1(0ea8df1bea26f6d043d315e516f8bc151ed12ad1)
WARNING: the machine might not run correctly.
```

Simply ignore that message.

## Keycombos / screenshots / example game session

Will write it in the following blog entry. Stay t00ned! :)

## Downloadable stuff

Here you are:

- rom image [mastermind.a15](./mastermind.a15)
- rom source code [mastermind_a15.d85](./mastermind_a15.d85)
- 8085 compiler [pasm8085-beta4.pl](../sdk85funpart1/pasm8085-beta4.pl)

## Have fun!

[Previous](../sdk85funpart1) | [Index](../../../../) | [Next](../sdk85funpart4)
--- | --- | ---
