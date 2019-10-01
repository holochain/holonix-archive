---
title: 'Predictable'
date: 2019-02-11T19:27:37+10:00
weight: 3
---

We designed Holonix to avoid common  and fundamental "works on my machine" style frustrations, by focusing on predictability.

It embodies lessons of the full spectrum from low level core development to ad-hoc beginner level hackathon explorations.

## Minimal assumptions

Software projects typically make many assumptions about what the developer environment looks like.

This happens of the lack of tooling that reliably provides the necessary dependency and configuration management needed at the system level.

This is due to many factors:

- Package managers are locked to either a platform (max/linux/windows) or language (node/rust/etc.)
- Dependencies and configuration are often global so project needs bleed into each other, causing system degradation over time
- Package managers try to be "helpful" with versioning by tracking "latest" (e.g. brew on mac) or unpinned semver logic in upstream transitive dependencies
- Binaries look for shared libs that may or may not be installed or be changed by a third party without notice (e.g. Mac software updates)
- Package managers don't audit the current system for inconsistencies after the initial install (or ad-hoc manual commands)
- Package managers are themselves running on unpinned and self-incompatible versions
- Many dependencies are missing or exist under different names and versions across different platform package managers
- People make mistakes during installation or the instructions they follow are inappropriate for their system

The bar is very high technically to setup and maintain development environments.

This is true of all software development. Even tightly controlled corporate environments often measure "onboarding" in days/weeks/months _per person per project_.

Open source projects can die simply because it is too hard to get people through the door and support them while they are here.

### Case study: Monero

The [Monero project github readme](https://github.com/monero-project/monero) includes an example of a relatively well documented and supported [depdendency list](https://github.com/monero-project/monero#dependencies).

Around 20 different libraries are listed under different names and versions across debian/ubuntu, arch, and fedora platforms.

Some libraries are listed as "optional" but it is not clear what the consequences of not including each are.

A separate installation process is provided for homebrew on Mac.

Windows compilation is cross compiled from a POSIX emulator.

Only "minimum versions" of dependencies are listed. It is not clear whether semver major/minor/patch boundaries affect compatibility with the compiler.

A list of build status ranging from "unknown" to "failed" at the time of writing are shown at the top of the page.

A list of cross-compiled static binaries are provided near the bottom, but must be manually downloaded and placed on the user's `$PATH` (our experience is that most people can't do this). A list of package manager integrations is provided only with an ominous security disclaimer at the top.

This is all to compile a single binary written in a single language, the Monero wallet.

This is for a well funded, security critical FOSS project with well known, vocal complaints from the community around onboarding and user experience.

As painful as this is, the typical open source experience is worse. No documentation, floating or missing dependencies, mixing and matching many different languages, and no thought to automated testing or cross-platform compilation or support.

### Holonix approach

Holonix tries to avoid assuming things about the underlying system.

- It uses NixOS tooling to audit and automate fixing gaps
- It sets its own environment variables and configuration conventions
- It defines and provides dependencies where possible
- It prefers statically linked binaries
- It prefers project-local configuration and scripts
- It prefers explicitly pinned versions of direct and upstream dependencies
