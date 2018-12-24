# pce-5160.cfg
path=" DUMMY $(: '"
# ')";(sleep 10;cat galax56k.bin|nc 127.0.0.1 5232;echo COM1 XFER DONE) & : '
# ' ; pce-ibmpc -v -c "$0" -g cga -r ; exit $? ; #
path="."
path="rom"
system {
	model="5160"
	boot=0
	rtc=0
	memtest=0
	floppy_disk_drives=0
	patch_bios_init=1
	patch_bios_int19=1
}
cpu {
	model="8088"
	speed=1
}
ram {
	address=0
	size=640K
}
load {
	format="binary"
	address=0xfe000
	file="ibm-xt-1982-11-08.rom"
}
load {
	format="binary"
	address=0xf6000
	file="ibm-basic-1.10.rom"
}
rom {
	address=0xf6000
	size=40K
}
terminal {
	driver="x11"
	scale=1
	mouse_mul_x=1
	mouse_div_x=1
	mouse_mul_y=1
	mouse_div_y=1
}
video {
	device="cga"
	font=0
	blink=30
}
speaker {
	volume=250
	lowpass=8000
	sample_rate=44100
	driver="null"
}
serial {
	uart="8250"
	address=0x3f8
	irq=4
	multichar=1
	driver="tcp:port=5232"
}
