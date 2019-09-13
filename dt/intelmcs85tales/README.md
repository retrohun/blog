# Intel MCS-85 tales
Some rights reserved! Vintage technology preserved.

---

[Previous](../aixps2part2) | [Index](../../../../) | [Next](../i8080emulatorinbash)
--- | --- | ---

---

## MCS-85 system development kit

We own two such CPU trainer boards. One is in fully working condition, the another one needs testing and resoldering.

Some specifications

| Name     | Intel MCS-85            |
| -------- | ----------------------- |
| Released | 1977                    |
| CPU      | Intel 8085A @ 3MHz      |
| Memory   | 256 bytes RAM (8155)    |
| Display  | 6 digit LED display     |
| Ports    | 38-line parallel bus    |
| OS       | Monitor in ROM          |
| Option 1 | Additional ROM (8755)   |
| Option 2 | Additional RAM (8155)   |
| Option 3 | Serial terminal support |

## Trying MAME as a testing platform

Was unsuccessful. In current MAME, the MCS-85 evboard needs the following files according to our knowledge and the ubuntu workstation's console dump:

```
user@errorlevel:0:~/github.com/retrohun/mame$ LC_ALL=C dpkg -l mess | grep -ie'[a-z]' | tr -s ' '
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name Version Architecture Description
ii mess 0.160-0ubuntu1 amd64 Multi Emulator Super System (MESS)
user@errorlevel:0:~/github.com/retrohun/mame$
```

So it is pretty outdated! Let's list the supported roms by the sdk85 platform, of which the MCS-85 evboard can be used:

```
user@errorlevel:0:~/github.com/retrohun/mame$ mess -listroms sdk85 | tr -s ' '
ROMs required for driver "sdk85".
Name Size Checksum
sdk85.a14 2048 CRC(9d5a983f) SHA1(54e218560fbec009ac3de5cfb64b920241ef2eeb)
user@errorlevel:0:~/github.com/retrohun/mame$
```

