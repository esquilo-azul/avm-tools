FROM ubuntu:20.04
RUN apt-get update -y

# Timezone
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Default user
RUN /usr/sbin/useradd --shell /bin/bash --home-dir /home/myuser --create-home myuser
RUN /bin/echo 'myuser:myuser' | /usr/sbin/chpasswd
RUN /bin/chown myuser:myuser /home/myuser -R

# Sudo
RUN apt-get install -y sudo
RUN /bin/echo "myuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/myuser_all_nopasswd && chmod 0440 /etc/sudoers.d/myuser_all_nopasswd

# Container
USER myuser
WORKDIR /home/myuser
ENTRYPOINT /bin/bash
CMD apt-get update -y && apt-get dist-upgrade -y
