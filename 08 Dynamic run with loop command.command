#!/bin/bash

# Always switch to the directory of the script itself
cd "$(dirname "$0")"

# Absolute or relative path to your CSV file
CONFIG_CSV_FILE="07 config.csv"

# Get current datetime (format: YYYYMMDD_HHMMSS)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Define paths
BASE_DIR="/Users/minhanhoa.truong/Project/Jmeter/01 - Jmeter performance test"
REPORT_DIR="${BASE_DIR}/Report"
FILENAME="06 Dynamic run with command"
JMX_PATH="${BASE_DIR}/${FILENAME}.jmx"
RESULT_CSV="${REPORT_DIR}/${FILENAME}_${TIMESTAMP}.csv"
HTML_REPORT="${REPORT_DIR}/HTML_report_${FILENAME}_${TIMESTAMP}"

# Path to your JMX file (optional, add -t flag if needed)
JMX_FILE="06 Dynamic run with command.jmx"

# Change directory to where JMeter is installed (optional)
# cd /path/to/apache-jmeter/bin

# Skip the header and loop
tail -n +2 "${CONFIG_CSV_FILE}" | while IFS=',' read -r threads rampUp loopCount; do
  echo "Running JMeter with: threads=$threads, rampUp=$rampUp, loopCount=$loopCount"
  #jmeter -Jthreads=$threads -JrampUp=$rampUp -JloopCount=$loopCount -n -t "${JMX_FILE}"
  jmeter -Jthreads=$threads -JrampUp=$rampUp -JloopCount=$loopCount -n -t "${JMX_PATH}" -l "${RESULT_CSV}" -e -o "${HTML_REPORT}"
done

echo "All JMeter tests completed."
