---
title: 'Bash scripts'
date: 2019-02-11T19:27:37+10:00
weight: 8
---

## Writing a bash script

Most repositories benefit from a set of "quality of life" scripts.

Bash is by far the lowest common denominator.  
It is easy to extend holonix with custom bash scripts.

### NixOS boilerplate

NixOS provides a function `writeShellScriptBin` that takes a name, any bash string, creates a binary and puts it on the `PATH`.

The name is literally what will be executed on the command line by users so must be globally unique.

For example, if we had the following bash script:

```bash
set -euo pipefail
# create a zip of our awesome assets
zip -r my-assets.zip ./assets
```

We can [extend holonix](/configure) like this:

`assets/default.nix`

```nix
{ pkgs, config }:
let
 zip-script = pkgs.writeShellScriptBin "assets-zip" ''
set -euo pipefail
zip -r ${config.assets.zip-name} ${config.assets.path}
'';
in
{
 buildInputs = [
  zip-script
  pkgs.zip
 ];
}
```

`./config.nix`

```nix
{
 # configuration for our assets management scripts
 assets = {
  path = "./public/assets";
  zip-name = "assets.zip";
 };

 # ...
}
```

`./default.nix`

```nix
{
 # ...

 buildInputs = [ ]
  ++ holonix.shell.buildInputs
  ++ config.buildInputs

  # scripts for working with assets
  ++ (holonix.pkgs.callPackage ./assets {
   pkgs = holonix.pkgs;
   # config is imported at the top of this file
   config = config;
  }).buildInputs
}
```

### Explanation

This asset zipping script is very minimal.  
In a small project this level of boilerplate would be overkill.  
The `writeShellScriptBin` could be added directly to the `buildInputs` list in `default.nix` along with `holonix.pkgs.zip`.

The example is contrived to show:

- Holonixifying a bash script as a raw string
- Adding values to `./config.nix` to centralise values that may change over time and/or used by several different scripts
- An example of setting up `let` blocks to scope values in a `default.nix` file
- **Providing dependencies explicitly for bash scripts** that can't be assumed across all systems
- Using the `holonix.pkgs` value so that the scripts used to build dependencies are pinned to holonix versions which **provides best compatibility with HoloPortOS**

`assets/default.nix`:

- `pkgs` is passed in from `./default.nix` as an argument in `{ pkgs }:`
- the `let` and `in` block binds some values for the following scope
- `assets-path` and `zip-name` set some values we might want to change over time
- `zip-script` uses `pkgs.writeShellScriptBin` to create a binary called `assets-zip` from our bash script
- the bash script uses the `''` notation for a string literal block
- the bash script uses `${...}` notation to interpolate nix values set earlier in the `let` block into the bash script string
- `zip-script` is added to `buildInputs`
- `pkgs.zip` is added to `buildInputs` **so that NixOS includes the `zip` command in the shell**

`default.nix`:

- `default.nix` calls `assets/default.nix` as a function
- `default.nix` passes the `holonix.pkgs` to `assets/default.nix` as the `pkgs` argument
- `default.nix` passes the imported config to `assets/default.nix` as the `config` argument
- `default.nix` appends the returned `.buildInputs` property to its internal `buildInputs`

## Strings

NixOS "compiles" bash scripts when the nix-shell is created.  
Bash may do additional variable substitutions at runtime.

The NixOS values are immutable and hashed as part of the derivation.  
Bash values are dependant on the state of the environment.

Both options are useful in different situations.  
For example, it is great to be able to keep release versions tracked in git as nix config. Bash variables may help to integrate with remote systems at runtime such as pulling data with `curl`.

Bash has many syntaxes for slightly different things.  
One of the syntaxes for string interpolation looks like this:

```bash
#!/usr/bin/env bash
export $my_var=foo
echo "my_var is: ${my_var}"
```

This can't always be avoided.  
For example string substitution requires it:

```bash
#!/usr/bin/env bash
firstString="I love Suzi and Marry"
secondString="Sara"
echo "${firstString/Suzi/$secondString}"    
# prints 'I love Sara and Marry'
```

In this case nix would treat the `${...}` as a nix expression if included in a nix string and error when building the derivation.

The solution is to escape the substitution in nix with `''${..}` syntax.

This will compile and bash will handle the string substitution correctly:

```nix
''
#!/usr/bin/env bash
firstString="I love Suzi and Marry"
secondString="Sara"
echo "''${firstString/Suzi/$secondString}"    
# prints 'I love Sara and Marry'
''
```
