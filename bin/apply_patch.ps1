# Change directory
Set-Location -Path 'Velocity' -ErrorAction Stop

# Get changed files
$patchFiles = Get-Content -Path '..\velocity-patches-trace-files'

# Reset changed files
git reset --hard
git clean -fd

# Apply patch file
foreach ($patchFile in $patchFiles) {
    echo "..\velocity-patches\$patchFile.patch"
    git apply --allow-empty "..\velocity-patches\$patchFile.patch"
}

Set-Location -Path '..' -ErrorAction Stop
