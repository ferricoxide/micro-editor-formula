# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

{#- Extract configuration parameters #}
{%- set install_root = micro_editor.config.get('install_root',
    'C:\\Program Files\\Micro') %}
{%- set binary_path = install_root ~ '\\micro.exe' %}
{%- set desktop_lnk = 'C:\\Users\\Public\\Desktop\\Micro Editor.lnk' %}
{%- set start_lnk = 'C:\\ProgramData\\Microsoft\\Windows\\Start ' ~
    'Menu\\Programs\\Micro Editor.lnk' %}
{%- set icon_location = 'C:\\Windows\\System32\\shell32.dll' %}
{%- set icon_index = 269 %}
{%- set link_description = 'Micro Editor CLI Utility' %}
{%- set ctx_menu = micro_editor.config.get('enable_context_menu', True) %}

Add Micro Editor To System Path:
  win_path.exists:
    - name: '{{ install_root }}'
    - require:
      - sls: {{ sls_package_install }}

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

Create Global Configuration Directory:
  file.directory:
    - makedirs: True
    - name: 'C:\ProgramData\micro'
    - require:
      - sls: {{ sls_package_install }}

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

Manage Micro Editor Global Default Settings:
  file.managed:
    - makedirs: True
    - name: 'C:\Users\Default\.config\micro\settings.json'
    - require:
      - sls: {{ sls_package_install }}
    - source: {{ files_switch(['settings.json', 'settings.json.jinja'],
                              lookup='Manage Micro Editor Global Default Settings'
                 )
              }}

{%- if micro_editor.config.get('enable_context_menu', True) %}

Register Explorer Context Menu Base:
  reg.present:
    - name: 'HKEY_CLASSES_ROOT\*\shell\Open with Micro'
    - require:
      - sls: {{ sls_package_install }}
    - vdata: 'Open with Micro'

Register Explorer Context Menu Command:
  reg.present:
    - name: 'HKEY_CLASSES_ROOT\*\shell\Open with Micro\command'
    - require:
      - sls: {{ sls_package_install }}
    - vdata: '"{{ binary_path }}" "%1"'

Register Explorer Context Menu Icon:
  reg.present:
    - name: 'HKEY_CLASSES_ROOT\*\shell\Open with Micro'
    - require:
      - sls: {{ sls_package_install }}
    - vdata: '{{ icon_location }},{{ icon_index }}'
    - vname: 'Icon'

{%- endif %}
