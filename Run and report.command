#!/bin/bash

# Get current datetime (format: YYYYMMDD_HHMMSS)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Define paths
BASE_DIR="/Users/minhanhoa.truong/Project/Jmeter/01 - Jmeter performance test"
JMX_PATH="$BASE_DIR/05 Data driven.jmx"
RESULT_CSV="$BASE_DIR/05_Data_driven_result_$TIMESTAMP.csv"
HTML_REPORT="$BASE_DIR/HTML_report_$TIMESTAMP"

# Run JMeter
echo "🟡 Running JMeter test at $TIMESTAMP..."
jmeter -n -t "$JMX_PATH" -l "$RESULT_CSV" -e -o "$HTML_REPORT"

# Open the HTML report in default browser
REPORT_INDEX="$HTML_REPORT/index.html"
if [ -f "$REPORT_INDEX" ]; then
    echo "🟢 Opening HTML report in browser..."
    open "$REPORT_INDEX"
else
    echo "🔴 Report index file not found at $REPORT_INDEX"
fi

echo "✅ Done. Results saved to:"
echo "- CSV: $RESULT_CSV"
echo "- HTML: $HTML_REPORT"

read -p "Press Enter to close this window..."
