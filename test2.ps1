# Prompt the user for a directory path
$directoryPath = Read-Host "Enter the directory path to create"

# Check if the directory exists, create if it doesn't
if (-Not (Test-Path -Path $directoryPath)) {
    New-Item -Path $directoryPath -ItemType Directory
    Write-Host "Directory created at: $directoryPath"
} else {
    Write-Host "Directory already exists at: $directoryPath"
}

# Define file names
$fileNames = @("file1.txt", "file2.txt", "file3.txt")

# Create the text files and write sample content
foreach ($fileName in $fileNames) {
    $filePath = Join-Path -Path $directoryPath -ChildPath $fileName
    Set-Content -Path $filePath -Value "This is the content for $fileName."
    Write-Host "$fileName created and content written."
}

# List all files in the directory with their sizes
Write-Host "`nListing all files in the directory with their sizes:"
Get-ChildItem -Path $directoryPath | Select-Object Name, @{Name="Size";Expression={[math]::round($_.Length / 1KB, 2)}} | Format-Table -AutoSize

# Prompt user to enter the name of the file to delete
$fileToDelete = Read-Host "Enter the name of the file you want to delete (e.g., file1.txt)"

# Check if the file exists and delete it
$filePathToDelete = Join-Path -Path $directoryPath -ChildPath $fileToDelete
if (Test-Path -Path $filePathToDelete) {
    Remove-Item -Path $filePathToDelete
    Write-Host "$fileToDelete has been deleted."
} else {
    Write-Host "File not found: $fileToDelete"
}
