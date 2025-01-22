#!/bin/bash
# Project: ShellExplorer
# Description: A tool for browsing the Internet through the terminal.
# Author: Taha Idra
# Version: 0.1

fetch_webpage() {
  url="$1"
  if [[ -z "$url" ]]; then
    echo "Please provide a URL."
    return 1
  fi
  if ! [[ "$url" =~ ^(http|https):// ]]; then
      url="https://$url"
  fi
  curl -s "$url" | head -n 20 # Fetch and display the first 20 lines
}

read -p "Enter URL: " user_url
fetch_webpage "$user_url"
