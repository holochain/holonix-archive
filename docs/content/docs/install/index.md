---
title: 'Install holonix'
date: 2019-02-11T19:27:37+10:00
weight: 4
---

# Linux/Mac

## Mac system dependencies

Holonix assumes [Xcode](https://developer.apple.com/xcode/) is installed.  
Xcode is the official Mac developer toolkit so is likely to already be installed on a development machine.

Install it from the [Apple app store](https://apps.apple.com/in/app/xcode/id497799835) if needed.

You may need to install the command line tools.  
Follow the instructions if prompted.

## Linux system dependencies

Only `curl` and `sudo` are needed to install `nix-shell`.

These are basic commands.  
Likely to already be installed on a development machine.

Install with the default package manger on your system if needed.

```bash
apt-get install -y sudo curl
```

## Install Nix Tooling

[Nix installation](https://nixos.org/nix/download.html) is the same on Linux and Mac:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

Once installation is finished it will tell you to source the new configuration. Run the command the installer tells you to run.

Once everything is installed and configured the `nix-shell` should work. Test it out by pulling up the help docs.

```bash
nix-shell --help
```

This is everything needed to work with Holonix on Mac and Linux!

# Windows

## System dependencies

Windows does not have native support for `nix-shell`.  
There are a few different options each with its own dependencies and pros/cons.

Holonix is tested against Windows 8+ with Powershell 2.0+.  
Setting up virtualisation may be possible on older systems but is significantly more complex. It seems that at least some changes to the BIOS or additional downloads are needed.

### Virtualisation

#### Vagrant

Working with Vagrant requires a few things to be installed first.

- [Vagrant](https://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (click "Windows hosts")

Once `vagrant` is installed there is an [additional NixOS plugin to install](https://github.com/nix-community/vagrant-nixos-plugin).

```shell
vagrant plugin install vagrant-nixos-plugin
```

Vagrant works by [reading the `Vagrantfile`](https://www.vagrantup.com/docs/vagrantfile/) out of the current project, the current user's home directory or in the root.

A minimal `Vagrantfile` with decent swap RAM configured looks like this (see the vagrant docs for more info):

<script src="https://gist.github.com/thedavidmeister/30ff7b8bdc47f54fe56b3ca17999ac4c.js"></script>

Importantly the `https://holochain.love/box` is a `NixOS` VM with a prewarmed holonix nix-shell and `:nixos` allows vagrant to use nix for provisioning.

This uses a combination of vanilla `Vagrantfile` configuration and additional NixOS configuration from `vagrant-nixos-plugin`.

You can use it directly to boot a vagrant machine and login with ssh.

```shell
cd path/to/your/project
# this URL is a shortened link to the raw gist above
wget https://bit.ly/2KE6cw4 -outfile Vagrantfile
# this will take a while, it is a large download
vagrant up
# login to the vagrant box when it is up
vagrant ssh
# this is inside the vagrant box
cd /vagrant
# see your project files inside vagrant
ls
# see that nix-shell is installed, ready for holonix
nix-shell --help
# make a change, it will be synced outside the box
# /vagrant has a 2-way mount between host and box
touch foo.txt
```

#### Docker

Docker is available for Windows but has specific requirements *that likely cost money*.

Docker *can* be a great option for development *if* you are familiar with how to use it. Docker is relatively low level and many behaviours like snapshots, volumes, detaching and pruning disk usage are unintuitive and inconvenient for casual usage.

The "official" docker box for holonix is [on docker hub](https://hub.docker.com/r/holochain/holonix). It is built on top of the [NixOS community maintained Alpine Linux docker](https://github.com/nix-community/docker-nix) optimised for [Circle CI testing](https://hub.docker.com/r/nixorg/nix) with nixpkgs warmed and pinned for Holonix. This box should work equally well for local usage as for CI.

##### Docker desktop

Docker desktop installation instructions and requirements are listed [on the docker website](https://docs.docker.com/docker-for-windows/install/).

It is the recommended option if possible.

Important notes:

- Requires Windows 10+ 64bit: Pro, Enterprise or Education (Build 15063+)
- Virtualisation must be enabled in BIOS (default setting)
- Hyper-V will be enabled *which will break Virtualbox*
- 4GB of RAM is needed

##### Docker toolbox

Docker toolbox is offered as a fallback as it has less onerous requirements than docker desktop.

Docker toolbox is an older solution that wraps virtual machines to fake native support.

Installation instructions for docker toolbox are listed [on the docker website](https://docs.docker.com/toolbox/toolbox_install_windows/).

Important notes:

- Requires Windows 7+ 64bit
- Virtualisation must be enabled in BIOS (default in Windows 8+)
- Uses VirtualBox under the hood (like vagrant)
- Hyper-V must be disabled

### Windows Subsystem Linux

Windows natively supports Linux emulation for development and general usage. This is called "Windows Subsystem Linux" (WSL).

WSL comes in [two major versions](https://devblogs.microsoft.com/commandline/announcing-wsl-2/):

- WSL1 is currently in wide circulation but is slower and not a real Linux kernel
- WSL2 is newer, faster and a real Linux kernel but requires virtualisation, so newer Windows machines only

The "not a real Linux kernel" limitation of WSL1 is known to cause some problems for NixOS in general. The workarounds outlined below should work fine for Holonix.

Installing WSL requires administrator access to powershell. The instructions are listed [on the Microsoft documentation site](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

#### WSL1

WSL1 can work with some additional configuration.

This may be a good option if your machine [cannot do 64bit virtualisation](https://forum.holochain.org/t/im-spinning-up-some-docs-for-holonix-feedback-welcome/451/5?u=thedavidmeister).

The `/etc/nix/nix.conf` file must be configured with:

```
sandbox = false
use-sqlite-wal = false
```

#### WSL2

WSL2 [may natively support NixOS](https://github.com/NixOS/nixpkgs/issues/30391) in the Windows app store.

If/when this eventuates it will likely be the best way to use NixOS on modern Windows machines.

At the time of writing, WSL2 is DIY and/or Coming Soon.

### Dual Boot

#### Linux dual boot

A linux dual boot can be used with nix shell directly.

Ubuntu + nix shell is a good option, especially for people new to holonix.

#### NixOS dual boot

The NixOS wiki lists instructions to [dual boot NixOS and Windows](https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows).

This seems to be technical but possible judging from various threads and articles:

- https://medium.com/@david.brian.ethier/installing-nixos-dual-booting-from-windows-10-7f082a68564c
- https://www.reddit.com/r/NixOS/comments/a3lp8r/newbie_guidenotes_for_dual_booting_nixos_and/
- https://www.reddit.com/r/NixOS/comments/31lx3i/windows_and_nixos_dual_boot/
- https://unix.stackexchange.com/questions/435122/dual-booting-nixos-and-windows-10-can-it-be-done-easily-if-nixos-is-installed-f

If you can stomach the technicalities of running a _full_ NixOS installation alongside a Windows install, go for it. Note that NixOS by itself is a fairly steep learning curve so this is an extra++ option.
