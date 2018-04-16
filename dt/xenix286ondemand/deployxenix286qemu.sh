#!/bin/bash
set -euo pipefail

qemumonitor() {
    if [[ $1 =~ sendkey.* ]]
    then
        nc 127.0.0.1 "$LISTENPORT" <<END >/dev/null 2>&1
$@
END
    else
        nc 127.0.0.1 "$LISTENPORT" <<END | grep -v '^(qemu)'
$@
END
    fi
}

qemuexpect() {
    qemumonitor x/16384xh 0xb8000 \
    | perl -ne 'while(m((?<=0x[0-9a-f]{2})([0-9a-f]{2}))g){print chr(hex($1))}' \
    | grep -E -q -e "$@"
}

### less portable, strtonum() is a gnu awk extension, perl is on OSX by default
# qemuexpect() {
#     qemumonitor x/16384xh 0xb8000 \
#     | awk -F' ' '{for(i=1;i<=NR;++i){if($i~/^0[xX]..../){printf("%c",strtonum($i)%256)}}}' \
#     | grep -E -q -e "$@"
# }

qemudelaysendline() {
    local mystring="${@}"
    local i
    local s
    sleep 1
    for ((i=0;i<${#mystring};++i))
    do
    s="${mystring:$i:1}"
    case "$s" in
        [A-Z]) qemumonitor sendkey shift-${s,,} ;;
        ,) qemumonitor sendkey comma ;;
        =) qemumonitor sendkey equal ;;
        -) qemumonitor sendkey minus ;;
        /) qemumonitor sendkey slash ;;
        .) qemumonitor sendkey dot ;;
        ' ') qemumonitor sendkey spc ;;
        '(') qemumonitor sendkey shift-9 ;;
        ')') qemumonitor sendkey shift-0 ;;
        '$') qemumonitor sendkey shift-4 ;;
        ';') qemumonitor sendkey semicolon ;;
        ':') qemumonitor sendkey shift-semicolon ;;
        '\') qemumonitor sendkey backslash ;;
        '>') qemumonitor sendkey shift-dot ;;
        *) qemumonitor sendkey "${s}" ;;
    esac
    done
    qemumonitor sendkey ret
}

LC_ALL=C
CYLINDERS=820
HEADS=4
SECTORS=17
HDDFILE="./xenix286_c${CYLINDERS}h${HEADS}s${SECTORS}_$((((CYLINDERS*HEADS*SECTORS)+2047)/2048))m.img"
LISTENPORT=4444
SERIALNUMBER='sco021641'
ACTIVATIONCODE='hdwtnkwc'
PASSWORD='xenix286'
QEMU_EXE='qemu-system-i386'
QEMU_EXE+=' -nodefaults'
QEMU_EXE+=' -vga std'
QEMU_EXE+=' -parallel null'
QEMU_EXE+=' -serial null'
QEMU_EXE+=' -m 16'
QEMU_EXE+=' -no-reboot'
QEMU_EXE+=' -no-fd-bootchk'
QEMU_EXE+=' -display vnc=127.0.0.1:1'
QEMU_EXE+=" -drive file=$HDDFILE,cyls=$CYLINDERS,heads=$HEADS,secs=$SECTORS,trans=none,if=ide,format=raw"
QEMU_EXE+=" -monitor tcp:127.0.0.1:$LISTENPORT,server,nowait"
BOOTSTRING='fd(52)xenix root=fd(52) swap=ram(0) pipe=ram(1) swplo=0 nswap=1000 ronly'

