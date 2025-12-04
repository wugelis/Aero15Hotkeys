; ===========================
;   AERO 15 自訂快捷鍵工具
;   亮度 / 音量 快捷鍵
; ===========================

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- 螢幕亮度調整 ---
; 亮度降低：Ctrl + Alt + F3
^!F5::
    AdjustBrightness(-10)
return

; 亮度增加：Ctrl + Alt + F4
^!F6::
    AdjustBrightness(10)
return

; --- 音量控制 ---
; 降音量：Ctrl + Alt + F7
^!F7::Send {Volume_Down}

; 升音量：Ctrl + Alt + F8
^!F8::Send {Volume_Up}

; 靜音：Ctrl + Alt + F9
^!F9::Send {Volume_Mute}

; --- 亮度調整 function ---
AdjustBrightness(amount) {
    try {
        WMI := ComObjGet("winmgmts:\\.\root\wmi")
        cols := WMI.ExecQuery("SELECT * FROM WmiMonitorBrightness")
        For monitor in cols {
            curBright := monitor.CurrentBrightness
        }

        newBright := curBright + amount
        if (newBright > 100)
            newBright := 100
        if (newBright < 0)
            newBright := 0

        wmi2 := ComObjGet("winmgmts:\\.\root\wmi")
        methods := wmi2.ExecQuery("SELECT * FROM WmiMonitorBrightnessMethods")
        For method in methods {
            method.WmiSetBrightness(1, newBright)
        }
    } catch e {
        MsgBox, 16, 錯誤, 無法更改亮度：%e%
    }
}
