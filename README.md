lonix/plex
=============
plexp. with or without plexpass to run the latest edition 


sample command:
```
docker run -d --name=plex --net=host -v /etc/localtime:/etc/localtime:ro -v /mnt/appdata/docker/plex:/config -v /mnt/net:/data  -e PLEXPASS=1 -p 32400:32400 lonix/plex:latest
```

You need to map 
* --net=host for streaming to work.
* Port 32400 for plex web-app.
* Mount /config for plex config files.
* Mount /data for plex media files
* Mount /etc/localhost for timesync (Not required)
* PLEXPASS set to 1 for Plexpass version, UNSET for Public



This container will update plex on each launch (if update found). It is based on phusion-baseimage with ssh removed. (use nsenter).
If the app does not update to the latest version, i need to update a file on server, msg me at <lonixx@gmail.com>

**Credits**
* needo <needo@superhero.org>
* Eric Schultz <eric@startuperic.com>
* Tim Haak <tim@haak.co.uk>
