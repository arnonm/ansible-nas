#!/usr/bin/env bash

echo "SSL certificates renewed"

cp "{{letsencrypt_dir}}/live/{{ansible_nas_fqdn}}/fullchain.pem" "/etc/cockpit/ws-certs.d/{{ansible_nas_fqdn}}.crt"

cp "{{letsencrypt_dir}}/live/{{ansible_nas_fqdn}}/privkey.pem" "/etc/cockpit/ws-certs.d/{{ansible_nas_fqdn}}.key"

chown cockpit-ws:cockpit-ws "/etc/cockpit/ws-certs.d/{{ansible_nas_fqdn}}.crt" "/etc/cockpit/ws-certs.d/{{ansible_nas_fqdn}}.key"

echo "Restarting Cockpit"
systemctl restart cockpit