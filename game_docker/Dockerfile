FROM ubuntu:14.04
EXPOSE 3000-3010
RUN useradd -s /bin/bash pwn3
ADD --chown=pwn3 ./GameServer.tar.gz /opt/pwn3
USER pwn3
WORKDIR /opt/pwn3/PwnAdventure3/Binaries/Linux
ENTRYPOINT /opt/pwn3/PwnAdventure3/Binaries/Linux/PwnAdventure3Server