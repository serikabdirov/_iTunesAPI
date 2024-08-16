export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint > /dev/null; then
    count=0
    for file_path in $(git ls-files --others --exclude-standard | grep ".swift$"); do
        export SCRIPT_INPUT_FILE_$count=$file_path
        count=$((count + 1))
    done
    for file_path in $(git diff HEAD --name-only --diff-filter=MA | grep ".swift$"); do
        export SCRIPT_INPUT_FILE_$count=$file_path
        count=$((count + 1))
    done
        export SCRIPT_INPUT_FILE_COUNT=$count
        swiftlint lint --use-script-input-files --force-exclude
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint";
    exit 1;
fi
