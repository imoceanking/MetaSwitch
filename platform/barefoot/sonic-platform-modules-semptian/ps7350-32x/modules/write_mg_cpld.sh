#!/bin/bash

/sbin/lpc write 0xa01 1 $1

/sbin/lpc write 0xa02 1 $2
/sbin/lpc write 0xa04 1 $3
/sbin/lpc write 0xa03 1 $4

/sbin/lpc write 0xa00 1 0x82

/sbin/lpc read 0xa07 1 
