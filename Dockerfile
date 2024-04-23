# Use ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    xfce4 \
    desktop-base \
    dbus-x11 \
    xscreensaver \
    && rm -rf /var/lib/apt/lists/*

# Add Google Linux signing key
RUN curl https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/chrome-remote-desktop.gpg

# Add Chrome Remote Desktop repository
RUN echo "deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main" | sudo tee /etc/apt/sources.list.d/chrome-remote-desktop.list

# Update package list
RUN apt-get update

# Install Chrome Remote Desktop
RUN DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes chrome-remote-desktop 32

# Set default session for Chrome Remote Desktop
RUN echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session

# Disable lightdm.service
RUN systemctl disable lightdm.service
