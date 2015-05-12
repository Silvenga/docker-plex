# Silvenga/docker-plex

## Build

```
docker build --tag local/plex .
```

## Run

```
docker run -d --name=plex -v /etc/localtime:/etc/localtime:ro -v <path to plex library>:/config -v <path to media>:/data -p 32400:32400 local/plex
```

> `--net=host` can be added to the above if you want localarea discovery to work. I personally don't care so I might as well sandbox Plex. 

This Dockerfile will pull the latest version of Plex for Ubuntu every 24 hours. If an update is required, just rebuild and deploy. 

**Credits**
* lonix <lonixx@gmail.com>
* needo <needo@superhero.org>
* Eric Schultz <eric@startuperic.com>
* Tim Haak <tim@haak.co.uk>
