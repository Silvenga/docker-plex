FROM phusion/baseimage:0.9.13
MAINTAINER Stian Larsen <lonixx@gmail.com>
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install Plex
RUN apt-get -q update
RUN apt-get install -qy gdebi-core wget
RUN wget -P /tmp http://downloads.plexapp.com/plex-media-server/0.9.9.14.531-7eef8c6/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb
RUN gdebi -n /tmp/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb
RUN echo 0.9.9.14.531-7eef8c6_amd64.deb | awk -F_ '{print $2}' > /tmp/version
RUN rm -f /tmp/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb

#Userfix
RUN usermod -u 999 plex
RUN groupmod -g 999 plex

#Mappings and ports
VOLUME /config
VOLUME /data
EXPOSE 32400


# Define /config in the configuration file not using environment variables
ADD plexmediaserver /etc/default/plexmediaserver

#Adding Custom files
RUN mkdir /etc/service/plex
ADD plex.run /etc/service/plex/run
ADD dbus.init /etc/my_init.d/10_dbus.sh
ADD updatePlex.init /etc/my_init.d/20_updatePlex.sh
RUN chmod +x /etc/service/plex/run
RUN chmod +x /etc/my_init.d/10_dbus.sh
RUN chmod +x /etc/my_init.d/20_updatePlex.sh


#Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
