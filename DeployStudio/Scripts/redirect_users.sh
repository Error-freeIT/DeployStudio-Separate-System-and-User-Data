#!/bin/bash

# This script should be postponed to run on first boot.

DEFAULT_DIRECTORY="/Volumes/System/Users"
NEW_DIRECTORY="/Volumes/Data/Users"
SHARED_DIRECTORY="${NEW_DIRECTORY}/Shared"

# Remove the default Users directory.
rm -rf "$DEFAULT_DIRECTORY"

# Create a symbolic link to redirect Users.
ln -s "$NEW_DIRECTORY" "$DEFAULT_DIRECTORY"

# Recreate the Shared directory.
mkdir -p "$SHARED_DIRECTORY"
chmod 1777 "$SHARED_DIRECTORY"
/usr/sbin/chown root:wheel "$SHARED_DIRECTORY"

exit 0