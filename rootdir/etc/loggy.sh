#!/bin/sh
# loggy.sh.

date=`date +%F_%H-%M-%S`
logcat -v time -f  /data/ramoops/cm14_1_logcat_${date}.txt
