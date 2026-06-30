micro-editor-formula
==================

A SaltStack formula designed to install and configure the [Micro Editor](https://micro-editor.github.io/) package on Windows-based installation-targets.

It is primarily expected that this formula will be run via [P3](https://www.plus3it.com/)'s "[watchmaker](https://watchmaker.readthedocs.io/en/stable/)" framework.

This formula is able to install the Micro Editor utility on Windows Server[^1] operating environments. Installation for internet-connected systems may come from the Micro Editor's ["Releases" page](https://github.com/micro-editor/micro/releases). Alternately:

* Sites whose installation-targets won't be able to reach the Micro Editor product's "Releases" page will need to self-host copies of the desired content.
* Sites that wish to use a specific version of the Micro Editor will need to target that content

Targeting specific versions of the Micro Editor or local copies of the install-archives can be directed to do so by adding appropriate content to the formula's associated Pillar-data (see this projct's [pillar.example](pillar.example) file for guidance).


## Available states

- [micro-editor](#micro-editor)
- [micro-editor.clean](#micro-editor.clean)
- [micro-editor.package](#micro-editor.package)
- [micro-editor.package.clean](#micro-editor.package.clean)
- [micro-editor.config](#micro-editor.config)
- [micro-editor.config.clean](#micro-editor.config.clean)

### micro-editor

Executes the `package` and `config` states to install and configure the Micro Editor

### micro-editor.clean

Executes the `package` and `config` states' `clean` actions to fully uninstall the Micro Editor and remove previously-installed browser policy-configs (and, on Windows, associated registry entries)

### micro-editor.package

Executes _just_ the `package` state to install the Micro Editor package.

### micro-editor.package.clean

Executes _just_ the `package.clean` state to uninstall the Micro Editor package.

### micro-editor.config

Executes _just_ the `config` state to install/configure the Micro Editor client-configuration (etc.) files

### micro-editor.config.clean

Executes _just_ the `config` state to uninstall the Micro Editor client-configuration (etc.) files and, on Windows, remove any registry-keys set by prior install-runs of the formula.

## Compatibility Notes:



[^1]: As of this README's writing, this functionality has only been tested on Windows Server 2022
