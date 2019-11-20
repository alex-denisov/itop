#!/bin/bash
chmod -f 644 /etc/itop/production/config-itop.php
chown www-data: /etc/itop/production/config-itop.php
echo "iTop config is writable now. Start update wizard http://localhost/setup in your browser."