That's not much. Latest MAME/mess supports a replacement BIOS, which contains a slightly modified mastermind game. But it is still rigid, lacks option rom slot support and the mastermind game itself uses the second RAM 8155 bank at address 0x2800, which is usually missing in regular kits. So I've made a pull request here: [github.com/mamedev/mame/pull/5427](
https://github.com/mamedev/mame/pull/5427/ )

The changes cover these:

- original sdk85.a14 and mastermind.a14 can be used without modifications
- added a trivial empty rom filled with zeroes (NOP instuctions)
- add support of empty rom in mandatory 0th bank (address 0x0000, size 2kbytes)
- new feature: option rom bank image support (address 0x0800, size 2kbytes)
- option rom image: mastermind.a15 also with corrected RAM bank usage

The checksums that are needed for the end user in order to acquire the images:
```
user@errorlevel:0:~/github.com/retrohun/mame$ ./mess64 -listroms sdk85 | tr -s ' '
ROMs required for driver "sdk85".
Name Size Checksum
sdk85.a14 2048 CRC(9d5a983f) SHA1(54e218560fbec009ac3de5cfb64b920241ef2eeb)
mastermind.a14 2048 CRC(36b694ae) SHA1(4d8a5ae5d10e8f72a6e349c7eeaf1aa00c4e45e1)
empty.a14 2048 CRC(f1e8ba9e) SHA1(605db3fdbaff4ba13729371ad0c4fbab3889378e)
mastermind.a15 2048 CRC(0538e162) SHA1(c351975e2cf515cee29fcaeb04ef47189afe5250)
user@errorlevel:0:~/github.com/retrohun/mame$
```

There is an excerpt from the pull request's changes that explains how to start the option rom from the SDK85 monitor:

```
38 Notes on expansion rom with default content Mastermind.
39 Original authors: see above (Paolo Forlani and Stefano Bodrato)
40 Ported to option rom: NASZVADI Peter
41 
42 The game can be started from monitor by defining SP as 20FFh and PC as 0800h and starting execution.
43 When setting register values in monitor, SPH, SPL, PCH and PCL values must be set to 20, FF, 08, 00 respectively before start!
44 Stefano's bios had been altered in order to use lower ram bank and the option rom slot.
45 When selecting "Empty" a14, which is basically 2kbytes of zeros, the default option rom will be launched directly.
```

## The option rom image

Pasted here using a hexdump clone called xxd, it can be 'reverted' to binary with that tool, too.

```
user@errorlevel:0:~/mess/roms/sdk85$ xxd -a mastermind.a15 
00000000: f331 ff20 2100 1936 cc36 2b36 e036 c236  .1. !..6.6+6.6.6
00000010: 943e ff21 0018 7777 3e0f cd63 097b c601  .>.!..ww>..c.{..
00000020: 275f 7ace 0027 573a 0019 a7ca 1d08 cd49  '_z..'W:.......I
00000030: 09e6 3fc2 1d08 2102 207b cd54 097a cd54  ..?...!. {.T.z.T
00000040: 0921 0a20 3600 2100 2036 03af 320b 2032  .!. 6.!. 6..2. 2
00000050: 0c20 3e0e cd63 09cd a609 3a00 2032 0120  . >..c....:. 2. 
00000060: cd22 09ca 7f08 3e03 3201 20cd 2209 ca86  ."....>.2. ."...
00000070: 083a 0120 b7ca 8a08 2101 2035 c36b 0821  .:. ....!. 5.k.!
00000080: 0b20 34c3 8a08 210c 2034 cd81 093a 0020  . 4...!. 4...:. 
00000090: b7ca 9b08 3d32 0020 c357 083a 0a20 c601  ....=2. .W.:. ..
000000a0: 2732 0a20 0e04 2106 2011 0220 1abe c2f4  '2. ..!. .. ....
000000b0: 0823 130d c2ac 083a 0019 a7ca c608 cd49  .#.....:.......I
000000c0: 09fe 02ca e008 cd3f 093e 9032 0019 2100  .......?.>.2..!.
000000d0: 183e ff77 7777 77cd 3f09 cd81 09c3 b708  .>.wwww.?.......
000000e0: 2106 203a 0a20 cd54 093e 0f77 2377 cd81  !. :. .T.>.w#w..
000000f0: 09c3 1d08 cd14 093a 0c20 3206 203a 0b20  .......:. 2. :. 
00000100: 3208 203e 0f32 0720 3209 20cd 8109 cd14  2. >.2. 2. .....
00000110: 09c3 4608 d5e5 11dc b41b 7ab3 c219 09e1  ..F.......z.....
00000120: d1c9 e5c5 d53a 0020 4f06 003a 0120 5f16  .....:. O..:. _.
00000130: 0021 0620 097e 2102 2019 bed1 c1e1 c911  .!. .~!. .......
00000140: 0030 1b7a b3ca 4209 c93e 4032 0019 3a00  .0.z..B..>@2..:.
00000150: 18e6 3fc9 f5e6 0f77 23f1 e6f0 0f0f 0f0f  ..?....w#.......
00000160: 7723 c91e 0421 0620 7723 1dc2 6809 c381  w#...!. w#..h...
00000170: 09f3 60b5 f466 d6d7 70f7 7677 9767 1704  ..`..f..p.vw.g..
00000180: 00e5 d51e 043e 9032 0019 2109 207e e5c5  .....>.2..!. ~..
00000190: 4f06 0021 7109 097e c1e1 2f32 0018 2b1d  O..!q..~../2..+.
000001a0: c28d 09d1 e1c9 e5d5 c53a 0019 e607 caa9  .........:......
000001b0: 09cd 4909 5f16 0021 cb09 1946 3a00 205f  ..I._..!...F:. _
000001c0: 1600 2106 2019 70c1 d1e1 c900 0102 0304  ..!. .p.........
000001d0: 0506 0708 090a 0b0c 0000 0000 0000 0000  ................
000001e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
00000630: 0000 0000 0000 0000 0000 0001 0000 0000  ................
00000640: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000007f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
user@errorlevel:0:~/mess/roms/sdk85$ 
```

The above game can be used standalone only with the empty flat rom file (empty.a14)

```
user@errorlevel:0:~/mess/roms/sdk85$ xxd -a empty.a14 
00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
*
000007f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
user@errorlevel:0:~/mess/roms/sdk85$
```

## Remarks

These files are different: mastermind.a14 and mastermind.a15! However they are basically same in most aspects like implementing the same game.

Originally it began to be a teensy project in order to get a decent and cool testing platform for developing roms.

Of course we are interested in backporting changes to earlier mame or mess versions, feel free to contact me!

## Related links

- [SDK-85 users manual on bitsavers.trailing-edge.com](
  https://bitsavers.trailing-edge.com/components/intel/8085/9800451A_SDK-85_Users_Manual_Jul77.pdf )
- [Intel System Development Kit entry on Wikipedia](
  https://en.wikipedia.org/wiki/Intel_System_Development_Kit#SDK-85 )
- [oldcomputers.net/intel-mcs-85.html](
  http://oldcomputers.net/intel-mcs-85.html )

---

[Previous](../aixps2part2) | [Index](../../../../) | [Next](../i8080emulatorinbash)
--- | --- | ---
