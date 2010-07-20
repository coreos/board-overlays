Attached is my simple OpenOCD .cfg file for use w/Harmony. 

I'm using it with a Flyswatter (tincantools.com) JTAG-USB board.

To change to a different JTAG interface (parallel port Wiggler, for example):

Replace 
"source [find interface/flyswatter.cfg]"
with
"source [find interface/parport.cfg]"

I'm using OpenOCD 0.4.0 on both Linux and in a WinXP DOS box. I've
compiled it for the lib-ftdi USB library. I've tried OpenOCD 0.5.x but
it seems to be more finicky. 

I run OpenOCD in one DOS box/terminal window, from the main OpenOCD
install directory (with bin, board, interface, and targets subdirs
below): 

>bin/openocd -f harmony.cfg

It will display the OpenOCD sign-on and report the scan-chain
detected. If you see any errors or warnings about unexpected JTAG IDs,
etc., then you'll (usually) need to reset or re-init the scan. Open
another DOS box/terminal app and use telnet to talk to the OpenOCD
daemon: 

>telnet localhost 4444

At the "Open On-Chip Debugger" prompt:

>jtag_init

Or 

>reset halt

a few times until you see that OpenOCD has seen/configured the 2 JTAG
devices correctly (0x4f1f0f0f and 0x4ba00477) and has printed some
lines about the 'Embedded ICE' version and that 2
breakpoints/watchpoints are available. That means that the AVP is now
available for halt/debug/run/etc. via OpenOCD/telnet. 

If that doesn't work after several attempts, I've had the most luck
with re-running OpenOCD. In the DOS box/terminal it's running in, kill
it with Ctrl-C, and immediately run it again w/the same args
(bin/openocd -f harmony.cfg). Keep doing that (exit and re-run)
until you get the 'Embedded ICE' string. Note that you'll need to
reload telnet in the other DOS box/term window once you've got a good
JTAG scan, since it quits when OpenOCD exits. 

You can tell that you've got full JTAG control if you do a 'targets'
command in telnet and see that the arm7tdmi cpu is 'running'. You
should then be able to do a 'halt' in telnet and dump regs ('arm reg',
or 'reg pc', etc.), examine memory ('mdb', 'mdw', etc.) and transfer
binaries into Tegra2 RAM ('load_image'). If the 'halt' times out or
doesn't work, you can try a couple of 'reset halt' commands and that
will usually get it to stop. 

Type 'help' in telnet for a list of OpenOCD commands.

I've successfully stepped thru bootROM code on the AVP, loaded binary
images into SDRAM and stepped thru them, set breakpoints, and dumped
memory images back to the host PC. I've used OpenOCD with the default
flyswatter and ti_beagleboard cfg files on a TI BeagleBoard (cortexA8)
and been successful loading u-boot to RAM and executing it
there. Until we get a u-boot compiled for the AVP on Tegra, that
doesn't work on Harmony. 



