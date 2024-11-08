# Adobe Uninstall Script

This script uninstalls a specified Adobe product from a macOS system, targeting the product by its name and version. It automatically determines the system architecture and adjusts the platform requirements. This script can be used as a standalone tool or with remote management (in my case Jamf).

## Requirements

- macOS environment
- Sudo permissions (to uninstall applications)

## Usage

### Standalone Usage

1. **Download the Script**

   Save the script to a location on your macOS system, such as `/usr/local/bin/uninstall_adobe.sh`.

2. **Set Permissions**

   Ensure the script is executable:
   ```bash
   chmod +x /path/to/uninstall_adobe.sh
    ```
3. **Run the Script**

    Use the following syntax to run the script:
    ```
    sudo /path/to/uninstall_adobe.sh <app_name> <sap_code>
    ```
    - `<app_name>`: Name of the Adobe application to uninstall (e.g., `Photoshop`, `Illustrator`).
    - `<sap_code>`: SAP code of the Adobe application (e.g., `PHSP` for Photoshop).

    **Example:**
    ```
    sudo /path/to/uninstall_adobe.sh Photoshop PHSP
    ```
4. **Output**

    If the script finds the specified application, it will output a message confirming the uninstallation:
    ```
    Adobe Photoshop with version 26.0 found in folder '/Applications/Adobe Photoshop 2025.app' was deleted.
    ```
    If no matching application is found:
    ```
    No matching folder found for 'Photoshop'.
    ```
## Jamf Integration

To deploy this script with Jamf, follow these steps:

1.    **Upload the Script to Jamf**
    In Jamf, navigate to Scripts and upload the `uninstall_adobe.sh` script.

2. **Create a Policy**
    - Go to **Policies > + New.**
    - In the **Files & Processes** section, add a command to call the script.
    - **Parameters:** Set **Parameter 4** to the Adobe application name (`app_name`) and **Parameter 5** to the Adobe SAP code (`code`).
    - If you want to run it before an installation of an Adobe product in the same Policy, just change **Priority** to `Before`

3. **Execution**
    When the policy runs, it will call the script with the specified application name and SAP code. Jamf will report the output as displayed in the standalone example.

# Notes
- This script targets directories within the `/Applications` folder that match the name format `Adobe <app_name>*.app.`
- For troubleshooting uninstallation failures, check if the application version and path are correctly identified.
- The `HDBox` uninstaller path is hardcoded to Adobe's standard installation path.