# pce-5150.cfg
path=" DUMMY $(: '"
# ' )" ; pce-ibmpc -v -c "$0" -g cga -R ; exit $? ; #
# # for i in cksum md5sum;do $i *.rom;done
# 1429418630 32768 ibm-basic-1.10.rom
# 3462763022 8192 ibm-pc-1982-10-27.rom
# eb28f0e8d3f641f2b58a3677b3b998cc  ibm-basic-1.10.rom
# 0b2373ff8ce894ba638c05445262a503  ibm-pc-1982-10-27.rom
path="."
system {
	model="5150"
	boot=0
	rtc=0
	memtest=0
	floppy_disk_drives=0
	patch_bios_init=0
	patch_bios_int19=0
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
	file="ibm-pc-1982-10-27.rom"
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
cassette {
	enable=1
	file="archon11k25.wav"
	pcm=1
	pcmfreq=11025
	filter=0
	mode="load"
	position=0
	append=0
}
