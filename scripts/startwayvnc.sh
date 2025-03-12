#!bin/bash
pkill wayvnc
swaymsg create_output

# Get the list of output names containing "HEADLESS", ignoring the first one
headless_outputs=$(swaymsg -t get_outputs | jq -r '.[].name' | grep HEADLESS | tail -n +2)

# Loop through the outputs (starting from the second one)
for i in $headless_outputs; do
    swaymsg output "$i" unplug
done

swaymsg -t get_outputs
swaymsg output "HEADLESS-1" resolution 1600x720
nohup wayvnc -o HEADLESS-1 &

