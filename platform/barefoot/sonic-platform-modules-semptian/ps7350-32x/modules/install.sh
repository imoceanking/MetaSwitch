#!/bin/bash

modprobe i2c_mux

### install lpc to i2c bus driver (cpld lpc driver/ mg_cpld_i2c_adapter) 
insmod mg_cpld_adapter.ko 

### cpld simulate pca9548
insmod cpld_simulate_pca.ko 

### xc3200an_fan_cpld (0x12)
insmod fan_cpld.ko
insmod temp.ko

#  xc3400an_port_cpld (0x11)
insmod port_cpld.ko 


insmod pca9548.ko

# xc3200an_mg_cpld (0x10)
insmod mg_cpld.ko 


insmod cpld_i2c_zl8802.ko 
insmod tps53681.ko 
insmod cpld_i2c_eeprom.ko 
insmod cpld_i2c_crps.ko 
insmod lm96080.ko 
insmod qsfp28_port.ko  

#mg cpld simulate pca9548
echo cpld_sim_pca9548 0x10 >/sys/bus/i2c/devices/i2c-2/new_device 

#fan cpld 
echo xc3200an_fan_cpld 0x12 >/sys/bus/i2c/devices/i2c-4/new_device 
echo tmp275_2 0x4a >/sys/bus/i2c/devices/i2c-4/new_device 
echo tmp275_3 0x4c >/sys/bus/i2c/devices/i2c-4/new_device 

#prot cpld
echo xc3400an_port_cpld 0x11 >/sys/bus/i2c/devices/i2c-5/new_device 

# MG cpld i2c device
echo cpld_pca9548 0x74  > /sys/bus/i2c/devices/i2c-2/i2c-3/new_device 
echo tmp275_0 0x48      > /sys/bus/i2c/devices/i2c-2/i2c-3/i2c-12/new_device      
echo tmp275_1 0x49 > /sys/bus/i2c/devices/i2c-2/i2c-3/i2c-12/new_device   
echo tmp411   0x4d > /sys/bus/i2c/devices/i2c-2/i2c-3/i2c-12/new_device   


#zl8802
echo cpld_i2c_zl8802_0 0x42 >/sys/bus/i2c/devices/i2c-2/i2c-3/i2c-6/new_device 
echo cpld_i2c_zl8802_1 0x40 >/sys/bus/i2c/devices/i2c-2/i2c-3/i2c-6/new_device 

#tps53681
echo  cpld_i2c_tps53681 0x60 >/sys/bus/i2c/devices/i2c-2/i2c-3/i2c-6/new_device 

#eeprom
echo eeprom 0x53 >/sys/bus/i2c/devices/i2c-2/i2c-3/i2c-9/new_device 

#crps
echo cpld_i2c_crps_0 0x59 >/sys/bus/i2c/devices/i2c-2/i2c-3/i2c-13/new_device 
echo cpld_i2c_crps_1 0x5a >/sys/bus/i2c/devices/i2c-2/i2c-3/i2c-13/new_device

#lm96080
echo  cpld_i2c_lm96080   0x28 >/sys/bus/i2c/devices/i2c-2/i2c-3/i2c-8/new_device 

#port cpld pca9548 and port_info
echo cpld_pca9546 0x77  > /sys/bus/i2c/devices/i2c-2/i2c-5/new_device 
echo cpld_pca9548 0x70  > /sys/bus/i2c/devices/i2c-2/i2c-5/i2c-14/new_device 
echo cpld_pca9548 0x71  > /sys/bus/i2c/devices/i2c-2/i2c-5/i2c-15/new_device 
echo cpld_pca9548 0x72  > /sys/bus/i2c/devices/i2c-2/i2c-5/i2c-16/new_device
echo cpld_pca9548 0x73  > /sys/bus/i2c/devices/i2c-2/i2c-5/i2c-17/new_device

#port add
echo cpld_i2c_qsfp28 0x50 >/sys/bus/i2c/devices/i2c-2/i2c-5/i2c-14/i2c-18/new_device 
