
```markdown
# POP Devnet Setup

This repository contains scripts and instructions to set up a Pipe POP Node on your server.

## Prerequisites

- A Linux-based server (Ubuntu 20.04 recommended)
- Root access or sudo privileges
- Minimum hardware requirements:
  - RAM: 8 GB
  - Disk: 100 GB

## Installation

1. Clone this repository to your server:

   ```bash
   git clone https://github.com/brillianesa/pop-devnet.git
   ```

2. Navigate to the repository directory:

   ```bash
   cd pop-devnet
   ```

3. Make the setup script executable:

   ```bash
   chmod +x pipe-setup.sh
   ```

4. Run the setup script with the required arguments:

   ```bash
   ./pipe-setup.sh "Link bin dari email" "Jumlah RAM" "Jumlah Disk" "Public Key"
   ```

   Example:

   ```bash
   ./pipe-setup.sh "https://example.com/pop" 8 100 "BgycUI/ZSFxeFvBhA5ymahe383A6dsdw22422scXVYzd"
   ```

## Script Details

The `pipe-setup.sh` script performs the following tasks:

- Downloads the POP binary from the provided link.
- Sets up the systemd service for the POP node.
- Configures the node with the specified RAM, disk space, and public key.
- Starts and enables the service to run on boot.

## Verifying the Setup

After running the script, you can check the status of the service:

```bash
sudo systemctl status pipe-pop.service
```

To view the logs, use:

```bash
journalctl -u pipe-pop.service -b
```

## Troubleshooting

If the service fails to start, check the following:

- Ensure the binary has execute permissions:
  ```bash
  chmod +x /root/pipenetwork/pop
  ```
- Verify the systemd service file is correctly configured:
  ```bash
  sudo nano /etc/systemd/system/pipe-pop.service
  ```
- Check for missing dependencies using:
  ```bash
  ldd /root/pipenetwork/pop
  ```

## Contributing

If you encounter any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
