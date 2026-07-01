# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}

{#- Retrieve download parameters and defaults #}
{%- set download_sig = micro_editor.pkg.get('download_sig') %}
{%- set download_uri = micro_editor.pkg.get('download_uri') %}
{%- set install_root = micro_editor.config.get('install_root',
    'C:\\Program Files\\Micro') %}
{%- set temp_extract = 'C:\\Windows\\Temp\\micro_staging' %}

{%- if not download_uri %}

Micro Editor Download Uri Missing:
  test.fail_without_changes:
    - text: |
        ------------------------------------------------------------------------
        The `download_uri` parameter is missing from configuration.
        ------------------------------------------------------------------------

{%- elif not download_uri.endswith('.zip') %}

Micro Editor Download Uri Extension Invalid:
  test.fail_without_changes:
    - text: |
        ------------------------------------------------------------------------
        The `download_uri` target is invalid; it must end with `.zip`.
        ------------------------------------------------------------------------

{%- else %}

Ensure {{ install_root }} Directory Exists:
  file.directory:
    - makedirs: True
    - name: {{ install_root }}

Ensure Temporary Staging Directory Is Clean:
  file.absent:
    - name: {{ temp_extract }}

Extract Micro Editor Archive To Staging:
  archive.extracted:
    - archive_format: zip
    - enforce_toplevel: False
    - name: {{ temp_extract }}
    - require:
      - file: Ensure Temporary Staging Directory Is Clean
    {%- if not download_sig %}
    - skip_verify: True
    {%- endif %}
    - source: {{ download_uri }}
    {%- if download_sig %}
    - source_hash: {{ download_sig }}
    {%- endif %}

Move Extracted Components Into Target Destination:
  file.rename:
    - force: True
    - name: {{ install_root }}
    - require:
      - archive: Extract Micro Editor Archive To Staging
    - source: {{ temp_extract }}\micro-2.0.15

Clean Up Staging Workspace:
  file.absent:
    - name: {{ temp_extract }}
    - require:
      - file: Move Extracted Components Into Target Destination

{%- endif %}
