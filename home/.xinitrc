#!/bin/bash

[[ -f ~/.Xresources ]] && xrdb ~/.Xresources
qtile start >/dev/null 2>&1
