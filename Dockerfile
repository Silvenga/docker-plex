FROM base:1.0
#Based on the work of needo
#MAINTAINER needo <needo@superhero.org>
#Based on the work of Eric Schultz <eric@startuperic.com>
#Thanks to Tim Haak <tim@haak.co.uk>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install Plex
RUN apt-get -q update
RUN apt-get install -qy gdebi-core wget
RUN wget -P /tmp http://downloads.plexapp.com/plex-media-server/0.9.9.12.504-3e7f93c/plexmediaserver_0.9.9.12.504-3e7f93c_amd64.deb
RUN gdebi -n /tmp/plexmediaserver_0.9.9.12.504-3e7f93c_amd64.deb
RUN echo plexmediaserver_0.9.9.12.504-3e7f93c_amd64.deb | awk -F_ '{print $2}' > /tmp/version
RUN rm -f /tmp/plexmediaserver_0.9.9.12.504-3e7f93c_amd64.deb

# Fix a Debianism of plex's uid being 101
RUN usermod -u 999 plex
RUN groupmod -g 999 plex
#RUN usermod -g 999 plex

VOLUME /config
VOLUME /data

EXPOSE 32400

# Define /config in the configuration file not using environment variables
ADD plexmediaserver /etc/default/plexmediaserver

# Add firstrun.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh

# Add Plex to runit
RUN mkdir /etc/service/plex
ADD plex.sh /etc/service/plex/run
RUN chmod +x /etc/service/plex/run

#RUN usermod -a -G nogroup plex

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
