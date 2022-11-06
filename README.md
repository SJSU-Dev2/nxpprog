# Programmer for NXP arm processors using ISP protocol.

Python version must be 3.9 and above.

## Installing using pip

```
pip install nxpprog
```

## Installing Requirements

```bash
python3 -m pip install -r requirements.txt
```

## Running nxpprog.py

For help run the command with no arguments:

```bash
python nxpprog.py
```

## Help menu

```
nxpprog.py <serial device> <image_file> : program image file to processor.
nxpprog.py --udp <ip address> <image_file> : program processor using Ethernet.
nxpprog.py --start=<addr> <serial device> : start the device at <addr>.
nxpprog.py --read=<file> --addr=<address> --len=<length> <serial device>:
            read length bytes from address and dump them to a file.
nxpprog.py --serialnumber <serial device> : get the device serial number
nxpprog.py --list : list supported processors.

Options:
  --binary TEXT     Path to the firmware.bin file you want to program the
                    board with.  [required]

  --device TEXT     Path to serial device file. In linux the name should be
                    something similar to "/dev/ttyUSB0", WSL "/dev/ttyS0", and
                    Max OSX "/dev/tty-usbserial-AJ20A5".  [required]

  --udp             Program processor using Ethernet.
  --cpu TEXT        Set the cpu type.
  --osfreq INTEGER  Set the oscillator frequency.
  --baud INTEGER    Set the baud rate.
  --xonxoff         Enable xonxoff flow control.
  --control         Use RTS and DTR to control reset and int0.
  --start           Start the device at a set address.
  -v, --verbose     Enable version debug message output.
  --read TEXT       Read from a file.
  --len INTEGER     Number of bytes to be read.
  --serialnumber    Get the device serial number.
  --list            List supported processors.
  --addr TEXT       Set the base address for the image.
  --verify          Read the device after programming.
  --verifyonly      Don't program, just verify.
  --eraseonly       Don't program, just erase. Implies --eraseall.
  --eraseall        Erase all flash not just the area written to.
  --blankcheck      Don't program, just check that the flash is blank.
  --filetype TEXT   Set filetype to intel hex format or raw binary.
  --bank INTEGER    Set filetype to intel hex format or raw binary.
  --port INTEGER    UDP port number to use (default 41825).
  --mac TEXT        MAC address to associate IP address with.
  --help            Show this message and exit.
```

## How to Flash an NXP LPC Microcontroller

### Using a USB to UART adaptor with both DTR & RTS

NOTE: Development boards with USB to UART adaptors on them can skip these steps.

Otherwise connect a USB to serial converter to UART port 0 on your device.
The USB to serial converter MUST have DTR and RTS support. An example of an
adaptor with all of the necessary pins is
[USB to UART adaptor](https://www.amazon.com/USB-Convert-TTL-Multifunctional-Functions/dp/B01CNW061U).

Connect DTR to the chips RESET pin and RTS to the chips NMI pin.

### USB to UART adaptor without DTR or RTS

If you don't have a a USB to UART adaptor with both RTS and DTR but have some
way to control the RESET and NMI pin directly. Lets use a set of push buttons
as an example. Here are the steps:

1. Hold down both RESET & NMI (pressing the button should short these signals to
   ground)
2. Release NMI
3. Release Reset
4. Device should be in bootloader mode now.

To test this over a serial monitor, connect to the device using any baud rate,
recommended 115200, and send a single `?` character. The device should
respond with a `Synchronized` message back.

### Flashing with NXPPROG

The general command for flashing a device with a binary looks like this:

```
nxpprog --control --binary="main.bin" --device="/dev/tty.usbserial-140"
```

- `--control`: This will control the DTR and RTS pins in order to put the device
  into bootloader mode, remove this if the device has been put into bootloader
  mode in some other way.
- `--binary="main.bin"`: path to the `.bin` file
- `--device="/dev/tty.usbserial-140"`: path to the serial port file on your
  system.
    - Windows: COM1, COM2, etc..
    - Linux: /dev/ttyUSB0, /dev/ttyACM0, /dev/ttyUSB1 ...
    - MacOS: /dev/tty.usbserial-140, /dev/cu.usbserial-AC140J, ...
