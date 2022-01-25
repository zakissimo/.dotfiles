#!/usr/bin/env sh

n=$(xrandr --query | grep -c '\bconnected\b')
echo "$n"
