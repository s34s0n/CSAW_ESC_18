import bluetooth

devices = bluetooth.discover_devices()

for addr in devices:
	target_name = bluetooth.lookup_name( addr )
	target_address = addr
	print target_name,"found with address ", target_address