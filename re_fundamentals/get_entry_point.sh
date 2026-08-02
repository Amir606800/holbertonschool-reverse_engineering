#!/bin/bash

# Check if a file name was provided
if [ $# -ne 1 ]; then
    echo "Error: Please provide an ELF file."
    exit 1
fi

file_name="$1"

# Check if the file exists
if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

# Check if the file is an ELF file
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: '$file_name' is not an ELF file."
    exit 1
fi

# Extract ELF header information
magic_number=$(readelf -h "$file_name" | grep "Magic:" | sed 's/^[[:space:]]*Magic:[[:space:]]*//')
class=$(readelf -h "$file_name" | grep "Class:" | sed 's/^[[:space:]]*Class:[[:space:]]*//')
byte_order=$(readelf -h "$file_name" | grep "Data:" | sed 's/^[[:space:]]*Data:[[:space:]]*//')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | sed 's/^[[:space:]]*Entry point address:[[:space:]]*//')

# Load display function
source ./messages.sh

# Display the information
display_elf_header_info
