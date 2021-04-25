Linux Client
========

## Download and Install

You can download and install the latest release from the official website at https://www.dev47apps.com/droidcam/linux/, along with instructions on how to update the webcam resolution and other info.

x64 releases are also available here on GitHub at https://github.com/dev47apps/droidcam/releases

Raspberry-PI instructions can be found here: https://github.com/dev47apps/droidcam/wiki/Raspberry-PI

## Building

Download and install latest libjpeg-turbo 2.0.X via:
https://github.com/libjpeg-turbo/libjpeg-turbo/releases

The libjpeg-turbo package should go into `/opt/libjpeg-turbo`.
The official binaries (.deb, .rpm) will automatically install into the correct directory.

Install the following dependencies
(the package names are for Debian based systems, adjust as needed for other distros)
```
libavutil-dev
libswscale-dev
libasound2-dev
libspeex-dev
libusbmuxd-dev
libplist-dev

gtk+-3.0               # Only needed for GUI client
```

Run `make`, or `make droidcam-cli` if you skipped installing GTK+, to build the droidcam binaries.

To install, run `sudo ./install-client`.

## V4L2 Loopback (webcam driver)

DroidCam comes with its own version of v4l2loopback, v4l2loopback-dc, which makes the app
[a little more user-friendly](https://github.com/dev47apps/droidcam/issues/56#issuecomment-626795824).

As of version 1.6 the droidcam client works with the standard [v4l2loopback](https://github.com/umlaeute/v4l2loopback) module,
and installing v4l2loopback-dc is optional.

The standard v4l2loopback module is already available on most distros.

To install v4l2loopback-dc, make sure you have these dependencies installed
```
linux-headers-`uname -r` gcc make
```
then run `sudo ./install-video`.

Debian/Ubuntu and RHEL (Fedora/SUSE) based distros:

[If your system supports DKMS](./README-DKMS.md), you can instead use `sudo ./install-dkms`.

## Sound

Run `sudo ./install-sound` to load the Linux ALSA Loopback sound card which the Droidcam client will use for audio input.

