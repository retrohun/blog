# Naszvadi Péter - AIX PS2 telepítés Bochs emulátorba

main()

## Tart a lom

- Tart a lom
- Beszólás, olyan jogi izé
- Kellékek, előkészületek
- Telepítés

## Beszólás, olyan jogi izé

Ez eléggé alfa állapotú dokumentáció (:).

A lehető legtöbb jog fenntartva! Semmilyen felelősséggel nem tartozik a
dokumentum készítője senkinek! E produktumot Magyarországgal hadban álló
ország polgárai nem használhatják, továbbá olyan ország nem Magyar nemzetiségű
polgárai sem, ahol a Magyarokat, a Magyarságot érintő bármiféle kollektív
bűnösséget vagy hátrányt deklaráló jogszabály, rendelkezés érvényben van (pl.
Szlovákia) vagy volt, és nem kértek hivatalosan bocsánatot és nem fizettek
érte a szerző által elégségesnek ítélt erkölcsi és anyagi jóvátételt minden
áldozatnak és leszármazottnak, a leszármazottak nélküli (gy.k. kiirtott)
áldozatok helyett pedig Magyarországnak!

## Kellékek, előkészületek

Az AIX unix-like operációs rendszer 1.x verziói i386 processzoros IBM PS2
számítógépeken futottak. Az 1.3, az utolsó 1.x kiadás pedig már futott
tetszőleges IBM PC kompatibilis számítógépen (80386 kompatibilis processzor
és kb. legalább 4 MB RAM, elegendő egyéb hardver-erőforrás azért szükséges).
Ingyenes és nyílt forrású emulátorba/virtualizátorba/szimulátorba való
telepítések azonban ezidáig kudarcot vallottak. Viszont sikeresen települ és
indul Ubuntu 10.04/x86 alatt futó bochs emulátorba, pontos verzió:

```
$ dpkg --get-selections  | grep -oP '.*(bios|bochs)\S*'
bochs
bochs-doc
bochs-sdl
bochs-term
bochs-wx
bochs-x
bochsbios
seabios
vgabios
$ bochs --help
========================================================================
                       Bochs x86 Emulator 2.4.5
              Build from CVS snapshot, on April 25, 2010
========================================================================
Usage: bochs [flags] [bochsrc options]

  -n               no configuration file
  -f configfile    specify configuration file
  -q               quick start (skip configuration interface)
  -benchmark n     run bochs in benchmark mode for millions of emulated ticks
  -r path          restore the Bochs state from path
  -log filename    specify Bochs log file name
  --help           display this help and exit

For information on Bochs configuration file arguments, see the
bochsrc section in the user documentation or the man page of bochsrc.
00000000000i[CTRL ] quit_sim called with exit code 0

$
```

Kell még egy kb. 300 megabájtos diszkképfájl, amit pl. így hozhatunk létre
unix-szerű rendszerek alatt:

```

$ nohup dd if=/dev/zero of=./944x14x46.chs count=$[944*14*46]

```

Ami még kell nekünk, egy FreeDOS telepítőfloppy, melyen rajta van az
alaprendszer (kernel*.* és command*.*), továbbá FDISK, FORMAT, SYS, BOOTMGR.
Ezenkívül még szükségünk lesz az AIXPS2 1.3 telepítőkészletére, a 15 db.
Base Operating System floppyra, 2 db. PTF0024 SCSI bootfloppyra, a PTF0024
install floppyra, és a PTF0024-U436295 háromdarabos update patch floppykra,
no és nem utolsósorban egy jól beállított, 8MB ramot használható bochsrc
konfigurációs fájlra, amiben a bootfloppy 0xaa55 ellenőrzést kikapcsoltuk!

## Telepítés

Bootoljunk egyet!

```
Plex86/Bochs VGABios current-cvs 16 Apr 2010
This VGA/VBE Bios is released under the GNU LGPL

Please visit :
 . http://bochs.sourceforge.net
 . http://www.nongnu.org/vgabios

Bochs VBE Display Adapter enabled

Bochs BIOS - build: 06/30/10
$Revision: 1.247 $ $Date: 2010/04/04 19:33:50 $
Options: apmbios pcibios pnpbios eltorito rombios32

ata0 master: LOCALBUSHD ATA-6 Hard-Disk ( 296 MBytes)
_










```

Bootol a FreeDOS floppyról

```
Please visit :
 . http://bochs.sourceforge.net
 . http://www.nongnu.org/vgabios

Bochs VBE Display Adapter enabled

Bochs BIOS - build: 06/30/10
$Revision: 1.247 $ $Date: 2010/04/04 19:33:50 $
Options: apmbios pcibios pnpbios eltorito rombios32

ata0 master: LOCALBUSHD ATA-6 Hard-Disk ( 296 MBytes)

Press F12 for boot menu.

Booting from Floppy...
FreeDOS kernel build 2036 cvs [version Aug 18 2006 compiled Aug 18 2006]
Kernel compatibility 7.10 - WATCOMC - 80386 CPU required - FAT32 support

(C) Copyright 1995-2006 Pasquale J. Villani and The FreeDOS Project.
All Rights Reserved. This is free software and comes with ABSOLUTELY NO
WARRANTY; you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation;
either version 2, or (at your option) any later version.
 - InitDisk_
```

Majdnem mindegy, hogy mit választunk ki, csak fdisk/format/sys/copy stb.
miatt kell

```
 Balder 10 (FreeDOS 1.0)

 0 - Start FreeDOS for 8086 based system
 1 - Start FreeDOS for 186 based system
 2 - Start FreeDOS for 286 + FDXMS
 3 - Start FreeDOS for 386 + FDXMS
 4 - Start FreeDOS for 386 + HIMEM + EMM386
 5 - Start FreeDOS for 386 + HIMEM + EMM386 + XDMA
 6 - Start FreeDOS for 386 + HIMEM + EMM386 + XDMA + CD-ROM

 NOTE : CD-ROM can be loaded by running file LOADCD.BAT



   Select from Menu [0123456], or press [ENTER] (Selection=1)

   Singlestepping (F8) is: OFF







```

Itt a szép promptunk!

```
FreeCom version 0.84-pre2 XMS_Swap [Aug 28 2006 00:29:00]

CuteMouse v1.9.1 alpha 1 [FreeDOS]
Installed at PS/2 port
A:\>_



















```

Fdisk!

```
FreeCom version 0.84-pre2 XMS_Swap [Aug 28 2006 00:29:00]

CuteMouse v1.9.1 alpha 1 [FreeDOS]
Installed at PS/2 port
A:\>fdisk_



















```

Az alapértelmezett fdisk indítási paraméterek NEM JÓK!

```




      Free FDISK is capable of using large disk support to allow you to
      create partitions that are greater than 2,048 MB by using FAT32
      partitions.  If you enable large disk support, any partitions or
      logical drives greater than 512 MB will be created using FAT32.

      IMPORTANT:  If you enable large disk support, some operating systems
      will be unable to access the partitions and logical drives that are
      over 512 MB in size.




          Do you want to use large disk (FAT32) support (Y/N).[Y]?







```

A kékeres kutyaizét kell fat32, helyette legyen fat16!

```




      Free FDISK is capable of using large disk support to allow you to
      create partitions that are greater than 2,048 MB by using FAT32
      partitions.  If you enable large disk support, any partitions or
      logical drives greater than 512 MB will be created using FAT32.

      IMPORTANT:  If you enable large disk support, some operating systems
      will be unable to access the partitions and logical drives that are
      over 512 MB in size.




          Do you want to use large disk (FAT32) support (Y/N).[N]?







```

Töxűz lemezre óhajtunk partíciót rakni (1-es gomb)

```
                          Free FDISK     Version 1.2.1
                            Fixed Disk Setup Program
                GNU GPL Copyright Brian E. Reifsnyder 1998 - 2003

                                  FDISK Options

    Current fixed disk drive: 1

    Choose one of the following:

    1.  Create DOS partition or Logical DOS Drive
    2.  Set Active partition
    3.  Delete partition or Logical DOS Drive
    4.  Display partition information



    Enter choice:  [1]






    Press Esc to exit FDISK
```

Elsődleges DOS partíció kell (1)

```



                    Create DOS Partition or Logical DOS Drive

    Current fixed disk drive: 1

    Choose one of the following:

    1.  Create Primary DOS Partition
    2.  Create Extended DOS Partition
    3.  Create Logical DOS Drive(s) in the Extended DOS Partition




    Enter choice:  [ ]






    Press Esc to return to FDISK options
```

(N), azaz nem akarjuk a teljes lemezterületet elpazarolni a DOS számára,
hiszen kell hely az AIX-nak is!

```



                          Create Primary DOS Partition

    Current fixed disk drive: 1

    Do you wish to use the maximum available size for a Primary DOS Partition
    and make the partition active (Y/N).....................? [N]














    Press Esc to return to FDISK options
```

Hasraütve 33 MB elég lesz a DOS számára

