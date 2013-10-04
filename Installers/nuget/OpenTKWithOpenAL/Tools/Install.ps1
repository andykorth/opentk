param($installPath, $toolsPath, $package, $project)

Import-Module (Join-Path $toolsPath VS.psd1)
if ($project.Type -eq 'Web Site') {
    $projectRoot = Get-ProjectRoot $project
    if (!$projectRoot) {
        return;
    }

    $binDirectory = Join-Path $projectRoot "bin"
    $libDirectory = Join-Path $installPath "lib\NET40"
    $nativeBinDirectory = Join-Path $installPath "NativeBinaries"
    Add-FilesToDirectory $libDirectory $binDirectory
    Add-FilesToDirectory $nativeBinDirectory $binDirectory
}
else {
    Add-PostBuildEvent $project $installPath
}
Remove-Module VS