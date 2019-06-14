# Coercive Man-in-the-Middle

In this report, we discuss the approaches we use to sniff the packet transfer between the bulb and the connected device without the knowledge of either of the two devices. We focus on a couple of methods which all works with the same principle of Man-in-the-Middle wherein a third party gain access to the data transferred between a connection between two devices by emulating one of the devices participating in the connection.

##  Man-in-the-Middle Attacks

#### Introduction

Man-in-the-Middle is the approach we will be discussing first. As the name suggests this method involves the third device apart from the two connecting devices in a BLE Connection which emulates one of the devices, thus virtually taking control of the data transfer between the two devices. While in most cases the attack is done before a successful connection is established, here we perform the attack after a successful connection is established between both the devices. 

Ever since BLE has been proven insecure against eavesdropping a lot of open-source MitM architectures such as Gattacker and BTLEJuice were created. attackers do not need to trick users into performing an action to compromise or infect them, nor does a target device's Bluetooth have to pair with an attack device or even be in Discovery Mode. The device simply has to have its Bluetooth feature turned on, which for most products is the default setting.

#### Components

The main components used in this attack include an Ubertooth One, to capture and transmit data packets; an SDR to transmit RF of a specific frequency to create interference in the connection, a Linux system and also a Raspberry Pi. In this setup, the Raspberry Pi becomes the Master device and the Linux system becomes the Slave device. After scanning the type of chipset being used in the IoT device we are able to find the frequency range of data transmission, thus we can emit RF of the required frequency to break the connection after which we use the Ubertooth to capture the packets that are being advertised and use it to emulate the device using the Slave device. The Master device, on the other hand, starts sending advertisements in large magnitudes to ensure that the devices connect with the Slave device.

#### Working

The attack works by emulating the device to be sniffed; in this case the Smart Bulb, by sending the same Advertising packets sent by the original device using the Master device; which is the RaspPi. Before this for getting the advertisement packets, we need to break the already existing connection, since advertising stops the moment a connection is established between two devices. For this, we use the SDR to emit RF waves of required frequency to break the connection. We then capture the advertising packets and then emit them through the RaspPi thus emulating the original device, thus once a connection is established we spoof the device network thus gaining access to the transferred data packets.

>Disclaimer: This method, however, is quite ineffective when there is hardware level encryption, in which case the MitM would be difficult since capturing and transmitting the encrypted advertised packets is ineffective.

**1.** *First we need to set up the slave device. We use *`docker`*, to host the slave device after which. A VM can also be used instead of `docker`, but `docker` is much practical for test purposes since VM would require a seperate Bluetooth adapter to set up. In VM's defence it is much more secure compared to `docker` but `docker` wins when it comes to ease of set up and would work with the default Bluetooth adapter present in the Laptop system. We start up the slave device by launching:*

```sh
sudo node ws-slave.js
``` 

*as shown in the image below.*

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start1.png">
</p>



**2.** *Get* `ssh` *access to your RaspPi:*


```sh
ssh pi@[Deviceaddr]
```

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start2.png">
</p>


*As mentioned before the RaspPi will be the Master device in this setup. In the setup we had already set up Gattacker and the necessary packages required.*

**3.** *Next we set up the variables for Gattacker* `config.env` *file.*

- NOBLE_HCI_DEVICE_ID : 
- BLENO_HCI_DEVICE_ID : 

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start3.png">
</p>

They would be given as '0' if we use the default Bluetooth adapter but if we use a seperate BT adapter we give it other numeric values depending on the number of adapters used.

**4.** *Now in the master device we access the Gattacker folder and run this command:*

```sh
sudo node scan.js
```

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start4.png">
</p>

*Here the advertisement packets are captured and saved in a file.*
*Now to save the service we run the command:*

```sh
sudo node scan f81d78632b93
```

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start61.png">
</p>

 
*Here the scan parameter is the name of the bulb as saved in Gattacker. The captured services and the advertisements are automatically updated in the slave devices so the emulation of the bulb is completed as shown below:*

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start62.png">
</p>

**5.** *Next we clone the MAC address of the original device along with the additional parameters as shown:*

