#!/usr/bin/env bashio
set -e

bashio::log.info 'Update Certificates'
update-ca-certificates

bashio::log.info 'Create media folder if not existing'
mkdir -p /media/mopidy/files
mkdir -p /media/mopidy/playlists

bashio::log.info 'Setup config'
local_scan=$(cat /data/options.json | jq -r '.local_scan // empty')
options=$(cat /data/options.json | jq -r 'if .options then [.options[] | "-o "+.name+"="+.value ] | join(" ") else "" end')
config="/share/mopidy/mopidy.conf"

bashio::log.info 'Start Mopidy....'
if  [ "$local_scan" == "true" ]; then
    /bin/bash -c "sudo -E -u icecast2 icecast2 -b -c /etc/icecast2/icecast.xml &; mopidy --config $config "$options"
fi
/bin/bash -c "sudo -E -u icecast2 icecast2 -b -c /etc/icecast2/icecast.xml &; mopidy --config $config "$options"