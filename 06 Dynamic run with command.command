#!/bin/bash

# Get current datetime (format: YYYYMMDD_HHMMSS)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Define paths
BASE_DIR="/Users/minhanhoa.truong/Project/Jmeter/01 - Jmeter performance test"
REPORT_DIR="${BASE_DIR}/Report"
FILENAME="06 Dynamic run with command"
JMX_PATH="${BASE_DIR}/${FILENAME}.jmx"
RESULT_CSV="${REPORT_DIR}/${FILENAME}_${TIMESTAMP}.csv"
HTML_REPORT="${REPORT_DIR}/HTML_report_${FILENAME}_${TIMESTAMP}"

# Create Report directory if it doesn't exist
mkdir -p "$REPORT_DIR"

# Run JMeter
echo "🟡 Running JMeter test at ${TIMESTAMP}..."
jmeter -Jthreads=10 -JrampUp=10 -JloopCount=3 -n -t "${JMX_PATH}" -l "${RESULT_CSV}" -e -o "${HTML_REPORT}"

# Open the HTML report in default browser
REPORT_INDEX="${HTML_REPORT}/index.html"
if [ -f "${REPORT_INDEX}" ]; then
    echo "🟢 Opening HTML report in browser..."
    open "${REPORT_INDEX}"
else
    echo "🔴 Report index file not found at ${REPORT_INDEX}"
fi

echo "✅ Done. Results saved to:"
echo "- CSV: ${RESULT_CSV}"
echo "- HTML: ${HTML_REPORT}"

read -p "Press Enter to close this window..."
