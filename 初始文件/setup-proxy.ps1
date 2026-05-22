# Claude Code 代理配置助手
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Claude Code 代理配置助手" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 检查当前代理设置
Write-Host "`n当前代理配置:" -ForegroundColor Yellow
$currentProxy = $env:HTTP_PROXY
if ($currentProxy) {
    Write-Host "  HTTP_PROXY: $currentProxy" -ForegroundColor White
} else {
    Write-Host "  HTTP_PROXY: 未设置" -ForegroundColor Red
}

# 检查常见代理端口
Write-Host "`n检查常见代理端口..." -ForegroundColor Yellow
$commonPorts = @(7890, 10809, 10808, 1080, 8080, 8888, 1087)
$activePorts = @()

foreach($port in $commonPorts) {
    try {
        $test = Test-NetConnection -ComputerName 127.0.0.1 -Port $port -WarningAction SilentlyContinue -InformationLevel Quiet
        if ($test) {
            Write-Host "  ✓ 端口 $port 可访问" -ForegroundColor Green
            $activePorts += $port
        }
    } catch {
        # 忽略错误
    }
}

if ($activePorts.Count -eq 0) {
    Write-Host "  ✗ 未找到活动的代理端口" -ForegroundColor Red
    Write-Host "`n请确保您的代理软件（Clash/V2Ray/Shadowsocks等）正在运行" -ForegroundColor Yellow
} else {
    Write-Host "`n找到 $($activePorts.Count) 个活动的代理端口" -ForegroundColor Green
    
    # 使用第一个找到的端口
    $proxyPort = $activePorts[0]
    $proxy = "http://127.0.0.1:$proxyPort"
    
    Write-Host "`n使用代理: $proxy" -ForegroundColor Cyan
    
    # 设置环境变量
    $env:HTTP_PROXY = $proxy
    $env:HTTPS_PROXY = $proxy
    $env:http_proxy = $proxy
    $env:https_proxy = $proxy
    
    # 永久保存
    [System.Environment]::SetEnvironmentVariable("HTTP_PROXY", $proxy, "User")
    [System.Environment]::SetEnvironmentVariable("HTTPS_PROXY", $proxy, "User")
    [System.Environment]::SetEnvironmentVariable("http_proxy", $proxy, "User")
    [System.Environment]::SetEnvironmentVariable("https_proxy", $proxy, "User")
    
    Write-Host "✓ 代理已配置并永久保存" -ForegroundColor Green
    
    # 配置 Git
    git config --global http.proxy $proxy
    git config --global https.proxy $proxy
    Write-Host "✓ Git 代理已配置" -ForegroundColor Green
    
    # 配置 npm
    npm config set proxy $proxy
    npm config set https-proxy $proxy
    Write-Host "✓ npm 代理已配置" -ForegroundColor Green
    
    # 测试连接
    Write-Host "`n测试通过代理访问..." -ForegroundColor Yellow
    try {
        $response = Invoke-WebRequest -Uri "https://www.google.com" -Proxy $proxy -TimeoutSec 5 -ErrorAction Stop
        Write-Host "✓ 代理工作正常" -ForegroundColor Green
    } catch {
        Write-Host "✗ 代理测试失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "配置完成！" -ForegroundColor Green
Write-Host "`n提示: 如果您的代理端口不在列表中，可以手动设置:" -ForegroundColor Yellow
Write-Host '  $env:HTTP_PROXY = "http://127.0.0.1:您的端口"' -ForegroundColor White
Write-Host '  $env:HTTPS_PROXY = "http://127.0.0.1:您的端口"' -ForegroundColor White





