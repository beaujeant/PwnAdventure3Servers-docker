FROM ubuntu:14.04
EXPOSE 3000-3010
RUN useradd -s /bin/bash pwn3
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y unzip && rm -rf /var/lib/apt/lists/*
ADD https://pwnadventure.com/PwnAdventure3Server.tar.gz /tmp/
ADD https://pwnadventure.com/PwnAdventure3_Linux.zip /tmp/
RUN tar xf /tmp/PwnAdventure3Server.tar.gz -C /tmp/ \
 && unzip /tmp/PwnAdventure3_Linux.zip -d /opt/ \
 && mv /opt/PwnAdventure3 /opt/pwn3 \
 && mv /tmp/PwnAdventure3Servers/GameServer/PwnAdventure3Server /opt/pwn3/PwnAdventure3/Binaries/Linux/ \
 && chown -R pwn3:pwn3 /opt/pwn3 \
 && rm /opt/pwn3/PwnAdventure3/Binaries/Linux/PwnAdventure3-Linux-Shipping \ 
 && rm /tmp/PwnAdventure3Server.tar.gz \
 && rm /tmp/PwnAdventure3_Linux.zip \
 && rm -rf /tmp/PwnAdventure3Servers
USER pwn3
COPY server.ini /opt/pwn3/PwnAdventure3/Content/Server/
WORKDIR /opt/pwn3/PwnAdventure3/Binaries/Linux/
ENTRYPOINT /opt/pwn3/PwnAdventure3/Binaries/Linux/PwnAdventure3Server