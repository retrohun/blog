# AT&T Unix first try

Some rights reserved! Vintage technology preserved.

---

[Previous](../microportunixon286) | [Index](../../../../) | [Next](../custombootromfun)
--- | --- | ---

---

I have never met AT&T Unix before, a plausible goal was installing it in when I accidentally found some install images at home. And everything was straightforward, however I applied some tricks I already known. No graphic content, but still no warranty - as usual! :-)

## DIY floppy image file conversion

The extension of all images are ".DCF". Despite attached the corresponding conversion software for MS-DOS in the bundle, applied the usual trial-and-error method to "disassemble" the images:

```
$ unzip -l A.zip|sed -ne'1,8p;/U..\.DCF/{9s/.*/\n...\n/gp};34,$p'
Archive:  A.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
    57530  1991-06-12 14:20   CCOPY.EXE
     3037  1999-12-21 00:58   README.!!!
  1474722  1992-01-28 20:33   U01.DCF
  1474722  1992-01-28 20:33   U02.DCF
  1474722  1992-01-28 20:33   U03.DCF

...

  1474722  1992-01-28 22:44   U29.DCF
  1474722  1992-01-28 22:44   U30.DCF
---------                     -------
 44302227                     32 files

$
```
All floppy images are exactly 162 bytes longer than a usual 1.44MB 3.5" standard. So let's check them again if they have some common header:

```
$ for i in U{01..30}.DCF;do hexdump -Cn162 $i|tr -d '\n';echo;done|uniq -c|awk '$0=$1'
30
$
```

This means obviously that all image files have the same 162 length header. After hexviewed some of them, recognized the usual pattern: most disks are cpio/tar files truncated to/padded to 1.44MB except the boot disk (with system boot record, magicword 0AA55h, fs etc. The following perl oneliner did all conversions to raw format:

```
$ perl -i -0777 -pes/.{162}//s U*.DCF
$
```

## Base system installation

The purpose of each image file are listed in the attached readme, so launched *qemu-system-i386* in terminal with curses, fed all 10 images with necessary order - note that alt-2/alt-1 switches between qemu monitor and simulated vga screen instead of alt-Fn in graphic mode! There are several other reasons for choosing qemu particulary this OS: ne2000 ISA card support, curses, speed... spoiler alert: it worked as a charm ;-)

In qemu monitor management interface, floppy images can be attached with "change floppy0 IMAGENAME.FILE.IMG" command for example. Virtual floppy disk removal command: "eject floppy0", of course withOUT quotes in all cases! For the curious, tab completion does work in monitor interestingly - both for commands, permitted parameters or for filenames!

### Disk image creation

Created image: 1015 cylinders, 16 heads, 63 sectors per track:

```
$ qemu-img create -f vmdk 10151663.vmdk 511560k
```

### Invoking qemu

Full virtual machine commandline with an empty floppy drive:

```
$ qemu-system-i386 -nodefaults \
  -hda 10151663.vmdk \
  -drive if=floppy \
  -m 32 \
  -net nic,model=ne2k_isa \
  -net user \
  -monitor vc \
  -serial vc \
  -parallel vc \
  -vga std \
  -curses \
  -no-reboot
```

The no-reboot switch is handy when some installation steps needs reboot - it is worth taking backups of harddisk images between two power cycles! Can use archives or snapshotting features - depending on disk image formats, host environment etc.

With this curses magic, grabbing text from guest to host using clipboard become easy - regardless support from guest side, so here is a merged dump of many simulated 80x25! VGA textmode dumps in linux host xterm:

```
total real memory        = 33157120
total available memory   = 31277056

AT&T UNIX System V/386 Release 4.0 Version 2.1

Copyright (c) 1984, 1986, 1987, 1988, 1989, 1990 AT&T
Copyright (c) 1987, 1988 Microsoft Corp.
All Rights Reserved


NOTICE: HD: interrupt with no request queued
Node: attsvr4
Setting up new kernel environment
The system is coming up.  Please wait.
The system is ready.


Welcome to the AT&T 386 UNIX System
System name: attsvr4

Console Login: root
Password:
Your password has expired. Choose a new one
New password:
Re-enter new password:
UNIX System V/386 Release 4.0 Version 2.1
attsvr4
Copyright (C) 1984, 1986, 1987, 1988, 1989, 1990 AT&T
Copyright (C) 1987, 1988 Microsoft Corp.
All Rights Reserved

/                  :    Disk space: 438.89 MB of 453.43 MB available (96.79%).
/stand             :    Disk space:   4.56 MB of   5.41 MB available (84.27%).

Total Disk Space: 443.45 MB of 458.84 MB available (96.64%).

# uname -a
attsvr4 attsvr4 4.0 2.1 i386 386/AT
# bc -l
scale=66
a(1)*4
3.141592653589793238462643383279502884197169399375105820974944592304
quit
#
```

I found earlier some 3rd party (NE2000-compatible) DE-220 ISA network interface card drivers for Xenix386 (worked fine) and for AT&T Unix! The showstopper is the missing TCP/IP package, which is definiately an unobtaininum for (almost) all AT&T x86 Unix versions - TBD.

Have fun!

## Links

- [Other experiments](https://www.linuxquestions.org/questions/other-*nix-55/using-floppies-in-at-and-t-unix-system-v-release-4-version-2-1-or-docs-link-4175428440/)
- [Bitsavers docs](http://www.bitsavers.org/pdf/att/unix/)

---

[Previous](../microportunixon286) | [Index](../../../../) | [Next](../custombootromfun)
--- | --- | ---
