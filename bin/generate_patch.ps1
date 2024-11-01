# Change directory
Set-Location -Path 'Velocity' -ErrorAction Stop
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

# Get changed files
git add .
$patchFiles = git diff --cached --name-only

# Clear old files
$traceFilesContent = ((echo $patchFiles) -join "`n") + "`n"
Set-Content -Value $Utf8NoBomEncoding.GetBytes($traceFilesContent) -Encoding Byte -Path '..\velocity-patches-trace-files'
Remove-Item -Path '..\velocity-patches' -Recurse -ErrorAction Ignore

# Generate patch file
foreach ($patchFile in $patchFiles) {
    echo "$patchFile"
    $fileName = Split-Path -Path $patchFile -Leaf
    $patchDir = Join-Path -Path '..\velocity-patches' -ChildPath (Split-Path -Path $patchFile -Parent)
    New-Item -ItemType Directory -Path $patchDir -Force | Out-Null
    $patchContent = ((git diff --no-color --cached --binary $patchFile) -join "`n") + "`n"
    Set-Content -Value $Utf8NoBomEncoding.GetBytes($patchContent) -Encoding Byte -Path "$patchDir\$fileName.patch"
}

cd ..