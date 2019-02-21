#!/usr/bin/env bash

gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://google-chrome.desktop', 'application://atom.desktop', 'application://jetbrains-rubymine.desktop', 'application://gnome-terminal.desktop']"

# remove autostart after running this script once
sudo rm -f /etc/xdg/autostart/set-gnome-settings.sh.desktop
