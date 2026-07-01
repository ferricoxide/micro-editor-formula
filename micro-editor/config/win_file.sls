# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}

include:
  - {{ sls_package_install }}

{#- Extract configuration parameters #}
{%- set install_root = micro_editor.config.get('install_root',
    'C:\\Program Files\\Micro') %}
{%- set binary_path = install_root ~ '\\micro.exe' %}
{%- set desc = micro_editor.config.get('shortcut_description',
    'Micro Editor CLI Utility') %}
{%- set desktop_lnk = micro_editor.config.get('desktop_shortcut',
    'C:\\Users\\Public\\Desktop\\Micro Editor.lnk') %}
{%- set start_lnk = micro_editor.config.get('start_menu_shortcut',
    'C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\Micro Editor.lnk') %}

Create Desktop Shortcut:
  shortcut.present:
    - arguments: ''
    - description: '{{ desc }}'
    - icon_index: 0
    - icon_location: '{{ binary_path }}'
    - name: '{{ desktop_lnk }}'
    - require:
      - sls: {{ sls_package_install }}
    - target: '{{ binary_path }}'
    - working_dir: '{{ install_root }}'

Create Start Menu Shortcut:
  shortcut.present:
    - arguments: ''
    - description: '{{ desc }}'
    - icon_index: 0
    - icon_location: '{{ binary_path }}'
    - name: '{{ start_lnk }}'
    - require:
      - sls: {{ sls_package_install }}
    - target: '{{ binary_path }}'
    - working_dir: '{{ install_root }}'