```



                          Create Primary DOS Partition

    Current fixed disk drive: 1







    Total disk space is    297 Mbytes (1 Mbyte = 1048576 bytes)
    Maximum space available for partition is    297 Mbytes (100%)


    Enter partition size in Mbytes or percent of disk space (%) to
    create a Primary DOS Partition.................................: [    33]

    No partitions defined


    Press Esc to return to FDISK options
```

Tovább

```



                          Create Primary DOS Partition

    Current fixed disk drive: 1

    Partition  Status   Type    Volume Label  Mbytes   System   Usage
     C: 1              PRI DOS                   33   FAT16       11%




    Total disk space is    297 Mbytes (1 Mbyte = 1048576 bytes)






    Primary DOS Partition created


    Press Esc to continue_
```

(2-es gomb) - azaz aktív partíciót ki kell jelölni

```



                                  FDISK Options

    Current fixed disk drive: 1

    Choose one of the following:

    1.  Create DOS partition or Logical DOS Drive
    2.  Set Active partition
    3.  Delete partition or Logical DOS Drive
    4.  Display partition information



    Enter choice:  [1]



    WARNING! No partitions are set active - disk 1 is not startable unless
    a partition is set active

    Press Esc to exit FDISK
```

A felkínált partíciók közül válasszunk ki egyet (1)

```



                              Set Active Partition

    Current fixed disk drive: 1

    Partition  Status   Type    Volume Label  Mbytes   System   Usage
     C: 1              PRI DOS                   33   FAT16       11%




    Total disk space is    297 Mbytes (1 Mbyte = 1048576 bytes)

    Enter the number of the partition you want to make active.........[ ]







    Press Esc to return to FDISK options
```

Kilépés az fdisk-ből

```



                                  FDISK Options

    Current fixed disk drive: 1

    Choose one of the following:

    1.  Create DOS partition or Logical DOS Drive
    2.  Set Active partition
    3.  Delete partition or Logical DOS Drive
    4.  Display partition information



    Enter choice:  [1]






    Press Esc to exit FDISK
```

Kikapcs/bekapcs

```
A:\>























```

Megint floppylemezről indítjuk a rendszert

```
Plex86/Bochs VGABios current-cvs 16 Apr 2010
This VGA/VBE Bios is released under the GNU LGPL

Please visit :
 . http://bochs.sourceforge.net
 . http://www.nongnu.org/vgabios

Bochs VBE Display Adapter enabled

Bochs BIOS - build: 06/30/10
$Revision: 1.247 $ $Date: 2010/04/04 19:33:50 $
Options: apmbios pcibios pnpbios eltorito rombios32

ata0 master: LOCALBUSHD ATA-6 Hard-Disk ( 296 MBytes)

Press F12 for boot menu.

_







```

Majdnem mindegy, hogy melyiket választjuk

```
 Balder 10 (FreeDOS 1.0)

 0 - Start FreeDOS for 8086 based system
 1 - Start FreeDOS for 186 based system
 2 - Start FreeDOS for 286 + FDXMS
 3 - Start FreeDOS for 386 + FDXMS
 4 - Start FreeDOS for 386 + HIMEM + EMM386
 5 - Start FreeDOS for 386 + HIMEM + EMM386 + XDMA
 6 - Start FreeDOS for 386 + HIMEM + EMM386 + XDMA + CD-ROM

 NOTE : CD-ROM can be loaded by running file LOADCD.BAT



   Select from Menu [0123456], or press [ENTER] (Selection=3) - 10

_  Singlestepping (F8) is: OFF







```

Format C: /Q /U /S parancsot adjuk ki

```
FreeCom version 0.84-pre2 XMS_Swap [Aug 28 2006 00:29:00]

CuteMouse v1.9.1 alpha 1 [FreeDOS]
Installed at PS/2 port
A:\>format c: /q /u/s

 WARNING: ALL DATA ON NON-REMOVABLE DISK
 DRIVE C: WILL BE LOST! PLEASE CONFIRM!
 Proceed with format (YES/NO)? _















```

Írjuk be az angol igen három betűjét (YES)

```
FreeCom version 0.84-pre2 XMS_Swap [Aug 28 2006 00:29:00]

CuteMouse v1.9.1 alpha 1 [FreeDOS]
Installed at PS/2 port
A:\>format c: /q /u/s

 WARNING: ALL DATA ON NON-REMOVABLE DISK
 DRIVE C: WILL BE LOST! PLEASE CONFIRM!
 Proceed with format (YES/NO)? YES_















```

Címkének mindegy, hogy mit adunk meg

```
FreeCom version 0.84-pre2 XMS_Swap [Aug 28 2006 00:29:00]

CuteMouse v1.9.1 alpha 1 [FreeDOS]
Installed at PS/2 port
A:\>format c: /q /u/s

 WARNING: ALL DATA ON NON-REMOVABLE DISK
 DRIVE C: WILL BE LOST! PLEASE CONFIRM!
 Proceed with format (YES/NO)? YES
 Disk size: 33 Mbytes, FAT16. ***
Please enter volume label (max. 11 chars): _













```

Szépen rákerül a FreeDOS kernel és a parancsértelmező (command.com)

```
Reading old bootsector from drive C:
FAT type: FAT16
Old boot sector values: sectors/track: 46, heads: 14, hidden: 46
Default and new boot sector values: sectors/track: 46, heads: 14, hidden: 46
Root dir entries = 512
FAT starts at sector (46 + 1)
Root directory starts at sector (PREVIOUS + 66 * 2)
Boot sector kernel name set to KERNEL  SYS
Boot sector load segment set to 60h
writing new bootsector to drive C:

Copying KERNEL.SYS...
45341 Bytes transferred
Copying COMMAND.COM...
66945 Bytes transferred
System transferred.

    34,597,888  bytes total disk space (disk size)
    34,512,896  bytes available on disk (free clusters)

         2,048  bytes in each allocation unit.
        16,852 allocation units on disk.

 Volume Serial Number is 1127-07FC
A:\>_
```

A formázás után kiadjuk a copy a:*.* c: parancsot, mely
a floppy gyökerének a tartalmát a C:\-be másolja

```
FAT type: FAT16
Old boot sector values: sectors/track: 46, heads: 14, hidden: 46
Default and new boot sector values: sectors/track: 46, heads: 14, hidden: 46
Root dir entries = 512
FAT starts at sector (46 + 1)
Root directory starts at sector (PREVIOUS + 66 * 2)
Boot sector kernel name set to KERNEL  SYS
Boot sector load segment set to 60h
writing new bootsector to drive C:

Copying KERNEL.SYS...
45341 Bytes transferred
Copying COMMAND.COM...
66945 Bytes transferred
System transferred.

    34,597,888  bytes total disk space (disk size)
    34,512,896  bytes available on disk (free clusters)

         2,048  bytes in each allocation unit.
        16,852 allocation units on disk.

 Volume Serial Number is 1127-07FC
A:\>copy a:*.* c:
Overwrite 'c:KERNEL.SYS' (Yes/No/All/Quit) ?
```

Ne írjuk felül a már létező KERNEL.SYS és COMMAND.COM fájlt!

```
Boot sector kernel name set to KERNEL  SYS
Boot sector load segment set to 60h
writing new bootsector to drive C:

Copying KERNEL.SYS...
45341 Bytes transferred
Copying COMMAND.COM...
66945 Bytes transferred
System transferred.

    34,597,888  bytes total disk space (disk size)
    34,512,896  bytes available on disk (free clusters)

         2,048  bytes in each allocation unit.
        16,852 allocation units on disk.

 Volume Serial Number is 1127-07FC
A:\>copy a:*.* c:
Overwrite 'c:KERNEL.SYS' (Yes/No/All/Quit) ? n
Overwrite 'c:COMMAND.COM' (Yes/No/All/Quit) ? n
a:APPEND.EXE => c:APPEND.EXE
a:ASSIGN.COM => c:ASSIGN.COM
a:ATTRIB.COM => c:ATTRIB.COM
a:CDTRIB.COM => c:ATTRIB.COM
a:CDRCACHE.SYS => c:_
```

Ezután újraindítjuk a rendszert

```
Plex86/Bochs VGABios current-cvs 16 Apr 2010
This VGA/VBE Bios is released under the GNU LGPL

Please visit :
 . http://bochs.sourceforge.net
 . http://www.nongnu.org/vgabios

Bochs VBE Display Adapter enabled

Bochs BIOS - build: 06/30/10
$Revision: 1.247 $ $Date: 2010/04/04 19:33:50 $
Options: apmbios pcibios pnpbios eltorito rombios32

ata0 master: LOCALBUSHD ATA-6 Hard-Disk ( 296 MBytes)
_










```

Be kell gépelni a BOOTMGR parancsot, amivel bootmanagert fogunk
telepíteni, majd beállítani

```
FreeCom version 0.84-pre2 XMS_Swap [Aug 28 2006 00:29:00]

CuteMouse v1.9.1 alpha 1 [FreeDOS]
Installed at PS/2 port
C:\>



















```

bátran tessék begépelni, hogy BOOTMGR(Enter) !

```
FreeCom version 0.84-pre2 XMS_Swap [Aug 28 2006 00:29:00]

CuteMouse v1.9.1 alpha 1 [FreeDOS]
Installed at PS/2 port
C:\>



















```

