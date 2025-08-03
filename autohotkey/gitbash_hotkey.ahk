^b::
; フォルダパスを初期化
folderPath := ""

; エクスプローラーのアクティブウィンドウのフォルダパスを取得
for window in ComObjCreate("Shell.Application").Windows
{
    if (window.hwnd = WinActive("A"))
    {
        try {
            folderPath := window.document.folder.self.path
        } catch {
            folderPath := ""
        }
        break
    }
}

; もし取得できなければ、デスクトップのパスを使う
if (folderPath = "")
{
    folderPath := A_Desktop
}

; Git Bashのパス（必要に応じて変更）
gitbashPath := "C:\Program Files\Git\git-bash.exe"

; Git Bashを指定フォルダで開く
Run, %gitbashPath%, %folderPath%
return
