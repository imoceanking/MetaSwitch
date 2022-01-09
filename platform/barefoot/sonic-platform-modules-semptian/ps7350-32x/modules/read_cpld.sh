#!/bin/bash

/sbin/lpc write 0xa51 1 $1

/sbin/lpc write 0xa52 1 $2
/sbin/lpc write 0xa50 1 0x81

/sbin/lpc read 0xa57 1 
/sbin/lpc read 0xa56 1
/sbin/lpc read 0xa55 1

