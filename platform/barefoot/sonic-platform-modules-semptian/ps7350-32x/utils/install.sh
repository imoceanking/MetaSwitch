#!/bin/bash

export EXTRA_KO_DIR=/lib/modules/`uname -r`/extra

sleep 10
modprobe i2c_mux

rv=`lsmod |grep ^mg_cpld_adapter`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/mg_cpld_adapter.ko 
else
	echo "[INFO] Control Cpld Adapter File exsit"
fi

rv=`lsmod |grep ^cpld_simulate_pca`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/cpld_simulate_pca.ko
else
	echo "[INFO] CPLD Simulate mux i2c File exsit"
fi
#insmod ${EXTRA_KO_DIR}/fan_cpld.ko 
#insmod ${EXTRA_KO_DIR}/temp.ko

rv=`lsmod |grep ^port_cpld`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/port_cpld.ko
else
	echo "[INFO] Port cpld File exsit"
fi

rv=` lsmod |grep ^pca9548 | awk -F " " '{ print $1 }' |grep ^pca9548$`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/pca9548.ko
else
	echo "[INFO] Pca9548 File exsit"
fi

rv=`lsmod |grep ^mg_cpld | awk -F " " '{ print $1 }' |grep ^mg_cpld$`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/mg_cpld.ko
else
	echo "[INFO] mg cpld File exsit"
fi
#insmod ${EXTRA_KO_DIR}/cpld_i2c_zl8802.ko 
#insmod ${EXTRA_KO_DIR}/tps53681.ko

#modprobe tps53681
#modprobe cpld_i2c_lmk03318

rv=`lsmod |grep cpld_i2c_eeprom`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/cpld_i2c_eeprom.ko
else
	echo "[INFO] Cpld i2c eeprom File exsit"
fi
rv=`lsmod |grep cpld_i2c_crps`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/cpld_i2c_crps.ko
else
	echo "[INFO] Cpld i2c crps File exsit"
fi
 
#insmod ${EXTRA_KO_DIR}/lm96080.ko 
rv=`lsmod |grep qsfp28_port`
if [ "$rv" = "" ];then
	insmod ${EXTRA_KO_DIR}/qsfp28_port.ko
else
	echo "[INFO] Qsfp port File exsit"
fi

num=`ls -al /sys/bus/i2c/devices | grep i2c |grep pci| wc -l`

if [ x$num = x"1" ];then
	echo "sys i2c num $num"
	#mg cpld simulate pca9548
	i2c_dev_path=/sys/bus/i2c/devices
	dir=${i2c_dev_path}/i2c-1/1-0010
	if [ ! -d $dir ];then
		echo cpld_sim_pca9548 0x10 >/sys/bus/i2c/devices/i2c-1/new_device 
	fi
	#fan cpld 
	#echo xc3200an_fan_cpld 0x12 >/sys/bus/i2c/devices/i2c-3/new_device 
	#echo tmp275_2 0x4a >/sys/bus/i2c/devices/i2c-3/new_device 
	#echo tmp275_3 0x4c >/sys/bus/i2c/devices/i2c-3/new_device 

	#prot cpld
	dir=${i2c_dev_path}/i2c-4/4-0011
	if [ ! -d $dir ];then
		echo xc3400an_port_cpld 0x11 >/sys/bus/i2c/devices/i2c-4/new_device 
	fi
	# MG cpld i2c device
	dir=${i2c_dev_path}/i2c-2/2-0074
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x74  > /sys/bus/i2c/devices/i2c-1/i2c-2/new_device
	fi 
	#echo tmp275_0 0x48      > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-11/new_device      
	##echo tmp275_1 0x49      > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-11/new_device
	#echo tmp411   0x4d      > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-11/new_device


	#zl8802
	#echo cpld_i2c_zl8802_0 0x42 > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-6/new_device  
	#echo cpld_i2c_zl8802_1 0x40 > /sys/bus/i2c/devices/i2c-1/i2c-2/i2c-6/new_device 

	#tps53681
	#dir=${i2c_dev_path}/i2c-5/5-0060
	#if [ ! -d $dir ];then
	#	echo echo cpld_i2c_tps53681 0x60 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-5/new_device 
	#fi 

	#eeprom
	dir=${i2c_dev_path}/i2c-8/8-0053
	if [ ! -d $dir ];then
		echo eeprom 0x53 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-8/new_device 
	fi

	#lmk03318
	#dir=${i2c_dev_path}/i2c-10/10-0050
	#if [ ! -d $dir ];then
	#	echo cpld_i2c_lmk03318 0x50 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-10/new_device 
	#fi

	#crps
	dir=${i2c_dev_path}/i2c-12/12-0059
	if [ ! -d $dir ];then
		echo cpld_i2c_crps_0 0x59 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-12/new_device
	fi
	dir=${i2c_dev_path}/i2c-12/12-005a
	if [ ! -d $dir ];then
		echo cpld_i2c_crps_1 0x5a >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-12/new_device
	fi
	#lm96080
	#echo  cpld_i2c_lm96080  0x28 >/sys/bus/i2c/devices/i2c-1/i2c-2/i2c-7/new_device 

	#port cpld pca9548 and port_info
	dir=${i2c_dev_path}/i2c-4/4-0077
	if [ ! -d $dir ];then
	echo cpld_pca9546 0x77  > /sys/bus/i2c/devices/i2c-1/i2c-4/new_device 
	fi

	dir=${i2c_dev_path}/i2c-13/13-0070
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x70  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-13/new_device 
	fi
	for i in {17..24};do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-13/i2c-$i/new_device
		fi
	done

	dir=${i2c_dev_path}/i2c-14/14-0071
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x71  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-14/new_device 
	fi
	for i in {25..32};do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-14/i2c-$i/new_device
		fi
	done
	dir=${i2c_dev_path}/i2c-15/15-0072
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x72  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-15/new_device
	fi
	for i in {33..40};do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-15/i2c-$i/new_device
		fi
	done
	dir=${i2c_dev_path}/i2c-16/16-0073
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x73  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-16/new_device
	fi
	for i in {41..48};do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-1/i2c-4/i2c-16/i2c-$i/new_device
		fi
	done
