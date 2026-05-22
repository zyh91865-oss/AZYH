# 验证永久环境变量设置
Write-Host "`n正在验证永久环境变量设置..." -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

$baseUrl = [System.Environment]::GetEnvironmentVariable("ANTHROPIC_BASE_URL", "User")
$apiKey = [System.Environment]::GetEnvironmentVariable("ANTHROPIC_API_KEY", "User")

if ($baseUrl) {
    Write-Host "✓ ANTHROPIC_BASE_URL: $baseUrl" -ForegroundColor Green
} else {
    Write-Host "✗ ANTHROPIC_BASE_URL 未设置" -ForegroundColor Red
}

if ($apiKey) {
    $keyPreview = $apiKey.Substring(0, [Math]::Min(20, $apiKey.Length))
    Write-Host "✓ ANTHROPIC_API_KEY: ${keyPreview}... (长度: $($apiKey.Length) 字符)" -ForegroundColor Green
} else {
    Write-Host "✗ ANTHROPIC_API_KEY 未设置" -ForegroundColor Red
}

Write-Host "`n注意：永久环境变量需要重新打开 PowerShell 窗口才能生效。" -ForegroundColor Yellow
Write-Host "当前会话中，请使用以下命令刷新环境变量：" -ForegroundColor Yellow
Write-Host '  $env:ANTHROPIC_BASE_URL = [System.Environment]::GetEnvironmentVariable(''ANTHROPIC_BASE_URL'', ''User'')' -ForegroundColor White
Write-Host '  $env:ANTHROPIC_API_KEY = [System.Environment]::GetEnvironmentVariable(''ANTHROPIC_API_KEY'', ''User'')' -ForegroundColor White

