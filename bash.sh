sudo apt-get update && \
    apt-get install -y --no-install-recommends curl gnupg xfce4 desktop-base dbus-x11 xscreensaver && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


 curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main" > /etc/apt/sources.list.d/chrome-remote-desktop.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends chrome-remote-desktop && \
    apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session

sudo rm -f /etc/init.d/*tty* && \
    echo '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    echo 'manual' > /etc/init/lightdm.override

CMD ["chrome-remote-desktop"]
