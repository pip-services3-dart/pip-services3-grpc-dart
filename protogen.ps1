#!/usr/bin/env pwsh

##Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

# Get component data and set necessary variables
$component = Get-Content -Path "component.json" | ConvertFrom-Json

$docsImage="$($component.registry)/$($component.name):$($component.version)-$($component.build)-proto"
$container=$component.name

# Remove old generate files
if (Test-Path "lib/src/generated") {
    Remove-Item -Path "lib/src/generated/*" -Force -Include *.dart
}

if (Test-Path "test/generated") {
    Remove-Item -Path "test/generated/*" -Force -Include *.dart
}

# Build docker image
docker build -f docker/Dockerfile.proto -t $docsImage .

# Create and copy compiled files, then destroy
docker create --name $container $docsImage
docker cp "$($container):/app/lib/src/generated" ./lib/src/
docker cp "$($container):/app/test/generated" ./test/
docker rm $container
