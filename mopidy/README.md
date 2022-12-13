# Mopidy (Hass.io Addon)
![armhf image pulls](https://img.shields.io/docker/pulls/poeschl/hassio-mopidy-armhf?label=docker%20pulls%20%28armhf%29)
![armv7 image pulls](https://img.shields.io/docker/pulls/poeschl/hassio-mopidy-armv7?label=docker%20pulls%20%28armv7%29)
![amd64 image pulls](https://img.shields.io/docker/pulls/poeschl/hassio-mopidy-amd64?label=docker%20pulls%20%28amd64%29)
![i386 image pulls](https://img.shields.io/docker/pulls/poeschl/hassio-mopidy-i386?label=docker%20pulls%20%28i386%29)

Mopidy with plugins for Hass.io. It enabled the host to play audio.

It is build with following extensions:

* [Mopidy-Local](https://docs.mopidy.com/en/latest/ext/local/)
* [Mopidy-Stream](https://docs.mopidy.com/en/latest/ext/stream/)
* [Mopidy-YouTube](https://github.com/mopidy/mopidy-youtube)
* [Mopidy-Iris](https://github.com/jaedb/iris)

Mopidy listens on `6680` for http connections, and `6600` for mpd ones.

## Local Media
The local media can be stored on `/share` (which allow an access through the samba addon).
By default the directory for media is `/share/mopidy/media`. 

## Panel integration

Since Mopidy-Iris don't play well (at least out-of-the-box) with the ingress feature Mopidy can be added to the side-panel in the configuration with those lines:

```yaml
panel_iframe:
  mopidy:
    title: 'Mopidy'
    icon: 'mdi:music-circle'
    url: 'http://<homeassistant-address>:6680/iris'
```

## Configuration

### local_scan (bool)
If it is set to true, a local scan is performed on startup. A local scan can also be triggered via the web ui.

### options (list of dict)

This object accepts any configuration of the listed extenstions. It can be also used to overwrite the default values.

For example: Overwrite the media dir

```
{"name": "local/media_dir", "value": "/share/media"}
```

## Example config

```
[core]
cache_dir = /data/mopidy/cache
data_dir = /data/mopidy/data_dir

[http]
hostname = 0.0.0.0

[mpd]
hostname = 0.0.0.0

[local]
media_dir = /share/mopidy/media
library = sqlite

[m3u]
playlists_dir = /share/mopidy/playlists

[stream]
enabled = true
protocols =
    http
    https

[iris]

```
