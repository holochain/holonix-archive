---
title: 'Support & debug'
date: 2019-02-11T19:27:37+10:00
weight: 16
---

## Mac & Linux

A common myth is that NixOS is required to develop with Holonix.  
This is not true.  
Holonix is native to Mac _and_ Linux through the nix shell.  
The nix shell is comparable to using `brew`, `apt-get` or `npm`.

This is all possible thanks to the awesome work by the [NixOS Foundation](https://nixos.org/nixos/foundation.html) and [Holochain](https://holochain.org) maintaining cross-platform binaries.

### Mac

Holonix assumes [Xcode](https://developer.apple.com/xcode/) is installed.  
Xcode is the official Mac developer toolkit so is likely to already be installed on a development


## Windows

Windows support is available through virtual machines (VMs), either [Vagrant](https://www.vagrantup.com/) or [Docker](https://www.docker.com/). This is similar to web development where local VMs imitate Linux production servers.

The future of native Windows support is bright!  
[May 2019](https://github.com/NixOS/nixpkgs/issues/30391#issuecomment-491350711) [@edolstra](https://github.com/edolstra) registered a Microsoft account for the NixOS foundation.  
If all goes well NixOS will be a Windows Subsystem Linux 2 (WSL2) app.

## NixOS
