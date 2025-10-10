#!/bin/bash

BASE_DIR="hospital_data"
ACTIVE_DIR="$BASE_DIR/active_logs"

declare -A LOG_FILES=(
    [1]="heart_rate_log.log"
    [2]="temperature_log.log"
    [3]="water_usage_log.log"
)
declare -A ARCHIVE_DIRS=(
    [1]="$BASE_DIR/heart_data_archive"
    [2]="$BASE_DIR/temp_data_archive"
    [3]="$BASE_DIR/water_data_archive"
)

error_exit() {
    echo " ERROR: $1" >&2
    exit 1
}

echo "--- Starting up Group 15 Log Archiver ---"

for dir in "${ARCHIVE_DIRS[@]}"; do
    [ -d "$dir" ] || mkdir -p "$dir" || error_exit "Failed to create 
archive directory: $dir"
done

echo "Select log to archive:"
echo "1) Heart Rate (${LOG_FILES[1]})"
echo "2) Temperature (${LOG_FILES[2]})"
echo "3) Water Usage (${LOG_FILES[3]})"

read -r -p "Enter choice (1-3): " choice

if ! [[ "$choice" =~ ^[1-3]$ ]]; then
    error_exit "Invalid choice: '$choice'. Must be 1 or 2 or or 3."
fi

INDEX="$choice"
ACTIVE_LOG="${LOG_FILES[$INDEX]}"        
ARCHIVE_DIR="${ARCHIVE_DIRS[$INDEX]}"    
FULL_ACTIVE_PATH="$ACTIVE_DIR/$ACTIVE_LOG" 

echo ""
echo "Archiving ${ACTIVE_LOG}..."

if [ ! -f "$FULL_ACTIVE_PATH" ]; then
    error_exit "Active log file not found: $FULL_ACTIVE_PATH. Is the 
simulator running?"
fi

TIMESTAMP=$(date +%Y-%m-%d_%H:%M:%S)

ARCHIVED_FILENAME="${ACTIVE_LOG%.log}_${TIMESTAMP}.log" 
FULL_ARCHIVED_PATH="$ARCHIVE_DIR/$ARCHIVED_FILENAME"

if mv "$FULL_ACTIVE_PATH" "$FULL_ARCHIVED_PATH"; then
    echo "SUCCESS: Archived to ${ARCHIVE_DIR##*/}/${ARCHIVED_FILENAME}"
    
    if touch "$FULL_ACTIVE_PATH"; then
        echo "SUCCESS: Created new empty log file for monitoring: 
$FULL_ACTIVE_PATH"
    else
        error_exit "Failed to create new empty log file. Check 
permissions."
    fi
else
    error_exit "Failed to move log file. Check file system permissions."
fi

echo "--- Archival complete ---"
