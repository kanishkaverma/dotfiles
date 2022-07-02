
GroupAdd, windowGroup, ahk_exe Code.exe
GroupAdd, windowGroup, ahk_exe mintty.exe
; ===============for caps lock stuff======================
*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    ; Modify the threshold time (in milliseconds) as necessary
    If ((A_TickCount-cDown) < 100)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return
; ========================================================

; ===============for hjkl stuff======================
#IfWinNotActive ahk_group windowGroup  
^h::
   SendInput, {Ctrl up}{left}{Ctrl down}
Return
^j::
   SendInput, {Ctrl up}{down}{Ctrl down}
Return
^k::
   SendInput, {Ctrl up}{up}{Ctrl down}
Return
^l::
   Send {Ctrl up}{Right}{Ctrl down}
Return
; ===========================================



