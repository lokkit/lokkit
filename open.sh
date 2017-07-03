#!/bin/bash

# This script is intended to be installed on a raspberry pi.
# It powers a gpio port with 5V for some seconds and then switches
# back to 0 voltage.

gpio_port=17

# trap ctrl and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
  echo turning off
  echo "0" > /sys/class/gpio/gpio${gpio_port}/value
}

# initialize
if [ -e "/sys/class/gpio/gpio${gpio_port}" ]; then
  echo Port $gpio_port is already configured
else
  echo configuring port ${gpio_port}
  sudo echo "${gpio_port}" > /sys/class/gpio/export
fi
# ensure it is out
sudo echo "out" > /sys/class/gpio/gpio${gpio_port}/direction

# open for few seconds
echo turning on
echo "1" > /sys/class/gpio/gpio${gpio_port}/value
sleep 4
echo turning off
echo "0" > /sys/class/gpio/gpio${gpio_port}/value
