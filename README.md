# Pi-hole

Docker Compose setup for running [Pi-hole](https://pi-hole.net/) as a network-wide ad blocker.

## Quick Start

```bash
cp .env.example .env
# Edit .env — set WEBPASSWORD and FTLCONF_LOCAL_IPV4 to your server's IP
docker compose up -d
```

The admin dashboard will be available at `http://<your-server-ip>:8089/admin`.

> **Note:** This uses `network_mode: host` so Pi-hole binds directly to the host network,
> avoiding port conflicts with existing DNS services. The web UI defaults to port 8089
> to avoid conflicts with port 80. Change `WEB_PORT` in `.env` if needed.

## Configuration

| File | Purpose |
|------|---------|
| `.env` | Timezone, web password, local IP |
| `config/custom.list` | Local DNS records (e.g., `192.168.1.10 nas.local`) |
| `config/adlists.list` | Ad/tracker blocklists for gravity |

## Updating

```bash
docker compose pull
docker compose up -d
```

## Updating Gravity (blocklists)

After editing `config/adlists.list`:

```bash
docker exec pihole pihole -g
```
