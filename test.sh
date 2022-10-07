#!/bin/bash

# Make

valac --pkg gio-2.0 DaemonTest.vala -o DaemonTest

# Install

echo Install of DaemonTest service

mkdir /usr/sbin/DaemonTest

cp ./DaemonTest /usr/sbin/DaemonTest/
#rm ./DaemonTest

chmod +x /usr/sbin/DaemonTest/DaemonTest

cp DaemonTest.service /etc/systemd/system/DaemonTest.service
systemctl daemon-reload
systemctl enable DaemonTest.service
systemctl start DaemonTest.service

# Start

echo Start of DaemonTest service

systemctl start DaemonTest

# Stop

echo Stop of DaemonTest service

systemctl stop DaemonTest

# Print test

cat /usr/sbin/DaemonTest/my-test.txt

# Uninstall

echo Uninstall of DaemonTest service

systemctl stop DaemonTest.service
systemctl disable DaemonTest.service
systemctl revert DaemonTest.service
systemctl reset-failed
rm -f /etc/systemd/system/DaemonTest.service
systemctl daemon-reload

rm -rf /usr/sbin/DaemonTest/*

