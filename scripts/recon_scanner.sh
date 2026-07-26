#!/bin/bash
# ==============================================================================
# Skillentrix Technologies - Cyber Security Minor Project
# Automated Network Reconnaissance & Enumeration Script
# Target Subnet: 192.168.56.0/24 | Target Host: 192.168.56.101
# ==============================================================================

SUBNET="192.168.56.0/24"
TARGET="192.168.56.101"
OUTPUT_DIR="../scans"

mkdir -p "$OUTPUT_DIR"

echo "======================================================"
echo "[+] Step 1: Performing Host Discovery via Netdiscover"
echo "======================================================"
sudo netdiscover -r "$SUBNET" -P | tee "$OUTPUT_DIR/netdiscover_scan.txt"

echo -e "\n======================================================"
echo "[+] Step 2: Confirming Host Discovery via Nmap Ping Sweep"
echo "======================================================"
nmap -sn "$SUBNET" | tee -a "$OUTPUT_DIR/nmap_ping_sweep.txt"

echo -e "\n======================================================"
echo "[+] Step 3: Full TCP Port Scan on Target ($TARGET)"
echo "======================================================"
nmap -p- -T4 "$TARGET" -oN "$OUTPUT_DIR/nmap_full_ports.txt"

echo -e "\n======================================================"
echo "[+] Step 4: Service Version & Default Script Scanning"
echo "======================================================"
nmap -sV -sC -p21,22,23,25,80,139,445,3306,5432,8180 "$TARGET" -oN "$OUTPUT_DIR/nmap_service_detection.txt"

echo -e "\n======================================================"
echo "[+] Step 5: OS Fingerprinting"
echo "======================================================"
sudo nmap -O "$TARGET" -oN "$OUTPUT_DIR/nmap_os_detection.txt"

echo -e "\n======================================================"
echo "[+] Reconnaissance Complete. Results saved to $OUTPUT_DIR"
echo "======================================================"
