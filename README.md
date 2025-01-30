
# POP Devnet Setup

This repository contains scripts and instructions to set up a Pipe POP Node on your server in one go.

## Prerequisites

- A Linux-based server (Ubuntu 20.04 recommended)
- Root access or sudo privileges
- Minimum hardware requirements:
  - RAM: 8 GB
  - Disk: 100 GB

## One-Command Installation

Run the following command to clone the repository, set up the environment, and configure the POP node:

```bash
git clone https://github.com/brillianesa/pop-devnet.git ; \
cd pop-devnet ; \
chmod +x pipe-setup.sh ; \
./pipe-setup.sh "Link bin dari email" "Jumlah RAM" "Jumlah Disk" "Public Key"
```

### Example

```bash
git clone https://github.com/brillianesa/pop-devnet.git ; \
cd pop-devnet ; \
chmod +x pipe-setup.sh ; \
./pipe-setup.sh "https://example.com/pop" "8" "100" "BgycUI/ZSFxeFvBhA2323ymahe383A62vuFRMcZHscXVYzd"
```

## What the Script Does

The `pipe-setup.sh` script performs the following tasks:

1. **Downloads the POP binary** from the provided link.
2. **Sets up the systemd service** for the POP node.
3. **Configures the node** with the specified RAM, disk space, and public key.
4. **Starts and enables the service** to run on boot.

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


