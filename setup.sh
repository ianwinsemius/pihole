#!/usr/bin/env bash
set -euo pipefail

# Disable systemd-resolved stub listener so Pi-hole can bind to port 53.
# This is the most common cause of port 53 conflicts on Ubuntu/Debian.

echo "==> Disabling systemd-resolved stub listener..."

# Tell resolved to stop listening on 53
sudo mkdir -p /etc/systemd/resolved.conf.d
sudo tee /etc/systemd/resolved.conf.d/no-stub.conf > /dev/null <<EOF
[Resolve]
DNSStubListener=no
EOF

# Point /etc/resolv.conf to the real resolved config (not the stub)
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

echo "==> Restarting systemd-resolved..."
sudo systemctl restart systemd-resolved

echo "==> Done. Port 53 should now be free."
echo "    Run 'docker compose up -d' to start Pi-hole."
