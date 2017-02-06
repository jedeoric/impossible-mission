@ECHO OFF
SET STARTADDR=$400
SET INPUTFN=Driver
SET OUTTAP=im.tap
SET AUTOFLAG=1

SET ORICUTRON="..\..\..\oricutron\"

SET ORIGIN_PATH=%CD%

mkdir Release\orix\
mkdir Release\orix\usr\
mkdir Release\orix\usr\share\
mkdir Release\orix\usr\share\im
mkdir Release\orix\usr\bin

%osdk%\bin\xa.exe %INPUTFN%.s -o Release\final.out -e Release\xaerr.txt -l Release\%INPUTFN%.txt
%osdk%\bin\header.exe -a%AUTOFLAG% Release\final.out Release\%OUTTAP% %STARTADDR%

echo Generating Orix version 

%osdk%\bin\xa.exe im_title.s -o Release\titletop.hrs
%osdk%\bin\xa.exe Scorepanel.s -o Release\scorepan.hrs

copy Release\titletop.hrs /b + Release\scorepan.hrs Release\orix\usr\share\im\title.hrs

%osdk%\bin\xa.exe %INPUTFN%.s -o Release\orix\im -e Release\telemon-xaerr.txt -l Release\telemon-%INPUTFN%.txt -DTARGET_ORIX


IF "%1"=="NORUN" GOTO End
copy release\orix\im ..\..\..\oricutron\usbdrive\bin
mkdir ..\..\..\oricutron\usbdrive\usr\share\im\
copy Release\orix\usr\share\im\title.hrs ..\..\..\oricutron\usbdrive\usr\share\im\

cd %ORICUTRON%
OricutronV4 -mt -d teledisks\stratsed.dsk
rem Oricutron_ch376V3 -mt -d teledisks\stratsed.dsk
cd %ORIGIN_PATH%
:End