#!/bin/bash

# Ensure working dir is where the minecraft server files are
cd /var/lib/minecraft/spigot-server

JAVA_OPTS="-Xms1G -Xmx4G -XX:+UseConcMarkSeepGC"
/usr/bin/java -jar /var/lib/minecraft/spigot-server/spigot.jar
