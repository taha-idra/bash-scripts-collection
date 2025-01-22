#!/bin/bash
# Project: System Monitor
# Description: A tool for monitoring system performance.
# Author: Taha Idra
# Version: 0.1

# This script will use tools like top, vmstat, or free.

monitor_system() {
  echo "System Monitoring (placeholder)"
  echo "CPU Usage:"
  top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}' # Basic CPU usage
  echo "Memory Usage:"
  free -h | grep "Mem" | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4}'
  # Future: Add more detailed metrics and output formatting.
}

monitor_system
