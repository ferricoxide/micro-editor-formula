# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}

include:
{%- if grains.kernel == "Linux" %}
  - micro-editor.package.lin_clean
{%- elif grains.kernel == "Windows" %}
  - micro-editor.package.win_clean
{%- endif %}

Avoid being a null-router (package/clean) - Micro Editor:
  test.nop: []
