FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&  \
    apt-get install -y --no-install-recommends --allow-unauthenticated \
    apt-utils \
    dialog \
    openssl \
    libnss3-tools \
    libcurl3 \
    dbus \
    libdbus-1-3 \
    wget \
    firefox \
    libgl1-mesa-glx \
    flashplugin-installer \
    expect \
    sudo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Flash needs libgl1-mesa-glx but it is not brought as a dependency


#
# Setup flash
#
# Enable flash to always run and reset the default firefox homepage
RUN echo -e '\nuser_pref("plugin.state.flash", 2);\nuser_pref("plugins.flashBlock.enabled", false)\npref("browser.startup.homepage", "http://www.bb.com.br");' >> /etc/firefox/syspref.js

#
# Setup unprivileged user and its firefox profile.
#
# Setup the initial firefox profile (so warsaw can find it and 
# install its own certs on it).
RUN useradd -ms /bin/bash bbuser
WORKDIR /home/bbuser/
COPY load_warsaw_and_run_firefox.sh /home/bbuser/
RUN chmod -v 755 /home/bbuser/load_warsaw_and_run_firefox.sh
USER bbuser
RUN DISPLAY=1270.0.0.1:0.0 /usr/bin/firefox --headless --CreateProfile default

#
# Setup warsaw
#

# Back to root
USER root
WORKDIR /tmp/

# warsaw installation has to be run after user creation so
# initial bootstrap happens for each and every user... go figure..

# Se o comando a baixo te deixa nervoso só lamento, mas é o que o BB
# quer que você faça. Aliás, o que você acha que essa solução de
# segurança do BB é na verdade?

RUN wget --no-check-certificate https://cloud.gastecnologia.com.br/bb/downloads/ws/linux/diagbb-1.0.64.run -O /tmp/diagbb-1.0.64.run
RUN chmod --verbose 755 /tmp/diagbb-1.0.64.run

# Use expect to automate Warsaw's rather chatty installation  process.

COPY install_diagbb.expect /tmp
RUN chmod --verbose 755 install_diagbb.expect
RUN TERM=linux /usr/bin/expect install_diagbb.expect

RUN /etc/init.d/warsaw restart && /etc/init.d/warsaw stop



# bbuser has sudo to start the warsaw servicice
RUN echo 'bbuser ALL = (ALL) NOPASSWD: /etc/init.d/warsaw' >> /etc/sudoers.d/bbuser
RUN echo 'bbuser ALL = (ALL) NOPASSWD: /usr/local/bin/warsaw/core' >> /etc/sudoers.d/bbuser


#
# Setup the runtime environment
#

USER bbuser
WORKDIR /home/bbuser/

# Start warsaw service, per-user warsaw process and firefox
CMD /home/bbuser/load_warsaw_and_run_firefox.sh



# from /etc/xdg/autostart/warsaw.desktop
# /usr/local/bin/warsaw/core &


# docker build --build-arg http_proxy=http://$(ipconfig getifaddr en0):3142/  -t tmacam/bb:base --file Dockerfile.base .
#  docker run -e DISPLAY=$(ipconfig getifaddr en0):0 -v /tmp/.X11-unix:/tmp/.X11-unix --shm-size=2g  -it tmacam/bb:base


