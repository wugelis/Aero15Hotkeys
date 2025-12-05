#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

global osdWin := 0
global osdText := 0
global osdTimer := 0
global osdHwnd := 0

; ================================================================
;  建立/顯示 OSD
; ================================================================
showOSD(text) {
    global osdWin, osdText, osdTimer, osdHwnd

    if !osdWin {
        osdWin := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
        osdWin.BackColor := "000000"  ; 黑色背景
        osdText := osdWin.AddText("Center w300 h50 cFFFFFF", "")
        osdWin.SetFont("s20 bold")
        osdHwnd := osdWin.Hwnd
    }

    osdText.Value := text
    osdWin.Show("AutoSize Center")

    ; 重設透明度
    WinSetTransparent(255, osdHwnd)

    ; 清除舊的 Timer
    if osdTimer
        osdTimer.Stop()

    ; 1.2 秒後開始淡出
    osdTimer := SetTimer(() => fadeOutOSD(), -1200)
}

; ================================================================
;  淡出效果（v2 正確寫法）
; ================================================================
fadeOutOSD() {
    global osdWin, osdHwnd

    Loop 12 {
        current := WinGetTransparent(osdHwnd)
        WinSetTransparent(current - 20, osdHwnd)
        Sleep 20
    }
    osdWin.Hide()
}

; ================================================================
;  亮度調整
; ================================================================
changeBrightness(amount) {
    try {
        wmi := ComObjGet("winmgmts:\\.\root\WMI")
        methods := wmi.ExecQuery("Select * from WmiMonitorBrightnessMethods").ItemIndex(0)
        current := wmi.ExecQuery("Select * from WmiMonitorBrightness").ItemIndex(0).CurrentBrightness

        newValue := current + amount
        if (newValue < 0) newValue := 0
        if (newValue > 100) newValue := 100

        methods.WmiSetBrightness(1, newValue)

        showOSD("亮度：" newValue "%")
    } catch {
        MsgBox "調整亮度功能錯誤"
    }
}

; ================================================================
;  音量控制（含 OSD）
; ================================================================
changeVolume(amount) {
    current := SoundGetVolume()
    newValue := current + amount
    if newValue < 0
        newValue := 0
    if newValue > 100
        newValue := 100

    SoundSetVolume(newValue)
    showOSD("音量：" Round(newValue) "%")
}

toggleMute() {
    SoundSetMute(-1)
    muted := SoundGetMute()

    if muted
        showOSD("🔇 已靜音")
    else {
        vol := Round(SoundGetVolume())
        showOSD("🔊 音量：" vol "%")
    }
}

; ================================================================
;  熱鍵設定：依你的 AERO 15 修改
; ================================================================
; Fn + F3 降低亮度
F3::(() => changeBrightness(-10))()

; Fn + F4 增加亮度
F4::(() => changeBrightness(10))()

; ------------ 音量調整 ------------
F8::SoundSetVolume("-2")   ; 降低音量
F9::SoundSetVolume("+2")    ; 增加音量
F7::Volume_Mute             ; 靜音
