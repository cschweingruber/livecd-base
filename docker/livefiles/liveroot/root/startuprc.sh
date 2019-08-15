#!/bin/sh
loadkeys ch
sleep 4
echo "startuprc Script" 
echo "$(date) startuPrc" >> /logf
echo "livetest"
sleep 300
init 0
