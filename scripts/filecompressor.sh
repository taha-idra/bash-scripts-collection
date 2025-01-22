#!/bin/bash
# Project: File Compressor
# Description: A tool to compress files and folders efficiently.
# Author: Taha Idra
# Version: 0.1

compress_files() {
  source_path="$1"
  output_file="$2"

  if [[ -z "$source_path" || -z "$output_file" ]]; then
    echo "Usage: compress_files <source_path> <output_file>"
    return 1
  fi
  echo "Compressing $source_path to $output_file (placeholder)"
  # Example using tar and gzip: tar -czvf "$output_file" "$source_path"
}

read -p "Enter path to file/folder to compress: " source_path
read -p "Enter output file name (e.g., archive.tar.gz): " output_file
compress_files "$source_path" "$output_file"
