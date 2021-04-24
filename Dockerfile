FROM jlesage/baseimage-gui:alpine-3.12

# Install required packages
RUN apk --update --no-cache add xvfb x11vnc openbox samba-winbind-clients wine

# Configure the wine prefix location
RUN mkdir /wine
ENV WINEPREFIX /wine/

# Disable wine debug messages
ENV WINEDEBUG -all

# Configure wine to run without mono or gecko as they are not required
ENV WINEDLLOVERRIDES mscoree,mshtml=

# Set the wine computer name
ENV COMPUTER_NAME bz-docker

# Create the data Directory
RUN mkdir /data

# Copy the start script to the container
COPY ./start.sh /start.sh
RUN chmod +x ./start.sh

# Set the name of the application.
ENV APP_NAME="Backblaze-Personal"

# Set the start script as entrypoint
ENTRYPOINT /start.sh
