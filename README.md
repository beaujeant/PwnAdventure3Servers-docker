# PwnAdventure3 Servers - Docker

* **URL**: https://pwnadventure.com/
* **Developer**: Rusty Wagner from [Vector 35](https://vector35.com/) ❤️
* **Descrition**: Pwn Adventure 3: Pwnie Island is a limited-release, first-person, true open-world MMORPG set on a beautiful island where anything could happen. That's because this game is intentionally vulnerable to all kinds of silly hacks! Flying, endless cash, and more are all one client change or network proxy away. Are you ready for the mayhem?! 


## Servers

The server has two components: a **master server** responsible for login, creating your characters, keeping track of you inventory, mission, etc; and the **game server** that creates the instance and takes care of the game logic on the server side. This repository contains the `Dockerfile` and `docker-compose.yml` to buid the image for both servers and deploy a working environment to play Pwn Adventure 3 online.

### Requirements

* Install [Docker Engine](https://docs.docker.com/engine/install/)
* Install [Docker Compose](https://docs.docker.com/compose/install/)
* (optional) Install [Git](https://github.com/git-guides/install-git)

### Install

Simply [download](https://github.com/beaujeant/PwnAdventure3Servers-docker/archive/refs/heads/main.zip), build and run the dockers. It might take a while to build the environment the first time as it will download the game server (around 2Go) and the docker images for _postgres_ and _Ubuntu 14.04_:

```
git clone https://github.com/beaujeant/PwnAdventure3Servers-docker.git
cd PwnAdventure3Servers-docker
docker-compose build
docker-compose up -d
```

Once done, you can run the following command to stop the containers:

```
docker-compose down
```

The database is persistent (via the volume `pwn3_db`). If you want to start from scratch, you can add the option `--volume` when putting down the containers.

### Server settings

By default, the **master server** listens on port **tcp/3333**, and the **game server** (maximum 5 instances) listens from port **tcp/3000** to **tcp/3004** (see `game_docker/server.ini`). There is one default admin team you can join with the hash `db1e797da308f027c876c61786682f3b` (see `maser_docker/MasterServer/initdb.sql`). The master server will advertise the game server with the hostname **game.pwn3**.


### Manual install

If you prefer to install the server directly on your computer, you can follow my [guide](https://github.com/beaujeant/PwnAdventure3/blob/master/INSTALL-server.md) on GitHub.

## Client

Download the client:

* [Windows](https://pwnadventure.com/PwnAdventure3_Windows.zip)
* [Linux](https://pwnadventure.com/PwnAdventure3_Linux.zip)

Modify the client configuration file (`PwnAdventure3/PwnAdventure3/Content/Server/server.ini`) to connect to the master server.

```
[MasterServer]
Hostname=master.pwn3
Port=3333
```

In our example, since the hostnames we set for the master server (i.e. `master.pwn3`) and for the game server (`game.pwn3`) do not exist, need to [create an entry in the hosts file](https://www.hostinger.com/tutorials/how-to-edit-hosts-file) to point to actual server. For instance, if the server is running locally, we add the following line:

```
127.0.0.1 	master.pwn3 game.pwn3
```