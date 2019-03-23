pkg-watcher
==============

This is a package for watching and auto-updating other packages.

Most likely, some other package will require this one and use it to watch itself and/or other packages

Do that with:

```
(watch! 'my-package)
```

Or the inverse:

```
(unwatch! 'my-package)
```

You can also do:

```
(priority-watch! 'my-package)
```

Or the inverse:

```
(priority-unwatch! 'my-package)
```

Updates of `priority-watch!` packages happen when DrRacket is opened.

Updates of all watched packages can be triggered with:

```
raco update-watched-packages
```

Or you can ask pkg-watcher to start checking for updates with:


```
raco start-realtime-updates
```

Ctrl-C to stop.

Example dev workflow when you're developing packages and want to test if it works on some other machine. Switch the source of a package you're developing to some github url (probably with a #dev branch tag or something).  Use `raco start-realtime-updates`.  And it'll be kind of like a mini continuous integration server.  Whenever you push to that branch, the machine with `pkg-watcher` installed will pull that branch and run `raco setup`.  If your tests fail on the remote machine, you'll know. 







