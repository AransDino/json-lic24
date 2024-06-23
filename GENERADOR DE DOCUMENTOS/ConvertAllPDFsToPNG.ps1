# Path to ImageMagick executable
$magickPath = "C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe"

# Function to convert PDF to PNG and JPG
function Convert-PDFToImages {
    param (
        [string]$pdfPath
    )

    # Convert to PNG
    $pngPath = [System.IO.Path]::ChangeExtension($pdfPath, ".png")
    $commandPNG = "`"$magickPath`" convert `"$pdfPath`" `"$pngPath`""
    Write-Output "Converting $pdfPath to $pngPath"
    & cmd.exe /c $commandPNG

    # Convert to JPG
    $jpgPath = [System.IO.Path]::ChangeExtension($pdfPath, ".jpg")
    $commandJPG = "`"$magickPath`" convert `"$pdfPath`" `"$jpgPath`""
    Write-Output "Converting $pdfPath to $jpgPath"
    & cmd.exe /c $commandJPG
}

# Function to process a folder
function Process-Folder {
    param (
        [string]$folderPath
    )

    # Get all PDF files in the current folder and subfolders
    Get-ChildItem -Path $folderPath -Filter *.pdf -Recurse | ForEach-Object {
        Convert-PDFToImages -pdfPath $_.FullName
    }
}

# Main script
# Specify the root directory
$rootDir = "C:\Users\ayoze\gitrepositories\TORNEO-LIC-ESTRUCTURA\GENERADOR DE DOCUMENTOS"

# Process the root directory
Process-Folder -folderPath $rootDir
