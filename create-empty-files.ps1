<#
create-empty-files.ps1
설명: 동일한 베이스 이름으로 확장자가 다른 빈 파일 5개를 생성합니다.
사용법:
  .\create-empty-files.ps1
  .\create-empty-files.ps1 -BaseName '빈파일' -Extensions 'txt','md','py','json','log' -Directory 'C:\Users\강민준\Downloads\데브옵스 과정' -Force
#>

param(
    [string]$BaseName = '빈파일',
    [string[]]$Extensions = @('txt','md','py','json','log'),
    [string]$Directory = (Join-Path $env:USERPROFILE 'Downloads\데브옵스 과정'),
    [switch]$Force
)

if (-not (Test-Path -Path $Directory)) {
    New-Item -Path $Directory -ItemType Directory -Force | Out-Null
}

foreach ($ext in $Extensions) {
    $file = Join-Path $Directory ("{0}.{1}" -f $BaseName, $ext)
    if (Test-Path -Path $file) {
        if ($Force.IsPresent) {
            New-Item -Path $file -ItemType File -Force | Out-Null
            Write-Host "Overwrote: $file"
        }
        else {
            Write-Host "Skipped (exists): $file"
        }
    } else {
        New-Item -Path $file -ItemType File | Out-Null
        Write-Host "Created: $file"
    }
}

Write-Host "Done."
