@echo off
echo ==================================================================
echo ���ܣ�����ֻ��ϵ�LOG�ļ����붨ʱ����ֻ��ϵ�LOG!
echo ע�� 1) ���ǰ����ADB
echo      2) ���ǰҪ��MTKLOG�ر�
echo      3) ���ű�������MTKƽ̨Android�����ֻ�
echo  ---------------------------------------                         
echo  @��Ʒ����� ���뻢, 2012-12-07,V2.6
echo  ---------------------------------------  
echo =================================================================

adb remount

adb shell rm -r /cache/assertlog
adb shell rm -r /data/anr
rem adb shell rm -r /data/tombstones

for /F  %%i in ('adb shell ls /data/tombstones/') do (
	set "thisline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "shortthisline=!thisline:~0,-1!"
	echo !shortthisline!
	adb shell rm -r /data/tombstones/!shortthisline!
	ENDLOCAL
)

rem adb shell rm -r /sdcard/mtklog
adb shell rm -r /sdcard/mtklog/config
adb shell rm -r /sdcard/mtklog/mobilelog
adb shell rm -r /sdcard/mtklog/netlog
adb shell rm -r /sdcard/mtklog/aee_exp

for /F  %%i in ('adb shell ls /sdcard/mtklog/mdlog/') do (
	set "thisline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "shortthisline=!thisline:~0,-1!"
	if !shortthisline!==catcher_filter.bin (echo catcher_filter.bin) else (adb shell rm -r /sdcard/mtklog/mdlog/!shortthisline!)	
	ENDLOCAL
)


adb shell rm -r /sdcard/external_sd/mtklog/config
adb shell rm -r /sdcard/external_sd/mtklog/mobilelog
adb shell rm -r /sdcard/external_sd/mtklog/netlog
adb shell rm -r /sdcard/external_sd/mtklog/aee_exp

for /F  %%i in ('adb shell ls /sdcard/external_sd/mtklog/mdlog/') do (
	set "thisline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "shortthisline=!thisline:~0,-1!"
	if !shortthisline!==catcher_filter.bin (echo catcher_filter.bin) else (adb shell rm -r /sdcard/external_sd/mtklog/mdlog/!shortthisline!)	
	ENDLOCAL
)

adb shell rm -r /data/aee_exp

adb shell rm -r /data/core

adb shell rm -r /sdcard/screencapture
adb shell rm -r /sdcard/Pictures/Screenshots
adb shell rm -r /sdcard/屏幕截图
adb shell rm -r /sdcard/external_sd/屏幕截图

adb shell rm -r /data/data/com.mediatek.engineermode/files/oppoMobileLog
adb shell rm -r /mnt/sdcard/oppoMobileLog
adb shell rm -r /mnt/sdcard/external_sd/oppoMobileLog
adb shell rm -r /data/bootlog

adb logcat -c

echo =========================================
echo 		��������
echo =========================================

pause

@echo on