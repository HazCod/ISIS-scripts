#!/bin/bash

wget http://download.aircrack-ng.org/aircrack-ng-1.2-beta2.tar.gz
tar -xzvf aircrack-ng-1.2-beta2.tar.gz
cd aircrack-ng-1.2-beta2
make
sudo make install
sudo airodump-ng-oui-update
cd ..