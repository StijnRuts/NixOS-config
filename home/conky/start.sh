#!/usr/bin/env bash

CONFIGDIR=/home/stijn/NixOS/home/conky

case $(hostname) in

  P520)
    echo "TODO: P520"
    # TODO: https://conky.cc/variables#nvidia
    ;;

  T420) # 1600 x 900
    conky --config=$CONFIGDIR/cpu.lua     -x   95 -y  70 &
    conky --config=$CONFIGDIR/memory.lua  -x  465 -y  70 &
    conky --config=$CONFIGDIR/disks.lua   -x  835 -y  70 &
    conky --config=$CONFIGDIR/system.lua  -x 1205 -y  70 &
    conky --config=$CONFIGDIR/network.lua -x 1205 -y 250
    ;;

  X201)
    echo "TODO: X201"
    ;;

  *)
    echo "TODO: Default"
    ;;
esac
