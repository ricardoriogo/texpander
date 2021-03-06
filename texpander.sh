#!/bin/bash

# Version: 1.2.1
# Release: September 12, 2017

pid=$(xdotool getwindowfocus getwindowpid)
proc_name=$(cat /proc/$pid/comm)

base_dir="${HOME}/.texpander/"
abbrvs=$(ls $base_dir)

name=$(zenity --list --title=Texpander --column=Abbreviations $abbrvs)

path=$base_dir$name

if [[ $name ]]
then
  if [ -e "$path" ]
  then
    clipboard=$(xclip -selection clipboard -o)
    xclip -selection c -i "$path"

    if [[ $proc_name =~ (termin|nano) ]]
    then
      xdotool key ctrl+shift+v
    else
      xdotool key ctrl+v
    fi
    
    sleep 1s

    echo $clipboard | xclip -selection c
  else
    zenity --error --text="Abbreviation not found:\n$name"
  fi
fi
