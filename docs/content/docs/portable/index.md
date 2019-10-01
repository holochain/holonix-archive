---
title: 'Portable'
date: 2019-02-11T19:27:37+10:00
weight: 2
---

Holonix works on all major operating systems (mostly) without VMs.

This is possible thanks to the awesome work by the [NixOS Foundation](https://nixos.org/nixos/foundation.html) and [Holochain](https://holochain.org) maintaining cross-platform binaries.

NixOS is an entire operating system but Holonix doesn't require a NixOS installation at all.

Holonix targets the standalone "nix shell" tool.  
Nix shell is comparable to using `brew`, `apt-get` or `npm` but is not locked to a single platform or language.

Read the [installation](/docs/install) and [configuration](/docs/config) guides for details on _how_ this all works.

## Mac & Linux

Holonix is native to Mac _and_ Linux through the nix shell.  

## Windows

### Virtualisation

Windows support is available through virtual machines (VMs), either [Vagrant](https://www.vagrantup.com/) or [Docker](https://www.docker.com/). This is similar to web development where local VMs imitate Linux production servers.

Vagrant is the simplest option for beginners.  
It doesn't require premium software, dual booting or "subsystems".  
If you're starting out with Holonix or running an event, this is a good place to start.

Read the holonix installation instructions for more information.

### Windows Subsystem Linux

If you can't use virtualisation you can try Windows Subsystem Linux (WSL) or dual booting to Ubuntu.

There are two versions of WSL.  

WSL1 can work with some additional configuration.  
Some success has been [reported in the holochain forums](https://forum.holochain.org/t/im-spinning-up-some-docs-for-holonix-feedback-welcome/451/3?u=thedavidmeister).  
Some issues have been [reported upstream in NixOS](https://github.com/NixOS/nix/issues/1203) with potential solutions.

WSL2 should provide better nix shell support than WSL1.  
[May 2019](https://github.com/NixOS/nixpkgs/issues/30391#issuecomment-491350711) [@edolstra](https://github.com/edolstra) registered a Microsoft account for the NixOS foundation.  
If all goes well NixOS will be a native Windows Subsystem Linux 2 (WSL2) app.  
Even without native NixOS support, nix shell in an WSL2 ubuntu setup should work well.

### Dual booting

Many Windows machines can be configured to dual boot an entirely separate Linux machine alongside Windows.

## NixOS

Of course, if you _are_ running NixOS as your development environment then Holonix will work great.

[@thedavidmeister](https://github.com/thedavidmeister) is doing all his development on NixOS and loves it.  
Several other people in and around holochain core development have tried and failed to get up and running.  

If you want to get involved in the NixOS community and help dogfood the tech, go for it!  
Don't feel obligated _at all_.
