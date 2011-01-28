Writing U-Boot to NAND
----------------------

To get the board into NVIDIA's recovery mode where you can write the firmware
you hold the force recovery switch (f.r.) while resetting or powering on.  The
recovery, reset and power buttons are available on the side of the board
oposite the HDMI connector.  They are also available on the satellite board.

Make sure there are no USB devices attached to the board while using recovery
mode.  One of the host side USB ports is reclaimed for the OTG port.

The Seaboard has a number of boot jumpers that need to be correctly configured
to write to the NAND and boot from it.  They are all located in the corner of
the board that has the Camera and LVDS connectors.

The jumpers must be set as specified below before writing to the NAND.

BOOT SEL 0 : jumper pins 2 and 3
BOOT SEL 1 : jumper pins 2 and 3
BOOT SEL 2 : jumper pins 1 and 2
BOOT SEL 3 : jumper pins 1 and 2
MFG MODE   : jumper pins 1 and 2

These jumpers are also available on the keyboard.

Once in recovery mode run the following from inside the chroot:

~/trunk/src/scripts/bin/write-tegra-bios --board tegra2_seaboard