Az első partíciót kereszteljül el példűul DOS névre, és tegyük
alapértelmezett bootmenüponttá! Majd a Write MBR gombbal írjuk ki
a partíciós táblát az új beállításokkal!

```
################################################################################
### BOOTMGR Version 18-FEB-2005 - multi-BOOT ManaGeR           BTTR Software ###
################################################################################
################################################################################
### Hard disk  1 (of  1), Size=  296M, C:H:S= 944: 14:46, Mode=LBA ## active ###
### #|ID|Type      |  Size| Start-LBA|Mode|Start-C:H:S|  End-C:H:S ##  Part. ###
################################################################################
### 1|06|FAT16B    |   32M|        46|CHS |   0:  1: 1| 104: 13:46 ## <-     ###
### 2|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 3|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 4|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
################################################################################
################################################################################
### Menu     ## Assoc. ## Hide ## Timeout #######  Save MBR   ##  Defaults   ###
################################################################################
### DOS      ## #1     ##      ## 10 sec. ######################################
### <Floppy> ## A:  <- ##      ################## Restore MBR ##  Write MBR  ###
### <NextHD> ## D:     ##      #################################################
###          ##        ##      #################################################
###          ##        ##      ################## Change disk ##    Quit     ###
################################################################################
################################################################################
### Write partition table, install BOOTMGR or generic loader                 ###
################################################################################
################################################################################
```

(B) betűt kell nyomni

```
################################################################################
### BOOTMGR Version 18-FEB-2005 - multi-BOOT ManaGeR           BTTR Software ###
################################################################################
################################################################################
### Hard disk  1 (of  1), Size=  296M, C:H:S= 944: 14:46, Mode=LBA ## active ###
### #|ID|Type      |  Size| Start-LBA|Mode|Start-C:H:S|  End-C:H:S ##  Part. ###
################################################################################
### 1|06|FAT16B    |   32M|        46|CHS |   0:  1: 1| 104: 13:46 ## <-     ###
### 2|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 3|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 4|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
################################################################################
################################################################################
### Menu     ## Assoc. ## Hide ## Timeout #######  Save MBR   ##  Defaults   ###
################################################################################
### DOS      ## #1     ##      ## 10 sec. ######################################
### <Floppy> ## A:  <- ##      ################## Restore MBR ##  Write MBR  ###
### <NextHD> ## D:     ##      #################################################
###          ##        ##      #################################################
###          ##        ##      ################## Change disk ##    Quit     ###
################################################################################
################################################################################
### Master Bootstrap Loader to install:  BOOTMGR  Generic  Keep existing     ###
################################################################################
################################################################################
```

Meg még egy (Enter)-t is!

```
################################################################################
### BOOTMGR Version 18-FEB-2005 - multi-BOOT ManaGeR           BTTR Software ###
################################################################################
################################################################################
### Hard disk  1 (of  1), Size=  296M, C:H:S= 944: 14:46, Mode=LBA ## active ###
### #|ID|Type      |  Size| Start-LBA|Mode|Start-C:H:S|  End-C:H:S ##  Part. ###
################################################################################
### 1|06|FAT16B    |   32M|        46|CHS |   0:  1: 1| 104: 13:46 ## <-     ###
### 2|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 3|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 4|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
################################################################################
################################################################################
### Menu     ## Assoc. ## Hide ## Timeout #######  Save MBR   ##  Defaults   ###
################################################################################
### DOS      ## #1     ##      ## 10 sec. ######################################
### <Floppy> ## A:  <- ##      ################## Restore MBR ##  Write MBR  ###
### <NextHD> ## D:     ##      #################################################
###          ##        ##      #################################################
###          ##        ##      ################## Change disk ##    Quit     ###
################################################################################
################################################################################
### <+ Ok to install/update BOOTMGR as configured                 Esc Cancel ###
################################################################################
################################################################################
```

Fejezzük be a garázdálkodást

```
################################################################################
### BOOTMGR Version 18-FEB-2005 - multi-BOOT ManaGeR           BTTR Software ###
################################################################################
################################################################################
### Hard disk  1 (of  1), Size=  296M, C:H:S= 944: 14:46, Mode=LBA ## active ###
### #|ID|Type      |  Size| Start-LBA|Mode|Start-C:H:S|  End-C:H:S ##  Part. ###
################################################################################
### 1|06|FAT16B    |   32M|        46|CHS |   0:  1: 1| 104: 13:46 ## <-     ###
### 2|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 3|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
### 4|00|empty     |    0K|         0|CHS |   0:  0: 0|   0:  0: 0 ##        ###
################################################################################
################################################################################
### Menu     ## Assoc. ## Hide ## Timeout #######  Save MBR   ##  Defaults   ###
################################################################################
### DOS      ## #1     ##      ## 10 sec. ######################################
### <Floppy> ## A:  <- ##      ################## Restore MBR ##  Write MBR  ###
### <NextHD> ## D:     ##      #################################################
###          ##        ##      #################################################
###          ##        ##      ################## Change disk ##    Quit     ###
################################################################################
################################################################################
### Exit to Operating System                                                 ###
################################################################################
################################################################################
```

MOST cserélünk Bochs konfigurációs fájlt, az indítandó bootfloppy
image fájl mostantól az AIX telepítő bootfloppy legyen, amit indítsunk
is el így

```
Plex86/Bochs VGABios current-cvs 16 Apr 2010
This VGA/VBE Bios is released under the GNU LGPL

Please visit :
 . http://bochs.sourceforge.net
 . http://www.nongnu.org/vgabios

Bochs VBE Display Adapter enabled

Bochs BIOS - build: 06/30/10
$Revision: 1.247 $ $Date: 2010/04/04 19:33:50 $
Options: apmbios pcibios pnpbios eltorito rombios32

ata0 master: LOCALBUSHD ATA-6 Hard-Disk ( 296 MBytes)

Press F12 for boot menu.

Booting from Floppy...







```

Nyomjuk meg Enikőt a folytatáshoz!

```
                         IBM AIX PS/2 Operating System

                                 VERSION 1.3.0

                              NVRAM Configuration

AIX PS/2 requires that a few system configuration parameters
be recorded in non-volatile memory (NVRAM).  Your NVRAM does not
contain this information.  It will be necessary for you to provide
the required information before proceeding to boot the AIX kernel.



     Press any key to continue ..._










```

Amerikai billentzuyetkiosytast valassyuk ki

```
                            SELECT KEYBOARD LANGUAGE

         Belgian                                     Portuguese
         Canadian                                    Spanish
         Danish                                      Swedish
         Dutch                                       SwissFren
         French                                      SwissGerm
         German                                      UK
         Italian                                     US
         LatinAmer                                   Icelandic
         Norwegian                                   Japanese








Use the cursor keys to select the desired item.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Valamelyik szimpatikus monitorbeállítási lehetőséget

```
                              SELECT MONITOR TYPE


     VGA w/7544   (13" color)                  VGA w/8515   (14" color)
     VGA w/7554   (19" color)                  VGA w/8516   (14" color)
     VGA w/8503   (12" mono)                   VGA w/8517   (16" color)
     VGA w/8504   (12" mono)                   VGA w/8518   (14" color)
     VGA w/8507   (19" mono)                   IBM 5574-M06   (15" mono)
     VGA w/8511   (14" color)                  IBM 5574-W06   (15" mono)
    _VGA w/8512   (14" color)                  IBM 5574-C06   (14" color)
     VGA w/8513   (12" color)                  IBM 5574-C07   (16" color)
     VGA w/8514   (16" color)                  IBM 5574-C09   (20" color)







Use the cursor keys to select the desired item.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Azért mégsem a sivatagi-hegyvidéki tundra-tajga az, ahol vogymuk...

```
                                SELECT TIME ZONE

   (GMT)    Greenwich England               (GMT+12) New Zealand
   (GMT-1)  Azores, Cape Verde              (GMT+11) Solomon Islands
   (GMT-2)  Falkland Islands                (GMT+10) Eastern Australia
   (GMT-3)  Greenland, East Brazil          (GMT+9)  Japan, Korea
   (GMT-4)  Central Brazil                  (GMT+8)  Western Australia
  _(GMT-5)  Eastern U.S., Colombia          (GMT+7)  Thailand
   (GMT-6)  Central U.S., Honduras          (GMT+6)  Tashkent USSR
   (GMT-7)  Mountain U.S.                   (GMT+5)  Pakistan
   (GMT-8)  Pacific U.S.                    (GMT+4)  Gorki USSR, Oman
   (GMT-9)  Yukon                           (GMT+3)  Turkey, Saudi Arabia
   (GMT-10) Alaska, Hawaii                  (GMT+2)  Finland, South Africa
   (GMT-11) Bering Straits                  (GMT+1)  Norway, France





Use the cursor keys to select the desired item.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Hanem norvégisztán

```
                                SELECT TIME ZONE

   (GMT)    Greenwich England               (GMT+12) New Zealand
   (GMT-1)  Azores, Cape Verde              (GMT+11) Solomon Islands
   (GMT-2)  Falkland Islands                (GMT+10) Eastern Australia
   (GMT-3)  Greenland, East Brazil          (GMT+9)  Japan, Korea
   (GMT-4)  Central Brazil                  (GMT+8)  Western Australia
   (GMT-5)  Eastern U.S., Colombia          (GMT+7)  Thailand
   (GMT-6)  Central U.S., Honduras          (GMT+6)  Tashkent USSR
   (GMT-7)  Mountain U.S.                   (GMT+5)  Pakistan
   (GMT-8)  Pacific U.S.                    (GMT+4)  Gorki USSR, Oman
   (GMT-9)  Yukon                           (GMT+3)  Turkey, Saudi Arabia
   (GMT-10) Alaska, Hawaii                  (GMT+2)  Finland, South Africa
   (GMT-11) Bering Straits                  (GMT+1)  Norway, France

