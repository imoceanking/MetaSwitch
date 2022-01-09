#!/bin/bash

export EXTRA_KO_DIR=/lib/modules/`uname -r`/extra

sleep 10

i2c_dev_path=/sys/bus/i2c/devices

## remove qsfp port device 
dir=${i2c_dev_path}/i2c-16/15-0073
if [ -d $dir ];then
	echo 0x73  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-16/delete_device
fi
for i in {41..48};do
	dir=${i2c_dev_path}/i2c-$i/$i-0050
	if [ -d $dir ];then
		echo 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-16/i2c-$i/delete_device
	fi
done

dir=${i2c_dev_path}/i2c-15/15-0072
if [ -d $dir ];then
	echo 0x72  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-15/delete_device
fi
for i in {33..40};do
	dir=${i2c_dev_path}/i2c-$i/$i-0050
	if [ -d $dir ];then
		echo 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-15/i2c-$i/delete_device
	fi
done
dir=${i2c_dev_path}/i2c-14/14-0071
if [ -d $dir ];then
	echo 0x71  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-14/delete_device 
fi

for i in {25..32};do
	dir=${i2c_dev_path}/i2c-$i/$i-0050
	if [ -d $dir ];then
		echo 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-14/i2c-$i/delete_device
	fi
done
dir=${i2c_dev_path}/i2c-13/13-0070
if [ -d $dir ];then
	echo 0x70  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-13/delete_device 
fi
for i in {17..24};do
	dir=${i2c_dev_path}/i2c-$i/$i-0050
	if [ -d $dir ];then
		echo 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-13/i2c-$i/delete_device
	fi
done

#port cpld pca9548 and port_info
dir=${i2c_dev_path}/i2c-4/4-0077
if [ -d $dir ];then
	echo 0x77  > /sys/bus/i2c/devices/i2c-1/i2c-4/delete_device 
fi

#crps
dir=${i2c_dev_path}/i2c-12/12-0059
if [ -d $dir ];then
	echo 0x59 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-12/delete_device
fi
dir=${i2c_dev_path}/i2c-12/12-005a
if [ -d $dir ];then
	echo 0x5a >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-12/delete_device
fi

#lmk03318
dir=${i2c_dev_path}/i2c-10/10-0050
if [ -d $dir ];then
	echo 0x50 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-10/delete_device 
fi

#echo  0x48      > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-11/delete_device      
##echo  0x49      > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-11/delete_device
#echo   0x4d      > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-11/delete_device

#eeprom
dir=${i2c_dev_path}/i2c-8/8-0053
if [ -d $dir ];then
	echo 0x53 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-8/delete_device 
fi

#tps53681
dir=${i2c_dev_path}/i2c-5/5-0060
if [ -d $dir ];then
	echo 0x60 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-5/delete_device 
fi

#lm96080 
#echo 0x28 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-7/delete_device 

#zl8802 (cpld_i2c_zl8802_0/1)
#echo 0x42 > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-6/delete_device  
#echo 0x40 > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-6/delete_device 

#tps53681
#echo 0x60 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-6/delete_device 

#prot cpld
dir=${i2c_dev_path}/i2c-4/4-0011
if [ -d $dir ];then
	echo  0x11 >/sys/bus/i2c/devices/i2c-4/delete_device 
fi

#fan cpld (tmp275_2/3)
#echo 0x4a >/sys/bus/i2c/devices/i2c-3/delete_device 
#echo 0x4c >/sys/bus/i2c/devices/i2c-3/delete_device 
#echo 0x12 >/sys/bus/i2c/devices/i2c-3/delete_device 

# MG cpld i2c device
dir=${i2c_dev_path}/i2c-2/2-0074
if [ -d $dir ];then
	echo 0x74  > /sys/bus/i2c/devices/i2c-1/i2c-2/delete_device
fi

dir=${i2c_dev_path}/i2c-1/1-0010
if [ -d $dir ];then
	echo 0x10 >/sys/bus/i2c/devices/i2c-1/delete_device
fi


 

rv=`lsmod |grep qsfp28_port`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/qsfp28_port.ko
fi

#rmmod ${EXTRA_KO_DIR}/lm96080.ko 

rv=`lsmod |grep cpld_i2c_crps`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/cpld_i2c_crps.ko
fi
rv=`lsmod |grep cpld_i2c_eeprom`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/cpld_i2c_eeprom.ko
fi


#rmmod ${EXTRA_KO_DIR}/tps53681.ko
#rmmod ${EXTRA_KO_DIR}/cpld_i2c_zl8802.ko 


rv=`lsmod |grep ^mg_cpld | awk -F " " '{ print $1 }' |grep ^mg_cpld$`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/mg_cpld.ko
fi

rv=` lsmod |grep ^pca9548 | awk -F " " '{ print $1 }' |grep ^pca9548$`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/pca9548.ko
fi

rv=`lsmod |grep ^port_cpld`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/port_cpld.ko
fi

#rmmod ${EXTRA_KO_DIR}/temp.ko
#rmmod ${EXTRA_KO_DIR}/fan_cpld.ko 

#mg cpld simulate pca9548
rv=`lsmod |grep ^cpld_simulate_pca`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/cpld_simulate_pca.ko
fi

rv=`lsmod |grep ^mg_cpld_adapter`
if [ "$rv" ];then
	rmmod ${EXTRA_KO_DIR}/mg_cpld_adapter.ko 
fi






























