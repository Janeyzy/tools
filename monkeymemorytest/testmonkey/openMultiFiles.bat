@echo off
rem call monkeyrunner %~dp0\script\units-monkeyPlayback.py 1 %times% %procrank_page% %procrank_camera_total%
rem �ڵ�ǰĿ¼��cmd���� cmd.exe /k pushd %1
rem %~dp0 ��ǰ���������̷��Լ�·��
set FilesPath=%cd%
rem echo %FilesPath%
call pypy %~dp0\script\openMultiFiles.py "%FilesPath%"

rem ping -n 1 127.0.0.1>nul
exit
