## micro-editor-formula

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### 0.1.0

**Released**: 2026.07.02

**Summary**:

*   Added Windows functionality:
    *   Installs the Micro editor's extracted archive-contents to a specified directory (default `C:\Program Files\Micro`)
    *   Ensures the editor is in the global system path
    *   Sets a conditional shell color-scheme (accounting for differences between RDP and PS-over-SSM)
    *   Globally enables "true-color" support
    *   Creates desktop and start menu shortcuts/launcher-icons
    *   (Optionally) Registers the editor to the Explorer context menus
    *   Prepopulates new users' editor defaults
    *   (Optionally) Creates default, pillar-defined file-type associations
    *   Creates a custom color-scheme to make editor-cues (e.g., "too wide for file-type") more obvious. Derived from "Monokai" color-scheme
*   Adds CI tests for Windows platforms (currently Windows Server 2022 and 2025)
*   Updates pillar.example to explain Windows-specific parameters/inputs that may be specified via Pillar


### 0.0.1

**Released**: 2026.07.01

**Summary**:

*   Cloned project from https://github.com/plus3it/repo-template
*   Created micro-editor directory-tree contents by:
    1.   Cloning https://github.com/saltstack-formulas/template-formula.git
    2.   Executing `bin/convert-formula.sh micro-editor` in the new repo-copy
    3.   Moving the resulting `micro-editor` directory into this project's space
    4.   Updating all imports from "`micro__editor`" to "`micro_editor`"
*   Update [LICENSE](LICENSE), CHANGELOG.md (this file), [README.md](README.md) and [.bumpversion.cfg](.bumpversion.cfg) per the P3
repo-template guidance
*   Update the `.github` and `tests` directories' contents  per the P3 repo-template guidance

