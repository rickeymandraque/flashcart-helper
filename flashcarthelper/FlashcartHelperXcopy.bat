@echo off
color 0f
cls
::date of compilation
set compiledate=8/27/2011
set sdfolder=Put_This_In_SD_Card
::copyver is whether FlashcartHelper uses xcopy or Robocopy 
set copyver=xcopy
::currentver is version number
set currentver=v0.5.6
::required for auto update check DO NOT CHANGE IF YOU WILL NOT REMOVE :fhtest
IF %errorlevel% EQU 1 goto begin 
::GPL notice
title FlashcartHelper %currentver% %copyver% version: GPL notice
echo  FlashcartHelper %currentver% Copyright (C) 2011  ron975
echo    This program comes with ABSOLUTELY NO WARRANTY; for details read the license
echo    This is free software, and you are welcome to redistribute it
echo    under certain conditions;read the license for details.
echo    This software comes with ABSOLUTELY NO WARRANTY; either express nor implied.
echo    FlashcartHelper is not responsible for any data loss resulting from
echo    improper use of this utility. FlashcartHelper is distributed in the hope that
echo    it will be useful, but this does not guarantee that it will be.
echo    By continueing, it is assumed that you agree to the following terms
pause
cls
title FlashcartHelper %currentver% %copyver% version
echo This is the %copyver% compliant version
echo This version will not work on Windows 7 or above
echo If you are on Windows 7 or above, type "Win 7" (Exactly like that), otherwise, 
echo press enter to continue
set /p xptest=
if "%xptest%" == "Win 7" call FlashcartHelperRobocopy
:wgettest
IF EXIST wget.exe. (
goto unrartest
) ELSE (
echo wget.exe not found
echo Press any key to exit.
pause >nul
exit
)
:unrartest 
IF EXIST unrar.exe. (
goto 7ztest
) ELSE (
echo unrar.exe not found
echo Press any key to download.
pause >nul
start /wait wget http://flashcart-helper.googlecode.com/files/unrar.exe
)

:7ztest
IF EXIST 7za.exe. (
goto fhtest
) ELSE (
echo 7za.exe not found
echo Press any key to download.
pause >nul
start /wait wget http://flashcart-helper.googlecode.com/files/7za.exe
)

