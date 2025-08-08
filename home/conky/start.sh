#!/usr/bin/env bash

CONFIGDIR=/home/stijn/NixOS/home/conky

case $(hostname) in

  P520)
    echo "TODO: P520"
    ;;

  T420) # 1600 x 900
    conky --config=$CONFIGDIR/system.lua  -x  155 -y  70 &
    conky --config=$CONFIGDIR/cpu.lua     -x  485 -y  70 &
    conky --config=$CONFIGDIR/memory.lua  -x  815 -y  70 &
    conky --config=$CONFIGDIR/disks.lua   -x 1145 -y  70 &
    conky --config=$CONFIGDIR/network.lua -x 1145 -y 370 &
    conky --config=$CONFIGDIR/energy.lua  -x  155 -y 370
    ;;

  X201)
    echo "TODO: X201"
    ;;

  *)
    echo "TODO: Default"
    ;;
esac
