@ECHO OFF
SET STARTADDR=$7FD
SET INPUTFN=Test1
SET OUTTAP=sp.tap
SET AUTOFLAG=1
c:\osdk\bin\xa.exe %INPUTFN%.s -o final.out -e xaerr.txt -l %INPUTFN%.txt
c:\osdk\bin\header.exe -a%AUTOFLAG% final.out %OUTTAP% %STARTADDR%
copy %OUTTAP% c:\emulate\oric\shared /Y
pause
