#!/bin/bash

# Colors 
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"
BOLD="\e[1m"

clear

USER_NAME=$(whoami)
HOSTNAME=$(hostname)
DATE_TIME=$(date "+%A, %d %B %Y | %I:%M:%S %p")

echo -e "${BOLD}${CYAN}"
echo "╔══════════════════════════════════════════════════╗"
echo "║            🚀 SYSTEM MONITOR DASHBOARD           ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "${RESET}"

# Welcome
echo -e "${GREEN}👋 Welcome, ${BOLD}$USER_NAME${RESET}${GREEN} on ${BOLD}$HOSTNAME${RESET}"
echo -e "${YELLOW}🕒 Date & Time : $DATE_TIME${RESET}"
echo

# Uptime
echo -e "${BLUE}⏱️  System Uptime:${RESET}"
uptime -p
echo

# Last Logins
echo -e "${BLUE}🔐 Last Logged-in Users:${RESET}"
last -a | head -5
echo

# Disk Usage
echo -e "${BLUE}💽 Disk Usage:${RESET}"
df -h | grep -E "^Filesystem|^/dev"
echo

# Memory Usage
echo -e "${BLUE}🧠 RAM Utilization:${RESET}"
free -h
echo

# CPU Load
echo -e "${BLUE}🔥 CPU Load Average:${RESET}"
cat /proc/loadavg | awk '{print "1 min:",$1,"| 5 min:",$2,"| 15 min:",$3}'
echo

# Top CPU Processes
echo -e "${RED}🚨 Top 5 CPU Consuming Processes:${RESET}"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -6
echo

# Network Info
echo -e "${BLUE}🌐 Network Info:${RESET}"
ip -brief address
echo

# Logged-in Users Count
echo -e "${GREEN}👥 Currently Logged-in Users:${RESET}"
who | wc -l
echo

# System Load Bar (fun but useful)
LOAD=$(uptime | awk -F'load average:' '{print $2}')
echo -e "${CYAN}📊 Load Average:$LOAD${RESET}"
echo

echo -e "${BOLD}${GREEN}✅ System health check completed successfully.${RESET}"
echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
