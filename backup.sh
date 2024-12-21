#!/bin/bash
#Owner: Arpit Jain
#Date: Sat Dec 21 06:22:32 PM IST 2024
#Version: 1.0.0

INPUT=$1
SEARCHFILE=$(find / -type f -name "$INPUT" 2>/dev/null)
SEARCHFOLDER=$(find / -type d -name "$INPUT" 2>/dev/null)

zip_file_or_folder() {
    TARGET=$1
    if [ -f "$TARGET" ]; then
        echo "Zipping file: $TARGET"
        zip "$(basename "$TARGET").zip" "$TARGET"
    elif [ -d "$TARGET" ]; then
        echo "Zipping folder: $TARGET"
        zip -r "$(basename "$TARGET").zip" "$TARGET"
    else
        echo "Error: $TARGET is not valid for zipping."
    fi
}


redirect() {
        DESTINATION=$1
        if [ -d "$DESTINATION" ]; then
                echo "Changing to directory: $DESTINATION"
		sleep 2
                 cd "$DESTINATION" || exit
		 read -p "Do you want to zip the contents of this directory? (y/n): " zip_choice
	         if [[ $zip_choice == "y" || $zip_choice == "Y" ]]; then
         		   echo "Zipping the contents of the directory..."
           		   zip_file_or_folder "$DESTINATION"
       		 else
           		   echo "Skipping zipping."
       		 fi
        else
                echo "Error: $DESTINATION is not a valid directory."
         fi
}

if [ -n "$INPUT" ]
then
  echo "$INPUT is a file."
  echo "$SEARCHFILE"
  FILE_DIR=$(dirname "$SEARCHFILE")
  redirect "$FILE_DIR"
elif [ -n "$SEARCHFOLDER" ]; then
  echo "$INPUT is a directory."
  echo "$SEARCHFOLDER"
  redirect "$SEARCHFOLDER"
else
  echo "$INPUT does not exist as a file or directory."
fi

current_directory=$(pwd)
echo "The current working directory is: $current_directory"