Do you observe daylight savings time?    No



Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Gyónás a CET-halban

```
                                SELECT TIME ZONE

   (GMT)    Greenwich England               (GMT+12) New Zealand
   (GMT-1)  Azores, Cape Verde              (GMT+11) Solomon Islands
   (GMT-2)  Falkland Islands                (GMT+10) Eastern Australia
   (GMT-3)  Greenland, East Brazil          (GMT+9)  Japan, Korea
   (GMT-4)  Central Brazil                  (GMT+8)  Western Australia
   (GMT-5)  Eastern U.S., Colombia          (GMT+7)  Thailand
   (GMT-6)  Central U.S., Honduras          (GMT+6)  Tashkent USSR
   (GMT-7)  Mountain U.S.                   (GMT+5)  Pakistan
   (GMT-8)  Pacific U.S.                    (GMT+4)  Gorki USSR, Oman
   (GMT-9)  Yukon                           (GMT+3)  Turkey, Saudi Arabia
   (GMT-10) Alaska, Hawaii                  (GMT+2)  Finland, South Africa
   (GMT-11) Bering Straits                  (GMT+1)  Norway, France

Do you observe daylight savings time?    No
Standard Timezone name:                  CET


Type the requested information into the highlighted field.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

NLS beállítások, nagymammónia-angol

```
                        SELECT NLS TRANSLATION LANGUAGE


         Canadian
         Danish
         Dutch
         Finnish
         French
         German
         Italian
         Japanese
         Norwegian
         Portuguese
         Spanish
         Swedish
         UK English
         US English
         Icelandic

Use the cursor keys to select the desired item.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Ide olyan szót írsz, amit akarsz (és elfogad:), de úgyelj arra, hogyha
valami trágárság, akkor is látszódni fog a lemezcímkében (is)!

```
                              SELECT MACHINE NAME


        Enter Machine Name:  aixpc_















Type the requested information into the highlighted field.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Floppyról indítjuk a rendszert, azaz Boot from Diskette

```
                             IBM AIX PS/2 Bootstrap

                                  vers (1.3.0)

         Boot from Diskette
         Boot from Hard Disk
         Boot DOS
         Set Keyboard Language
         Set Monitor Type
         Set Timezone
         Set Machine Name
         Set NLS translation language
         Copy Diskette
         Stand-alone Backup
         Stand-alone Restore




Use the cursor keys to select the desired item.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Az alapértelmezett beállítások jelenleg pompásak nekünk, itt most
csak végig entert nyomogatunk

```
                        LOAD A SYSTEM FROM THE DISKETTE




Module to be loaded:         unix.gen
System mode:                 Single User
Run system from hard disk:   No











Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

No, most cserélünk először floppylemezt. Kibaszottul ügyeljünk arra,
hogy amerikai angol legyen a billentyűzetkiosztás a HOST gépen IS,
továbbá a csavarkulcsos piktogrammos Config ikonra való kattintás
után a terminálablak felső lécére kattintsunk, a floppylemez sikeres
cseréje és a szimuláció folytatására való utasítás után meg a GUEST
ablakára!

```
                        LOAD A SYSTEM FROM THE DISKETTE




Module to be loaded:         unix.gen
System mode:                 Single User
Run system from hard disk:   No

Loading sec 0 (.bss) at 0x230000, length 408636 bytes
408636 bytes cleared
Loading sec 1 (.data) at 0x293C3C, length 274452 bytes
274452 bytes loaded
Loading sec 2 (.text) at 0x2D6C50, length 1124556 bytes
Please insert BOOT  diskette number 2; Press any key when ready
_



Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Töltődik a rendszer

```
                        LOAD A SYSTEM FROM THE DISKETTE




Module to be loaded:         unix.gen
System mode:                 Single User
Run system from hard disk:   No

Loading sec 0 (.bss) at 0x230000, length 408636 bytes
408636 bytes cleared
Loading sec 1 (.data) at 0x293C3C, length 274452 bytes
274452 bytes loaded
Loading sec 2 (.text) at 0x2D6C50, length 1124556 bytes
Please insert BOOT  diskette number 2; Press any key when ready

901120 bytes loaded


Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Az Install0024.img floppylemezt kell behelyezni (floppycsere megint)

```
                               AIX VERSION 1.3.0





                 Insert installation diskette and press Enter.


                                     - OR -


To perform system maintenance, insert the Maintenance diskette and press Enter.






Check to make sure the diskette is write-enabled before using._




```

Gyönyörködsz, nem piszka!

```
IBM AIX PS/2  Version 1.3.0

_






















```

Nem piszka!

```
IBM AIX PS/2  Version 1.3.0

911-364 tkinit: No token ring card.  Option not enabled.
<it>: minicartridge tape driver v3.3.0d
_




















```

Még mindig nem piszka!

```
IBM AIX PS/2  Version 1.3.0

911-364 tkinit: No token ring card.  Option not enabled.
<it>: minicartridge tape driver v3.3.0d
<it>: initialization error 23: Drive not found; Driver not installed
900-039 - no if_ena adaptors present
0 Bus Master Token Ring adapter(s) found
900-600 Available User Memory: 1278 pages (0x4fe000 bytes)

INIT: generic site -- NOT CHECKING ROOT
_














```

Állítólag az (F3) gomb is jó, én viszont kiírattam az új partíciós
táblát

```
                            REMOVE NON-AIX PARTITONS

 Select a Partition to delete
 Disk Number 1       Partition:
                               Number      Type                 Id
                    o          1           DOS >32meg            6

                               2                                 0

                               3                                 0

                               4                                 0

                            Write New Partition Table




      Select :Write New Partition Table: option after deleting
      desired partition(s) or <F3> to exit without any changes

                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Le kell nyilakkal léptetni a helyőrt a Write New Partition
Table menüpontra, majd (Enter)

```
                            REMOVE NON-AIX PARTITONS

 Select a Partition to delete
 Disk Number 1       Partition:
                               Number      Type                 Id
                               1           DOS >32meg            6

                               2                                 0

                               3                                 0

                    o          4                                 0

                            Write New Partition Table




      Select :Write New Partition Table: option after deleting
      desired partition(s) or <F3> to exit without any changes

                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Aztán nyomjunk egy (Y)-tervet, Enter beverve

```
                            REMOVE NON-AIX PARTITONS

 Select a Partition to delete
 Disk Number 1       Partition:
                               Number      Type                 Id
                               1           DOS >32meg            6

                               2                                 0

                               3                                 0

                               4                                 0

     +====================================================================+
     | The option you have selected will remove the partitions            |
     | you have selected.                                                 |
     | Do you wish to proceed (y/n)? _                                    |
     +====================================================================+
      Select :Write New Partition Table: option after deleting
      desired partition(s) or <F3> to exit without any changes

                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Préselj Entert!

```
                               SYSTEM INSTALLATION



                    o       Install and Customize AIX

                            End Installation














                 Hit <SPACE> to toggle items; <ENTER> to select.


```

Nem piszka!

```
     GET BAD BLOCKS ON HARD DISK

     Scanning hard disk 0: 943 cylinders
     now checking cyl:  920 _




















```

(N) nyomandó

```
     GET BAD BLOCKS ON HARD DISK

     Scanning hard disk 0: 943 cylinders
     now checking cyl:  943

     Would you like to add any other bad sectors <y/n>?  _


















```

oszt ha megállna, mint paci a hideg vízben, akkor püfölj egy
(Enter)-t is!

```
     GET BAD BLOCKS ON HARD DISK

     Scanning hard disk 0: 943 cylinders
     now checking cyl:  943

     Would you like to add any other bad sectors <y/n>?  n_


















```

Nyomás Enikő!

```
     GET BAD BLOCKS ON HARD DISK

     Scanning hard disk 0: 943 cylinders
     now checking cyl:  943

     Press ANY KEY to continue._


















```

Enter

