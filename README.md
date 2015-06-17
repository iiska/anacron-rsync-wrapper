Simple rsync + anacron setup for syncing backups
================================================

Just a wrapper script for backing up files using
[rsync](https://rsync.samba.org/) and [anacron](http://anacron.org/).

Basic setup
-----------

Edit file */etc/anacrontab* and add task for running backup.sh from your desired
source (eg. your home directory) to a backup destination.

```
# Example /etc/anacrontab

SHELL=/bin/sh
PATH=/bin:/usr/bin

RANDOM_DELAY=45
START_HOURS_RANGE=3-22

# period in days | delay in minutes | job-identifier | command
1 5 rsync.backup nice ~user/bin/backup.sh ~user/ user@nas:/mnt/backups

```

Excluding unwanted files
------------------------

Backup script will look source directory and $HOME of user running the script
for *.rsync-excludes* file listing patterns for files which should be excluded.

See
[*rsync-excludes.sample*](https://github.com/iiska/anacron-rsync-wrapper/blob/master/rsync-excludes.sample)
for example and documentation for **--exclude-from**
option in [rsync manpage](https://download.samba.org/pub/rsync/rsync.html) for
more info.

Restoring backups
-----------------

Restoration could be done by simply copying individual files from your backup
destination or by syncing whole directory using backup destination as a source.

**Example:**

```
$ rsync -av user@nas:/mnt/backups ~user/
```

How about incremental snapshots
-------------------------------

This setup only syncs file changes around and doesn't implement any
sophisticated features like incremental backup.

In my own home setup incrementals are achieved by using periodical filesystem
snapshots with ZFS in [FreeNAS box](http://www.freenas.org/).

