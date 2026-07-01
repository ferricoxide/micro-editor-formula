# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}

{#- Extract configuration parameters #}
{%- set install_root = micro_editor.config.get('install_root',
    'C:\\Program Files\\Micro') %}

Remove Micro Editor Installation Directory:
  file.absent:
    - name: '{{ install_root }}'
