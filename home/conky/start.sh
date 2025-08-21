#!/usr/bin/env bash

CONFIGDIR=~/NixOS/home/conky

case $(hostname) in

  P520) # 2560 x 1440
    conky --config=$CONFIGDIR/system.lua  -x  235 -y 200 &
    conky --config=$CONFIGDIR/cpu.lua     -x  605 -y 200 &
    conky --config=$CONFIGDIR/memory.lua  -x  975 -y 200 &
    conky --config=$CONFIGDIR/disks.lua   -x 1345 -y 200 &
    conky --config=$CONFIGDIR/network.lua -x 1715 -y 200
    ;;

  X201) # 1280 x 800
    conky --config=$CONFIGDIR/cpu.lua     -x 120 -y  70 &
    conky --config=$CONFIGDIR/memory.lua  -x 490 -y  70 &
    conky --config=$CONFIGDIR/disks.lua   -x 860 -y  70 &
    conky --config=$CONFIGDIR/system.lua  -x 120 -y 410 &
    conky --config=$CONFIGDIR/network.lua -x 490 -y 410
    ;;

  T420 | *) # 1600 x 900
    conky --config=$CONFIGDIR/cpu.lua     -x   95 -y 100 &
    conky --config=$CONFIGDIR/memory.lua  -x  465 -y 100 &
    conky --config=$CONFIGDIR/disks.lua   -x  835 -y 100 &
    conky --config=$CONFIGDIR/system.lua  -x 1205 -y 100 &
    conky --config=$CONFIGDIR/network.lua -x 1205 -y 280
    ;;
esac
