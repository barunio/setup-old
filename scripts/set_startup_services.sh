#!/bin/bash

echo "Start memcached at login"
ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents

echo "Start mysql at login"
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

echo "Start redis at login"
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents

echo "Start postgres at login"
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
