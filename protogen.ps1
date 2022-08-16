#!/usr/bin/env pwsh

##Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

# Get component data and set necessary variables
$component = Get-Content -Path "component.json" | ConvertFrom-Json

$protosImage="$($component.registry)/$($component.name):$($component.version)-$($component.build)-proto"
$container=$component.name

# Remove old generate files
if (Test-Path "$PSScriptRoot/lib/src/generated") {
    Remove-Item -Path "$PSScriptRoot/lib/src/generated/*" -Force -Include *.dart
}
if (Test-Path "$PSScriptRoot/test/generated") {
    Remove-Item -Path "$PSScriptRoot/test/generated/*" -Force -Include *.dart
}

# Build docker image
docker build -f "$PSScriptRoot/docker/Dockerfile.proto" -t $protosImage .

# Create and copy compiled files, then destroy
docker create --name $container $protosImage
docker cp "$($container):/app/lib/src/generated" "$PSScriptRoot/lib/src/generated"
docker cp "$($container):/app/test/generated" "$PSScriptRoot/test/generated"
docker rm $container

# Verify that protos folder was indeed created after generating proto files
if (-not (Test-Path "$PSScriptRoot/lib/src/generated")) {
    Write-Error "generated folder doesn't exist in lib/src dir. Build failed. See logs above for more information."
}