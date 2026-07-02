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

1. This formula configures default editor settings for several file-types. This is done by wring a JSON-formatted configuration file to `C:\Users\Default\.config\micro\settings.json`. Users created after this file is laid down will get a copy of this file added to thier `$env:HOME\.config\micro\` directory. For users created before this formula is run, it will be necessary to manually copy the file-contents from its source location to its destination location(s).

2. There is a difference in color-support between the full, graphical desktop and tools like Powershell-over-SSM:

    * When accessing via channels with minimal color support &mdash; such as Powershell-over-SSM &mdash; the 16-color, "simple" color palett is used. This should only effect the SSM user
        <div align="center">
          <img src="/docs/images/MicroEditor-PSoveSSM.png">
          <br>
          <sup>Micro Editor launched within a Powershell-over-SSM session</sup>
        </div>
    
    * When accessing via channels with full color support &mdash; such as a full desktop session via console or RDP &mdash; the 16Mn-color, "true color" color palett is used. This should only effect the SSM user
        <div align="center">
          <img src="/docs/images/MicroEditor-RDP.png">
          <br>
          <sup>Micro Editor launched within a graphical desktop (RDP)  session</sup>
        </div>


[^1]: As of this README's writing, this functionality has only been tested on Windows Server 2022
