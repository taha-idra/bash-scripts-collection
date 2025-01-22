#!/bin/bash
# Project: Geo Calculator
# Description: A tool for calculating areas and dimensions of geometric shapes.
# Author: Taha Idra
# Version: 0.1


calculate_circle_area() {
  radius="$1"
  if ! [[ "$radius" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Invalid radius. Please enter a number."
    return 1
  fi
  area=$(echo "3.14159 * $radius * $radius" | bc -l)
  echo "Area of the circle: $area"
}

read -p "Enter the radius of the circle: " circle_radius
calculate_circle_area "$circle_radius"
