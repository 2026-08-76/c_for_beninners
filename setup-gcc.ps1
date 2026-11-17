$ErrorActionPreference = "Stop"

$version = "2.11.0"
$archiveName = "w64devkit-x64-$version.7z.exe"
$downloadUrl = "https://github.com/skeeto/w64devkit/releases/download/v$version/$archiveName"
$expectedSha256 = "54c2bb9962e8a30c8270e34c5efc3d5fee579f53087fa7d435b95fbba2af7b2b"
$toolsDirectory = Join-Path $PSScriptRoot ".tools"
$installDirectory = Join-Path $toolsDirectory "w64devkit"
$compilerPath = Join-Path $installDirectory "w64devkit\bin\gcc.exe"
$archivePath = Join-Path $toolsDirectory $archiveName

if (Test-Path $compilerPath) {
    Write-Host "GCC ja esta disponivel em $compilerPath"
    & $compilerPath --version
    if ($LASTEXITCODE -ne 0) {
        throw "O GCC foi encontrado, mas nao iniciou corretamente."
    }
    exit 0
}

New-Item -ItemType Directory -Path $toolsDirectory -Force | Out-Null
Write-Host "Baixando w64devkit $version..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $archivePath -UseBasicParsing

$actualSha256 = (Get-FileHash -Path $archivePath -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actualSha256 -ne $expectedSha256) {
    Remove-Item -LiteralPath $archivePath -Force
    throw "O SHA-256 do arquivo baixado nao corresponde ao esperado; o arquivo foi removido."
}

New-Item -ItemType Directory -Path $installDirectory -Force | Out-Null
Write-Host "Extraindo o compilador..."
$arguments = "-o`"$installDirectory`" -y"
$process = Start-Process -FilePath $archivePath -ArgumentList $arguments -Wait -PassThru -NoNewWindow
if ($process.ExitCode -ne 0) {
    throw "A extracao do w64devkit falhou (codigo $($process.ExitCode))."
}

if (-not (Test-Path $compilerPath)) {
    throw "A extracao terminou, mas gcc.exe nao foi encontrado em $compilerPath."
}

Remove-Item -LiteralPath $archivePath -Force
Write-Host "GCC instalado na pasta do repositorio:"
& $compilerPath --version
if ($LASTEXITCODE -ne 0) {
    throw "O GCC foi extraido, mas nao iniciou corretamente."
}
