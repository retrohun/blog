# Xenix286 on demand - Retrohun blog

Some rights reserved! Vintage technology preserved.

[Previous](../toshibat3100fun) | [Index](../../../../) | Next
--- | --- | ---

## Unix-x86 ports from the past
Unix v6-7, SystemIII-V, BSD unix and other flavours had been ported even to 8086 and above since those CPU-s are released + some years delay. Even Microsoft participated in the who-ports-fancier stuff competition, and the result was Xenix. Descriptions of installation of x86 port and features, kits are floating around in several good pages, especially at [os2museum.com](http://www.os2museum.com/wp/category/xenix/), [virtuallyfun.com](https://virtuallyfun.com/wordpress/category/xenix/), [gunkies.org Wiki](http://gunkies.org/wiki/Xenix) etc.

They still can appear suddenly nowadays, see Snellman's writing about: [The most obsolete infrastructure money could buy - my worst job ever](https://www.snellman.net/blog/archive/2015-09-01-the-most-obsolete-infrastructure-money-could-buy/)

## What virtual platforms support Xenix286?
As of 2018:

- Qemu: since around the release of v2.x, before that versions 0.14.x-0.15.x were only able to allow xenix guests.
- VirtualBox
- MESS: [visit Neozeed's blog](https://virtuallyfun.com/wordpress/2014/05/30/not-that-i-hang-out-on-irc-anymore/)

Networking: AFAIK xenix286 has no support for networking. However for v2.3.4/386: SLIP can be configured in both Qemu and VirtualBox, and also 3c503 etherlink NIC support allegedly works in MESS as in the previous link.

Remarkable and annoying that version "2.3.2 for 286", which is the latest known Xenix flavour that supports 286 - has broken guest serial port support in all known host solutions, read more about this here: [http://www.os2museum.com/wp/oldest-surviving-386-pc-os/](http://www.os2museum.com/wp/oldest-surviving-386-pc-os/)

## A fully-automated install script in Qemu

Author: N (that's me)

Prerequisities are usual: already installed recent Qemu in the path, usual binux/ubuntu CLI utilities (md5sum, netcat, bash etc.) Example session:

```
$ time ./deployxenix286qemu.sh 
Xenix 286 v2.3.2 will be deployed
Author: Naszvadi, Peter, 2018
```
...(log shortened)...
```
floppy0 (#block2196): ga.tar (raw)
    Removable device: not locked, tray closed
    Cache mode:       writeback
Exiting.

real    4m9.836s
user    0m37.556s
sys     0m11.648s
$

```

It performs most operations in background. Basically, it checks the existence and the md5 checksums of all 1.2MB HD raw floppy images including the custom game package (ga.tar), defines some functions to query qemu in order to poll screen data and sending keypress events, a handy way to simulate typing. After then, at least two contiguous "headless" qemu process will be launched. The installation itself is a straightforward, linear process with almost no branching - one exception is: a conditional question might appear if the destination hard disc image is considered to be small.

Needs around 4 minutes and 10 seconds, and these two files as well:

- [deployxenix286qemu.sh](deployxenix286qemu.sh)
- [md5sums.txt](md5sums.txt)

And of course there is a need for the floppy install kit images in raw format and with a corresponding name, guess and pair it from the provided md5sums.txt!

After automated installation, the guest can be booted with providing the corresponding C/H/S values via command line:
```
$ qemu-system-i386 -no-reboot -m 16 -net none -hda xenix286_c820h4s17_28m.img -hdachs 820,4,17,none
```

## There might be bugs
Yes. Play with hardcoded parameter values and enjoy ruining your computer, world, whatever! Use at your own risk!

## A good summary of the manual installation process
Was made by Neozeed:

- [Installing Xenix 286 on Qemu 0.14.0](https://virtuallyfun.com/wordpress/2011/04/11/installing-xenix-286-on-qemu-0-14-0/)
- [Installing Xenix on Qemu 0.14.0](https://virtuallyfun.com/wordpress/2011/04/08/installing-xenix-on-qemu-0-14-0/)
- [Installing Xenix on Qemu 0.14.0 part two.](https://virtuallyfun.com/wordpress/2011/04/08/installing-xenix-on-qemu-0-14-0-part-two/)
- [Relevant Gunkies.org Wiki entry](http://gunkies.org/wiki/Installing_Xenix_2.x_on_Qemu)

## Thanks to

Neozeed! And do not forget to try games in /usr/games folder! One of my favourite is "mind", a mastermind implementation. Some of them still could be addictive despite their age.

[Previous](../toshibat3100fun) | [Index](../../../../) | Next
--- | --- | ---
