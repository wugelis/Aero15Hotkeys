#Requires AutoHotkey v2.0

; ------------ 基本設定 ------------
#SingleInstance Force
SetTitleMatchMode "RegEx"
Persistent

; ------------ 功能：調整螢幕亮度 ------------
changeBrightness(amount) {
    try {
        ; 使用 WMI 控制亮度
        wmi := ComObjGet("winmgmts:\\.\root\WMI")
        methods := wmi.ExecQuery("Select * from WmiMonitorBrightnessMethods").ItemIndex(0)
        current := wmi.ExecQuery("Select * from WmiMonitorBrightness").ItemIndex(0).CurrentBrightness
        newValue := current + amount

        if (newValue < 0)
            newValue := 0
        if (newValue > 100)
            newValue := 100

        methods.WmiSetBrightness(1, newValue)
    } catch {
        MsgBox "調整亮度功能錯誤"
    }
}

; ------------ 熱鍵設定（請依你的機型功能鍵修改） ------------

; Fn + F3 降低亮度
F3::(() => changeBrightness(-10))()

; Fn + F4 增加亮度
F4::(() => changeBrightness(10))()

; ------------ 音量調整 ------------
F8::SoundSetVolume("-2")   ; 降低音量
F9::SoundSetVolume("+2")    ; 增加音量
F7::Volume_Mute             ; 靜音
