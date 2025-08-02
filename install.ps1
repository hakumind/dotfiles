
# install.ps1 - 自分専用の環境再構築スクリプト

Write-Host "🔧 必要なアプリを winget でインストール中..."

# --- 基本ツール ---
winget install --id Microsoft.PowerToys --source winget --accept-package-agreements
winget install --id voidtools.Everything --source winget --accept-package-agreements
winget install --id Ditto.Ditto --source winget --accept-package-agreements
winget install --id AutoHotkey.AutoHotkey --source winget --accept-package-agreements
#winget install --id Flux.Flux --accept-package-agreements --accept-source-agreements
winget install --id VS.RevoUninstaller --accept-package-agreements --accept-source-agreements

# --- 開発環境 ---
winget install --id Microsoft.VisualStudioCode --source winget --accept-package-agreements
winget install --id Git.Git --source winget --accept-package-agreements
winget install --id Python.Python.3 --source winget --accept-package-agreements
winget install --id OpenJS.NodeJS.LTS --source winget --accept-package-agreements

# --- ターミナル拡張 ---
winget install --id Microsoft.WindowsTerminal --source winget --accept-package-agreements
winget install --id JanDeDobbeleer.OhMyPosh --source winget --accept-package-agreements

# --- ユーティリティ ---
winget install --id 7zip.7zip --source winget --accept-package-agreements
winget install --id WinDirStat.WinDirStat --source winget --accept-package-agreements

Write-Host "`n✅ アプリのインストール完了"

$repo = $PSScriptRoot

# VSCode settings.json
$src = "$repo\vscode\settings.json"
$dst = "$env:APPDATA\Code\User\settings.json"
if (Test-Path $src) { Copy-Item -Path $src -Destination $dst -Force }

# PowerToys settings
$src = "$repo\powertoys"
$dst = "$env:LOCALAPPDATA\Microsoft\PowerToys"
if (Test-Path $src) { Copy-Item -Path $src -Destination $dst -Recurse -Force }

# AHK to startup
$src = "$repo\autohotkey"
$dst = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
if (Test-Path $src) { Copy-Item "$src\*.ahk" $dst -Force }

# Oh My Posh config
$ompConfig = "$repo\oh-my-posh\custom.omp.json"
if (Test-Path $ompConfig) {
    $profilePath = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
    if (-not (Test-Path $profilePath)) {
        New-Item -Path $profilePath -ItemType File -Force
    }
    $initLine = 'oh-my-posh init pwsh --config "$HOME\dotfiles\oh-my-posh\custom.omp.json" | Invoke-Expression'
    if (-not (Select-String -Path $profilePath -Pattern "oh-my-posh")) {
        Add-Content -Path $profilePath -Value "`n$initLine"
    }
}

Write-Host "`n🎉 すべて完了！ターミナルを再起動してください。"
