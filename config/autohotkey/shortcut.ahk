; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
; Hotkeys for JEFF at 20121010
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2    

Activate(t)
{
	IfWinActive,%t%
	{
		WinMinimize
		return
	}
	SetTitleMatchMode 2    
	DetectHiddenWindows,on
	IfWinExist,%t%
	{
		WinShow
		WinActivate           
		return 1
	}
	return 0
}
 
ActivateAndOpen(t,p)
{
	if Activate(t)==0
	{
		Run %p%
		WinActivate
		return
	}
}
 
; Program in common use
;s::ActivateAndOpen()
;w::ActivateAndOpen()
;a::ActivateAndOpen("Chrome","C:\Users\Administrator\AppData\Local\Google\Chrome\Application\chrome.exe")
;c::ActivateAndOpen("Picasa","D:\Program Files (x86)\Picasa\Picasa.exe")
;q::ActivateAndOpen("搜索Everything","C:\Program Files (x86)\Everything\Everything.exe")

;#h::
;Run Notepad
;WinWait, 无标题 - 记事本
;MsgBox 记事本窗口已被打开
;Return

;;按键定义
^Up::Send {PgDn}

 ;＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
;biying
#b::Run http://cn.bing.com/?mkt=zh-CN

;设备管理器
#h::Run C:\testmonkey\testmonkey\open_device_mgr.bat 0

;删除安装程序
#p::Run C:\testmonkey\testmonkey\open_device_mgr.bat 1

;删除卸载程序

;android resource
#a::Run https://github.com/android/platform_frameworks_base

;谷歌
;#g::
 ;  Run http://203.208.46.148/search?q=%clipboard%
;Return

#s::
Run D:\software\Everything\Everything.exe
Return

;Notepad
#n::Run d:\software\notepad++\notepad++.exe

;OA
#o::Run C:\Program Files\lotus\notes\notes.exe

;adb_push_N1
#q::Run D:\Users\Administrator\Desktop\adb_push_N1.bat

;adb_push _find5
#f::Run D:\Users\Administrator\Desktop\adb_push _find5.bat

;adb_push .bat
#m::Run http://search.mscbsc.com/


;adblog_MTK .bat
#g::Run D:\Users\Administrator\Desktop\adblog_MTK.bat

;lingoes
#t::Run C:\Users\Administrator\AppData\Local\Lingoes\Translator\lingoes-cn\Lingoes.exe

;eclipse
#j::Run D:\software\eclipse-java-kepler-SR1-win32-x86_64\eclipse\eclipse.exe -nl en

; Win + X
;#x:: ; Attention:  Strips formatting from the clipboard too!
;Send ^c
;clipboard = "%clipboard%"
; Remove space introduced by WORD
;StringReplace, clipboard, clipboard,%A_SPACE%",", All
;Send ^v
;return

; F7 to launch or switch to chrome
$F7::
IfWinActive, Google Chrome
{
	WinMinimize, Google Chrome 
	return
}
IfWinExist Google Chrome
{
	WinActivateBottom, Google Chrome
	return
}
Else
{
	Run "D:\software\chrome\chrome.exe"
	return
}
Return

; F8 to launch or switch to rtx
$F8::
If (WinActive("OPPO 深圳分部 ahk_class #32770")) or (WinExist("OPPO 深圳分部 ahk_class #32770"))
{
	WinMinimize OPPO 深圳分部 ahk_class #32770
	return
}
Else
{
	Run "D:\software\RTX\RTX.exe"
	return
}
Return


;ctrl+o to move to symbol window
/*
$F10::
If (WinActive("Android-20140711_0320_14019 Project - Source Insight ahk_class si_Frame"))
{
	;MsgBox, movetoedit = %movetoedit%
	if(movetoedit = 0){
		;MsgBox, movetoedit = 0
		;CoordMode, Mouse, Screen
		;MouseGetPos, xpos, ypos
		Send, {ALTDOWN}l{ALTUP}
		movetoedit = 1
		return	
	}else{
		;MsgBox, movetoedit = %movetoedit%
		Send, {Esc}
		;MouseClick, left, %xpos%, %ypos%
		movetoedit = 0
		return
	}
	;Send, {ALTDOWN}{tab}{ALTUP}	
	return
}
Else
{
	MsgBox not active 
	return
}
Return
*/


$F9::
IfWinExist Lingoes
{
	process=notepad.exe 
	Process, Exist, %process%
	if	pid :=	ErrorLevel
	{
		Loop 
		{
			WinClose, ahk_pid %pid%, , 5	; will wait 5 sec for window to close
			if	ErrorLevel	; if it doesn't close
				Process, Close, %pid%	; force it 
			Process, Exist, %process%
		}	Until	!pid :=	ErrorLevel
	}

	process=Lingoes.exe 
	Process, Exist, %process%
	if	pid :=	ErrorLevel
	{
		Loop 
		{
			WinClose, ahk_pid %pid%, , 5	; will wait 5 sec for window to close
			if	ErrorLevel	; if it doesn't close
				Process, Close, %pid%	; force it 
			Process, Exist, %process%
		}	Until	!pid :=	ErrorLevel
	}
	Return
	
}
Else
{
  Run "C:\Users\Administrator\AppData\Local\Lingoes\Translator\lingoes-cn\Lingoes.exe"

}
Return

$#Del::FileRecycleEmpty ; Win+Del to empty trash (recycle bin)

;$F5::RUN ::{645ff040-5081-101b-9f08-00aa002f954e} ; open trash (recycle bin)

;make Insert key to hide (minimize) current window
$Insert::WinMinimize, A


;::btw::by the way 





;###############################################test##############################################
; EXAMPLE #1: This is a working script that adds a new menu item to the bottom of the tray icon menu.

#Persistent  ; Keep the script running until the user exits it.
Menu, tray, add  ; Creates a separator line.
Menu, tray, add, Item1, MenuHandler  ; Creates a new menu item.
return

MenuHandler:
MsgBox You selected %A_ThisMenuItem% from menu %A_ThisMenu%.
return


;FileSelectFolder, OutputVar, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}  ; 我的电脑.

#1::
{
	MouseGetPos
	Click right
	sleep, 500
	MouseMove, 10, 50, 5, R
	Sleep, 500
	MouseClick, L
	return
}



#i::
{
send {Ctrl Down}a{Ctrl Up}
MouseGetPos
Click right
sleep 100
MouseMove, 10, 400, 5, R
Sleep, 100
;MouseClick, L

;send {alt}w
return
}

