# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}

{#- Extract configuration parameters #}
{%- set install_root = micro_editor.config.get('install_root',
    'C:\\Program Files\\Micro') %}
{%- set desktop_lnk = 'C:\\Users\\Public\\Desktop\\Micro Editor.lnk' %}
{%- set ps_profile = 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0' ~
    '\\profile.ps1' %}
{%- set start_lnk = 'C:\\ProgramData\\Microsoft\\Windows\\Start ' ~
    'Menu\\Programs\\Micro Editor.lnk' %}
{%- set env_reg_key = 'HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\' ~
    'Control\\Session Manager\\Environment' %}

Remove Conditional Shell Colorscheme:
  file.replace:
    - ignore_if_missing: True
    - name: '{{ ps_profile }}'
    - pattern: '(?s)function micro\s*\{.*?\}\s*'
    - repl: ''

Remove Desktop Shortcut:
  file.absent:
    - name: '{{ desktop_lnk }}'

Remove Explorer Context Menu Base:
  reg.absent:
    - name: 'HKEY_CLASSES_ROOT\*\shell\Open with Micro'

Remove Global Configuration Directory:
  file.absent:
    - name: 'C:\ProgramData\micro'

Remove Global Default Settings Directory:
  file.absent:
    - name: 'C:\Users\Default\.config\micro'

Remove Global Truecolor Support Environment Variable:
  reg.absent:
    - name: '{{ env_reg_key }}'
    - vname: 'MICRO_TRUECOLOR'

Remove Micro Editor From System Path:
  win_path.absent:
    - name: '{{ install_root }}'

Remove Micro Editor Programmatic Identifier Base:
  reg.absent:
    - name: 'HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Micro.Assoc'

Remove Start Menu Shortcut:
  file.absent:
    - name: '{{ start_lnk }}'

{%- for ext in micro_editor.config.get('file_associations', []) %}

Remove {{ ext | upper }} Extension File Association Value:
  reg.absent:
    - name: 'HKEY_LOCAL_MACHINE\SOFTWARE\Classes\{{ ext }}'
    - vname: ''

{%- endfor %}
