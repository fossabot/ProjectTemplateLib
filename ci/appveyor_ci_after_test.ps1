#
# Script to after tests phase in AppVeyor
#

# Load functions from the helper file
. (Join-Path (Split-Path $MyInvocation.MyCommand.Path) 'appveyor_helpers.ps1')

$build_dir = "build"

if (-not $env:APPVEYOR)
{
    function Push-AppveyorArtifact($Filename)
    {
        Write-Host "Publishing artifact: $Filename"
    }
}

if ($env:GenerateInstaller)
{
    $build_dir = "build"
    
    if(!($env:Configuration -eq 'Release'))
    {
        throw "Installer generation is only supported for release builds"
    }
    
    switch -Wildcard ($env:Platform)
    {
        'MinGW*'
        {
            $mingw_path = Get-MinGWBin

            # Add mingw to the path
            Add-PathFolder $mingw_path

            Invoke-Command "mingw32-make package" "$build_dir"

            Remove-PathFolder $mingw_path
        }

        default
        {
            throw "Installer generation is only supported for MinGW builds"
        }
    }
}

if ($env:PublishArtifacts)
{
    Get-ChildItem $build_dir\*.exe | % { Push-AppveyorArtifact $_.FullName -FileName $_.Name }
}
