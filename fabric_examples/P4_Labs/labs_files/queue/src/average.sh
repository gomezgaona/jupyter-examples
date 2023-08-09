#!/bin/bash
  
# Initialize variables
count=0
sum=0
samples=()

# Read from stdin and calculate averages every 1000 samples
while read -r value; do
  samples+=("$value")
  ((count++))

  # Calculate the sum
  ((sum += value))

  # Check if we've reached 1000 samples
  if ((count == 1000)); then
    # Calculate the average and print it
    average=$(bc <<< "scale=2; $sum / $count")
    echo "$average us"

    # Reset variables for the next batch of samples
    count=0
    sum=0
    samples=()
  fi
done

# Calculate the average for the remaining samples (if any)
if ((count > 0)); then
  average=$(bc <<< "scale=2; $sum / $count")
  echo "$average us"
fi