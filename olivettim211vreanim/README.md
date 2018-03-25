# Olivetti M211 reanim - Retrohun blog

Some rights reserved! Vintage technology preserved.

Previous | [Back to blog](../..) | Next
--- | --- | ---

## First steps
This beast survived nearly 30 years. This lifeform is a 80286 based portable.
The restoration was pretty straightforward, except that it had been purchased
with bad screen. After repairing, the only showstopper was that it basically handles
only 2 types of IDE 3.5"(!) harddisks: 20MB and 40MB, the BIOS and/or the autodetection
is set to the latter one. It does nothing with a winchester with other C/H/S parameters
just truncates it to these 980/5/17 - the 40MB dimensions. Of course there wasn't around
a harddisc with such parameters, so the laptop was fed with a 1011/15/22 160MB hdd.
## Dead end
Tried FreeDOS latest (v1.2) "manual install", which is nothing but invoking fdisk and format
dos utilites. Used the floppy image ripped from the so-called legacy ISO image, and it seems that
it has broken master boot code - cannot handle forced C/H/S values other than the default of the
HDD. The MBR code had been replaced then with a custom code snippet that load only the first system
boot sector, which parameters was hardcoded. Unfortunately, after the "..." FreeDOS prompt, it freezed.
## Solution
Instead of making an Int 13H hook loaded from the first 17 sectors, gave up in order to waste around 75%
of the HDD space and a bare MS DOS 6.22 "install" - using again fdisk and format only - worked as a charm.
The final result is here:
![Olivetti M211V in action](olim211v.jpg)

Previous | [Back to blog](../..) | Next
--- | --- | ---
