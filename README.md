# ext-build-scripts

1. Declare 4 key variables within config.txt (see below)
2. Maintain two manifests: manifest_chrome.json and manifest_firefox.json
   - manifest.json file may exist for unpacked testing
3. Requires .buildignore file (same format as .gitignore)

## Example config.txt file

```txt
BASE_NAME="ExtensionName"

IGNORE_FILE=".buildignore"
BUILD_DIR_CHROME="build"
BUILD_DIR_FIREFOX="build_ff"
```