```sh
./mac_adv -a devices/f81d78632b93_LEDBLE-78632b93.adv.json -s devices/f81d78632b93.srv.json
```

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start71.png">
</p>

*Now the RaspPi starts snuffing packets transferred between the devices and thus the packets will be captured by the RaspPi as shown in the image below:*

<p align="center">
  <img width="650" height="300" src="Blog/Photos/Start8.png">
</p>

*The packets shown here controls RGB values of the bulb and determines the colour of the bulb. Changes in these packets would change the colour of the bulb.*

Now we will look into how we use Ubertooth to sniff the transferred data between the connected devices.

## Sniffing

To understand how the connection between Bluetooth devices work we use a process called sniffing to get the details of the target device. Linux contains basic Bluetooth analysis tools. We tried using **hcidump** which is one of these tools.<br/>
**hcidump** can be used to read raw data coming from and going to a Bluetooth device and print it in human readable form.<br/>
Syntax is:

```console
hcidump [option [option...]] [filter]
```

But the data we get from this very limited and its quite hard to get a proper analysis from this data.<br/>
So to get a better idea about the connection and how it works we need to use we need to use more specific hardware.<br/>
We are using **Ubertooth One** by **Great Scott Gadgets**, it is an open source 2.4 GHz wireless development tool for Bluetooth experimentation. Ubertooth can be used to sniff Bluetooth packets even when the devices are in connected state. When paired with **Wireshark** we can analyse the data passing through two connected devices.<br/>
Ubertooth can follow a particular connection using the command :

```console
ubertooth-btle -fI -c ble_dump.pcap
```

Here the `-fI` is used to follow and interfere with a particular device. Without the `I` ubertooth will not interfere and we won't be able to get the data when the device is in connected state.<br/>
Furthermore, we can target a specific device by specifying the address of the target device :

```console
ubertooth-btle -fI -t<BD_ADDR> -c ble_dump.pcap
```

