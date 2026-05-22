# Claude Code 环境变量配置脚本
# 使用方法：在 PowerShell 中运行此脚本

Write-Host "正在配置 Claude Code 环境变量..." -ForegroundColor Green

# 设置 API 基础 URL（国内镜像）
$env:ANTHROPIC_BASE_URL = "https://open.bigmodel.cn/api/anthropic"
Write-Host "✓ ANTHROPIC_BASE_URL 已设置" -ForegroundColor Green

# 设置 API 密钥（请替换为您的实际 API 密钥）
# 注意：请将下面的 "your-api-key-here" 替换为您的实际 API 密钥
if (-not $env:ANTHROPIC_API_KEY) {
    Write-Host "`n请输入您的 ANTHROPIC_API_KEY（如果已有，请忽略）:" -ForegroundColor Yellow
    Write-Host "或者手动设置: `$env:ANTHROPIC_API_KEY = 'your-api-key-here'" -ForegroundColor Yellow
    # 取消注释下面这行并填入您的 API 密钥
    # $env:ANTHROPIC_API_KEY = "your-api-key-here"
}

# 显示当前设置
Write-Host "`n当前环境变量设置:" -ForegroundColor Cyan
Write-Host "ANTHROPIC_BASE_URL = $env:ANTHROPIC_BASE_URL" -ForegroundColor White
if ($env:ANTHROPIC_API_KEY) {
    Write-Host "ANTHROPIC_API_KEY = $($env:ANTHROPIC_API_KEY.Substring(0, [Math]::Min(10, $env:ANTHROPIC_API_KEY.Length)))..." -ForegroundColor White
} else {
    Write-Host "ANTHROPIC_API_KEY = (未设置)" -ForegroundColor Yellow
}

Write-Host "`n注意：这些设置仅在当前 PowerShell 会话中有效。" -ForegroundColor Yellow
Write-Host "如需永久设置，请使用以下方法之一：" -ForegroundColor Yellow
Write-Host "1. 使用 [System.Environment]::SetEnvironmentVariable()" -ForegroundColor White
Write-Host "2. 通过系统设置 -> 环境变量手动添加" -ForegroundColor White

