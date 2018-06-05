#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
export NCURSES_NO_UTF8_ACS=1
 ## point to variable file for ipv4 and domain.com

HEIGHT=12
WIDTH=40
CHOICE_HEIGHT=5
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="Plex Enhacements Tools"
MENU="Make a Selection:"

OPTIONS=(A "PGDupes   (BETA)"
         B "PGTrak"
         C "PGScan    (BETA)"
         D "Telly     (BETA)"
         E "SSTVProxy (BETA)"
         Z "Exit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        A)
            bash /opt/plexguide/menus/pgdupes/main.sh
            ;;
        B)
            bash /opt/plexguide/menus/pgtrak/main.sh
            ;;
        C)
            if [ ! "$(docker ps -q -f name=plex)" ]; then
              dialog --title "NOTE!" --msgbox "\nPlex needs to be running!" 7 38
            else
              if [ ! -s /opt/appdata/plexguide/plextoken ]; then
                dialog --title "NOTE!" --msgbox "\nYour plex username and password is needed to get your plextoken!" 7 38
                bash /opt/plexguide/scripts/plextoken/main.sh
              fi
              ansible-role pgscan
              dialog --title "Your PGscan URL - We Saved It" --msgbox "\nURL: $(cat /opt/appdata/plexguide/pgscanurl)\nNote: You need this for sonarr/radarr!\nYou can always get it later!" 0 0
            fi
            ;;
        D)
            bash /opt/plexguide/menus/plex/telly.sh
            ;;
        E)
            bash /opt/plexguide/menus/plex/sstvproxy.sh
            ;;
        Z)
            clear
            exit 0 ;;

########## Deploy End
esac

bash /opt/plexguide/menus/plex/enhancement.sh
