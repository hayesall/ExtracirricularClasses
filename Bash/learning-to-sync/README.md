`rsync` is not necessarily installed by default.

- https://www.liquidweb.com/kb/install-rsync-and-lsync-on-centos-fedora-or-red-hat/

It was pretty straightforward to get it installed on my Debian instance.

```
sudo apt-get install rsync
```

And the version appears to be 3.1.3

```
rsync  version 3.1.3  protocol version 31
Copyright (C) 1996-2018 by Andrew Tridgell, Wayne Davison, and others.
Web site: http://rsync.samba.org/
Capabilities:
    64-bit files, 64-bit inums, 64-bit timestamps, 64-bit long ints,
    socketpairs, hardlinks, symlinks, IPv6, batchfiles, inplace,
    append, ACLs, xattrs, iconv, symtimes, prealloc
```

Luckily, version 3.1.3 also appears to be the one installed on the
Luddy Unified Linux Systems.

## Tutorials for rsync

- https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories
- https://www.digitalocean.com/community/tutorials/how-to-copy-files-with-rsync-over-ssh

The first recommends syntax like this:

```bash
rsync -a username@remote_host:/home/username/dir1 place_to_sync_on_local_machine
```
