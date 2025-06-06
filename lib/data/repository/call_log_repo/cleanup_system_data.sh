#!/bin/bash

echo "🧹 Cleaning up system junk and reclaiming space..."

# Ask for password once
sudo -v

# 1. Delete system and user cache files
echo "🗑️  Deleting system and user caches..."
sudo rm -rf ~/Library/Caches/*
sudo rm -rf /Library/Caches/*

# 2. Clear logs
echo "🧾 Clearing log files..."
sudo rm -rf /private/var/log/*
sudo rm -rf ~/Library/Logs/*

# 3. Delete local Time Machine snapshots
echo "⏳ Deleting local Time Machine snapshots..."
snapshots=$(tmutil listlocalsnapshots / | grep com.apple.TimeMachine)
for snapshot in $snapshots; do
  sudo tmutil deletelocalsnapshots ${snapshot:33}
done

# 4. Clean up iOS backups
echo "📱 Removing iOS device backups..."
rm -rf ~/Library/Application\ Support/MobileSync/Backup/*

# 5. Clean Xcode derived data and old archives
if [ -d "~/Library/Developer/Xcode" ]; then
  echo "🧪 Cleaning Xcode derived data and archives..."
  rm -rf ~/Library/Developer/Xcode/DerivedData/*
  rm -rf ~/Library/Developer/Xcode/Archives/*
fi

# 6. Remove old .dmg files in Downloads
echo "📦 Removing old .dmg files from Downloads..."
find ~/Downloads -name "*.dmg" -delete

# 7. Empty Trash
echo "🗑️  Emptying Trash..."
rm -rf ~/.Trash/*

echo "✅ Done! You may want to restart your Mac to see updated storage usage."

# commands to run this script:
# chmod +x cleanup_system_data.sh
# ./cleanup_system_data.sh
# Note: This script requires sudo privileges to delete system files.
# Make sure to review the commands before running, as they will permanently delete files.
# Always back up important data before running cleanup scripts.
# This script is intended for macOS systems.
# It is recommended to run this script periodically to keep your system clean and optimized.
# Disclaimer: Use this script at your own risk. The author is not responsible for any data loss or system issues that may occur.
# Ensure you have a backup of important data before running this script.
# This script is designed to help reclaim disk space by cleaning up various system and user data.
# It is not intended to fix system issues or errors.
# If you encounter any issues, please consult with a professional or refer to official documentation.
# This script is provided as-is and may not work on all macOS versions.
# Always test scripts in a safe environment before deploying them on production systems.
# For more information, refer to the official Apple documentation on system maintenance and cleanup.
# This script is a simple utility to help users maintain their macOS systems by cleaning up unnecessary files.
# It is not a comprehensive solution and may not cover all aspects of system maintenance.
# Use it as a starting point for your own cleanup routines.
# Remember to keep your system updated and regularly check for software updates.
# This script is intended for personal use and may not be suitable for all users.