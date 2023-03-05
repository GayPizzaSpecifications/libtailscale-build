$ErrorActionPreference = 'Stop'

if (-not $env:GOOS -or -not $env:GOARCH) {
    Write-Host "GOOS and GOARCH must be set."
    Exit 1
}

if (-not $env:LIBSUFFIX) {
    Write-Host "LIBSUFFIX must be set."
    Exit 1
}

Set-Location (Split-Path $MyInvocation.MyCommand.Path)

if (-not (Test-Path "libtailscale/go.mod")) {
    git submodule update --init --recursive
}

New-Item -ItemType Directory -Force -Path "build" | Out-Null

Set-Location "libtailscale"
$env:CGO_ENABLED = '1'
& go build -buildmode=c-shared -o "../build/libtailscale-$($env:GOOS)-$($env:GOARCH).$($env:LIBSUFFIX)"
Remove-Item -Path "../build/*.h" -Force