:fhtest
echo Loading..
del fhupdater.bat 2> nul
start /wait wget http://flashcart-helper.googlecode.com/files/FHupdater.bat
call fhupdater.bat
::----tests end---
:begin
mode con lines=30
del *.zip 2> nul
del *.7z 2> nul
del *.rar 2> nul
rmdir %cd%\Put_This_In_SD_Card\ /S /Q 2> nul
mkdir Put_This_In_SD_Card 2>nul
:start
cls
set errorlevel=1
:start2
cls
IF %errorlevel% NEQ 1 echo Invalid Choice
echo.
echo                          Welcome to FlashcartHelper.          %currentver% %copyver%
echo                           What do you wish to do?
echo                     __________________________________
color F0
echo [1]Help me setup my cart/Update Kernel
echo.
echo [2]Format my MicroSD
echo.
echo [3]Download Homebrew
echo.
echo [4]Redownload unrar and start 7za
echo.
echo [5]eNDryptS Advance (Decrypt Roms)
echo.
echo [6]NDSTokyoTrim  (Trim Roms)
echo.
echo [R]Readme
echo.
echo [A]About FlashcartHelper
echo.
echo [L]Read License
echo.
echo [E]Exit
echo.
echo Please input your choice
::selection menu
set /p selection=
IF "%selection%" == "1" goto setups
IF "%selection%" == "2" goto format
IF "%selection%" == "3" goto hb
IF "%selection%" == "4" goto redown
IF "%selection%" == "5" goto encrypt
IF "%selection%" == "6" goto trim
IF "%selection%" == "A" goto about
IF "%selection%" == "E" goto exit
IF "%selection%" == "R" goto readmii
IF "%selection%" == "L" goto license
IF "%selection%" == "a" goto about
IF "%selection%" == "e" goto exit
IF "%selection%" == "r" goto readmii
IF "%selection%" == "l" goto license
set errorlevel=0
goto start2
:setups
cls
del guide.txt 2> nul
set errorlevel=1
:setup
::Displays invalid choice if invalid choice
cls
IF %errorlevel% NEQ 1 echo Invalid Choice
echo.
echo                                  ~~Setup~~
echo What is your flashcart?
echo.
echo [1] Supercard DSTwo
echo.
echo [2] Acekard 2i/2.1/R.P.G
echo.
echo [3] R4 Revolution
echo. 
echo [4] DSTT/DSTTi
echo.
echo [5] R4i Gold (r4ids.cn
echo.
echo [6] R4iDSN (r4ids.cn)
echo.
echo [7] CycloDS Evo
echo.
echo [8] CycloDS iEVO
echo.
echo [9] iSmartMM
echo.
echo [B] Go back
echo Please input your choice

set /p FC=
IF "%FC%" == "1" goto ds2 
IF "%FC%" == "2" goto ak2
IF "%FC%" == "3" goto r4
IF "%FC%" == "4" goto tt
IF "%FC%" == "5" goto r4i
IF "%FC%" == "6" goto r4dsn
IF "%FC%" == "7" goto cyclo
IF "%FC%" == "8" goto iEVO
IF "%FC%" == "9" goto mm
IF "%FC%" == "B" goto start2
IF "%FC%" == "b" goto start2
set errorlevel=0
goto setup
:ds2
cls
echo You chose DSTWO
echo Is this correct?
echo (y/n)
set /p ds2yn=
IF "%ds2yn%" == "n" goto start
echo Downloading latest EOS kernel and firmware
start /wait wget http://filetrip.net/h35130066-Supercard-DSTWO-EOS.html
echo Downloading DSTwo setup guide
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/ds2.guide.txt
start /wait unrar x *.rar Put_This_In_SD_card\
start /wait 7za x *.7z  -oPut_This_In_SD_card\
start /wait 7za x *.zip -oPut_This_In_SD_card\
del *.rar
del *.7z
del *.zip
cls
echo Is your DSTWO flashed? (Choose no if you have not used your DSTwo before yet)
echo (y/n)
set /p ds2boot=
IF "%ds2boot%" == "y" goto dstwoboot
IF "%ds2boot%" == "n" goto plug
:dstwoboot
cls
echo Your DSTwo is flashed, correct?
echo (y/n)
set /p sure=
IF "%sure%" == "n" goto plug
del %cd%\Put_This_In_SD_Card\ds2boot.dat

:plug
cls
echo Download Plugins? (Yes is highly recommended)
echo (y/n)
set /p ds2plug=
IF "%ds2plug%" == "n" goto ds2end

echo Downloading NDSGBA and game_config.txt
echo Please wait, this may take a while..
start /wait wget http://filetrip.net/d11694-SuperCard-DSTWO-GBA-EMU-Plug-in-1-21.html
start /wait 7za x *.zip -oPut_This_In_SD_card\
del *.zip
start /wait wget http://filetrip.net/h35130196-SCDS2Iplayer-GBA-EMU-%28game_conf-.html
start /wait 7za x *.7z -oPut_This_In_SD_card\NDSGBA\
del *.7z
echo Downloading CATSFC
echo Please wait, this may take a while..
start /wait wget http://filetrip.net/h35131424-CATSFC.html
start /wait 7za x *.zip -x!version -x!source.txt -x!copyright -x!installation.txt
start /wait xcopy %cd%\CATSFC %cd%\Put_This_In_SD_card\CATSFC /s /e /c /h /i
copy *.ini %cd%\Put_This_In_SD_card\_dstwoplug\*.ini
copy *.bmp %cd%\Put_This_In_SD_card\_dstwoplug\*.bmp
copy *.plg %cd%\Put_This_In_SD_card\_dstwoplug\*.plg
del cat*.*
rmdir %cd%\CATSFC\ /S /Q
del *.zip
echo Downloading iPlayer
echo Please wait, this may take a while..
start /wait wget http://filetrip.net/h35130740-Supercard-DSTWO-iPlayer-Plugin.html
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y
del *.zip
echo Downloading iReader, Please wait
start /wait wget http://filetrip.net/h35130143-DSTwo-iReader.html
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y
del *.zip
echo Download Moonshell? (Yes is recommended)
echo (y/n)
set /p mshlplug=
IF "%mshlplug%" == "n" goto ds2end

echo Downloading Moonshell from Supercard server
start /wait wget http://down.supercard.cn/download/dstwo/plugin/moonshl2_for_DSTWO.zip
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y
del *.zip

echo Download MAME4ALL? (Arcade emulators for the DSTWO)
echo (y/n)
set /p mame4all=
IF "%mame4all%" == "n" goto ds2end
start /wait wget http://filetrip.net/h35130190-MAME4ALL-%28SCDS2%29.html
start /wait 7za x *.7z -oPut_This_In_SD_card\ -y -x!readme.txt
del *.zip
:ds2end
cls
echo A guide will now pop up
echo Please drag eveything in the folder that will pop up to the root of your MicroSD card. Follow the guide for further instructions
pause
ren *.guide.txt guide.txt
start notepad ds2.guide.txt
explorer %cd%\Put_This_In_SD_card\
exit

:ak2
cls
echo You chose Acekard 2i/2.1
echo Is this correct?
echo (y/n)
set /p ak2yn=
IF "%ak2yn%" == "n" goto start

echo Downloading Latest AKAIO Kernel
start /wait wget http://filetrip.net/h7853-AKAIO.html
start /wait 7za x *.zip Put_This_In_SD_Card
start /wait unrar x *.rar Put_This_In_SD_Card
start /wait 7za x *.7z Put_This_In_SD_Card
del *.zip
del *.rar
echo Downloading guide
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r9/data/guides/ak2.guide.txt

echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl

:mshl
echo Downloading MoonShell
echo Please wait, this may take a while.
del *.zip
start /wait wget http://mdxonline.dyndns.org/201002161705_moonshell210stable.zip
start /wait 7za x *.zip
start /wait xcopy 201002161705_moonshell210stable %cd%\Put_This_In_SD_card\ /s /e /c /h /i
rmdir %cd%\Put_This_In_SD_card\misctools /S /Q
rmdir 201002161705_moonshell210stable /S /Q
start /wait wget http://flashcart-helper.googlecode.com/svn/data/misc/moonshl2.ini
copy moonshl2.ini %cd%\Put_This_In_SD_card\moonshl2\moonshl2.ini
del moonshl2.ini
:end
cls
del *.zip 2> nul
del *.7z 2> nul
del *.rar 2> nul
echo A guide will now pop up
echo Please drag eveything in the folder that will pop up to the root of your MicroSD card. 
echo Follow the guide for further instructions
pause
del guide.txt 2> nul
ren *.guide.txt guide.txt 2> nul
start notepad guide.txt
start explorer %cd%\Put_This_In_SD_card\
exit


:r4
cls
echo You chose R4 Revolution
echo Is this correct?
echo (y/n)
set /p r4yn=
IF "%r4yn%" == "n" goto start
echo Downloading latest Wood R4
start /wait wget http://filetrip.net/h25123666-Wood-R4.html
start /wait 7za x *.7z
rmdir %cd%\Put_This_In_SD_Card\ /S /Q 2> nul
for /D %%j in (%cd%\*) do move %%j %%~dpj\Put_This_In_SD_Card
echo Downloading guide
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r9/data/guides/r4.guide.txt
del *.7z
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl

:tt
cls
echo You chose DSTT(i)
echo Is this correct?
echo (y/n)
set /p ttyn=
IF "%ttyn%" == "n" goto start


echo Do you want YSMenu or TTMenu?
echo [1] YSmenu (Loads roms faster and Recommended)
echo [2] TTmenu (Prettier, but loads roms slower)
set /p ystt=
IF "%ystt%" == "1" goto ysmenu
IF "%ystt%" == "2" goto ttmenu

:ysmenu
cls
echo You chose YSmenu
echo Is this correct? (y/n)
set /p ysme=
IF "%ysme%" == "n" goto tt
echo Downloading RetroGameFan's DSTT Updates (YSmenu)
start /wait wget http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html
start /wait unrar x *.rar -y
del *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl
:ttmenu
cls
echo You chose TTmenu
echo Is this correct?
set /p ttme=
IF "%ttme%" == "n" goto tt
echo Downloading RetroGameFan's DSTT Updates (TTMenu)
start /wait wget http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html
start /wait unrar x *.rar -y
del *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi TTMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi TTmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl

:R4i
cls
echo You chose R4i Gold (r4ids.cn)
echo Is this correct?
echo (y/n)
set /p r4iyn=
IF "%r4iyn%" == "n" goto start
echo Downloading guide
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r9/data/guides/r4i.guide.txt
start /wait wget http://filetrip.net/h35130127-Wood-R4-for-R4i-Gold-%28R4iDS%29.html
start /wait unrar x *.rar Put_This_In_SD_card\
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl

:r4dsn
cls
echo You chose R4iDSN (r4ids.cn)
echo Is this correct?
echo (y/n)
set /p r4dyn=
IF "%r4dyn%" == "n" goto start
echo Downloading guide
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r9/data/guides/dsn.guide.txt
echo Downloading latest Wood R4iDSN
start /wait wget http://filetrip.net/h35130793-Wood-R4iDSN.html
start /wait 7za x *.7z 
rmdir %cd%\Put_This_In_SD_Card\ /S /Q 2> nul
for /D %%j in (%cd%\*) do move %%j %%~dpj\Put_This_In_SD_Card
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl

:cyclo
cls
echo You chose CycloDS Evo
echo Is this correct?
echo (y/n)
set /p cyclo=
IF "%cyclo%" == "n" goto start
echo Downloading guide
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r9/data/guides/cyclo.guide.txt
echo Downloading Latest STABLE Evolution firmware
start /wait wget http://filetrip.net/h35130821-CycloDS-Evolution-Firmware-Stable.html
start /wait 7za e *.zip -oPut_This_In_SD_card
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl

:iEVO
cls
echo You chose CycloDS iEVO
echo Is this correct?
echo (y/n)
set /p iEVO=
IF "%iEVO%" == "n" goto start
echo Downnloading guide
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r9/data/guides/ievo.guide.txt
echo Downloading latest STABLE iEvoloution Firmware
del *.zip
start /wait wget http://filetrip.net/h35131267-CycloDS-iEvolution-Firmware-Stable.html
start /wait 7za e *.zip -oPut_This_In_SD_card
cls
echo Do you need to flash your CycloDS iEVO? 
echo (Choose Yes if you have not used your CycloDS iEVO before)
echo (y/n)
set /p evoflash=
IF "%evoflash%" == "n" goto imshl
echo Downloading CycloDS iEvoloution BootStrapper
:bootstrapper
echo What region is your DSi's firmware?
echo [1]US
echo [2]Europe
set /p bootstr=
IF "%bootstr%" == "1" goto EUS
IF "%bootstr%" == "2" goto EEU
exit
:EUS
cls
del *.zip
start /wait wget http://filetrip.net/h35131269-CycloDS-iEvolution-Bootstrap-%28US-.html
start /wait 7za e *.zip -oievobootstrapper
echo WAIT WAIT WAIT WAIT!
echo You need to flash your CycloDS iEvoloution. Read everything before you continue
echo A guide will pop up describing how to flash your iEVO
echo Flashing your iEVO requires 2 roms
echo 1) MechAssault - Phantom War (U)
echo 2) My Healthy Cooking Coach (DSi Enhanced) (US)
echo More information on how to flash your iEVO will be in the text file that will pop up
echo When you are done flashing, close Notepad to continue
pause 
start explorer.exe %cd%\ievobootstrapper\
notepad.exe %cd%\ievobootstrapper\readme.txt

