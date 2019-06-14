The Bluetooth connection is impossible to sniff through external power devices when in the connection with other devices as in the the broadcast/advertistments stop after the connection is established.
* Making it impossible to listen to data while connected to other device
* Hence need to find methods to make the device send packets that recieve able over the air

Taking Logs from using Developer Options in Android 6.0+
* (All current packets taken like that ;) )

27

##Two modes in BLE
1. One is the Adverstiment mode
    * Data sent at regular intervals and can be recieved through any devices
    * Possible to detect anywhere.
    * Forms the basis for connection of 2 devices.
2. Second is the Connected mode:
    * The controlling device is known as the client, and the perherial or the gadget is 
   known as the server.
    * All the exchange of information takes on the basis of GATT; the server is known as
        GATT Server.
    * Based on a high level transaction.
    * Profile -> Service -> Characterisitcs
    * Profile is usually pre-defined by the SIG group with services 
    * Services contain chunks of data assigned to a unique ID [16-bit Official and 128-bit
        unofficial]
    *Charac contains the lowest amount of data available like some value or counter in
        the watch. (Can send back data to the BLE)

Then there's the possiblity of intereference in the WiFi and BLE Bands.
_We need to look into the possibilty of exploiting the closeness of the bands_

##Exercepts from Mike Ryan's WhitePaper
1. Eavesdropping
    * First the MAC Address of the device.
    * Getting the main hop interval of the packets. (If not understood, ask me)
    * Hop increment or the hop step
        * Usually the implementations try to increase this interval inorder to conserve battery.
    * Access Address (Aka the address the packet is trying to write into)
    * CRC Init (Need to look into the security in this as well)
    * All the data is then XORed with a LFSR O/P (Seed is something like the Channel number of transmission)

##Info from EURECOM Paper on Screaming Channels
* Leaking data through Mixed Signal Chips [ A device which is performing digital logic and Analog that is (Radio/Wireless) ]
    * Main concept being the fact that the _Design of theses devices_ results in a side-channel, that broadcasts the _EM disturbances_ via the analog/signal portion.
    * There's is a __issue__ of regarding the fact that the bluetooth protocol keeps hopping frequencies while transmitting the data, cause it frequently hops over the data. Hence we need to make sure that the we are able to smartly sniff the data with out any issue.
    * The use a coarse-grained trigger mechanism to identify frequencies (simply speaking a mechanism to find out about when the AES encryption has started).
        * Amplitude Demodulated & the Squared to get the triggering effect.
        * Then splice the traces to get traces similar to the original capture.
        * Then fine tune the trace elements
    * They have undertook the template attacks in the ChipWhisperer Repo and slightly modified to fit the purpose.

## Bluetooth Core Specifications v5.0
* __Important pages__
    * LLS: 2554
    * PHY1: 2560