echo 'Xenix 286 v2.3.2 will be deployed'
echo 'Author: Naszvadi, Peter, 2018'
md5sum -c md5sums.txt
dd if='/dev/zero' of="$HDDFILE" count="$((CYLINDERS*HEADS*SECTORS))"
$QEMU_EXE -boot a -fda 'n1.img' &
while ! qemuexpect 'Boot {76}:';do sleep 3; done
qemudelaysendline "$BOOTSTRING"
while ! qemuexpect 'to select one of the above options:   ';do sleep 3; done
qemudelaysendline 1
while ! qemuexpect 'Do you wish to continue. .y/n..   ';do sleep 3; done
qemudelaysendline y
while ! qemuexpect "Enter an option or 'q' to quit:  ";do sleep 3; done
qemudelaysendline q
while ! qemuexpect '2. Use Entire Disk for XENIX.*Enter your choice or q to quit:   ';do sleep 3; done
qemudelaysendline 2
while ! qemuexpect 'Press <RETURN> to continue';do sleep 3; done
qemudelaysendline ''
while ! qemuexpect 'Active  *. XENIX.*Press <RETURN> to continue.*Enter your choice or q to quit:   ';do sleep 3; done
qemudelaysendline q
while ! qemuexpect 'Enter your choice or q to quit: q.*Enter your choice or .q. to quit:   ';do sleep 3; done
qemudelaysendline q
while ! qemuexpect 'bad tracks to allocate space for *.or press <RETURN> to use the recommended value';do sleep 3; done
qemudelaysendline ''
while ! qemuexpect 'Please enter the swap-space allocation, or press <RETURN>';do sleep 3; done
qemudelaysendline ''
# while ! qemuexpect 'Do you want a separate /u filesystem. .y/n..   ';do sleep 3; done
# qemudelaysendline n
# while ! qemuexpect 'Do you require block-by-block control over +the layout of the XENIX division';do sleep 3; done
# qemudelaysendline n
while ! qemuexpect 'Do you require block-by-block control over +the layout of the XENIX division|Do you want a separate /u filesystem. .y/n..  ';do sleep 3; done
qemudelaysendline n
if qemuexpect 'Do you want a separate /u filesystem. .y/n.. *n'
then
while ! qemuexpect 'Do you require block-by-block control over +the layout of the XENIX division';do sleep 3; done
qemudelaysendline n
fi
while ! qemuexpect 'Enter your serial number +and press <RETURN>   ';do sleep 3; done
qemudelaysendline "$SERIALNUMBER"
while ! qemuexpect 'Enter your activation key +and press <RETURN>   ';do sleep 3; done
qemudelaysendline "$ACTIVATIONCODE"
while ! qemuexpect 'Hit Any Key to Reboot';do sleep 3; done
qemudelaysendline ''
wait
$QEMU_EXE -boot c -fda 'b1.tar' &
while ! qemuexpect 'Boot {76}:';do sleep 3; done
qemudelaysendline ''
while ! qemuexpect 'and press <RETURN>';do sleep 3; done
sleep 1
qemumonitor sendkey delete
while ! qemuexpect '    <Installation>    ';do sleep 3; done
qemudelaysendline cd /dev
while ! qemuexpect '    <Installation>    ';do sleep 3; done
qemudelaysendline ln -f fd096ds15 install
while ! qemuexpect '    <Installation>    ';do sleep 3; done
qemudelaysendline ln -f rfd096ds15 rinstall
while ! qemuexpect '    <Installation>    ';do sleep 3; done
qemudelaysendline cd /
while ! qemuexpect '    <Installation>    ';do sleep 3; done
qemudelaysendline . /.profile
while ! qemuexpect 'Insert Operating System .Basic Utilities. volume B1 +and press <RETURN>';do sleep 3; done
qemudelaysendline ''
while ! qemuexpect 'Insert Operating System .Basic Utilities. volume B2 +and press <RETURN>';do sleep 3; done
qemumonitor change floppy0 b2.tar
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'New password:';do sleep 3; done
qemudelaysendline "$PASSWORD"
while ! qemuexpect 'Re-enter new password:';do sleep 3; done
qemudelaysendline "$PASSWORD"
while ! qemuexpect 'Are you in North America. .y/n..   ';do sleep 3; done
qemudelaysendline n
while ! qemuexpect 'Enter 1-9 characters or enter q to quit:   ';do sleep 3; done
qemudelaysendline 'CET'
while ! qemuexpect 'GMT. or enter q to quit:   ';do sleep 3; done
qemudelaysendline -1
while ! qemuexpect 'summer time.*apply at your location. .y/n..   ';do sleep 3; done
qemudelaysendline n
while ! qemuexpect '2. Continue installation +Enter an option:   ';do sleep 3; done
qemudelaysendline 2
while ! qemuexpect 'Select a set to customize or enter q to quit:   ';do sleep 3; done
qemudelaysendline 1
while ! qemuexpect 'Insert Operating System .Extended Utilities. volume X1 +and press <RETURN> or enter q to quit:';do sleep 3; done
qemumonitor change floppy0 x1.tar
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'X1 +and press <RETURN> or enter q to quit: +1. Install one or more packages.*Select an option or enter q to quit:';do sleep 3; done
qemudelaysendline 1
while ! qemuexpect 'ALL .* Entire Operating System set.*Enter the package.s. to install +or enter q to return to the menu:';do sleep 3; done
qemudelaysendline 'ALL'
while ! qemuexpect 'ALL +Insert Operating System .Extended Utilities. volume X1 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemudelaysendline ''
while ! qemuexpect 'Insert Operating System .Extended Utilities. volume X2 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemumonitor change floppy0 x2.tar
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'Insert Operating System .Extended Utilities. volume X3 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemumonitor change floppy0 x3.tar
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'Insert Operating System .Extended Utilities. volume X4 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemumonitor change floppy0 x4.tar
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'Does this installation consist of only a root filesystem. .y/n..   ';do sleep 3; done
qemudelaysendline n
while ! qemuexpect 'and a user filesystem named ./u.. .y/n..   ';do sleep 3; done
qemudelaysendline n
while ! qemuexpect 'Please assign a password for .backup.. +(.{1,80} +){2}New password:';do sleep 3; done
qemudelaysendline "$PASSWORD"
while ! qemuexpect 'Please assign a password for .backup.. +(.{1,80} +){2}New password: +Re-enter new password:';do sleep 3; done
qemudelaysendline "$PASSWORD"
while ! qemuexpect 'Please assign a password for .sysadm.. +(.{1,80} +){2}New password:';do sleep 3; done
qemudelaysendline "$PASSWORD"
while ! qemuexpect 'Please assign a password for .sysadm.. +(.{1,80} +){2}New password: +Re-enter new password:';do sleep 3; done
qemudelaysendline "$PASSWORD"
while ! qemuexpect 'Do you want to continue initializing terminfo now. .y/n..   ';do sleep 3; done
qemudelaysendline n
while ! qemuexpect 'Insert Operating System .Installation. volume N1 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemumonitor change floppy0 n1.img
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'Insert Operating System .Installation. volume N2 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemumonitor change floppy0 n2.tar
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'Insert Operating System .Installation. volume N3 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemumonitor change floppy0 n3.tar
qemumonitor info block
qemudelaysendline ''
while ! qemuexpect 'Link kit serialization +Enter your serial number:   ';do sleep 3; done
qemudelaysendline "$SERIALNUMBER"
while ! qemuexpect 'Link kit serialization +Enter your serial number:.{20} +Enter your activation key:   ';do sleep 3; done
qemudelaysendline "$ACTIVATIONCODE"
while ! qemuexpect 'Checking file permissions ... +1. Install one or more packages.+Select an option or enter q to quit:   ';do sleep 3; done
qemudelaysendline 6
qemumonitor change floppy0 ga.tar
qemumonitor info block
while ! qemuexpect 'Select an option or enter q to quit: 6.*4. Add a Supported Product +Select a set to customize or enter q to return to the menu:   ';do sleep 3; done
qemudelaysendline 4
while ! qemuexpect 'Installing custom data files ... +Insert distribution volume 1 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemudelaysendline ''
while ! qemuexpect 'Select a set to customize or enter q to return to the menu: 4 +([^ ]+( [^ ]+)*        +){11}Select an option or enter q to quit:   ';do sleep 3; done
qemudelaysendline 1
while ! qemuexpect 'SCO XENIX Games packages.*or enter q to return to the menu:   ';do sleep 3; done
qemudelaysendline ALL
while ! qemuexpect 'Insert SCO XENIX Games volume 1 +and press <RETURN> or enter q to return to the menu:';do sleep 3; done
qemudelaysendline ''
while ! qemuexpect 'Select an option or enter q to quit:    ';do sleep 3; done
qemudelaysendline q
while ! qemuexpect 'Hit Any Key to Reboot';do sleep 3; done
qemudelaysendline ''
wait
echo 'Exiting.'
