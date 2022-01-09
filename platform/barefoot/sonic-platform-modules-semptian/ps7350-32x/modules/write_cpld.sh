#!/bin/bash

/sbin/lpc write 0xa51 1 $1

/sbin/lpc write 0xa52 1 $2
/sbin/lpc write 0xa54 1 $3
/sbin/lpc write 0xa53 1 $4

/sbin/lpc write 0xa50 1 0x80

/sbin/lpc read 0xa57 1 