else
	echo "sys i2c num $num"
	#mg cpld simulate pca9548
	i2c_dev_path=/sys/bus/i2c/devices
	dir=${i2c_dev_path}/i2c-$num/$num-0010
	if [ ! -d $dir ];then
		echo cpld_sim_pca9548 0x10 >/sys/bus/i2c/devices/i2c-$num/new_device
	fi
	#fan cpld 
	#echo xc3200an_fan_cpld 0x12 >/sys/bus/i2c/devices/i2c-$((num+2))/new_device
	#echo tmp275_2 0x4a >/sys/bus/i2c/devices/i2c-$((num+2))/new_device
	#echo tmp275_3 0x4c >/sys/bus/i2c/devices/i2c-$((num+2))/new_device 

	#prot cpld
	dir=${i2c_dev_path}/i2c-$((num+3))/$((num+3))-0011
	if [ ! -d $dir ];then
		echo xc3400an_port_cpld 0x11 >/sys/bus/i2c/devices/i2c-$((num+3))/new_device 
	fi
	# MG cpld i2c device
	dir=${i2c_dev_path}/i2c-$((num+1))/$((num+1))-0074
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x74  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/new_device
	fi 
	#echo tmp275_0 0x48      > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+10))/new_device      
	##echo tmp275_1 0x49      > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+10))/new_device
	#echo tmp411   0x4d      > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+10))/new_device


	#zl8802
	#echo cpld_i2c_zl8802_0 0x42 > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+5))/new_device  
	#echo cpld_i2c_zl8802_1 0x40 > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+5))/new_device 

	#tps53681
	#dir=${i2c_dev_path}/i2c-$((num+4)/$((num+4)-0060
	#if [ ! -d $dir ];then
	#	echo echo cpld_i2c_tps53681 0x60 >/sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+4))/new_device 
	#fi 

	#eeprom
	dir=${i2c_dev_path}/i2c-$((num+7))/$((num+7))-0053
	if [ ! -d $dir ];then
		echo eeprom 0x53 >/sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+7))/new_device 
	fi

	#lmk03318
	#dir=${i2c_dev_path}/i2c-$((num+9)/$((num+9)-0050
	#if [ ! -d $dir ];then
	#	echo cpld_i2c_lmk03318 0x50 >/sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+9))/new_device 
	#fi

	#crps
	dir=${i2c_dev_path}/i2c-$((num+11))/$((num+11))-0059
	if [ ! -d $dir ];then
		echo cpld_i2c_crps_0 0x59 >/sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+11))/new_device
	fi
	dir=${i2c_dev_path}/i2c-$((num+11))/$((num+11))-005a
	if [ ! -d $dir ];then
		echo cpld_i2c_crps_1 0x5a >/sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+11))/new_device
	fi
	#lm96080
	#echo  cpld_i2c_lm96080  0x28 >/sys/bus/i2c/devices/i2c-$num/i2c-$((num+1))/i2c-$((num+6))/new_device 

	#port cpld pca9548 and port_info
	dir=${i2c_dev_path}/i2c-$((num+3))/$((num+3))-0077
	if [ ! -d $dir ];then
	echo cpld_pca9546 0x77  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/new_device 
	fi

	dir=${i2c_dev_path}/i2c-$((num+12))/$((num+12))-0070
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x70  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+12))/new_device 
	fi
	#for i in {17..24};do
	for i in `eval echo {$[num+16]..$[num+23]}`;do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+12))/i2c-$i/new_device
		fi
	done

	dir=${i2c_dev_path}/i2c-$((num+13))/$((num+13))-0071
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x71  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+13))/new_device 
	fi
	#for i in {25..32};do
	for i in `eval echo {$[num+24]..$[num+31]}`;do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+13))/i2c-$i/new_device
		fi
	done
	dir=${i2c_dev_path}/i2c-$((num+14))/$((num+14))-0072
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x72  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+14))/new_device
	fi
	#for i in {33..40};do
	for i in `eval echo {$[num+32]..$[num+39]}`;do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+14))/i2c-$i/new_device
		fi
	done
	dir=${i2c_dev_path}/i2c-$((num+15))/$((num+15))-0073
	if [ ! -d $dir ];then
		echo cpld_pca9548 0x73  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+15))/new_device
	fi
	#for i in {41..48};do
	for i in `eval echo {$[num+40]..$[num+47]}`;do
		dir=${i2c_dev_path}/i2c-$i/$i-0050
		if [ ! -d $dir ];then
			echo cpld_i2c_qsfp28 0x50  > /sys/bus/i2c/devices/i2c-$num/i2c-$((num+3))/i2c-$((num+15))/i2c-$i/new_device
		fi
	done


fi

bmc=0
while [ $bmc -eq 0 ]
do
	rv=`lsmod |grep ^ipmi_si | awk -F " " '{ print $1 }' |grep ^ipmi_si$`
	if [ "$rv" ];then
		rmmod ipmi_si
	fi
	modprobe ipmi_si
	if [ -c /dev/ipmi0 ];then
		echo "bmc ready ok\n"
		bmc=1
	else
		echo "bmc ready no\n"
		sleep 5
		bmc=0
	fi
done	
