@echo off 
rem �ر��Զ����
rem ��������
:begin
rem set /p input=�������ַ���:

rem ����õ���������Ϣ

rem echo ��������ַ����ǣ�%input%

adb remount
call python %~dp0\script\analyseTime.py C:\1234.log
@pause 
