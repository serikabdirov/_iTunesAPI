#!/bin/zsh

# Get path of current executable script
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";
# Get path to ICC Profile, computing based on SCRIPT_PATH
ICC_PROFILE_PATH="$SCRIPT_PATH/Display P3.icc";

# Get current changed files in git: changed files (staged and unstaged) + new untracked files
CHANGED_FILES_STRING=$({ git diff HEAD --name-only --diff-filter=MA; git ls-files --others --exclude-standard; });
# Split CHANGED_FILES_STRING to create array of file paths
FILES=("${(@f)CHANGED_FILES_STRING}");

for FILE in $FILES; do
    # Check if file is PNG image
    if [[ $FILE == *.png ]]; then
        # Get current image ICC Profile information
        PROFILE=$(sips -g profile $FILE);
        # Check if current ICC Profile is NOT Display P3
        if ! [[ "$PROFILE" =~ .*"Display P3".* ]]; then
            echo $PROFILE;
            # Set new Display P3 ICC Profile to image using ICC_PROFILE_PATH
            sips -e $ICC_PROFILE_PATH "$FILE" --out "$FILE" > /dev/null;
        fi
    fi
done
