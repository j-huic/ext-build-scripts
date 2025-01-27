# ext-build-scipts

1. Change project-specific variables atop each script
2. Maintain two manifests: manifest_chrome.json and manifest_firefox.json
   - manifest.json file may exist for unpacked testing
3. Requires .buildignore file (same format as .gitignore)
4. Requres config.txt for spec variables (see below)

```txt
BASE_NAME="ExtensionName"

IGNORE_FILE=".buildignore"
BUILD_DIR_CHROME="build"
BUILD_DIR_FIREFOX="build_ff"
```
