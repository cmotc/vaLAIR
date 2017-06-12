FROM ratox-deb
USER root
RUN apt-get purge -yq libtox-toktok-dev \
        libtoxav-toktok \
        libtoxav-toktok-dbgsym \
        libtoxav-toktok-dev \
        libtoxcore-toktok \
        libtoxcore-toktok-dbgsym \
        libtoxcore-toktok-dev \
        libtoxdns-toktok \
        libtoxdns-toktok-dbgsym \
        libtoxdns-toktok-dev \
        libtoxencryptsave-toktok \
        libtoxencryptsave-toktok-dbgsym \
        libtoxencryptsave-toktok-dev
RUN apt-get install -yq libtox-dev \
        libtoxav0 \
        libtoxav0-dbgsym \
        libtoxav-dev \
        libtoxcore0 \
        libtoxcore0-dbgsym \
        libtoxcore-dev \
        libtoxdns0 \
        libtoxdns0-dbgsym \
        libtoxdns-dev \
        libtoxencryptsave0 \
        libtoxencryptsave0-dbgsym \
        libtoxencryptsave-dev \
        build-essential \
        checkinstall \
        valac \
        valac-dbgsym \
        valac-0.34-vapi \
        libvala-0.34-0 \
        libvala-0.34-dev \
        libsdl2-2.0-0 \
        libsdl2-image-2.0-0 \
        libsdl2-mixer-2.0-0 \
        libsdl2-net-2.0-0 \
        libsdl2-ttf-2.0-0 \
        libsdl-ttf2.0-0 \
        libsdl-ttf2.0-dev \
        libluajit-5.1-2 \
        libluajit-5.1-common \
        libluajit-5.1-dev \
        luajit \
        gcc libc-dev make git \
        debhelper
RUN useradd
RUN useradd -ms /bin/bash lair
USER lair
WORKDIR /home/lair
RUN git clone https://github.com/cmotc/valair.git && cd valair && make deb-pkg && sudo dpkg -i ../*.deb
RUN lair
