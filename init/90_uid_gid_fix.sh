if [ ! "$(id -u plex)" -eq "$UID" ]; then usermod -u "$UID" plex ; fi
if [ ! "$(id -g plex)" -eq "$GID" ]; then usermod -g "$GID" plex ; fi

echo "
-----------------------------------
PLEX GID/UID
-----------------------------------
Plex uid:    $(id -u plex)
Plex gid:    $(id -g plex)
-----------------------------------
Plex will now continue to boot.
"