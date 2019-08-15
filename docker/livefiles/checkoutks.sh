#/bin/bash
ln -s /bin/true /sbin/initctl
export HOME=/root
export LC_ALL=C
dpkg-divert --local --rename --add /sbin/initctl
dpkg-query -W --showformat='${Package} ${Version}\n' > /filesystem.manifest
