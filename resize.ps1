Add-Type -AssemblyName System.Drawing

$srcPath = Join-Path $PSScriptRoot "public\icon-processed.png"
$img = [System.Drawing.Image]::FromFile($srcPath)

function Resize-Image($image, $width, $height, $path) {
    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $graph = [System.Drawing.Graphics]::FromImage($bmp)
    $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graph.DrawImage($image, 0, 0, $width, $height)
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $graph.Dispose()
    $bmp.Dispose()
}

Resize-Image $img 192 192 (Join-Path $PSScriptRoot "public\pwa-192x192.png")
Resize-Image $img 512 512 (Join-Path $PSScriptRoot "public\pwa-512x512.png")

$img.Dispose()
