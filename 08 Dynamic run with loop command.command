#!/bin/bash

cd "$(dirname "$0")"

CONFIG_CSV_FILE="07 config.csv"
BASE_DIR="/Users/minhanhoa.truong/Project/Jmeter/01 - Jmeter performance test"
PARENT_TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_DIR="${BASE_DIR}/HTML_Report/${PARENT_TIMESTAMP}"
FILENAME="06 Dynamic run with command"
JMX_PATH="${BASE_DIR}/${FILENAME}.jmx"

mkdir -p "$REPORT_DIR"

# Determine delimiter: try tab first
DELIM=$'\t'
first_line=$(head -n 1 "$CONFIG_CSV_FILE")
if [[ "$first_line" != *$'\t'* ]]; then
  DELIM=','  # fallback to comma if no tab found
fi

# Skip the header and process each row
{
  read -r _ # skip header
  counter=1  # ✅ Start from 01

  while IFS="$DELIM" read -r testType threads rampUp loopCount || [[ -n "$testType" ]]; do
    # Trim whitespace
    testType=$(echo "$testType" | xargs)
    threads=$(echo "$threads" | xargs)
    rampUp=$(echo "$rampUp" | xargs)
    loopCount=$(echo "$loopCount" | xargs)

    # Skip empty or malformed rows
    if [[ -z "$testType" || -z "$threads" || -z "$rampUp" || -z "$loopCount" ]]; then
      continue
    fi

    # Format counter as two digits: 01, 02, etc.
    index=$(printf "%02d" "$counter")

    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    RESULT_CSV="${REPORT_DIR}/Scenario_${index}_${testType}_${TIMESTAMP}.csv"
    HTML_REPORT="${REPORT_DIR}/Scenario_${index}_${testType}_${TIMESTAMP}"

    echo "▶️  Running JMeter: $testType (threads=$threads, rampUp=$rampUp, loopCount=$loopCount)"
    jmeter -n -t "$JMX_PATH" \
           -Jthreads="$threads" \
           -JrampUp="$rampUp" \
           -JloopCount="$loopCount" \
           -l "$RESULT_CSV" \
           -e -o "$HTML_REPORT"

    echo "✅ Report saved to: $HTML_REPORT"
    ((counter++))
  done
} < "$CONFIG_CSV_FILE"

echo "🎉 All JMeter test runs completed."
