#!/bin/bash
# vi: ts=4:sw=4:et
# Associate Array, type code -> destination directory


# LFTP Throttle, this would download 1 file at a time, with 4 segments a 3M = 12 MB/s
readonly RATE=3M
readonly SEGMENTS=4
readonly PARALLEL=1

# LFTP Login (Home->Seedbox) Values (alternatively use .netrc or set up ssh keys instead)
readonly CREDS='YOUR_USERNAME'

# Your Server
readonly HOST="YOUR_SEEDBOX_IP"

# Type Code to Destination Directory Map: [CODE]="DIRECTORY"
# Don't Remove ERR as last entry

declare -Ag TypeCodes=\
(
        [A]="/data/torrents/Music"
        [B]="/data/torrents/Books"
        [M]="/data/torrents/Movies"
        [P]="/data/torrents/Software"
        [S]="/data/torrents/TV"
        [V]="/data/torrents"
        [ERR]="/data/torrents/ERR"
)

# Event Indexes
readonly FILENAME=0
readonly HASH=1
readonly TYPE=2
