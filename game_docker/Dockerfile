FROM ubuntu:14.04
EXPOSE 3000-3010
RUN useradd -s /bin/bash pwn3 \
 && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y unzip wget \
 && rm -rf /var/lib/apt/lists/* \
 && wget https://pwnadventure.com/PwnAdventure3Server.tar.gz --no-check-certificate -O /tmp/servers.tar.gz \
 && wget https://pwnadventure.com/PwnAdventure3_Linux.zip --no-check-certificate -O /tmp/client.zip \
 && tar xf /tmp/servers.tar.gz -C /tmp/ \
 && unzip /tmp/client.zip -d /opt/ \
 && mv /opt/PwnAdventure3 /opt/pwn3 \
 && mv /tmp/PwnAdventure3Servers/GameServer/PwnAdventure3Server /opt/pwn3/PwnAdventure3/Binaries/Linux/ \
 && chown -R pwn3:pwn3 /opt/pwn3 \
 && rm /opt/pwn3/PwnAdventure3/Binaries/Linux/PwnAdventure3-Linux-Shipping \ 
 && rm /tmp/servers.tar.gz \
 && rm /tmp/client.zip \
 && rm -rf /tmp/PwnAdventure3Servers
USER pwn3
COPY server.ini /opt/pwn3/PwnAdventure3/Content/Server/
WORKDIR /opt/pwn3/PwnAdventure3/Binaries/Linux/
ENTRYPOINT /opt/pwn3/PwnAdventure3/Binaries/Linux/PwnAdventure3Server
