# 检查 Git Bash 安装位置
Write-Host "正在检查 Git Bash 安装位置..." -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

$found = $false

# 检查常见安装路径
$commonPaths = @(
    "C:\Program Files\Git\bin\bash.exe",
    "C:\Program Files (x86)\Git\bin\bash.exe",
    "$env:USERPROFILE\AppData\Local\Programs\Git\bin\bash.exe",
    "D:\Program Files\Git\bin\bash.exe",
    "D:\Git\bin\bash.exe",
    "E:\Program Files\Git\bin\bash.exe",
    "E:\Git\bin\bash.exe"
)

Write-Host "`n检查常见安装路径:" -ForegroundColor Yellow
foreach ($path in $commonPaths) {
    if (Test-Path $path) {
        Write-Host "✓ 找到: $path" -ForegroundColor Green
        $found = $true
    }
}

# 检查 PATH 环境变量
Write-Host "`n检查 PATH 环境变量:" -ForegroundColor Yellow
$pathEntries = $env:PATH -split ';'
foreach ($entry in $pathEntries) {
    if ($entry -like '*git*' -or $entry -like '*bash*') {
        $bashPath = Join-Path $entry "bash.exe"
        if (Test-Path $bashPath) {
            Write-Host "✓ 在 PATH 中找到: $bashPath" -ForegroundColor Green
            $found = $true
        }
    }
}

# 检查注册表
Write-Host "`n检查注册表:" -ForegroundColor Yellow
try {
    $regPath = Get-ItemProperty -Path "HKLM:\SOFTWARE\GitForWindows" -ErrorAction SilentlyContinue
    if ($regPath -and $regPath.InstallPath) {
        $bashPath = Join-Path $regPath.InstallPath "bin\bash.exe"
        if (Test-Path $bashPath) {
            Write-Host "✓ 在注册表中找到: $bashPath" -ForegroundColor Green
            $found = $true
        }
    }
} catch {
    Write-Host "  注册表中未找到 Git 安装信息" -ForegroundColor Gray
}

# 检查所有驱动器的 Program Files
Write-Host "`n检查所有驱动器的 Program Files:" -ForegroundColor Yellow
Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    $drive = $_.Root
    $gitPath = Join-Path $drive "Program Files\Git\bin\bash.exe"
    if (Test-Path $gitPath) {
        Write-Host "✓ 找到: $gitPath" -ForegroundColor Green
        $found = $true
    }
}

# 总结
Write-Host "`n=================================" -ForegroundColor Cyan
if (-not $found) {
    Write-Host "✗ 未找到 Git Bash 安装" -ForegroundColor Red
    Write-Host "`n请安装 Git for Windows:" -ForegroundColor Yellow
    Write-Host "  下载地址: https://git-scm.com/download/win" -ForegroundColor White
} else {
    Write-Host "✓ Git Bash 已找到！" -ForegroundColor Green
}





