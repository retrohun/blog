# Booting from COM1
Some rights reserved! Vintage technology preserved.

---

[Previous](../qnx2fun) | [Index](../../../../) | Next
--- | --- | ---

---

## Abusing IBM ROM BASIC
Some IBM brand x86 based machines had builtin BASIC in their ROM. These can be accessed booting such a machine without any bootable media - no bootable harddisk nor diskette, nor network card with netbooting capabilities and onboard rom containing RPL or similar. It is mentioned on [vcfed.org forums](http://www.vcfed.org/forum/archive/index.php/t-41602.html) as well as on others that ROM BASIC is hardly usable, no saving/restoring capabilities other than 5150 or PCjr, hence the name "Cassette BASIC" or "CB". According to http://bitsavers.org/pdf/ibm/pc/languages/BASIC_1.1_May82.pdf - on page 3-35 lists the only devices that can be used with CB:

| Name  | Description                               |
|-------|-------------------------------------------|
| KYBD: | keyboard                                  |
| SCRN: | screen                                    |
| LPT1: | printer - output only, with LIST, "LPT1:" |
| CAS1: | see more: http://github.com/retrohun/pce  |

### Why did I do this?
Just for fun :)

Simple answer: imagine a machine with no attached storages like diskette drives, memory disks, harddisks, optical drives, tapes etc. In that case, an alternate way is necessary to boot an **operating system** other than ROM BASIC.

The so-called CB has no support for high level access for peripherals on most IBM machines - except the first parallel port for output only. I've managed to boot galaxian using "CAS1:" before:

![PCE ROMBIOS Galaxian](https://raw.githubusercontent.com/retrohun/pce/master/doc/pcerombiosgalaxian.gif)

But there should be another way to access external data sources during booting in an efficient way. The only IBM machines that have CB:

- IBM-PC
- IBM-PCjr
- IBM-XT
- IBM-XT 286
- IBM-AT
- PS/2 Model 25
- PS/2 Model 30
- PS/2 Model 25 286
- PS/2 Model 30 286
- PS/2 Model 50
- PS/2 Model 55SX
- PS/2 Model 60
- PS/2 Model 70
- PS/2 Model 73 (P75?)
- PS/2 Model 80

according to: http://www.walshcomptech.com/ohlandl/config/ROM_Basic.html

## Proposed solution for a serial port booter
At most two lines of *basic* code:
```
1 DATA 14,7,184,227,0,153,137,215,205,20,185,0,224,180,2,205,20,158,120,249,252,170,226,245,81,195
2 DEF SEG=256:A=65432:FOR I=0 TO 25:READ J:POKE A+I,J:NEXT:CALL A
```
Enter in CB "IDE" after turning on the computer. Then run it by pressing F2 or entering RUN command.

### Explanation
In the first line, there is a 8088 machine code chainloader that has to be "poked" to the memory segment 0x100 (256) on an enough high target offset. Galaxian booter in my example needs 56 kbytes (57344 bytes exactly). The corresponding bytes in the DATA section is: "0,224", which encodes the word 0xE000 in little endian, hence the reversed order of nibbles. Obviously, variable A must be set greater than 57344 in this example.

The assembly source of the COM1 loader routine in case if anyone wanted to optimize:
```
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bits 16
_start:
        push cs
        pop  es
        mov  ax, 0E3h ; 9600 baud,8 data,0 parity,1 stopbit
        cwd           ; DX := 0 = COM1
        mov  di, dx   ; DI := 0
        int  14h
        mov  cx, 57344; size of loadable code
sloop:  mov  ah, 2
        int  14h
        sahf          ; shortest test pf highest bit of AH
        js   sloop    ; if set, try again reading COM1
        cld
        stosb         ; store read data in segment
        loop sloop
        push cx       ; destination address := 0
        ret           ; jump to loaded code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
```

## Test drive
All you need is pce build with basic and ibm xt or pc rom images, a unixish environment with netcat installed, a galaxian dump named to "galax56k.bin"  and the following dual syntax pce configuration file:

- [pce-5160.sh](pce-5160.sh)

A free tcp host socket is necessary just pick one unused, I chose 5232 in the previous configuration file. The virtual serial socket can be replaced with PTY or other BIDI solutions p.ex. attaching host's serial port.

### Obtaining Galaxian binary data
The source can be both an .EXE file, or a floppy image. Simply find the first 0xE9 0xEB 0x01 three bytes and dump it together with the consecutive 57341 bytes.

## TODO

- test on real machines. Got some candidates, of course :)
- test more applications, converting more booter games etc.
- hacking basic within basic e.g. hooking cassette interrupt using COM1/2 or LPT2
- "golfing" = shortening basic code
- more tests

#### Boldog karácsonyt!

---

[Previous](../qnx2fun) | [Index](../../../../) | Next
--- | --- | ---
