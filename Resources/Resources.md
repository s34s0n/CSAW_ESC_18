# Some tips 
- Start by reading specification ([core](https://www.bluetooth.com/specifications/bluetooth-core-specification) and [GATT](https://www.bluetooth.com/specifications/gatt)) and learn how it works
- Sometimes you need to change your bdaddr (MAC addr) to match the original device
- Study the hardware and check what kind of approach is better (sniffing, MiTM, brute-forcing, etc)
- You learn a lot by [RE the mobile application](https://www.evilsocket.net/2017/04/27/Android-Applications-Reversing-101/)
- By reversing don’t forget to search for specific keywords – liked password, CMD, secret and stuff like (sometimes you get some low hanging fruits)
- For alternative sniffing, use Android Bluetooth HCI snoop log
- Be persistent, don’t give up on first sign of fail

# Resources 
- [Exploiting IoT enabled BLE smart bulb security](http://blog.attify.com/2017/01/17/exploiting-iot-enabled-ble-smart-bulb-security/) 
- [Introduction to Bluetooth Low Energy](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/introduction)
- [Security Analysis of Wearable Fitness Devices](https://courses.csail.mit.edu/6.857/2014/files/17-cyrbritt-webbhorn-specter-dmiao-hacking-fitbit.pdf)
- [Like+ FuelBand SE BLE Protocol Reversed](https://www.evilsocket.net/2015/01/29/nike-fuelband-se-ble-protocol-reversed/)
- [Blue picking – hacking Bluetooth Smart Lock](http://smartlockpicking.com/slides/HITB_AMS_2017_Blue_Picking_-_Hacking_Bluetooth_Smart_Locks.pdf)
- [GATTacking Bluetooth Smart Devices](https://github.com/securing/docs/blob/master/whitepaper.pdf)
- [Locating and exploiting smart adult toys](https://www.pentestpartners.com/security-blog/screwdriving-locating-and-exploiting-smart-adult-toys/)
- [Hexiwear Bluetooth Low Energy Packet Sniffing with Wireshark](https://mcuoneclipse.com/2016/12/25/tutorial-hexiwear-bluetooth-low-energy-packet-sniffing-with-wireshark/)
- [Hack a BT Low Energy (BLE) butt plug](https://scubarda.wordpress.com/2017/10/17/hacking-a-bt-low-energy-ble-butt-plug/)
- [How to pick a BLE smart lock and cause cancer using just a mobile phone](https://smartlockpicking.com/tutorial/how-to-pick-a-ble-smart-lock-and-cause-cancer/)
- [HlueSteal: Popping GATT Safes](https://www.twosixlabs.com/bluesteal-popping-gatt-safes/)
- [Low I Reverse Engineered and Exploited a Smart Massager](https://medium.com/@arunmag/how-i-reverse-engineered-and-exploited-a-smart-massager-ee7c9f21bf33)
- [BLE Driving 101](https://www.davidsopas.com/ble-driving-101/)
- [My journey towards Reverse Engineering a Smart Band — Bluetooth-LE RE](https://medium.com/@arunmag/my-journey-towards-reverse-engineering-a-smart-band-bluetooth-le-re-d1dea00e4de2)
- [Exploiting Bluetooth Low Energy using Gattacker for IoT – Step-by-Step Guide](https://blog.attify.com/hacking-bluetooth-low-energy/)
- [Totally Pwning the Tapplock Smart Lock NEW](https://www.pentestpartners.com/security-blog/totally-pwning-the-tapplock-smart-lock/)
- [How to extract the firmware from a device](https://ianhowson.com/iot/extracting-firmware/)
- [Extracting directly from the hardware while capturing when the device is updating](https://www.owasp.org/index.php/IoT_Firmware_Analysis)
- [Practical Reverse engineering hunting foor debug ports](http://jcjc-dev.com/2016/04/08/reversing-huawei-router-1-find-uart/)
_ This link provides step by step through the process of Reverse Engineering a router. More specifically, a Huawei HG533.
- [How to dump the firmware from EEPROM with the help of Buspirate](http://iotpentest.com/how-to-dump-the-firmware-from-the-router-using-buspirate/)
- [Harddisk firmware hacking](https://www.malwaretech.com/2015/04/hard-disk-firmware-hacking-part-1.html)

# Hardware
- Ubertooth
- CSR 4.0 Bluetooth dongle
- [Ellisys Bluetooth Explorer 400](http://www.ellisys.com/products/bex400/)
- [ComProbe BPA® 600 Dual Mode Bluetooth](http://www.fte.com/products/BPA600.aspx)
- [Adafruit nRF51822](https://www.adafruit.com/product/2269)
- Sena UD100 Long Range Bluetooth 4.0 Class1 USB Adapter

# Tools
- [RF Connect](https://www.nordicsemi.com/eng/Products/Nordic-mobile-Apps/nRF-Connect-for-mobile-previously-called-nRF-Master-Control-Panel) (Android or iOS)
- [Lightblue](https://punchthrough.com/bean) (Android or iOS)
- [BtleJuice Bluetooth Smart (LE) Man-in-the-Middle framework](https://github.com/DigitalSecurity/btlejuice)
- [GATTacker MiTM](https://github.com/securing/gattacker)
- [Wireshark](https://www.wireshark.org/) 
- [crackle](https://github.com/mikeryan/crackle) (crack and decrypt BLE encryption)
- [BLEAH](https://github.com/evilsocket/bleah) (great BLE scanner)
- [Bluetooth Python extension module](https://github.com/karulis/pybluez)
- [bettercap](https://github.com/bettercap/bettercap) (it has a BLE module)
- [RaMBLE](https://play.google.com/store/apps/details?id=com.contextis.android.BLEScanner&hl=en_US) – Bluetooth LE Mapper (Android) 
- [Firmware automatic dumping and extraction tool](https://gist.github.com/cryptolok/6916aee059c0b8317ed7078adaa7a226)

# Talks

- [DEFCON 24 Wireless Village – Jose Gutierrez and Ben Ramsey – How Do I BLE Hacking](https://www.youtube.com/watch?v=oP6sx2cObrYillall -q polybar)
- [DEF CON 24 – Anthony Rose, Ben Ramsey – Picking Bluetooth Low Energy Locks a Quarter Mille Away](https://www.youtube.com/watch?v=KrOReHwjCKI)
- [Hack.lu 2016 BtleJuice: the Bluetooth Smart Man In The Middle Framework by Damiel Cauquil](https://www.youtube.com/watch?v=G08fh5Sa7TU)
- [Bluetooth Smart: The Good, the Bad, the Ugly, and the Fix!](https://www.youtube.com/watch?v=SoH11fi-FcA)
- [Hack-a-ble (SHA2017)](https://www.youtube.com/watch?v=5xJ_xeNJ3WU)
- [Gattacking Bluetooth Smart Devices – Introducing a New BLE Proxy Tool](https://www.youtube.com/watch?v=uKqdb4lF0XU)
- [Battle of the Smarts: Hacking Smartphones with Bluetooth Smart](https://www.youtube.com/watch?v=tsFOBLusdnU)

# Crypto Links

- [Correlation Power Analysis](https://wiki.newae.com/Correlation_Power_Analysis)





