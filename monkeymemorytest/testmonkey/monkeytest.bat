@echo off 
rem close the auto output
rem autotest 1000 times by default
set times=1000
set option=0
set platform=0

set report_enter_exit=c:/testCameraMemory/report_enter_exit.png
set report_switch_camera=c:/testCameraMemory/report_switch_camera.png
set report_capture_camera=c:/testCameraMemory/report_capture_camera.png
set report_record_camera=c:/testCameraMemory/report_record_camera.png
set report_autofocus_camera=c:/testCameraMemory/report_autofocus_camera.png

set procrank_camera_total=c:/testCameraMemory/procrankCameratotal.tmp
set procrank_mediaserver_total=c:/testCameraMemory/procrankMediaservertotal.tmp
set extramem_total=c:/testCameraMemory/catmeminfototal.tmp
set procrank_page=c:/testCameraMemory/procrankpage.tmp

set psfile=c:/ps.log
echo #####################################
rem edit by zhiquan.huang
echo ѹ�����ԣ�Ĭ��1000��
echo 0: ��������(all) 
echo 1: �����˳����(enter-exit)
echo 2: ǰ���л�����ͷ(switch-camera)
echo 3����ͨ����(capture)
echo 4: ¼��(recording)
echo 5: �Խ�(autofocus)
echo ##################################### 

set /p option=������ѡ��(��������.�ָ�):
set /p times=���Դ���(enterĬ��1000��)
echo ��ѡ�����: %option%  ���� %times%
choice /C 1 /N /M "ѡ��MTK��ѡ��1��ѡ��qualcomm��ѡ��2"
echo platformΪ%ERRORLEVEL%

cd /d c:/testCameraMemory
del /s/q *.tmp
del /s/q *.png

adb remount

:again
echo  the option is %option% 
if "%option%"=="" goto kill
for /F "tokens=1,* delims=." %%a in ("%option%") do (
	set option=%%b
	if %%a==0 goto all
	if %%a==1 goto enter-exit
	if %%a==2 goto switch-camera
	if %%a==3 goto capture
	if %%a==4 goto recording
	if %%a==5 goto autofocus
	echo invalid option exit
	goto end
)

:all
echo all
cd /d c:/testCameraMemory
del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 1 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_enter_exit%

del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 2 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_switch_camera%

del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 3 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_capture_camera%

del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 4 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_record_camera%

del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 5 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_autofocus_camera%
goto again

:enter-exit
echo �����˳��������begin
cd /d c:/testCameraMemory
del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 1 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_enter_exit%
goto again

:switch-camera
echo switch-camera
cd /d c:/testCameraMemory
del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 2 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_switch_camera%
goto again
 
:capture
echo capture
cd /d c:/testCameraMemory
del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 3 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_capture_camera%
goto again

:recording
echo recording
cd /d c:/testCameraMemory
del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 4 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_record_camera%
goto again

:autofocus
echo autofocus
cd /d c:/testCameraMemory
del /s/q *.tmp
call monkeyrunner %~dp0\script\units-monkeyPlayback.py 5 %times% %procrank_page% %procrank_camera_total%
call python %~dp0\script\analyseUssDate.py %procrank_camera_total% %procrank_mediaserver_total% %extramem_total% %report_autofocus_camera%
goto again

:kill
echo kill-mediaserver
adb shell ps > %psfile%
call python %~dp0\script\getMediaserverPid.py %psfile%
rem adb shell kill %errorlevel%
echo kill-mediaserver success
goto end

:end
echo Goodbye
pause