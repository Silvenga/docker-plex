# Silvenga/docker-plex

This Docker container for Plex is meant to be deployed on a remote server - not on the local network. Things like local area searching are sandboxed. 

## Build

```
docker build --tag local/plex .
```

## Run

```
docker run -d --name=plex -v /etc/localtime:/etc/localtime:ro -v <path to plex library>:/config -v <path to media>:/data -p 32400:32400 local/plex
```

This Dockerfile will pull the latest version of Plex for Ubuntu every 24 hours. If an update is required, just rebuild and deploy. 

**Credits**
* lonix <lonixx@gmail.com>
* needo <needo@superhero.org>
* Eric Schultz <eric@startuperic.com>
* Tim Haak <tim@haak.co.uk>