echo Have you flashed your CycloDS iEVO yet?
echo (y/n)
set /p checkboot=
IF "%checkboot%" == "y" goto imshl
IF "%checkboot%" == "n" goto bootstrapper

:EEU
cls
del *.zip
start /wait wget http://filetrip.net/h35131270-CycloDS-iEvolution-Bootstrap-%28Eu-.html
start /wait 7za e *.zip -oievobootstrapper
echo WAIT WAIT WAIT WAIT!
echo You need to flash your CycloDS iEvoloution. Read everything before you continue
echo A guide will pop up describing how to flash your iEVO
echo Flashing your iEVO requires 2 roms
echo 1) MechAssault - Phantom War (U)
echo 2) Mon Coach Personnel - Mes Recettes Plaisir et Ligne (DSi Enhanced) (FR)
echo More information on how to flash your iEVO will be in the text file that will pop up
echo When you are done flashing, close Notepad to continue
pause 
start explorer.exe %cd%\ievobootstrapper\
notepad.exe %cd%\ievobootstrapper\readme.txt

echo Have you flashed your CycloDS iEVO yet?
echo (y/n)
set /p checkboot=
IF "%checkboot%" == "y" goto imshl
IF "%checkboot%" == "n" goto bootstrapper

:imshl
cls
echo Download Moonshell?
echo (y/n)
set /p imshl=
IF "%imshl%" == "n" goto end
start /wait wget http://filetrip.net/h35131285-CycloDS-iEvolution-Moonshell.html
start /wait unrar x *.rar Put_This_In_SD_Card
echo You can access Moonshell from the "Media" icon from the main CycloDS iEVO menu
pause
goto end
exit

