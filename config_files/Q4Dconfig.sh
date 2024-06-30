#!/bin/bash
# vi: ts=4:sw=4:et

readonly Q4D_PATH=~/.Q4D/


## Event Bus
readonly BUS_HOST="YOUR_SEEDBOX_IP"
readonly BUS_PORT=1883

# Mosquitto Credentials - Please Change
readonly USER="YOUR_MOSQUITTO_USERNAME"
readonly PW="YOUR_MOSQUITTO_PASSWORD"

# Torrent Client
# OTHER, RTCONTROL, RTORRENT, ARIA2, DELUGE, or QBITTORRENT

readonly TORRENT_CLIENT=QBITTORRENT
readonly ACTIVE_TORRENT_FOLDER=~/.local/share/qBittorrent/BT_backup

# *Torrent Client Choices*

# [OTHER] Provide all torrent details as parameters
# For Other Not Defined Torrent Clients
# /home/user/.Q4D/Queue4Download.sh [NAME] [HASH] [LABEL] [TRACKER] [PATH]

# [RTCONTROL] RTorrent - Single Key Rtorrent with pyroscope tool (rtcontrol)
# /home/user/.Q4D/Queue4Download.sh [NAME]
# Single Field: .rtorrent.rc >  method.set_key = event.download.finished,complete,"execute.throw.bg=~/.Q4D/Queue4Download.sh,(d.name)"

# [RTORRENT] RTorrent without additional tool
# Four Fields: method.set_key = event.download.finished,complete,"execute.throw.bg=~/.Q4D/Queue4Download.sh,(d.name),(d.hash),(d.custom1),(d.data_path)"

# [ARIA2] Use Aria2 for Torrent Metadata
# ~/.Q4D/Queue4Download.sh [HASH] [LABEL]

# [DELUGE] DelugeD Torrent Client, uses deluge-console, presumes local daemon
# Use Execute Plugin
# ~/.Q4D/Queue4Download.sh [HASH] [NAME] [PATH]  <Execute plugin provides, by default, the three parameters>
# USAGE: ~/.Q4D/Queue4Download.sh

# [QBITTORRENT] QBittorrent
# Run external program on torrent completion setting  ~/.Q4D/Queue4Download.sh "%N" %I %L %T "%F"
# /home/user/.Q4D/Queue4Download.sh [NAME] [HASH] [LABEL] [TRACKER] [PATH]

# [TRANSMISSION] Transmission UNTESTED
# Change transmission's transmission-daemon/settings.json file:
# "script-torrent-done-enabled": true, 
# "script-torrent-done-filename": "/home/YOU/.Q4D/Queue4Download.sh",


# Do we update the label after Queued?  Regular Success: QUEUED -> DONE  (Failed: NOT_QD / NOPE )
# Requires Labelling Tool, right now only RTCONTROL and DELUGE supported by default

LABELLING=true
readonly _LABEL_TOOL='~/.Q4D/qbitTagger.py ${Event[$HASH_INDEX]} ${Event[$LABEL_INDEX]}'


# Type Code Logic File, types code tell the client what directory the download should be in, TV, MOVIE, MUSIC, VIDEO
readonly TYPE_CODES=$Q4D_PATH/Types.config
# IF not set, default to:
DEFAULT_TYPE="V"