```
                          INSTALL A NEW VERSION OF AIX

 Select a method of installation

                    o       Install a NEW AIX System. All AIX type minidisks
                            will be deleted.

                            Replace your Current Version of AIX with the New
                            Version. AIX system minidisks will be deleted.
                            All user created AIX minidisks as well as
                            all non-AIX minidisks and DOS partitions will remain
                            intact.









                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

(Y)-t vár

```
                          INSTALL A NEW VERSION OF AIX

 Select a method of installation

                    o       Install a NEW AIX System. All AIX type minidisks
                            will be deleted.

                            Replace your Current Version of AIX with the New
                            Version. AIX system minidisks will be deleted.
                            All user created AIX minidisks as well as
                            all non-AIX minidisks and DOS partitions will remain
                            intact.

     +====================================================================+
     | The installation method you have selected will                     |
     | result in the deletion of all AIX minidisks.                       |
     | Do you wish to proceed (y/n)? _                                    |
     +====================================================================+



                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Y után entert is illene nyomni...

```
                          INSTALL A NEW VERSION OF AIX

 Select a method of installation

                    o       Install a NEW AIX System. All AIX type minidisks
                            will be deleted.

                            Replace your Current Version of AIX with the New
                            Version. AIX system minidisks will be deleted.
                            All user created AIX minidisks as well as
                            all non-AIX minidisks and DOS partitions will remain
                            intact.

     +====================================================================+
     | The installation method you have selected will                     |
     | result in the deletion of all AIX minidisks.                       |
     | Do you wish to proceed (y/n)? y_                                   |
     +====================================================================+



                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Itt most nem az alapértelmezett menüpontot fogjuk kiválasztani

```
                            INSTALL AND CUSTOMIZE AIX



                    o       Install AIX with Current Choices

                            Show Current Choices and Install

                            Change Current Choices and Install












                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Hanem a Change Current Choices and Install pontot

```
                            INSTALL AND CUSTOMIZE AIX



                            Install AIX with Current Choices

                            Show Current Choices and Install

                    o       Change Current Choices and Install












                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Az alapértelmezett slice-kiosztás ez, ami édeskevés - ebből látható,
hogy kb 75 Megabájtnyi összefűggő lemezterület kell az AIX számára

```
                       CHANGE CURRENT CHOICES AND INSTALL

 Select a minidisk to change, or install AIX.
                                           Disk    Blocks       Files
                            /u             0        9824         982

                            /aixpc         0        7704         770

                            /              0       42000        4200

                            page           0        4000           0

                            dump           0        4000           0

                            /aixpc/tmp     0        5804         580

                    o       Install the Operating system and cause the
                            current choices to take effect.



                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

A 300MB kapacitású lemezen ezt gondoltam egy lehetséges választásnak

```
                       CHANGE CURRENT CHOICES AND INSTALL

 Select a minidisk to change, or install AIX.
                                           Disk    Blocks       Files
                            /u             0       65536        6553

                            /aixpc         0       65536        6553

                            /              0       73356        7335

                            page           0       16384           0

                            dump           0       16384           0

                            /aixpc/tmp     0       32768        3276

                    o       Install the Operating system and cause the
                            current choices to take effect.



                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

(F3)-mat a vesztesek, (Enter)-t a nyertesek kalapáljanak!

```


 Installation of AIX will take several minutes.

 To CANCEL and go back to the INSTALL AND CUSTOMIZE AIX
 menu, press F3.

 To INSTALL AIX, press Enter._
















```

Örülsz

```
                       CREATING MINIDISKS AND FILESYSTEMS

 Installing AIX...
   - building minidisk /u (65536 blks) on ID # 1
   - building minidisk /aixpc (65536 blks) on ID # 2
   - building minidisk / (73356 blks) on ID # 3
   - building minidisk page (16384 blks) on ID # 4_

















```

Gyönyörködsz

```
                       CREATING MINIDISKS AND FILESYSTEMS

 Installing AIX...
   - building minidisk /u (65536 blks) on ID # 1
   - building minidisk /aixpc (65536 blks) on ID # 2
   - building minidisk / (73356 blks) on ID # 3
   - building minidisk page (16384 blks) on ID # 4
   - building minidisk dump (16384 blks) on ID # 5
   - building minidisk /aixpc/tmp (32768 blks) on ID # 6

   - making /u filesystem (65536 blks:6553 files) on ID # 1_













```

Ámulsz

```
                       CREATING MINIDISKS AND FILESYSTEMS

 Installing AIX...
   - building minidisk /u (65536 blks) on ID # 1
   - building minidisk /aixpc (65536 blks) on ID # 2
   - building minidisk / (73356 blks) on ID # 3
   - building minidisk page (16384 blks) on ID # 4
   - building minidisk dump (16384 blks) on ID # 5
   - building minidisk /aixpc/tmp (32768 blks) on ID # 6

   - making /u filesystem (65536 blks:6553 files) on ID # 1
   - making /aixpc filesystem (65536 blks:6553 files) on ID # 2
   - making / filesystem (73356 blks:7335 files) on ID # 3_











```

Bámulsz

```
                            FIRST STAGE INSTALLATION

 Installation of the mini system will take several minutes.
          Installing mini-root, please wait...

          Installing mini-local, please wait...

          Updating /etc/system.
          Linking devices.
          Updating configuration file
          Updating global information file /etc/fsmap._













```

Újracsizma, azaz reboot következik, ahol floppyról kell megint
bootolni!

```
                   INSTALLATION OF THE MINI SYSTEM IS COMPLETE






 The system is now ready to reboot.
 After you receive the "System Halted" message
 remove the Installation Diskette
 and insert Boot Diskette 1.

 After you have switched the diskettes
 press Enter to reboot the system.



 Refer to the "Installing and Customizing the AIX Operating System" Manual
 for further instructions.
01:09:37 910-772 System halted, you may turn the power off now.
01:09:37 910-773 Type Enter to Reboot: _



```

Ugyanúgy járunk el, mint az előző AIX floppy bootolása során EDDIG a
képernyőig, itt ugyanis beállítjuk a Run system from hard disk
értéket igazra

```
                        LOAD A SYSTEM FROM THE DISKETTE




Module to be loaded:         unix.gen
System mode:                 Single User
Run system from hard disk:   Yes











Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Még kér a nép (második bootfloppyt)

```
                        LOAD A SYSTEM FROM THE DISKETTE




Module to be loaded:         unix.gen
System mode:                 Single User
Run system from hard disk:   Yes

Loading sec 0 (.bss) at 0x230000, length 408636 bytes
408636 bytes cleared
Loading sec 1 (.data) at 0x293C3C, length 274452 bytes
274452 bytes loaded
Loading sec 2 (.text) at 0x2D6C50, length 1124556 bytes
Please insert BOOT  diskette number 2; Press any key when ready
_



Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Bootol a merevlemezre felmásolt install rendszer, amely nemsokára
valóban telepíteni fog

```
IBM AIX PS/2  Version 1.3.0

_






















```

1-2-3-múkod!

```
IBM AIX PS/2  Version 1.3.0

911-364 tkinit: No token ring card.  Option not enabled.
<it>: minicartridge tape driver v3.3.0d
_




















```

Pr0n

```
IBM AIX PS/2  Version 1.3.0

911-364 tkinit: No token ring card.  Option not enabled.
<it>: minicartridge tape driver v3.3.0d
<it>: initialization error 23: Drive not found; Driver not installed
900-039 - no if_ena adaptors present
0 Bus Master Token Ring adapter(s) found
900-600 Available User Memory: 1278 pages (0x4fe000 bytes)
900-652 pipe (3/2), root (3/3), swap (3/4), dump (3/5)
init: Checking local copy of root `/dev/root'
/dev/root: gfs 1, pk 1: not checking, filesystem clean
init: Checking local file system `/generic/dev/aixpc'
/generic/dev/aixpc: gfs 3, pk 1: not checking, filesystem clean
_











```

Az első (azaz nulladik) lemezről fogunk telepíteni

```
                              CONTINUE INSTALLATION



                    o       Diskette Drive 0

                            Diskette Drive 1

                            6157 Tape

                            Internal Tape

                            Network Install

                            SCSI Tape






                 Hit <SPACE> to toggle items; <ENTER> to select.


```

Szép türelmesen elkezdjük a 15 Base Operating System (azaz BOS) floppyk
etetését, sorrendben haladva, az első következik:

```




















Use the Operating System diskettes.

