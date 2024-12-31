#!/usr/bin/env bash

! [ "$#" -eq 1 ] && echo "Usage: $0 THEME" && exit 1

wine regedit "$1"