:format
mkdir formatter 2> nul
IF EXIST %cd%\formatter\SDFormatter.exe. (
goto formatstart
) ELSE (
del *.rar 2> nul
echo Download Panasonic Formatter?
echo (y/n)
set /p format=
IF "%format%" == "n" goto start
start /wait wget http://filetrip.net/d6027-Panasonic-SD-FormatterPORTABLE.html
start /wait unrar e *.rar formatter
)

:formatstart
start %cd%\formatter\SDformatter.exe
pause
goto start

:up
echo Redownload FlashcartHelper?
echo (y/n)
set /p up=
IF "%up%" == "n" goto start
wget 
FHupdater.bat
exit

:mm
cls
echo You chose iSmartMM
echo Is this correct?
echo (y/n)
set /p imm=
IF "%imm%" == "n" goto start
echo Downloading latest iSmartMM kernel
del *.zip 2> nul
start /wait wget http://filetrip.net/h35132061-iSmart-MM-kernel-update.html
start /wait 7za x *.zip -oPut_This_In_SD_Card
echo Downloading guide file
start /wait wget https://flashcart-helper.googlecode.com/svn-history/r14/data/guides/ismm.guide.txt
echo Download Moonshell?
echo (y/n)
set /p mshlmm=
IF "%mshlmm%" == "n" goto end
echo Downloading MoonShell
echo Please wait, this may take a while.
del *.zip
start /wait wget http://mdxonline.dyndns.org/201002161705_moonshell210stable.zip
start /wait 7za x *.zip
start /wait xcopy 201002161705_moonshell210stable %cd%\Put_This_In_SD_card\ /s /e /c /h /i
rmdir %cd%\Put_This_In_SD_card\misctools /S /Q
rmdir 201002161705_moonshell210stable /S /Q
start /wait wget http://flashcart-helper.googlecode.com/svn/data/misc/moonshl2.ini
copy moonshl2.ini %cd%\Put_This_In_SD_card\moonshl2\moonshl2.ini
del moonshl2.ini
copy %cd%\Put_This_In_SD_card\moonshl2.nds %cd%\Put_This_In_SD_card\ismartplug\moonshell.nds
echo [plug setting] >> %cd%\Put_This_In_SD_card\ismartplug\moonshell.ini
echo icon=fat1:/ismartplug/moonshell.bmp >> %cd%\Put_This_In_SD_card\ismartplug\moonshell.ini
echo name=Moonshell >> %cd%\Put_This_In_SD_card\ismartplug\moonshell.ini
goto end

