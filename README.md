# Aero15 熱鍵腳本

這是一個為筆記型電腦（如 Aero15）設計的 AutoHotkey v2 腳本，提供螢幕亮度和音量調整的快捷鍵功能。

## 功能特色

- 🔆 **螢幕亮度調整**：透過 WMI 直接控制螢幕亮度
- 🔊 **音量控制**：快速調整系統音量與靜音切換
- ⚡ **單一實例執行**：自動關閉舊實例，避免重複執行

## 系統需求

- Windows 作業系統
- [AutoHotkey v2.0](https://www.autohotkey.com/) 或更新版本

## 安裝步驟

1. 下載並安裝 [AutoHotkey v2.0](https://www.autohotkey.com/)
2. 下載 `Aero15Hotkeys.ahk` 腳本檔案
3. 雙擊執行腳本，或將其加入 Windows 啟動資料夾以開機自動執行

## 快捷鍵說明

| 按鍵 | 功能 | 說明 |
|------|------|------|
| <kbd>F3</kbd> | 降低亮度 | 每次降低 10% 亮度 |
| <kbd>F4</kbd> | 增加亮度 | 每次增加 10% 亮度 |
| <kbd>F7</kbd> | 靜音切換 | 開啟/關閉靜音 |
| <kbd>F8</kbd> | 降低音量 | 每次降低 2% 音量 |
| <kbd>F9</kbd> | 增加音量 | 每次增加 2% 音量 |

> **注意**：部分筆記型電腦需要同時按住 <kbd>Fn</kbd> 鍵才能觸發功能鍵（F1-F12）。

## 自訂設定

### 修改亮度調整幅度

編輯腳本中的數值（預設為 ±10）：

```ahk
F3::(() => changeBrightness(-10))()  ; 將 -10 改為您想要的數值
F4::(() => changeBrightness(10))()   ; 將 10 改為您想要的數值
```

### 修改音量調整幅度

編輯腳本中的數值（預設為 ±2）：

```ahk
F8::SoundSetVolume("-2")   ; 將 -2 改為您想要的數值
F9::SoundSetVolume("+2")   ; 將 +2 改為您想要的數值
```

### 變更快捷鍵

如果您的功能鍵配置不同，可以修改熱鍵綁定。例如：

```ahk
; 將 F3 改為 F5
F5::(() => changeBrightness(-10))()

; 使用組合鍵（Ctrl + F3）
^F3::(() => changeBrightness(-10))()
```

**常用修飾鍵符號**：
- `^` = Ctrl
- `!` = Alt
- `+` = Shift
- `#` = Win

## 開機自動執行

1. 按 <kbd>Win</kbd> + <kbd>R</kbd> 開啟執行視窗
2. 輸入 `shell:startup` 並按 Enter
3. 將 `Aero15Hotkeys.ahk` 的捷徑複製到開啟的資料夾中

## 疑難排解

### 亮度調整無效

- 確認您的顯示器支援 WMI 亮度控制（部分外接螢幕可能不支援）
- 嘗試以系統管理員身分執行腳本
- 確認已安裝最新的顯示卡驅動程式

### 音量調整無效

- 檢查系統音量混音器設定
- 確認音訊服務正常運作

### 熱鍵衝突

如果熱鍵與其他程式衝突，請修改腳本中的按鍵綁定。

## 技術說明

- **亮度控制**：使用 Windows Management Instrumentation (WMI) 介面的 `WmiMonitorBrightness` 類別
- **音量控制**：使用 AutoHotkey 內建的 `SoundSetVolume` 函數
- **執行模式**：單一實例強制模式，確保不會重複執行

## 授權

此腳本為開源專案，您可以自由修改與分享。

## 貢獻

歡迎提交問題回報或改進建議！ Hotkeys for Aero15

This AutoHotKey script is designed to customize hotkeys for the Aero15 laptop, allowing users to adjust screen brightness and volume using specific function keys.