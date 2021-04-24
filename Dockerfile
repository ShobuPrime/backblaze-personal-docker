FROM jlesage/baseimage-gui:alpine-3.12

# Install required packages
#RUN apk --update --no-cache add xvfb x11vnc openbox samba-winbind-clients
RUN apk --update --no-cache add samba-winbind-clients
RUN echo "https://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && apk --no-cache add wine

# Configure the wine prefix location
RUN mkdir /wine
RUN chown -R ${USER_ID}:${GROUP_ID} /wine
ENV WINEPREFIX /wine/

# Disable wine debug messages
ENV WINEDEBUG -all

# Configure wine to run without mono or gecko as they are not required
ENV WINEDLLOVERRIDES mscoree,mshtml=

# Set the wine computer name
ENV COMPUTER_NAME bz-docker

# Create the data Directory
RUN mkdir /data
RUN chown -R ${USER_ID}:${GROUP_ID} /data

# Copy the start script to the container
COPY ./startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Set the name of the application.
ENV APP_NAME="Backblaze-Personal"

WORKDIR /
