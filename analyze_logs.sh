
]#!/bin/bash
LOG_DIR="hospital_data/active_logs"
REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/analysis_report.txt"
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temparature.log)"
echo "3) Water Usage (water_usage.log)"
read -P "Enter choice (1-3): " choice
if [[ "$choice" != "1" && "$choice" != "2" && "$choice" != "3" ]]; then
echo "Invalid choice. Please enter a number between 1 and 3."
exit 1
fi
if [ "$choice" == "1" ]; then
logfile="LOG_DIR/heart_rate'log"
logname="Heart Rate"
elif ["$choice" == "2" ]; then
logfile="$LOG_DIR/temperature.log"
logname="Temperature"
else
logfile="$LOG_DIR/water_usage.log"
logname="Water usage"
fi
if [ ! -f "$logfile" ]; then
echo "Log file $logfile not found!"
exit 2
fi
mkdir -p "$REPORT_DIR"
device_counts=$(awk '{print $2}' "$logfile" | sort | uniq -c)
first_timestamp=$(head -n 1 "$logfile" | awk '{print $1, $2}')
last_timestamp=$(tail -n 1 "$logfile" | awk '{print $1, $2}')
{
echo "=============================="
echo "Analysis for: $logname"
echo "Date: $(date)"
echo "Log file: $logfile"
echo ""
echo "Device Counts:"
echo "$device_counts"
echo ""
echo "First Entry: $first_timestamp"
echo "Last Entry: $last_timestamp"
echo "============================="
echo ""
} >> "$REPORT_FILE"
echo "Analysis completed and saved to $REPORT_FILE"