Please mount volume 1 on /dev/fd0
...and press Enter to continue _
```

Majd a második...

```
x ./bin/expr
x ./bin/false
x ./bin/fdformat
x ./bin/fgrep
x ./bin/find
x ./bin/format
linked to ./bin/fdformat
x ./bin/getopt
x ./bin/grep
x ./bin/groups
x ./bin/help
x ./bin/hostname
x ./bin/i370
linked to ./bin/false
x ./bin/i386
x ./bin/iconv
x ./bin/id
x ./bin/ipcrm
x ./bin/ipcs
x ./bin/keyboard
x ./bin/kill
x ./bin/killall
x ./bin/ksh
Please mount volume 2 on /dev/fd0
...and press Enter to continue _
```

A harmadik...

```
x ./bin/red
linked to ./bin/ed
x ./bin/rm
x ./bin/rmail
x ./bin/rmdir
x ./bin/sed
x ./bin/setmaps
x ./bin/sh
x ./bin/sleep
x ./bin/sort
x ./bin/sound
x ./bin/stty
x ./bin/su
x ./bin/sum
x ./bin/sync
x ./bin/tar
x ./bin/tctl
linked to ./bin/mt
x ./bin/termdef
x ./bin/test
linked to ./bin/[
x ./bin/touch
x ./bin/trace
Please mount volume 3 on /dev/fd0
...and press Enter to continue _
```

és a 14. után az utolsó, ami után még egy entert vár, hogy
gyönyörködhessünk a telepítés státuszában

```
linked to ./usr/ucb/more
x ./usr/ucb/printenv
linked to ./bin/env
x ./usr/ucb/uptime
x ./usr/ucb/users
x ./usr/ucb/vi
linked to ./usr/bin/edit
x ./usr/ucb/view
linked to ./usr/bin/edit
x ./usr/ucb/w
linked to ./usr/ucb/uptime
x ./usr/ucb/wc
linked to ./bin/wc
x ./usr/ucb/what
linked to ./bin/what
x ./usr/ucb/whatis
linked to ./usr/bin/man
x ./usr/ucb/whereis
x ./usr/ucb/which
x ./usr/ucb/whoami
x ./usr/ucb/xa370
linked to ./usr/ucb/users
    files restored: 1264

Press Enter to refresh the screen (Be sure to check for errors). _
```

Kisebb finomhangolások következnek, ami a UNIX rendszereknél ilyenkor
bevett dolog

```


    The new version of AIX was installed successfully.


    To CONTINUE with post installation processing, press Enter. _


















```

A felsőt választom

```
                               CONSOLE LOGIN MODE



                    o       Normal console login.  At system
                            startup /etc/getty will run on the
                            system console allowing login by
                            any valid username.

                            Automatic login of specific username.
                            At system startup the specified
                            username will be automatically logged
                            onto the console.








                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Tégy úgy...

```


 Running post installation.  Please wait..._





















```

A 2. pont az installp parancsot adja ki, de nekünk az első kell

```
                            INSTALL PROGRAM PRODUCTS



                            Continue Installation.

                    o       Install a Program Product.







 Total free space on root: 53468K






                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Enter

```
                            INSTALL PROGRAM PRODUCTS



                    o       Continue Installation.

                            Install a Program Product.







 Total free space on root: 53468K






                 Hit <SPACE> to toggle items; <ENTER> to select.
                      or F3 to return to the previous menu.

```

Enter

```
                                POST INSTALLATION

 Post installation processing is completed.  To start your
 system return to the SYSTEM INSTALLATION menu and select the
 End Installation menu item.

 To RETURN to the SYSTEM INSTALLATION menu, press Enter._

















```

End Installation, majd Enter

```
                               SYSTEM INSTALLATION



                            Install and Customize AIX

                    o       End Installation














                 Hit <SPACE> to toggle items; <ENTER> to select.


```

És megint enter!

```
                                END INSTALLATION






 The system is now ready to reboot.
 After you receive the "System Halted" message
 remove any diskettes and
 press Enter to reboot the system.








910-772 System halted, you may turn the power off now.
910-773 Type Enter to Reboot: _



```

Bootol a GUEST..., floppyról bootoltassuk még, ugyanis a
PTF0024-U436295 patch nélkül az AIXPS2 nem képes IDE diszken bootolni,
csak floppyról

```
Plex86/Bochs VGABios current-cvs 16 Apr 2010
This VGA/VBE Bios is released under the GNU LGPL

Please visit :
 . http://bochs.sourceforge.net
 . http://www.nongnu.org/vgabios

Bochs VBE Display Adapter enabled

Bochs BIOS - build: 06/30/10
$Revision: 1.247 $ $Date: 2010/04/04 19:33:50 $
Options: apmbios pcibios pnpbios eltorito rombios32

ata0 master: LOCALBUSHD ATA-6 Hard-Disk ( 296 MBytes)











```

Immáron szokásos képernyő

```
                         IBM AIX PS/2 Operating System

                                 VERSION 1.3.0




_









IBM AIX PS/2 Operating System - Version 1.3.0
5713-AEQ (C) COPYRIGHT IBM CORP. 1988
LICENSED MATERIAL - PROGRAM PROPERTY OF IBM
All Rights Reserved
PS/2 and AIX are trademarks of International Business Machines Corp.


```

Ez is ismerős már, harmadszorra csináljuk

```
                             IBM AIX PS/2 Bootstrap

                                  vers (1.3.0)

         Boot from Diskette
         Boot from Hard Disk
         Boot DOS
         Set Keyboard Language
         Set Monitor Type
         Set Timezone
         Set Machine Name
         Set NLS translation language
         Copy Diskette
         Stand-alone Backup
         Stand-alone Restore




Use the cursor keys to select the desired item.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Másodjára követjük el ugyanezt

```
                        LOAD A SYSTEM FROM THE DISKETTE




Module to be loaded:         unix.gen
System mode:                 Single User
Run system from hard disk:   Yes











Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Második bootlemezzel etessük

```
                        LOAD A SYSTEM FROM THE DISKETTE




Module to be loaded:         unix.gen
System mode:                 Single User
Run system from hard disk:   Yes

Loading sec 0 (.bss) at 0x230000, length 408636 bytes
408636 bytes cleared
Loading sec 1 (.data) at 0x293C3C, length 274452 bytes
274452 bytes loaded
Loading sec 2 (.text) at 0x2D6C50, length 1124556 bytes
Please insert BOOT  diskette number 2; Press any key when ready
_



Press SPACE to toggle the field to the desired value.
Press ENTER to confirm your selection and continue.
Press F3 to cancel this selection.


```

Első igazi boot, de (Y)-t kell nyomni

```
IBM AIX PS/2  Version 1.3.0

911-364 tkinit: No token ring card.  Option not enabled.
<it>: minicartridge tape driver v3.3.0d
<it>: initialization error 23: Drive not found; Driver not installed
900-039 - no if_ena adaptors present
0 Bus Master Token Ring adapter(s) found
900-600 Available User Memory: 1278 pages (0x4fe000 bytes)
900-652 pipe (3/2), root (3/3), swap (3/4), dump (3/5)
init: Checking local copy of root `/dev/root'
/dev/root: gfs 1, pk 1: not checking, filesystem clean
init: Checking local file system `/generic/dev/aixpc'
/generic/dev/aixpc: gfs 3, pk 1: not checking, filesystem clean
Enabling hft ...
date: bad conversion
usage: date [-nu] [[[MM]dd]hh]mm[[.ss]yy]
       date [-nu] [[[[yy]MM]dd]hh]mm[.ss]
       date [-u] [+field descriptors]

INIT: SINGLE USER MODE

Do you want to enter system maintenance (single user) mode ? <n> _



```

És entert nyomni az (Y) után

```
911-364 tkinit: No token ring card.  Option not enabled.
<it>: minicartridge tape driver v3.3.0d
<it>: initialization error 23: Drive not found; Driver not installed
900-039 - no if_ena adaptors present
0 Bus Master Token Ring adapter(s) found
900-600 Available User Memory: 1278 pages (0x4fe000 bytes)
900-652 pipe (3/2), root (3/3), swap (3/4), dump (3/5)
init: Checking local copy of root `/dev/root'
/dev/root: gfs 1, pk 1: not checking, filesystem clean
init: Checking local file system `/generic/dev/aixpc'
/generic/dev/aixpc: gfs 3, pk 1: not checking, filesystem clean
Enabling hft ...
date: bad conversion
usage: date [-nu] [[[MM]dd]hh]mm[[.ss]yy]
       date [-nu] [[[[yy]MM]dd]hh]mm[.ss]
       date [-u] [+field descriptors]

INIT: SINGLE USER MODE

Do you want to enter system maintenance (single user) mode ? <n> y
Give root password for maintenance (single-user) mode:
System Maintenance (single-user) Mode

<aixpc <1>># _
```

A rendszer update-eket az updatep -ac paranccsal telepíthetjük,
amit most ki is adunk. Vigyázat, TILOS összekeverni az installp
paranccsal!

```
/dev/root: gfs 1, pk 1: not checking, filesystem clean
init: Checking local file system `/generic/dev/aixpc'
/generic/dev/aixpc: gfs 3, pk 1: not checking, filesystem clean
Enabling hft ...
date: bad conversion
usage: date [-nu] [[[MM]dd]hh]mm[[.ss]yy]
       date [-nu] [[[[yy]MM]dd]hh]mm[.ss]
       date [-u] [+field descriptors]

INIT: SINGLE USER MODE

Do you want to enter system maintenance (single user) mode ? <n> y
Give root password for maintenance (single-user) mode:
System Maintenance (single-user) Mode

<aixpc <1>># updatep -ac
000-123 Warning: Before you continue, you must minimize other activity on the
        system. Under no conditions should you allow more that one session of
        any of the service tools (installp, updatep, or uninst) to run
        at the same time. Failure to do so may result in damage to the LPP(s)
        being serviced and to the history files.

        Do you want to continue with this command?  (y or n)

        ---> _
```

(Y)-t vár, majd helyezzük be a PTF0024-U436295 update három floppyja
közül az elsőt, utána nyomjunk entert

```
/generic/dev/aixpc: gfs 3, pk 1: not checking, filesystem clean
Enabling hft ...
date: bad conversion
usage: date [-nu] [[[MM]dd]hh]mm[[.ss]yy]
       date [-nu] [[[[yy]MM]dd]hh]mm[.ss]
       date [-u] [+field descriptors]

INIT: SINGLE USER MODE

Do you want to enter system maintenance (single user) mode ? <n> y
Give root password for maintenance (single-user) mode:
System Maintenance (single-user) Mode

<aixpc <1>># updatep -ac
000-123 Warning: Before you continue, you must minimize other activity on the
        system. Under no conditions should you allow more that one session of
        any of the service tools (installp, updatep, or uninst) to run
        at the same time. Failure to do so may result in damage to the LPP(s)
        being serviced and to the history files.

        Do you want to continue with this command?  (y or n)

        ---> y
Please mount volume 1 on /dev/rfd0
...and press Enter to continue _
```

Mindet kiválasztottam

```
x ./usr/sys/inst_updt/special
    files restored: 3
Extracting optional ctarp file from control archive ... done.
048-116 The system is checking the update against your programs.  This may
        take a while.  Please wait.
048-082 Commit Updates Menu

        No_Special_Function_Required

         ID UPDATE

          1 Serv Tool Update for 386 opsys
          2 Critical Updates for 386 opsys
          3 Cmd Updates for 386 (opsys)
          4 Kernel Updates for 386 (opsys)
          5 Apply All of the
            Above Updates

        You may select one or more numbers from the list.

        Type the ID numbers of the programs you wish to commit separated
        by spaces (example: 1 3) and press Enter.
        To cancel the updatep command enter "quit".

        ---> _
```

begépelünk egy 5-öst, majd entert nyomunk

```
        take a while.  Please wait.
048-082 Commit Updates Menu

        No_Special_Function_Required

         ID UPDATE

          1 Serv Tool Update for 386 opsys
          2 Critical Updates for 386 opsys
          3 Cmd Updates for 386 (opsys)
          4 Kernel Updates for 386 (opsys)
          5 Apply All of the
            Above Updates

        You may select one or more numbers from the list.

        Type the ID numbers of the programs you wish to commit separated
        by spaces (example: 1 3) and press Enter.
        To cancel the updatep command enter "quit".

        ---> 5

Performing pre- and co-requisite checks...
Performing space/inode requirement checks ...
_
```

(Y) ...

```
        You may select one or more numbers from the list.

        Type the ID numbers of the programs you wish to commit separated
        by spaces (example: 1 3) and press Enter.
        To cancel the updatep command enter "quit".

        ---> 5

Performing pre- and co-requisite checks...
Performing space/inode requirement checks ...
048-085 Specific update instructions exist for the programs
        listed below.  They should be reviewed before continuing with the
        update.

        Program                           Update Instruction File

        IBM AIX PS/2 Critical Updates     /usr/lpp/oscrit/ui.01.30.0024
        IBM AIX PS/2 Kernel Updates fo    /usr/lpp/oskern/ui.01.30.0024

        Enter "Y" if you wish to continue the update without reviewing
        the update instructions, "N" to quit the updatep program. Any other
        response will display the listed files.

        ---> _
```

... és enter, ilyen sorrendben

```
        You may select one or more numbers from the list.

        Type the ID numbers of the programs you wish to commit separated
        by spaces (example: 1 3) and press Enter.
        To cancel the updatep command enter "quit".

        ---> 5

Performing pre- and co-requisite checks...
Performing space/inode requirement checks ...
048-085 Specific update instructions exist for the programs
        listed below.  They should be reviewed before continuing with the
        update.

        Program                           Update Instruction File

        IBM AIX PS/2 Critical Updates     /usr/lpp/oscrit/ui.01.30.0024
        IBM AIX PS/2 Kernel Updates fo    /usr/lpp/oskern/ui.01.30.0024

        Enter "Y" if you wish to continue the update without reviewing
        the update instructions, "N" to quit the updatep program. Any other
        response will display the listed files.

        ---> y
_
```

Bámészkodnivaló

```
tar: record size = 20 blocks
x ./usr/lpp/osserv/inst_updt
x ./usr/lpp/osserv/inst_updt/arp, 28654 bytes, 56 tape blocks



IBM AIX PS/2 Operating System Version 1.3.0
IBM AIX PS/2 Service Tools Update FSU Version 1.3.0

5713-AEQ (C) Copyright International Business Machines Corporation 1988, 1989,
1990, 1992
All Rights Reserved
Licensed Material - Property of International Business Machines Corporation

US Government Users Restricted Rights - Use, duplication or disclosure is
restricted by GSA ADP Schedule Contract with International Business Machines
Corporation.

IBM is a registered trademark of International Business Machines Corporation.
AIX is a trademark of International Business Machines Corporation.
PS/2 is a registered trademark of International Business Machines Corporation.



_
```

Eddig a lépésig a gép kérésére megkínáltuk a patch második, és
harmadik floppylemezével is

```
Saving /usr/lpp/osserv to /usr/lpp.save/1/osserv
Done     at Thu Jan  1 01:25:46 1970
12 blocks on 1 volume(s)
Saving /usr/lpp/oscrit to /usr/lpp.save/1/oscrit
Done     at Thu Jan  1 01:25:50 1970
32 blocks on 1 volume(s)
Saving /usr/lpp/oscmds to /usr/lpp.save/1/oscmds
Done     at Thu Jan  1 01:25:55 1970
4 blocks on 1 volume(s)
Saving /usr/lpp/oskern to /usr/lpp.save/1/oskern
Done     at Thu Jan  1 01:26:02 1970
928 blocks on 1 volume(s)
Saving status /usr/sys/inst_updt to /usr/lpp.save/1/status
Done     at Thu Jan  1 01:26:06 1970
180 blocks on 1 volume(s)
048-089 The system is now starting to commit the updates for program
        "Serv Tool Update for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Critical Updates for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Cmd Updates for 386 (opsys)".
048-089 The system is now starting to commit the updates for program
        "Kernel Updates for 386 (opsys)".
048-088 All requested update processing is completed.
_
```

Ezután illik bebootolni multiuser módban!

```
Saving /usr/lpp/oskern to /usr/lpp.save/1/oskern
Done     at Thu Jan  1 01:26:02 1970
928 blocks on 1 volume(s)
Saving status /usr/sys/inst_updt to /usr/lpp.save/1/status
Done     at Thu Jan  1 01:26:06 1970
180 blocks on 1 volume(s)
048-089 The system is now starting to commit the updates for program
        "Serv Tool Update for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Critical Updates for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Cmd Updates for 386 (opsys)".
048-089 The system is now starting to commit the updates for program
        "Kernel Updates for 386 (opsys)".
048-088 All requested update processing is completed.

qproc: Processing queue entry 1 of 2
LPP oskern is not installed on this site.
Ignoring queue entry 1

qproc: Processing queue entry 2 of 2
LPP oskern is not installed on this site.
Ignoring queue entry 2
qproc complete
<aixpc <1>># _
```

exit paranccsal lépünk tovább

```
Saving /usr/lpp/oskern to /usr/lpp.save/1/oskern
Done     at Thu Jan  1 01:26:02 1970
928 blocks on 1 volume(s)
Saving status /usr/sys/inst_updt to /usr/lpp.save/1/status
Done     at Thu Jan  1 01:26:06 1970
180 blocks on 1 volume(s)
048-089 The system is now starting to commit the updates for program
        "Serv Tool Update for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Critical Updates for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Cmd Updates for 386 (opsys)".
048-089 The system is now starting to commit the updates for program
        "Kernel Updates for 386 (opsys)".
048-088 All requested update processing is completed.

qproc: Processing queue entry 1 of 2
LPP oskern is not installed on this site.
Ignoring queue entry 1

qproc: Processing queue entry 2 of 2
LPP oskern is not installed on this site.
Ignoring queue entry 2
qproc complete
<aixpc <1>># exit_
```

Most nem akarunk karbantartani, ezért csak entert ütünk

```
Done     at Thu Jan  1 01:26:06 1970
180 blocks on 1 volume(s)
048-089 The system is now starting to commit the updates for program
        "Serv Tool Update for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Critical Updates for 386 opsys".
048-089 The system is now starting to commit the updates for program
        "Cmd Updates for 386 (opsys)".
048-089 The system is now starting to commit the updates for program
        "Kernel Updates for 386 (opsys)".
048-088 All requested update processing is completed.

qproc: Processing queue entry 1 of 2
LPP oskern is not installed on this site.
Ignoring queue entry 1

qproc: Processing queue entry 2 of 2
LPP oskern is not installed on this site.
Ignoring queue entry 2
qproc complete
<aixpc <1>># exit

INIT: SINGLE USER MODE

Do you want to enter system maintenance (single user) mode ? <n> _
```

Várakozunk türelmesen

```
Do you want to enter system maintenance (single user) mode ? <n>

INIT: New run level: 2
Starting tlogger...
Thu Jan 01 01:32:18 CET 1970

Checking file systems...
/dev/rhd1: gfs 2, pk 1: not checking, filesystem clean
/dev/rhd6: gfs 4, pk 1: not checking, filesystem clean
Checks done.
/dev/hd6 mounted on /aixpc/tmp
mount: Warning: /aixpc/tmp wasn't empty
/dev/hd1 mounted on /u
Running driver config task ...
Starting systems logging daemon...
Starting cron...
Starting qdaemon...
Starting errdemon...
Rebuilding ps data file...
Starting sendmail daemon...
3 aliases, longest 11 bytes, 53 bytes total
Remaking /etc/motd...
Preserving ex/vi crash files...
Performing one-time installation procedures...
_
```

Enter, és reboot

```
INIT: New run level: 2
Starting tlogger...
Thu Jan 01 01:32:18 CET 1970

Checking file systems...
/dev/rhd1: gfs 2, pk 1: not checking, filesystem clean
/dev/rhd6: gfs 4, pk 1: not checking, filesystem clean
Checks done.
/dev/hd6 mounted on /aixpc/tmp
mount: Warning: /aixpc/tmp wasn't empty
/dev/hd1 mounted on /u
Running driver config task ...
Starting systems logging daemon...
Starting cron...
Starting qdaemon...
Starting errdemon...
Rebuilding ps data file...
Starting sendmail daemon...
3 aliases, longest 11 bytes, 53 bytes total
Remaking /etc/motd...
Preserving ex/vi crash files...
Performing one-time installation procedures...
The kernel has been rebuilt.  Please press RETURN to reboot.
_
```

Mindjárt újraindul a rendszer

```
Starting tlogger...
Thu Jan 01 01:32:18 CET 1970

Checking file systems...
/dev/rhd1: gfs 2, pk 1: not checking, filesystem clean
/dev/rhd6: gfs 4, pk 1: not checking, filesystem clean
Checks done.
/dev/hd6 mounted on /aixpc/tmp
mount: Warning: /aixpc/tmp wasn't empty
/dev/hd1 mounted on /u
Running driver config task ...
Starting systems logging daemon...
Starting cron...
Starting qdaemon...
Starting errdemon...
Rebuilding ps data file...
Starting sendmail daemon...
3 aliases, longest 11 bytes, 53 bytes total
Remaking /etc/motd...
Preserving ex/vi crash files...
Performing one-time installation procedures...
The kernel has been rebuilt.  Please press RETURN to reboot.

Jan  1 01:38:14  reboot: reboot initiated by root
_
```

Bootoljunk DOS-t, leginkább a harddiskről, és ...

```
Plex86/Bochs VGABios current-cvs 16 Apr 2010
This VGA/VBE Bios is released under the GNU LGPL

Please visit :
 . http://bochs.sourceforge.net
 . http://www.nongnu.org/vgabios

Bochs VBE Display Adapter enabled

Bochs BIOS - build: 06/30/10
$Revision: 1.247 $ $Date: 2010/04/04 19:33:50 $
Options: apmbios pcibios pnpbios eltorito rombios32

ata0 master: LOCALBUSHD ATA-6 Hard-Disk ( 296 MBytes)

Press F12 for boot menu.

Select boot device:

1. Floppy
2. Hard Disk
3. CD-Rom



```

... és állítsuk be MOST a BOOTMGR programmal a második partíciót AIX
menüpontként, majd mentsük el a BOOTMGR beállításokat (a partíciós
táblába), aztán reboot. Ha mindent jól csináltunk, ilyesmit kell
látnunk:

```
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################### [HD1] 09 ###################################
################################### DOS      ###################################
################################### AIX      ###################################
################################### <Floppy> ###################################
################################### <NextHD> ###################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
```

No, kész a játékunk

```
                         IBM AIX PS/2 Operating System

                                 VERSION 1.3.0




                Booting default unix.std from disk
                    Press any key to override.








IBM AIX PS/2 Operating System - Version 1.3.0
5713-AEQ (C) COPYRIGHT IBM CORP. 1988
LICENSED MATERIAL - PROGRAM PROPERTY OF IBM
All Rights Reserved
PS/2 and AIX are trademarks of International Business Machines Corp.


```

Öröm és boldogság!

```
IBM AIX PS/2  Version 1.3.0

911-364 tkinit: No token ring card.  Option not enabled.
<it>: minicartridge tape driver v3.3.0d
<it>: initialization error 23: Drive not found; Driver not installed
900-039 - no if_ena adaptors present
900-600 Available User Memory: 1294 pages (0x50e000 bytes)
900-652 pipe (3/2), root (3/3), swap (3/4), dump (3/5)
900-962 LARP version 3
init: Checking local copy of root `/dev/root'
/dev/root: gfs 1, pk 1: not checking, filesystem clean
init: Checking local file system `/generic/dev/aixpc'
/generic/dev/aixpc: gfs 3, pk 1: not checking, filesystem clean
_











```

Mert a csókja édes, annyi szent!

```
900-039 - no if_ena adaptors present
900-600 Available User Memory: 1294 pages (0x50e000 bytes)
900-652 pipe (3/2), root (3/3), swap (3/4), dump (3/5)
900-962 LARP version 3
init: Checking local copy of root `/dev/root'
/dev/root: gfs 1, pk 1: not checking, filesystem clean
init: Checking local file system `/generic/dev/aixpc'
/generic/dev/aixpc: gfs 3, pk 1: not checking, filesystem clean
Enabling hft ...
date: bad conversion
usage: date [-nu] [[[MM]dd]hh]mm[[.ss]yy]
       date [-nu] [[[[yy]MM]dd]hh]mm[.ss]
       date [-u] [+field descriptors]
Starting tlogger...
Thu Jan 01 01:00:13 CET 1970

Checking file systems...
/dev/rhd1: gfs 2, pk 1: not checking, filesystem clean
/dev/rhd6: gfs 4, pk 1: not checking, filesystem clean
Checks done.
/dev/hd6 mounted on /aixpc/tmp
mount: Warning: /aixpc/tmp wasn't empty
/dev/hd1 mounted on /u
Running driver config task ...
_
```

Türelem!

```
usage: date [-nu] [[[MM]dd]hh]mm[[.ss]yy]
       date [-nu] [[[[yy]MM]dd]hh]mm[.ss]
       date [-u] [+field descriptors]
Starting tlogger...
Thu Jan 01 01:00:13 CET 1970

Checking file systems...
/dev/rhd1: gfs 2, pk 1: not checking, filesystem clean
/dev/rhd6: gfs 4, pk 1: not checking, filesystem clean
Checks done.
/dev/hd6 mounted on /aixpc/tmp
mount: Warning: /aixpc/tmp wasn't empty
/dev/hd1 mounted on /u
Running driver config task ...
Starting systems logging daemon...
Starting cron...
Starting qdaemon...
Starting errdemon...
Rebuilding ps data file...
Starting sendmail daemon...
Remaking /etc/motd...
Preserving ex/vi crash files...
End of tlogger style logging of application console i/o
Coming up Multiuser...

```

Jelentkezzünk be root-ként

```



















IBM AIX PS/2 Operating System - Version 1.3.0
5713-AEQ (C) COPYRIGHT IBM CORP. 1988,1989,1990,1992
LICENSED MATERIAL - PROGRAM PROPERTY OF IBM
aixpc
Console login:_
```

Jelszó alapértelmezés szerint nincs beállítva

```



















IBM AIX PS/2 Operating System - Version 1.3.0
5713-AEQ (C) COPYRIGHT IBM CORP. 1988,1989,1990,1992
LICENSED MATERIAL - PROGRAM PROPERTY OF IBM
aixpc
Console login:root_
```

Melyik mátrixban vagyunk, Morpheus?

```








IBM AIX PS/2 Operating System - Version 1.3.0
5713-AEQ (C) COPYRIGHT IBM CORP. 1988,1989,1990,1992
LICENSED MATERIAL - PROGRAM PROPERTY OF IBM
aixpc
Console login:root
                                 -- IBM AIX --

 ******************************************************************************
 *                                                                            *
 *              (     place your message of the day here     )                *
 *                                                                            *
 ******************************************************************************


aixpc # uname -a
_
```

taps, függöny

```





IBM AIX PS/2 Operating System - Version 1.3.0
5713-AEQ (C) COPYRIGHT IBM CORP. 1988,1989,1990,1992
LICENSED MATERIAL - PROGRAM PROPERTY OF IBM
aixpc
Console login:root
                                 -- IBM AIX --

 ******************************************************************************
 *                                                                            *
 *              (     place your message of the day here     )                *
 *                                                                            *
 ******************************************************************************


aixpc # uname -a
AIX aixpc 1 3.0 i386
aixpc # echo 'Fuck yeah!'
Fuck yeah!
aixpc # _
```

Jövőbeni tennivalók:
ATE telepítés leírása, soros port konfigurálása, TCP/IP telepítése,
SLIP telepítése U436296 (!=U436295) patch által, SLIP beállítása,
megfelelően támogatott ISA-s hálózati kártya beállítása, sshd portolása,
kisebb ftp szerver beüzemelése, bilibemarkolva horkantva felébredés

Utolsó módosítás: 2012.06.18.
Mégutolsóbb mosdósítás(tm)((c) term bát űberexpert former kálig): 2021.07.14.
