# PowerShell 环境变量设置说明

## 问题原因

在 PowerShell 中，`export` 是 bash/Linux 命令，不能直接使用。PowerShell 使用不同的语法来设置环境变量。

## 解决方案

### 方法 1：临时设置（仅当前会话有效）

在 PowerShell 中，使用以下语法：

```powershell
# 设置 API 基础 URL
$env:ANTHROPIC_BASE_URL = "https://open.bigmodel.cn/api/anthropic"

# 设置 API 密钥（请替换为您的实际密钥）
$env:ANTHROPIC_API_KEY = "your-api-key-here"
```

**验证设置：**
```powershell
# 查看环境变量
echo $env:ANTHROPIC_BASE_URL
echo $env:ANTHROPIC_API_KEY
```

### 方法 2：永久设置（用户级别）

```powershell
# 设置用户级别的环境变量（永久）
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "https://open.bigmodel.cn/api/anthropic", "User")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "your-api-key-here", "User")
```

**注意：** 设置后需要重新打开 PowerShell 窗口才能生效。

### 方法 3：永久设置（系统级别，需要管理员权限）

```powershell
# 以管理员身份运行 PowerShell，然后执行：
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "https://open.bigmodel.cn/api/anthropic", "Machine")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "your-api-key-here", "Machine")
```

### 方法 4：使用脚本文件

运行已创建的 `setup-claude-env.ps1` 脚本：

```powershell
.\setup-claude-env.ps1
```

## 快速设置命令

将以下命令复制到 PowerShell 中执行（记得替换 API 密钥）：

```powershell
# 临时设置
$env:ANTHROPIC_BASE_URL = "https://open.bigmodel.cn/api/anthropic"
$env:ANTHROPIC_API_KEY = "your-api-key-here"

# 验证
Write-Host "ANTHROPIC_BASE_URL: $env:ANTHROPIC_BASE_URL"
Write-Host "ANTHROPIC_API_KEY: $($env:ANTHROPIC_API_KEY.Substring(0, [Math]::Min(10, $env:ANTHROPIC_API_KEY.Length)))..."
```

## 常见问题

### Q: 为什么 export 命令不工作？
A: `export` 是 bash 命令，PowerShell 使用 `$env:VARIABLE_NAME = "value"` 语法。

### Q: 如何查看所有环境变量？
A: 使用 `Get-ChildItem Env:` 或 `dir env:`

### Q: 如何删除环境变量？
A: 
```powershell
# 临时删除
Remove-Item Env:ANTHROPIC_BASE_URL

# 永久删除（用户级别）
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", $null, "User")
```

## 验证 Claude Code 配置

设置完成后，可以运行：

```powershell
claude --version
claude
```

如果配置正确，Claude Code 应该能够正常使用国内 API 端点。

