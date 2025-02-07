#!/bin/bash
echo "Searching for node_info.json files..."
echo "----------------------------------------"

# Find all node_info.json files and store details in a temporary file
sudo find / -name node_info.json -type f -exec stat --format="%Z %n" {} \; 2>/dev/null | sort -n > /tmp/node_files.txt

if [ ! -s /tmp/node_files.txt ]; then
    echo "No node_info.json files found on the system."
    rm /tmp/node_files.txt
    exit 0
fi

echo "Found node_info.json files (sorted by change time):"
echo "----------------------------------------"

# Read and format the output
while read timestamp filepath; do
    # Convert timestamp to human readable date
    date_str=$(date -d @"$timestamp" "+%Y-%m-%d %H:%M:%S")
    # Get file size
    size=$(sudo du -h "$filepath" | cut -f1)
    # Check if file is being used by a running process
    if sudo lsof "$filepath" >/dev/null 2>&1; then
        status="ACTIVE - Currently in use by running process"
    else
        status="inactive"
    fi
    
    echo "File: $filepath"
    echo "Created: $date_str"
    echo "Size: $size"
    echo "Status: $status"
    echo "----------------------------------------"
done < /tmp/node_files.txt

# Clean up
rm /tmp/node_files.txt

echo "The OLDEST node_info.json file is likely the original registered one."
echo "If you're experiencing registration issues:"
echo "1. Stop any running pop processes"
echo "2. Ensure your pop service or command uses the oldest node_info.json"
echo "3. Consider removing newer duplicate files after backing them up"
echo ""
echo "To prevent future duplicates:"
echo "- Always run pop commands from the directory containing your original node_info.json"
echo "- Or use the 'pop' alias if you've set up the service using the installation script"
