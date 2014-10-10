FROM phusion/baseimage:0.9.15
MAINTAINER Stian Larsen <lonixx@gmail.com>
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install Plex
RUN apt-get -q update && \
apt-get install -qy gdebi-core wget && \
wget -P /tmp http://downloads.plexapp.com/plex-media-server/0.9.9.14.531-7eef8c6/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb && \
gdebi -n /tmp/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb && \
rm -f /tmp/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Userfix
RUN usermod -u 996 plex && \
groupmod -g 996 plex

#Mappings and ports
VOLUME /config
VOLUME /data
EXPOSE 32400


# Define /config in the configuration file not using environment variables
ADD plexmediaserver /etc/default/plexmediaserver

#Adding Custom files
RUN mkdir -p /etc/service/plex && \
mkdir -p /etc/service/dbus && \
mkdir -p /etc/service/avahi

ADD plex.run /etc/service/plex/run
ADD dbus.run /etc/service/dbus/run
ADD avahi.run /etc/service/avahi/run
ADD dbus.init /etc/my_init.d/10_dbus.sh
ADD updatePlex.init /etc/my_init.d/20_updatePlex.sh
RUN chmod +x /etc/service/plex/run && \
chmod +x /etc/service/avahi/run && \
chmod +x /etc/service/dbus/run && \
chmod +x /etc/my_init.d/10_dbus.sh && \
chmod +x /etc/my_init.d/20_updatePlex.sh
