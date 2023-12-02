
#!/bin/bash

# Update the package lists for upgrades and new package installations
sudo apt-get update

# Install Apache
sudo apt-get install -y apache2

# Navigate to the Apache root directory
cd /var/www/html

# Create a custom home page
echo "Hello World, This is My Apache Server" >> index.html

# Restart the Apache service to reflect the changes
sudo systemctl restart apache2