:hb
start http://filetrip.net/

:redown
echo Redownloading start /wait unrar and 7z.exe
start /wait wget http://flashcart-helper.googlecode.com/files/start /wait unrar.exe
start /wait wget http://flashcart-helper.googlecode.com/files/start /wait 7za.exe
goto begin

:readmii
start notepad.exe Readme
goto start

:about
echo About FlashcartHelper
echo FlashcartHelper %currentver% %copyver% Compliant
echo Compiled %compiledate%
echo By ron975
echo Press any key for credits
pause > nul

echo Credits to..
echo GBAtemp.net 
echo Aijelsop for testing
echo Themanhunt for testing
echo anyone else who volunteered to test my pre-release versions
echo RetroGameFan for letting me use his multi-cart updates
echo The Supercard Team for Supercard EOS
echo The Acekard team for making the acekard
echo The AKAIO team for making AKAIO
echo Yellow Wood Goblin for making Wood R4/RPG
echo Filetrip.net for hosting downloads
echo The R4 Team for making the R4 and proving Slot-1 carts possible
echo The R4ids.cn Team for working with ywg to make Wood R4iDSN and Wood R4iGold
echo Moonlight for Moonshell
echo BrianTokyo for NDSTokyoTrim
echo SolidSnake for eNDryptS advanced

