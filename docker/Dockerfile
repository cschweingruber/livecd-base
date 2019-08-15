FROM ubuntu:bionic
MAINTAINER c.schweingruber@iet-gibb.ch
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install locales && \
    apt-get -y install --install-recommends linux-virtual-hwe-18.04 && \
    localedef -i de_CH -c -f UTF-8 -A /usr/share/locale/locale.alias de_CH.UTF-8 && \
    apt-get -y install software-properties-common && \
    apt-get -y install genisoimage xorriso isolinux squashfs-tools squashfuse debootstrap && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /work/chroot && cd /work/chroot && \
    debootstrap --foreign --arch=amd64 bionic /work/chroot && \
    sed -i '/setup_devices ()/a return 0' /work/chroot/debootstrap/functions && \
    sed -i '/setup_proc ()/a return 0' /work/chroot/debootstrap/functions && \
    sed -i 's/rsyslog //' /work/chroot/debootstrap/base && \
    cd /work/chroot && \
    DEBOOTSTRAP_DIR=/work/chroot/debootstrap/ debootstrap/debootstrap --second-stage --second-stage-target=/work/chroot/ 

COPY /livefiles/liveroot/prepiso.sh /work/chroot

RUN cat /etc/apt/sources.list |grep -v '^#' > /work/chroot/etc/apt/sources.list && \
    chroot /work/chroot /prepiso.sh

COPY /livefiles /

ENV KSVERSION=0.1

RUN /inst-ks.sh
CMD /bin/bash /geniso.sh
