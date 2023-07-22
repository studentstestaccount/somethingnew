Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a message box with "Hello, World!" message
[System.Windows.Forms.MessageBox]::Show("Hello, World!", "PowerShell Alert", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

