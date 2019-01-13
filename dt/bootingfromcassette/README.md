# Booting from cassette
Some rights reserved! Vintage technology preserved.

---

[Previous](../bootingfromcom1part2) | [Index](../../../../) | [Next](../xenixtales)
--- | --- | ---

---

## Rediscovering the mysterious tape device
From the [previous blogentry](../bootingfromcom1part2), let's see the IBM ROM BASIC device table again:

| Name  | Description                               |
|-------|-------------------------------------------|
| KYBD: | keyboard                                  |
| SCRN: | screen                                    |
| LPT1: | printer - output only, with LIST, "LPT1:" |
| CAS1: | see more: http://github.com/retrohun/pce  |

As of 2018, only one non-basic application is released as an IBM PC/PCjr cassette booter, which is the IBM PC Diagnostics 1.02 (Cassette) - but some months ago, the number of such applications had been doubled - by me ( N.-).

![PCE ROMBIOS Galaxian](https://raw.githubusercontent.com/retrohun/pce/master/doc/pcerombiosgalaxian.gif)

And I am in britney-mode: "oops, I did it again" - doubled the number of tape booters - the two games mentioned in the previous post had been converted, so the can be booted from IBM ROM BASIC allegedly on a real IBM PC/PCjr having enough ram with the following commands:

```
LOAD "archon",r
```

or

```
LOAD "boulder1",r
```

for each mentioned game, respectively. The strings between the quotes are case sensitive! However, the commands themselves are not.

As a fun challenge without any reward, feel free to submit here as a change/PR/discussion poke cheats especially for boulder dash!

## Listing files

### Archon stuff

- [archon11k25.wav.gz](archon11k25.wav.gz)
- [pce-5150-archon.sh](pce-5150-archon.sh)

### Boulder Dash stuff

- [bdash11k25.wav.gz](bdash11k25.wav.gz)
- [pce-5150-boulder1.sh](pce-5150-boulder1.sh)

### Remarks

- Tape files are compressed with gzip, uncompressed WAVs are 11025kHz/8bit/mono format
- The shellscripts are dual syntax [pce-ibmpc](https://github.com/retrohun/pce) configuration files
- Due to the custom sample rate - differs from 44100 -, these games need N's patches in pce-ibmpc
- ROM image files not included, they must be dumped from **IBM PC**, not from **IBM XT**!

For those who want to start pce from other than a unixish host, the shell command is:

```
pce-ibmpc.exe -v -c pce-5150-archon.sh -g cga -R
```

For the other game, different configuration file should be specified, obviously.

Have fun! Hope you enjoy these games, originally met them on a C64 many decades ago.


## Happy New Year!

---

[Previous](../bootingfromcom1part2) | [Index](../../../../) | [Next](../xenixtales)
--- | --- | ---
