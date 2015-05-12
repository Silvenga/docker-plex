FROM phusion/baseimage:latest
MAINTAINER Mark Lopez <m@silvenga.com>
# Forked from lonix @ https://bitbucket.org/lonix/plex

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install Plex
RUN \
	echo "deb http://deb.silvenga.com/ plex main" >> /etc/apt/sources.list \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 992A3C9A3C3DE741 \
	&& apt-get update \
	&& apt-get install -y plexmediaserver

#Mappings and ports
VOLUME ["/config", "/data"]
EXPOSE 32400

# Define /config in the configuration file not using environment variables
ADD plexmediaserver /etc/default/plexmediaserver

#Adding Custom files
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
