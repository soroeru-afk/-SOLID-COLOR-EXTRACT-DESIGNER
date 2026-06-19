Add-Type -AssemblyName System.Drawing

$srcPath = Join-Path $PSScriptRoot "public\icon-custom.png"
$img = [System.Drawing.Image]::FromFile($srcPath)
$bmp = New-Object System.Drawing.Bitmap($img)

$targetColor = [System.Drawing.Color]::FromArgb(255, 14, 16, 20)

function IsWhite($c) {
    # Check if pixel is light and lacks color (grayscale-ish)
    return $c.R -gt 210 -and $c.G -gt 210 -and $c.B -gt 210 -and 
           ([Math]::Abs($c.R - $c.G) -lt 20) -and ([Math]::Abs($c.G - $c.B) -lt 20)
}

$w = $bmp.Width
$h = $bmp.Height

for ($y = 0; $y -lt $h; $y++) {
    for ($x = 0; $x -lt $w; $x++) {
        if (IsWhite($bmp.GetPixel($x, $y))) { $bmp.SetPixel($x, $y, $targetColor) } else { break }
    }
    for ($x = $w - 1; $x -ge 0; $x--) {
        if (IsWhite($bmp.GetPixel($x, $y))) { $bmp.SetPixel($x, $y, $targetColor) } else { break }
    }
}
for ($x = 0; $x -lt $w; $x++) {
    for ($y = 0; $y -lt $h; $y++) {
        if (IsWhite($bmp.GetPixel($x, $y))) { $bmp.SetPixel($x, $y, $targetColor) } else { break }
    }
    for ($y = $h - 1; $y -ge 0; $y--) {
        if (IsWhite($bmp.GetPixel($x, $y))) { $bmp.SetPixel($x, $y, $targetColor) } else { break }
    }
}

$destPath = Join-Path $PSScriptRoot "public\icon-processed.png"
$bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$img.Dispose()
