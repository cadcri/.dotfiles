# Connect to a wifi with wpa_supplicant
```
wpa_passphrase <SSID> <password> > wpa.conf
sudo wpa_supplicant -c wpa.conf -i <wifi_interface> -B
sudo dhclient
```

# Connect to wifi with network-manager
```
nmcli radio wifi on
nmcli dev wifi list
nmcli dev wifi connect <network-essid> password <network-password>
```
