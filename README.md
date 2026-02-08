# OpenClaw Hetzner Deployment

Deploy OpenClaw as a self-hosted instance on Hetzner (or any VPS).

## Prerequisites

- Docker and Docker Compose installed on your server
- A domain pointing to your server (for HTTPS)
- API keys for your AI provider (OpenAI, etc.)

## Quick Start

1. **Clone this repository on your server:**
   ```bash
   git clone https://github.com/jondoesflow/openclawhertner.git
   cd openclawhertner
   ```

2. **Create your environment file:**
   ```bash
   cp .env.example .env
   nano .env
   ```
   
   Fill in your credentials:
   - `OPENAI_API_KEY` - Your OpenAI API key
   - `TELEGRAM_BOT_TOKEN` - Your Telegram bot token (from @BotFather)
   - `MSTEAMS_APP_ID` - Azure Bot App ID
   - `MSTEAMS_APP_PASSWORD` - Azure Bot secret
   - `MSTEAMS_TENANT_ID` - Azure tenant ID

3. **Configure Caddy (for HTTPS):**
   ```bash
   nano Caddyfile
   ```
   
   Replace `your-domain.com` with your actual domain and update the email.

4. **Start the services:**
   ```bash
   docker-compose up -d
   ```

5. **Check logs:**
   ```bash
   docker-compose logs -f openclaw
   ```

## Configuration

Edit `config/openclaw.json` to customize:
- Channel settings (Telegram, MS Teams)
- Agent model preferences
- Gateway settings

## Ports

- `80/443` - Caddy reverse proxy (HTTPS)
- `18789` - OpenClaw WebSocket/API (internal)
- `3978` - MS Teams webhook (internal)

## Updating Azure Bot Endpoint

After deployment, update your Azure Bot messaging endpoint to:
```
https://your-domain.com/api/messages
```

## Updating

```bash
docker-compose pull
docker-compose up -d --build
```

## Troubleshooting

View logs:
```bash
docker-compose logs openclaw
```

Restart services:
```bash
docker-compose restart
```
