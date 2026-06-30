# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}

micro-editor-service-clean-service-dead:
  service.dead:
    - name: {{ micro_editor.service.name }}
    - enable: False
