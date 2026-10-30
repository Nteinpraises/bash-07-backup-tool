# Backup Script

This Bash script creates compressed, timestamped backups of directories and automatically removes older backups based on a retention limit.

## Problem

Files can be lost because of hardware failure, accidental deletion, or other unexpected problems. This script provides a simple way to back up important project folders and keep older backups under control.

## Project Goals

- Create compressed backups of directories.
- Add a timestamp to each backup filename.
- Allow users to choose where backups are stored.
- Allow users to choose how many backups to keep.

## Tech Stack

- Language: Bash
- Archiving: tar and gzip
- Tools: Git, GitHub

## Testing

Use `tar -tzf` to inspect the contents of a generated archive.

The script uses these exit codes:

 `0`: Success.
 `1`: Backup operation failed.
 `2`: Invalid usage or input.

## Challenges Faced

One of the main challenges is automatically rotating old backups and validating user input correctly.

## What I am Learned

Through this project, I am learning how to use functions, handle errors, create compressed archives, and manage files safely.

## Author

Ntein Praises