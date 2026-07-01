# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as micro_editor with context %}

include:
{%- if grains.kernel == "Linux" %}
  - micro-editor.package.lin_install
{%- elif grains.kernel == "Windows" %}
  - micro-editor.package.win_install
{%- endif %}

Avoid being a null-router (package/install) - Micro Editor:
  test.nop: []
