---
title: 'Predictable'
date: 2019-02-11T19:27:37+10:00
weight: 3
---

It is developed specifically to address common  and ongoing "works on my machine" style frustrations.  
Holonix embodies lessons from the full spectrum of low level core development needs to ad-hoc beginner level hackathon explorations.

## Minimal assumptions

Software projects typically make many assumptions about what the developer environment looks like.

There are few options to provide dependencies and configuration needed at the system level.

This is due to many factors:

- Package managers are locked to either a platform (max/linux/windows) or language (node/rust/etc.)
- Dependencies and configuration are often global so projects bleed into each other, causing system degradation over time
- Package managers try to be "helpful" with versioning by tracking "latest" (e.g. brew on mac) or unpinned semver logic in upstream transitive dependencies
- Binaries look for shared libs that may or may not be installed or be changed by a third party without notice (e.g. Mac software updates)
