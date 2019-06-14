# Basic Process

- Select the **target**
  - Perform active scan
  - Passively sniff advertisement packages
- Enumerate its **services** and **characteristics**
  - Sniff services discovery messages
  - Connect to the target yourself
- Reverse the application **protocol**
  - Analyse legitimate traffic
  - Impersonate devices

## Selecting the target
Our goal: find BLE devices
- All devices use special channels to advertise: 
  - Connectability
  - Available services or manufacture-specific data

- Apps: lightblue or nRFConnect
- Linux: hcitool lescan or listen for advertisements with **--passive and btmon**

##  Smells like Traffic
-Ubertooth One

## A note on encryption
Your traffic may encrypted if:
- Devices forces you to "pair" with it
- LL_START_ENC_REQ at the top of capture
- Sniffed traffic contains a ton of L2CAP Fragments

Mike Ryan gave us crackle, which can  decrypt traffic if:
- You capture the full pairing process
- Pairing mode is "6-digit PIN" or "Just Words"

Bluetooth v4.2 added "Numerical Comparison" mode as countermeasure.

## Enumerate 
Our Goal: Determine what services are running on the target
 
## Reversing the application
Our Goal: Understand the application protocol 
- Generate and analyze legitimate traffic
- Impersonate target using **bleno (node.js)**
  - Create arbitrary BLE server on Kali
  - Implement as much functionality as needed
  - Use Captured traffic to your advantage

## Finding Password 
- In most cases  Password is sent in **cleartext**





