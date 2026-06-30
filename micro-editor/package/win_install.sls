{#- -*- coding: utf-8 -*- #}
{#- vim: ft=sls #}

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}

{#- Retrieve download parameters and defaults #}
{%- set download_sig = micro_editor.pkg.get('download_sig') %}
{%- set download_uri = micro_editor.pkg.get('download_uri') %}
{%- set install_root = micro_editor.config.get('install_root',
    'C:\\Program Files\\Micro') %}

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

Extract and Install Micro Editor package into {{ install_root }}:
  archive.extracted:
    - archive_format: zip
    - enforce_toplevel: False
    - name: {{ install_root }}
    - require:
      - file: Ensure {{ install_root }} Directory Exists
    - source: {{ download_uri }}
    {%- if download_sig %}
    - source_hash: {{ download_sig }}
    {%- endif %}
{%- endif %}
