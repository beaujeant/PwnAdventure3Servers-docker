FROM ubuntu:14.04
EXPOSE 3333
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*
RUN useradd -u 70 -s /bin/sh postgres
ADD --chown=postgres ./MasterServer/ /opt/pwn3
USER postgres
ENTRYPOINT /opt/pwn3/master.sh