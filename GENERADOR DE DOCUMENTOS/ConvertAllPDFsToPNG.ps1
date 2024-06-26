# Ruta al ejecutable de ImageMagick
$magickPath = "C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe"

# Función para convertir PDF a PNG y JPG
function Convertir-PDFaImagenes {
    param (
        [string]$rutaPDF
    )

    # Convertir a PNG
    $rutaPNG = [System.IO.Path]::ChangeExtension($rutaPDF, ".png")
    $comandoPNG = "`"$magickPath`" convert `"$rutaPDF`" `"$rutaPNG`""
    Write-Output "Convirtiendo $rutaPDF a $rutaPNG"
    & cmd.exe /c $comandoPNG

    # Incrementar el contador
    $script:archivosConvertidos++
}

# Función para procesar una carpeta
function Procesar-Carpeta {
    param (
        [string]$rutaCarpeta
    )

    # Inicializar el contador
    $script:archivosConvertidos = 0

    # Obtener todos los archivos PDF en la carpeta actual y subcarpetas
    Get-ChildItem -Path $rutaCarpeta -Filter *.pdf -Recurse | ForEach-Object {
        Convertir-PDFaImagenes -rutaPDF $_.FullName
    }

    # Mostrar el número total de archivos convertidos
    Write-Output "Total de archivos convertidos: $script:archivosConvertidos"
}

# Script principal
# Especificar el directorio raíz
$directorioRaiz = "C:\Users\ayoze\gitrepositories\json-lic24\GENERADOR DE DOCUMENTOS"

# Procesar el directorio raíz
Procesar-Carpeta -rutaCarpeta $directorioRaiz

# Cambiar al directorio raíz
Set-Location -Path $directorioRaiz

# Añadir todos los cambios al staging area
& git add .

# Hacer commit de los cambios
$fechaHora = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$mensajeCommit = "Torneo-$fechaHora"
& git commit -m $mensajeCommit

# Hacer push de los cambios a la rama main
& git push origin main
