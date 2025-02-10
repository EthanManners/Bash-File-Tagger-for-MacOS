#!/bin/bash

# Path to the folder containing your CR3 files
FOLDER_PATH="/Path/to/CR3/files/"

# Path to the file containing the list of filenames (including the .cr3 extension)
FILE_LIST="/Path/to/list.txt"

# Tag you want to apply to the files
# You must create a tag via Finder with this name
TAG="selected"

# Loop through each line in the text file
while IFS= read -r FILE_NAME; do
  # Clean up the file name by removing carriage returns and any extra spaces
  CLEAN_FILE_NAME=$(echo "$FILE_NAME" | tr -d '\r' | xargs)

  # Print the cleaned-up file name for debugging
  echo "Checking file: '$CLEAN_FILE_NAME'"

  # Construct full path to the CR3 file
  FILE_PATH="$FOLDER_PATH/$CLEAN_FILE_NAME"

  # Check if the file exists
  if [[ -e "$FILE_PATH" ]]; then
    echo "Tagging file: $CLEAN_FILE_NAME"

    # Print the exact file path being used for debugging
    echo "Applying tag to: '$FILE_PATH'"

    # Apply the tag using xattr
    xattr -w com.apple.metadata:_kMDItemUserTags '("selected")' "$FILE_PATH"
    
  else
    echo "File not found: $FILE_PATH"
  fi
done < "$FILE_LIST"

echo "Tagging completed."
