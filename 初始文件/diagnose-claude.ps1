# Claude Code 连接问题诊断脚本
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Claude Code 连接问题诊断" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n1. 检查环境变量:" -ForegroundColor Yellow
$baseUrl = $env:ANTHROPIC_BASE_URL
$apiKey = $env:ANTHROPIC_API_KEY

if ($baseUrl) {
    Write-Host "   ✓ ANTHROPIC_BASE_URL: $baseUrl" -ForegroundColor Green
} else {
    Write-Host "   ✗ ANTHROPIC_BASE_URL 未设置" -ForegroundColor Red
}

if ($apiKey) {
    Write-Host "   ✓ ANTHROPIC_API_KEY: $($apiKey.Substring(0, [Math]::Min(20, $apiKey.Length)))..." -ForegroundColor Green
} else {
    Write-Host "   ✗ ANTHROPIC_API_KEY 未设置" -ForegroundColor Red
}

Write-Host "`n2. 检查永久环境变量:" -ForegroundColor Yellow
$permBaseUrl = [System.Environment]::GetEnvironmentVariable("ANTHROPIC_BASE_URL", "User")
$permApiKey = [System.Environment]::GetEnvironmentVariable("ANTHROPIC_API_KEY", "User")

if ($permBaseUrl) {
    Write-Host "   ✓ 永久 ANTHROPIC_BASE_URL: $permBaseUrl" -ForegroundColor Green
} else {
    Write-Host "   ✗ 永久 ANTHROPIC_BASE_URL 未设置" -ForegroundColor Red
}

if ($permApiKey) {
    Write-Host "   ✓ 永久 ANTHROPIC_API_KEY: 已设置" -ForegroundColor Green
} else {
    Write-Host "   ✗ 永久 ANTHROPIC_API_KEY 未设置" -ForegroundColor Red
}

Write-Host "`n3. 测试网络连接:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "https://open.bigmodel.cn/api/anthropic" -Method GET -TimeoutSec 5 -ErrorAction Stop
    Write-Host "   ✓ 国内镜像端点可访问" -ForegroundColor Green
} catch {
    Write-Host "   ✗ 国内镜像端点不可访问: $($_.Exception.Message)" -ForegroundColor Red
}

try {
    $response = Invoke-WebRequest -Uri "https://api.anthropic.com" -Method GET -TimeoutSec 5 -ErrorAction Stop
    Write-Host "   ✓ 官方端点可访问" -ForegroundColor Green
} catch {
    Write-Host "   ✗ 官方端点不可访问: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n4. Claude Code 版本:" -ForegroundColor Yellow
$version = claude --version 2>&1
Write-Host "   $version" -ForegroundColor White

Write-Host "`n5. 可能的问题和解决方案:" -ForegroundColor Yellow
Write-Host "   - Claude Code 可能不支持通过 ANTHROPIC_BASE_URL 设置自定义端点" -ForegroundColor White
Write-Host "   - 可能需要使用代理或 VPN 来访问官方 API" -ForegroundColor White
Write-Host "   - 或者需要等待 Claude Code 更新以支持自定义端点" -ForegroundColor White

Write-Host "`n========================================" -ForegroundColor Cyan



