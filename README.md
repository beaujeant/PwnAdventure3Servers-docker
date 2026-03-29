# PwnAdventure3 Servers - Docker

Run your own **Pwn Adventure 3** servers easily using Docker.

- **Game**: https://pwnadventure.com/  
- **Developer**: Rusty Wagner ([Vector 35](https://vector35.com/)) ❤️  

Pwn Adventure 3 is a fun, intentionally vulnerable online game where you’re encouraged to hack, cheat, and experiment.

---

## 🧩 What’s included?

This setup runs two servers:

- **Master server** → handles login, characters, inventory  
- **Game server** → runs the actual game world  

Everything is packaged with Docker, so setup is quick.

---

## ✅ Requirements

Install these first:

- [Docker Engine](https://docs.docker.com/engine/install/)  
- [Docker Compose](https://docs.docker.com/compose/install/)  
- *(Optional)* [Git](https://github.com/git-guides/install-git)

---

## 🚀 Quick Start

```bash
git clone https://github.com/beaujeant/PwnAdventure3Servers-docker.git
cd PwnAdventure3Servers-docker
docker-compose build
docker-compose up -d
```

⏳ First run may take time (downloads ~2 GB).

---

## 🛑 Stop the servers

```bash
docker-compose down
```

To reset everything (including the database):

```bash
docker-compose down --volumes
```

---

## ⚙️ Default Settings

- Master server → `tcp/3333`  
- Game server → `tcp/3000` to `tcp/3004`  

Default admin team hash:

```
db1e797da308f027c876c61786682f3b
```

---

## 🔌 Proxy Setup

Since PwnAdventure3 is designed for learning reverse engineering and network protocol analysis, you may want to intercept traffic between the client and the servers using a proxy.

A `.env.proxy` file is provided to easily offset the Docker host ports, freeing the original ports for your proxy:

```bash
cp .env.proxy .env
docker compose up -d
```

This maps the Docker containers to ports `13333` (master) and `13000-13010` (game), leaving ports `3333` and `3000-3010` available for your proxy. Your proxy then listens on the original ports and forwards traffic to the offset Docker ports.

- **Master server** (login/auth): client ↔ proxy on `tcp/3333` ↔ Docker on `tcp/13333`
- **Game server** (game instances): client ↔ proxy on `tcp/3000-3010` ↔ Docker on `tcp/13000-13010`

---

## 🎮 Client Setup

Download the game:

- [Windows](https://pwnadventure.com/PwnAdventure3_Windows.zip)
- [Linux](https://pwnadventure.com/PwnAdventure3_Linux.zip)

Make sure to run the executable directly in the folder, otherwise the binary might have some issue to find the certificate.

```
cd PwnAdventure3/Binaries/Linux
./PwnAdventure3-Linux-Shipping
```

### Configure the client

Edit the client's `server.ini` file (located at `PwnAdventure3/Content/Server/server.ini`) and set the master server hostname:

```ini
[MasterServer]
Hostname=master.pwn3
Port=3333
```

That's all you need to configure. The game server address (`game.pwn3`) is automatically advertised by the game server to the master server, which forwards it to your client upon login.

---

## 🌐 Hostnames

Add this to your **hosts file** (`/etc/hosts` on Linux, `C:\Windows\System32\drivers\etc\hosts` on Windows):

```
127.0.0.1 master.pwn3 game.pwn3
```

This makes your computer resolve the server hostnames to your local machine, where Docker (or your proxy) is listening.

---

## 🧱 Linux Fix (if needed)

If you get missing libraries:

- `libssl.so.1.0.0`
- `libcrypto.so.1.0.0`

Pre-compiled versions are already available in the `lib/` folder of this repository. Just copy them next to the game binary:

```bash
cp lib/libssl.so.1.0.0 lib/libcrypto.so.1.0.0 /path/to/client/PwnAdventure3/Binaries/Linux/
```

Alternatively, you can build or install them from your distro:

**Arch Linux (AUR):**

```bash
mkdir aurbuild
cd aurbuild
yay -G openssl-1.0
cd openssl-1.0
makepkg -s --skippgpcheck
cp pkg/openssl-1.0/usr/lib/*.so.1.0.0 /path/to/client/PwnAdventure3/Binaries/Linux/
```

**Ubuntu / Debian:**

`libssl1.0.0` is no longer in the default repos. Build it from source instead:

```bash
sudo apt-get install build-essential
wget https://www.openssl.org/source/openssl-1.0.2u.tar.gz
tar xf openssl-1.0.2u.tar.gz
cd openssl-1.0.2u
./config shared
make -j$(nproc)
cp libssl.so.1.0.0 libcrypto.so.1.0.0 /path/to/client/PwnAdventure3/Binaries/Linux/
cd .. && rm -rf openssl-1.0.2u openssl-1.0.2u.tar.gz
```

**RHEL / Fedora / CentOS:**

`compat-openssl10` is deprecated or unavailable on recent releases. Build it from source instead:

```bash
sudo dnf install gcc make perl-core
wget https://www.openssl.org/source/openssl-1.0.2u.tar.gz
tar xf openssl-1.0.2u.tar.gz
cd openssl-1.0.2u
./config shared
make -j$(nproc)
cp libssl.so.1.0.0 libcrypto.so.1.0.0 /path/to/client/PwnAdventure3/Binaries/Linux/
cd .. && rm -rf openssl-1.0.2u openssl-1.0.2u.tar.gz
```

---

## 🧑‍💻 Manual Install

Prefer no Docker? Follow this guide:  
https://github.com/beaujeant/PwnAdventure3/blob/master/INSTALL-server.md
