#!/bin/bash

# Input Variables
POP_BINARY_URL="$1"
RAM="$2"
MAX_DISK="$3"
PUBLIC_KEY="$4"
REFERRAL_ROUTE="3b4cb3807e27668f"

# Directories
PIPE_DIR="/root/pipenetwork"
CACHE_DIR="$PIPE_DIR/download_cache"
SERVICE_FILE="/etc/systemd/system/pipe-pop.service"

# Create directories
mkdir -p "$PIPE_DIR"
mkdir -p "$CACHE_DIR"
cd "$PIPE_DIR"

# Download pop binary
wget -O pop "$POP_BINARY_URL"
chmod +x pop

# Create systemd service file
echo "[Unit]
Description=Pipe POP Node Service
After=network.target
Wants=network-online.target

[Service]
User=root
Group=root
WorkingDirectory=$PIPE_DIR
ExecStart=$PIPE_DIR/pop \\
    --ram $RAM \\
    --max-disk $MAX_DISK \\
    --cache-dir $CACHE_DIR \\
    --pubKey $PUBLIC_KEY \\
    --signup-by-referral-route $REFERRAL_ROUTE
Restart=always
RestartSec=5
LimitNOFILE=65536
LimitNPROC=4096
StandardOutput=journal
StandardError=journal
SyslogIdentifier=dcdn-node

[Install]
WantedBy=multi-user.target" | tee "$SERVICE_FILE"

# Reload systemd and enable service
sudo systemctl daemon-reload
sudo systemctl enable pipe-pop
sudo systemctl start pipe-pop

# Verify the service
sudo systemctl status pipe-pop --no-pager
