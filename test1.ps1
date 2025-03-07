# Prompt user for directory path
$directoryPath = Read-Host "Enter the directory path to scan for text files"

# Check if the directory exists
if (Test-Path -Path $directoryPath) {
    # Get a list of all .txt files in the directory
    $txtFiles = Get-ChildItem -Path $directoryPath -Filter "*.txt"

    # If no text files are found
    if ($txtFiles.Count -eq 0) {
        Write-Host "No text files found in the directory."
    } else {
        # Display a list of text files with numbers
        Write-Host "Text files found:"
        for ($i = 0; $i -lt $txtFiles.Count; $i++) {
            Write-Host "$($i + 1). $($txtFiles[$i].Name)"
        }

        # Prompt user to select a file by number
        $fileNumber = Read-Host "Enter the number of the file to read"

        # Validate the user input
        if ($fileNumber -gt 0 -and $fileNumber -le $txtFiles.Count) {
            $selectedFile = $txtFiles[$fileNumber - 1]
            Write-Host "`nDisplaying content of $($selectedFile.Name):"
            # Display the contents of the selected file
            Get-Content -Path $selectedFile.FullName
        } else {
            Write-Host "Invalid selection."
        }
    }
} else {
    Write-Host "Directory not found. Please check the path and try again."
}
