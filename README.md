# tools
Ansible  - Copy Nginx dirs of 'vhost.d' and etc.

# requirements

Install 'rsync' on the Ansible workstation

Add: 'StrictHostKeyChecking=accept-new' to your ssh config

Add your SSH public key to root@localhost:
```bash
ssh-keygen
ssh-copy-id root@localhost
```
