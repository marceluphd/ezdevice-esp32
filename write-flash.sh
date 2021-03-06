
set - e

TYP=L
APP=releases/firmware-$TYP.bin

esptool.py -b 921600 write_flash  0x10000 $APP

# Don't really need to write the second copy - instead just fill with 0xff
# esptool.py -b 921600 write_flash 0x150000 $APP
esptool.py -b 921600 erase_region 0x150000 0x140000

esptool.py -b 921600 write_flash 0x290000 eeprom.bin
esptool.py -b 921600 write_flash   0x9000 nvs.bin

echo "Device MAC (fixme - print a full ezdevice serial number"
esptool.py read_mac | grep MAC | head -1 | cut -d " " -f 2 | cut -d : -f 1- --output-delimiter=""
