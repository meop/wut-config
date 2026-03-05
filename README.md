# wut-config

Configuration files for Web Update Tool (wut) — package definitions, dotfile mappings, and custom scripts.

Companion repository to the main [wut](../wut) project.

## Setup

After cloning and configuring the wut server, run these initialization commands on the client:

```bash
# Sync packages
wut p s

# Add required CLI tools
wut p a -g cli

# (Linux only) Install Nushell if not available
wut s e i nu

# Sync dotfiles
wut f s
```

You may need to reopen your terminal between commands for environment changes to take effect.
