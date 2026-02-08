FROM node:22-slim

WORKDIR /app

# Install OpenClaw globally
RUN npm install -g openclaw

# Create openclaw user and directories
RUN useradd -m -s /bin/bash openclaw && \
    mkdir -p /home/openclaw/.openclaw && \
    chown -R openclaw:openclaw /home/openclaw

USER openclaw
WORKDIR /home/openclaw

# Copy configuration
COPY --chown=openclaw:openclaw config/ /home/openclaw/.openclaw/

# Expose ports
EXPOSE 18789 3978

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:18789/__openclaw__/health || exit 1

# Start OpenClaw gateway
CMD ["openclaw", "gateway", "start", "--foreground"]
