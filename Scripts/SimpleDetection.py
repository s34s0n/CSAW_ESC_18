import bluetooth

target_name = "Galaxy S9+"
target_address = None

nearby_devices = bluetooth.discover_devices()

for bdaddr in nearby_devices:
    if target_name == bluetooth.lookup_name( bdaddr ):
        target_address = bdaddr
        break

if target_address is not None:
    print target_name,"found with address ", target_address
else:
    print "could not find target bluetooth device nearby"
