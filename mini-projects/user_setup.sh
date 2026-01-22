#!/bin/bash

# =========================
# Root Pr Chla Bhai
# =========================

echo "Starting user & group setup..."

#GROUPS 
groupadd developers
groupadd testers

#  USERS 
useradd -m -s /bin/bash adminuser
useradd -m -s /bin/bash devuser
useradd -m -s /bin/bash testuser

#  PASSWORDS 
echo "adminuser:admin123" | chpasswd
echo "devuser:dev123" | chpasswd
echo "testuser:test123" | chpasswd

# GROUP ASSIGNMENT
usermod -aG developers devuser
usermod -aG testers testuser

# ADMIN PRIVILEGES 
usermod -aG sudo adminuser

# DIRECTORIES 
mkdir -p /projects/dev
mkdir -p /projects/test

# OWNERSHIP 
chown :developers /projects/dev
chown :testers /projects/test

#  PERMISSIONS
chmod 770 /projects/dev      #  developers
chmod 750 /projects/test     # tester only  read & execute

# ADMIN AUDIT CAPABILITIES
# Allow admin to view logs
usermod -aG adm adminuser

#  LOGIN TRACKING INFO 
echo "-----------------------------------"
echo "ADMIN COMMANDS FOR USER MONITORING"
echo "-----------------------------------"
echo "Check currently logged-in users:"
echo "  who"
echo ""
echo "Check last login history:"
echo "  last"
echo ""
echo "Check login history of a specific user:"
echo "  last devuser"
echo ""
echo "Check failed login attempts:"
echo "  sudo cat /var/log/auth.log"
echo ""
echo "Check user details:"
echo "  id devuser"
echo "  groups devuser"
echo "-----------------------------------"

echo "Setup complete."

