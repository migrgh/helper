#!/bin/bash

XAUTH=/tmp/container_xauth
xauth nextract - "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$XAUTH" nmerge -
