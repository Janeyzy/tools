@echo off
title get_qualcomm_log [by Pan tengjiao]
goto BEGIN

:COMMENT
echo ##############################################
rem 	get_qualcomm_log.bat
rem			By Tengjiao.Pan @2014-01-21
rem 	Description:
rem 		Used to get qualcomm log 
rem 	Version: 1.0
rem
echo ##############################################

:BEGIN
echo ##########################################################
echo ���ܣ���ȡ�ֻ��ϵ�LOG�ļ�
echo ע�� 1) ��ȡǰ����ADB
echo      2) ����BUGʱ���뾡���ܽ���ͼƬ�Ա������
echo      3) ��ȡ��LogĬ�ϱ�����D:/logĿ¼
echo         @Create by Panda , 2014-01-21,V1.0
echo ##########################################################

set "CURR_TIME=%date:~,4%_%date:~5,2%_%date:~8,2%_%time:~,2%_%time:~3,2%_%time:~6,2%"

set DEST_DIR=d:\log\log_qualcomm_%CURR_TIME%\

md "%DEST_DIR%"
md "%DEST_DIR%cur_log\"

adb pull /cache/admin/assertlog  "%DEST_DIR%cur_log\oppo_assertlog"
adb pull /cache/admin/apps  "%DEST_DIR%cur_log\apps"
adb pull /cache/admin/kernel "%DEST_DIR%cur_log\kernel"

adb pull /mnt/sdcard/Pictures/Screenshots "%DEST_DIR%Screenshots"

md  "%DEST_DIR%per_log"
cd   /d  "%DEST_DIR%per_log"

adb shell ls /sdcard/admin/
for /F  %%i in ('adb shell ls /sdcard/admin/') do (
	set "curline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "templine=!curline:~0,-1!"
	echo !templine!
	adb pull /sdcard/admin/!templine!  !templine!
	ENDLOCAL
)

cd ..
rmdir "%DEST_DIR%per_log"

md  "%DEST_DIR%data/tombstones"
cd   /d  "%DEST_DIR%data/tombstones"

adb shell ls /data/tombstones/

for /F  %%i in ('adb shell ls /data/tombstones/') do (
	set "curline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "templine=!curline:~0,-1!"
	echo !templine!
	adb pull /data/tombstones/!templine!  !templine!
	ENDLOCAL
)

cd ..
rmdir "%DEST_DIR%data/tombstones"
cd ..
rmdir "%DEST_DIR%data"

md  "%DEST_DIR%tombstones"
cd   /d  "%DEST_DIR%tombstones"

for /F  %%i in ('adb shell ls /tombstones/') do (
	set "curline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "templine=!curline:~0,-1!"
	echo !templine!
	adb pull /tombstones/!templine!  !templine!
	ENDLOCAL
)

cd ..
rmdir "%DEST_DIR%tombstones"

md  "%DEST_DIR%dropbox"
cd   /d  "%DEST_DIR%dropbox"

for /F  %%i in ('adb shell ls /data/system/dropbox/') do (
	set "curline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "templine=!curline:~0,-1!"
	echo !templine!
	adb pull /data/system/dropbox/!templine!  !templine!
	ENDLOCAL
)

cd ..
rmdir "%DEST_DIR%dropbox"

md  "%DEST_DIR%device_modem_log"
cd   /d  "%DEST_DIR%device_modem_log"

for /F  %%i in ('adb shell ls /sdcard/diag_logs/') do (
	set "curline=%%i"
	SETLOCAL EnableDelayedExpansion
	set "templine=!curline:~0,-1!"
	echo !templine!
	adb pull /sdcard/diag_logs/!templine!  !templine!
	ENDLOCAL
)

cd ..
rmdir "%DEST_DIR%device_modem_log"


rmdir %DEST_DIR%

if exist "%DEST_DIR%" goto finish
echo ##########################################################
echo  ��ȡLOGʧ�ܣ��п���ADBû���ϻ��ֻ���û��LOG���ڣ�����
echo ##########################################################
goto exit

:finish
echo ##########################################################
echo  �뵽Ŀ¼--"%DEST_DIR%"--�»�ȡLOG��
echo ##########################################################

pause
exit

:exit
pause