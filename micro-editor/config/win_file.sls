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
{%- set icon_index = 269 %}
{%- set icon_location = 'C:\\Windows\\System32\\shell32.dll' %}
{%- set link_description = 'Micro Editor CLI Utility' %}
{%- set binary_path = install_root ~ '\\micro.exe' %}
{%- set desktop_lnk = 'C:\\Users\\Public\\Desktop\\Micro Editor.lnk' %}
{%- set start_lnk = 'C:\\ProgramData\\Microsoft\\Windows\\Start ' ~
    'Menu\\Programs\\Micro Editor.lnk' %}

Create Desktop Shortcut:
  shortcut.present:
    - arguments: ''
    - description: '{{ link_description }}'
    - icon_index: {{ icon_index }}
    - icon_location: '{{ icon_location }}'
    - name: '{{ desktop_lnk }}'
    - require:
      - sls: {{ sls_package_install }}
    - target: '{{ binary_path }}'
    - working_dir: '{{ install_root }}'

Create Start Menu Shortcut:
  shortcut.present:
    - arguments: ''
    - description: '{{ link_description }}'
    - icon_index: {{ icon_index }}
    - icon_location: '{{ icon_location }}'
    - name: '{{ start_lnk }}'
    - require:
      - sls: {{ sls_package_install }}
    - target: '{{ binary_path }}'
    - working_dir: '{{ install_root }}'