There are different tools which we can use to find the address of our target device. We have used [blue hydra](https://github.com/pwnieexpress/blue_hydra) which is a Bluetooth device discovery tool built on top of the `bluez` library. It can be linked with Ubertooth to track both classic and LE Bluetooth devices.<br/>
For an active traffic interception of the data transferred by our target device, we can create a pipe by using the command `mkfifo /tmp/pipe` and then using it in Wireshark as the capture interface.

During sniffing we get the following important details : 
- Access address(AA) is a unique value set up during connection and it is used to manage the link layer
- When in advertising state,
    - The channels used are 37, 38 and 39 
    - Advertisement PDUs(`ADV_IND` which is used to send connectable undirected advertisement) are sent through these advertising channels.
    - The device advertises its Bluetooth address as **AdvA**(Advertisement address)
- Three packets are sent between two devices before the connection between them sets up:
    - **SCAN_REQ**: It is a packet sent by the master device to the broadcasting device requesting for a connection
    - **SCAN_RSP**: It is a packet sent by the slave device to the master device responding to the scan request.
    - **CONNECT_REQ**: This packet is issued by the master device and sent to the broadcasting device requesting a connection. If this request is accepted the connection sets up and a new access address is set for this connection.
- Once the connection is set up the channels used changes from Advertising channel(37-39) to Data channels(0-36).

When in data connection, the channel through which data transfers are continuously changing and this process is called Adaptive Frequency Hopping(AFH). A frequency hopping algorithm is used to cycle through the 37 data channels:

<p align="center">
  <img width="200" height="15" src="Blog/img.png">
</p>

Where **f<sub>n+1</sub>** is the channel to be used in the next connection event, and hop is a value between 5 and 16 and is set up during the connection. The value which is set for hop can be seen in the **CONNECT_REQ** packet.

```
systime=1540911540 freq=2402 addr=8e89bed6 delta_t=0.368 ms rssi=-39
45 22 27 69 57 fc 3f 54 93 0e 63 78 1d f8 d1 02 c5 d6 65 a4 84 02 24 00 27 00 00 00 d0 07 00 fe ff 00 1e a6 d7 26 ad 
Advertising / AA 8e89bed6 (valid)/ 34 bytes
    Channel Index: 37
    Type:  CONNECT_REQ
    InitA: 54:3f:fc:57:69:27 (random)
    AdvA:  f8:1d:78:63:0e:93 (public)
    AA:    d6c502d1
    CRCInit: 84a465
    WinSize: 02 (2)
    WinOffset: 0024 (36)
    Interval: 0027 (39)
    Latency: 0000 (0)
    Timeout: 07d0 (2000)
    ChM: 00 fe ff 00 1e
    Hop: 6
    SCA: 5, 31 ppm to 50 ppm

    Data:  27 69 57 fc 3f 54 93 0e 63 78 1d f8 d1 02 c5 d6 65 a4 84 02 24 00 27 00 00 00 d0 07 00 fe ff 00 1e a6
    CRC:   d7 26 ad
```

With all the data we obtained from sniffing we can move on to the next stage of our attack

## HackRF
**HackRF One** from Great Scott Gadgets is a Software Defined Radio peripheral capable of transmission or reception of radio signals from 1 MHz to 6 GHz. Designed to enable test and development of modern and next-generation radio technologies, HackRF One is an open source hardware platform that can be used as a USB peripheral or programmed for stand-alone operation.
### Exploring BLE – from software to radio signals and back.
Armed with the frequency range only and no other information we decided to see if we can just blindly capture and replay a transmissions raw form to perform actions without the legitimate transmitters.
BTLE has 40 channels with the following frequencies :
```console
Channel 37: 2.402000000 GHz
Channel 00: 2.404000000 GHz
Channel 01: 2.406000000 GHz
Channel 02: 2.408000000 GHz
:
:
Channel 10: 2.424000000 GHz
Channel 38: 2.426000000 GHz
Channel 11: 2.428000000 GHz
:
:
Channel 36: 2.478000000 GHz
Channel 39: 2.480000000 GHz
```
To break the existing connection between the central and peripheral devices we decided to brute force all the channels by sending  20 millions samples of raw I/Q. The term “I/Q” is an abbreviation for “in-phase” and “quadrature”.I/Q signalling refers to the use of two sinusoids that have the same frequency and a relative phase shift of 90°. Transmitter induced I/Q imbalance occurs when the modulator's in-phase and quadrature components are not orthogonal. This causes the real and imaginary components of the complex signal to interfere with each other. But apart from the process being quite slow the raw data does not break the established connection.

Then we tried to brute-force a single channel by replay transmissions in raw form which also resulted in failure as the probability of transmission through a particular channel is less, the method seemed out of practical implementation.

The next method was to transmit packets instead of raw I/Q. So we started transmitting the `TERMINATE` packet through a single channel which closes the established connection. Transmitting collision situations can occur when the transmitted `TERMINATE` packet and the packet sent by the central device collide with each other, In this situation, the master shall reject the slave-initiated procedure. But the probability is still low due to randomization of the frequency channel.

In the next method, we use Ubertooth to sniff the packet transferred between the connection and thus gaining the access address. We then transmit the `TERMINATE` packet through the channel at the access address, to terminate the connection between the device and controller.

### BTLE packet sniffer/scanner btle_rx
```console
btle_rx -c chan -g gain -a access_addr -k crc_init -v -r
```
`chan`: Channel number.

`gain`: VGA gain. default value 6. valid value 0~62.

`access_addr`: Access address.

`crc_init`: Captured from the Ubertooth Dump.

`-v`: Verbose mode. Print more information when there is an error

_To support fast/realtime transmission , we also changed_
```console
lib_device->transfer_count to 4
lib_device->buffer_size to 4096 
```
in hackrf driver: src/hackrf.c, then and re-compile, re-install as instructed in [hackrf](https://github.com/mossmann/hackrf).

## Final Attack
We finally combine all of the above methods to create a _single_ attack.We use the data obtained from sniffing via the Ubertooth (Access Address, CRC Init), and then using the HackRF transmit the packets to terminate the connection and allowing us to perform the MiTM to covertly sniff the data without both the ends knowing the connection has terminated, we have here assumed that the users wouldn't be able to immediately detect a termination in the connection as we immediately start with the MiTM attack.  

