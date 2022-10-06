#!/bin/bash
sleep 5 # waiting for postgresql to start
psql -h /var/run/postgresql -tc "SELECT 1 FROM pg_database WHERE datname = 'master'" -d template1 | grep -q 1 || psql -h /var/run/postgresql -f /opt/pwn3/initdb.sql -d template1
cd /opt/pwn3/
/opt/pwn3/MasterServer