pause
goto start 

:license
start notepad gpl
goto start

:encrypt
cls
color 4F
echo eNDrypt Advance requires FlashcartHelper to be run as Administrator in 
echo Windows Vista and 7
echo.
echo If FlashcartHelper is not running in Administrator mode Press 1 to exit and 
echo restart FlashcartHelper as an Administrator
echo.
echo Otherwise press any other key to continue.
set /p admins=
IF "%admins%" == "1" goto exit
IF EXIST "eNDryptS\eNDryptS Advanced.exe". (
goto drypt
) ELSE (
goto endl
exit
)
:endl
del *.zip
start /wait wget http://filetrip.net/d219-eNDryptS-Advanced-v1-2.html
start /wait 7za e *.zip -x!ind-ndse12.jpg -x!ind-ndse12.nfo
start /wait 7za e ind-ndse12.zip -oeNDryptS -y
:drypt
echo Please put roms in the folder that will pop up, 
echo then press any button to continue
start explorer.exe %cd%\eNDryptS\
pause > nul
echo View guide on how to use eNDrypt Advanced?
echo (y/n)
set /p eguide=
IF "%eguide%" == "n" goto estart
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/enderyptguide.txt
start notepad enderyptguide.txt


:estart
cls
color 0F
title eNDryptS Advance 1.2
del *.zip
"eNDryptS\eNDryptS Advanced.exe"

:trim
IF EXIST "ndstokyotrim\NDSTokyoTrim.exe". (
goto trim2
) ELSE (
goto trimdl
exit
)
:trimdl
mkdir ndstokyotrim
start /wait wget http://eden.fm/apps/NDSTokyoTrim/NDSTokyoTrim25Beta2.exe
move %cd%\NDSTokyoTrim25Beta2.exe %cd%\ndstokyotrim\NDSTokyoTrim.exe
:trim2
start ndstokyotrim\NDSTokyoTrim.exe
goto start
:exit
exit