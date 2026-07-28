# A temporary solution for krunner on nvidia driver

## How it works?

This script waits for any output that contains error `eglSwapBuffers` and restarts krunner.
To make it work qdbus open krunner to make it looks like it's being used.
If you start spamming, kde will raise random errors, but it's not a big deal.

## Requirements

 - `qdbus` for Qt5 or `qdbus-qt6` for Qt6

## Install 

```bash
make install
```

## Uninstall

```bash
make uninstall
```
