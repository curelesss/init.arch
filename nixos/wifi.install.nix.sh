#!/bin/sh

echo "List of interfaces"
ip link

# Ask for SSID and password
read -p "Enter name of the interface for connecting to local WiFi: " interface
read -p "Enter WiFi SSID: " ssid
read -sp "Enter WiFi password: " password

# Create WPA configuration
echo
echo "Generating WPA configuration..."
sudo wpa_passphrase "$ssid" "$password" | sudo tee /etc/wpa_supplicant.conf > /dev/null

# Connect to WiFi
echo "Connecting to WIFI $ssid on interface $interface..."
sudo wpa_supplicant -B -i "$interface" -c /etc/wpa_supplicant.conf
