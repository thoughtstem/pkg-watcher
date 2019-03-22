pkg-watcher
==============

This is a package for watching and auto-updating other packages.

Most likely, some other package will require this one and use it to watch itself and/or other packages

Do that with

```
(watch! 'my-package)
```

Or the inverse:

```
(unwatch! 'my-package)
```

You can also do,

```
(priority-watch! 'my-package)
```

Or the inverse:

```
(priority-unwatch! 'my-package)
```

Updates happen automatically when you log into DrRacket.

A single update can also be triggered by:

```
raco update-watched-packages
```

Or you can ask pkg-watcher to continally check for updates with:


```
raco start-realtime-updates
```



