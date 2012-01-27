@echo off
::To translators
::Please do not change commented lines, (lines with :: in fron of it)
::Also, only change lines with echo infront of it.
::Also, you may replace the GPL notice with translated versions from
::http://www.gnu.org/licenses/licenses.html#translations
::The license is GNU GPL v3.0
color 0f
cls
::date of compilation
set compiledate=9/1/2011
::copyver is whether FlashcartHelper uses xcopy or Robocopy 
set copyver=xcopy
::currentver is version number
set currentver=v0.6
::required for auto update check DO NOT CHANGE IF YOU WILL NOT REMOVE :fhtest
::IF %errorlevel% EQU 1 goto begin 
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
echo    By continuing, it is assumed that you agree to the following terms
pause
cls
title FlashcartHelper %currentver% %copyver% version
echo This is the %copyver% compliant version
echo This version will not work on Windows 7 or above
echo If you are on Windows 7 or above, type "Win7" (Exactly like that), otherwise, 
echo press enter to continue
set /p xptest=
if "%xptest%" == "Win7" goto FlashcartHelperRobocopy
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
::echo Loading..
::start /wait wget http://flashcart-helper.googlecode.com/files/FHupdater.bat
::call fhupdater.bat
::----tests end---
:begin
del fhupdater.bat 2> nul
mode con lines=40
del *.zip 2> nul
del *.7z 2> nul
del *.rar 2> nul
rmdir %cd%\Put_This_In_SD_Card\ /S /Q 2> nul
mkdir Put_This_In_SD_Card 2>nul
:start
cls
set error=1
:start2
cls
IF %error% NEQ 1 echo Invalid Choice
title FlashcartHelper %currentver% %copyver% version
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
echo [7]Download DSi Firmware Fixes (Use this option at your own risk)
echo.
echo [R]Readme
echo.
echo [A]About FlashcartHelper
echo.
echo [L]Read License
echo.
echo [U]Update FlashcartHelper
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
IF "%selection%" == "U" goto update
IF "%selection%" == "u" goto update
IF "%selection%" == "A" goto about
IF "%selection%" == "E" goto exit
IF "%selection%" == "R" goto readmii
IF "%selection%" == "L" goto license
IF "%selection%" == "a" goto about
IF "%selection%" == "e" goto exit
IF "%selection%" == "r" goto readmii
IF "%selection%" == "l" goto license
IF "%selection%" == "7" goto dsi
set error=0
goto start2
:setups
cls
del guide.txt 2> nul
set ind=1
:setup
::Displays invalid choice if invalid choice
cls
IF %ind% NEQ 1 echo Invalid Choice
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
echo [10] EZ Flash 5
echo.
echo [11] EZ Flash 5i
echo.
echo [12] M3 Real/M3 Simply/M3i Zero
echo.
echo [13] R4 Clones
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
IF "%FC%" == "10" goto ez5
IF "%FC%" == "11" goto ez5i
IF "%FC%" == "12" goto m3
IF "%FC%" == "13" goto clone
IF "%FC%" == "B" goto start2
IF "%FC%" == "b" goto start2
set ind=0
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
del *.dat 2> nul
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
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r17/data/guides/r4.guide.txt
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
echo You chose R4iDSN (r4idsn.com)
echo Is this correct?
echo (y/n)
set /p r4dyn=
IF "%r4dyn%" == "n" goto start
echo Downloading guide
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r17/data/guides/dsn.guide.txt
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

:update 
start /wait wget http://flashcart-helper.googlecode.com/files/FHupdater.bat
call FHupdater.bat

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

:ez5
cls
echo You chose EZ Flash 5
echo If you meant EZ Flash 5i, please go back and select the EZ5i option.
echo Is this correct?
echo (y/n)
set /p ez5=
IF "%ez5%" == "n" goto start
echo Downloading latest EZ5 kernel
start /wait wget http://filetrip.net/h25124137-EZ5-Kernel.html
start /wait 7za x *.zip -oPut_This_In_SD_Card
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/ez5.guide.txt
echo You need atleast 1 .NDS file to load your EZ Flash 5
echo Download Moonshell?
echo (y/n)
set /p mshez5=
IF "%mshez5%" == "y" goto mshl
IF "%mshez5%" == "n" goto end
goto end

:ez5i
cls
echo You chose EZ Flash 5i
echo If you meant EZ Flash 5, please go back and select the EZ5 option.
echo Is this correct?
echo (y/n)
set /p ez5i=
IF "%ez5i%" == "n" goto start
echo Downloading latest EZ5i kernel
start /wait wget http://filetrip.net/h25124710-EZ5i-Kernel.html
start /wait unrar x *.rar Put_This_In_SD_Card
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/ez5.guide.txt
echo If you have not yet updated your EZ5i to v101, please run ez5firmwreUP_V101.nds
echo If your cart says "No need to update" you do not need to update to v101.
echo You need atleast 1 .NDS file to load your EZ Flash 5
del %cd%\Put_This_In_SD_Card\ez5firmwreUP_V103.nds 2> nul
echo Download Moonshell?
echo (y/n)
set /p mshez5i=
IF "%mshez5i%" == "y" goto mshl
IF "%mshez5i%" == "n" goto end
exit

:m3
cls
echo You chose M3 Real/M3 Simply/M3i Zero
echo This will not work with the M3i Zero gmp-z003
echo Is this correct?
echo (y/n)
set /p m3=
IF "%m3%" == "n" goto start
echo Downloading latest M3 Quad-Boot
start /wait wget http://filetrip.net/h25123141-The-M3-Quad-Boot.html
start /wait 7za x *.7z -oPut_This_In_SD_Card
start /wait wget http://flashcart-helper.googlecode.com/svn-history/r17/data/guides/m3.guide.txt
echo Download Moonshell?
echo (y/n)
set /p m3msh=
IF "%m3msh%" == "y" goto mshl
IF "%m3msh%" == "n" goto end

:clone
cls
mode con lines=50
echo R4 Clones are separated into groups. 
echo Please select the group your clone belongs to.
echo This list is sorted by
echo (Name of cart) - (website)
:group1
echo.
echo A Guide for R4 clones is not availible at this time. Sorry for the inconvenience. > guide.txt
echo    ----------------
echo [1]    Group 1 
echo Group 1 includes
echo DSTTi Gold - www.ndstti.cn
echo DSTT-Advance - www.dsttadv.com
echo R4Top Revolution - www.r4top.com 
echo R4i-SDHC v3.07 www.r4ll-net.com
echo.
echo   -----------------
echo [2]   Group 2
echo R4iTT - www.r4itt.net
echo R4IIISDHC v3.07 www.r4iiisdhc.com
echo.
echo   -----------------
echo [3]   Group 3
echo R4i V1.45 Revolution - www.ndsiLL.net 
echo R4i SDHC Upgrade Revolution - r4i-sdhc.com.tw
echo R4i Gold Upgrade Revolution v1.4.1 - www.r4igold.cn
echo.
echo   -----------------
echo [4]   Group 4
echo R4i DSi XL - www.r4i-ndsill.com 
echo R4V-R4i v2.2 and v2.5 - www.r4-v.com
echo.
echo   -----------------
echo [5]   Group 5
echo R4i Gold Upgrade Revolution v1.14b - www.r4igold.cn
echo.
echo   -----------------
echo [6]   Group 6
echo R4i SDHC Upgrade Revolution - r4i-dshc.com 
echo.
echo   -----------------
echo [7]   Group 7
echo R4i King LL - www.r4-king.com 
echo.
echo   -----------------
echo [8]   Group 8
echo R4SDHC v1.34 - www.r4sdhc.com

set /p group1=
IF "%group1%" == "1" goto g1
IF "%group1%" == "2" goto g2
IF "%group1%" == "3" goto g3
IF "%group1%" == "4" goto g4
IF "%group1%" == "5" goto g5
IF "%group1%" == "6" goto g6
IF "%group1%" == "7" goto g7
IF "%group1%" == "8" goto g8
goto start
:g1
cls
echo You chose Group 1
echo Is this correct? (y/n)
set /p g1=
IF "%g1%" == "n" goto start
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
set /p gmshl=
IF "%gmshl%" == "n" goto end
IF "%gmshl%" == "y" goto mshl

:g2
echo You chose Group 2
echo Is this correct? (y/n)
set /p g2=
IF "%g2%" == "n" goto start
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
ren Put_This_In_SD_card\TTmenu.dat R4.dat
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p g2mshl=
IF "%g2mshl%" == "n" goto end
IF "%g2mshl%" == "y" goto mshl

:g3
echo You chose Group 3
echo Is this correct? (y/n)
set /p g3=
IF "%g3%" == "n" goto start
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
ren Put_This_In_SD_card\TTmenu.dat iLL.iL
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p g3mshl=
IF "%g3mshl%" == "n" goto end
IF "%g3mshl%" == "y" goto mshl

:g4
echo You chose Group 4
echo Is this correct? (y/n)
set /p g4=
IF "%g4%" == "n" goto start
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
copy Put_This_In_SD_card\TTmenu.dat Put_This_In_SD_card\iLL.iL
ren Put_This_In_SD_card\TTmenu.dat R4i.TP
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p g4mshl=
IF "%g4mshl%" == "n" goto end
IF "%g4mshl%" == "y" goto mshl

:g5
echo You chose Group 5
echo Is this correct? (y/n)
set /p g5=
IF "%g5%" == "n" goto start
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
copy Put_This_In_SD_card\TTmenu.dat Put_This_In_SD_card\R4i.dat
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p g5mshl=
IF "%g5mshl%" == "n" goto end
IF "%g5mshl%" == "y" goto mshl

:g6
echo You chose Group 6
echo Is this correct? (y/n)
set /p g6=
IF "%g6%" == "n" goto start
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
ren Put_This_In_SD_card\TTmenu.dat R4i.TP
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p g6mshl=
IF "%g6mshl%" == "n" goto end
IF "%g6mshl%" == "y" goto mshl

:g7
echo You chose Group 7
echo Is this correct? (y/n)
set /p g7=
IF "%g7%" == "n" goto start
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
ren Put_This_In_SD_card\TTmenu.dat R4KING
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p g7mshl=
IF "%g7mshl%" == "n" goto end
IF "%g7mshl%" == "y" goto mshl

:g8
echo You chose Group 8
echo Is this correct? (y/n)
set /p g8=
IF "%g8%" == "n" goto start
echo Downloading RetroGameFan's DSTT Updates (YSmenu)
start /wait wget http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html
start /wait unrar x *.rar -y
del *.rar
start /wait 7za a -tzip ystt.zip "R4SDHC"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "R4SDHC" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
del *.zip
del *.rar
echo Download Moonshell?
echo (y/n)
set /p g8mshl=
IF "%g8mshl%" == "n" goto end
IF "%g8mshl%" == "y" goto mshl
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
echo The R4 Team for making the R4
echo The R4ids.cn Team for working with ywg to make Wood R4iDSN and Wood R4iGold
echo Moonlight for Moonshell
echo BrianTokyo for NDSTokyoTrim
echo SolidSnake for eNDryptS advanced
echo A Gay Little Cat Boy for M3 QuadBoot
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


:dsi
cls
echo This option is for updating your flashcart for the latest 3DS/DSi firmware
echo The latest DSi firmware is 1.4.3, 1.4.4C
echo The latest 3DS firmware is 2.1.0-4
echo This option is up to date as of August 29th 2011
echo.
echo FlashcartHelper is not responsible for bricked flashcarts resulting from 
echo improper use of this option.
echo.
echo DSi Firmware fixes are availible for...
echo [1] Supercard DSTWO
echo [2] Acekard 2i
echo [3] R4i Gold (Non 3DS version) (r4ids.cn)
echo [4] R4i Gold (3DS version) (r4ids.cn)
echo [5] R4iDSN (Non 3DS version) (r4idsn.com)
echo [6] R4iDSN (3DS version) (r4idsn.com)
echo [7] EZ5i
echo.
echo All other carts do not have a DSi 1.4.3 compatible patch.


echo The following patches are only compatible to up to DSi firmware 1.4.2 
echo and/or 3DS 2.1.0-4
echo.
echo [8] M3i Zero
echo [9] DSTTi
echo [B] Go back to the main menu
set /p dsifirm=
IF "%dsifirm%" == "1" goto firmdstwo
IF "%dsifirm%" == "2" goto firmak2
IF "%dsifirm%" == "3" goto firmr4igold
IF "%dsifirm%" == "4" goto firmr4i3ds
IF "%dsifirm%" == "5" goto firmr4idsn
IF "%dsifirm%" == "6" goto firmr4idsn3ds
IF "%dsifirm%" == "7" goto firmez5i
IF "%dsifirm%" == "8" goto firmm30
IF "%dsifirm%" == "9" goto firmtti
IF "%dsifirm%" == "B" goto start
:firmdstwo
cls
echo You chose DSTWO
echo Is this correct?
echo (y/n)
set /p firmdstwo=
IF "%firmdstwo%" == "n" goto exit

start /wait wget http://down.supercard.sc/download/dstwo/Firmware/Firmware_v1.12_eng.zip
start /wait 7za x *.zip 
del *.zip
rmdir Put_This_In_SD_Card /S /Q
ren eng Put_This_In_SD_Card
cls
echo.
echo Please put the file dstwoupdate.dat in the ROOT of your SD card
echo Then boot your DSTWO and it will prompt you to update.
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
start explorer.exe %cd%\Put_This_In_SD_Card
echo Press any key to exit. 
pause > nul
:firmak2
cls
echo You chose Acekard 2i
echo Is this correct?
echo (y/n)
set /p firmak2=
IF "%firmak2%" == "n" goto exit
start /wait wget http://www.acekard.com/download/ak2/ak2ifw_update_3ds21_DSi143.zip
start /wait 7za x *.zip -oPut_This_In_SD_Card
cls
echo Please put the files 
echo ak2ifw_update_3ds21_DSi143_onDSi_NO44.nds 
echo ak2ifw_update_3ds21__DSi143_onDSL_NO44.nds
echo to the ROOT of your SD Card
echo Then run the file that is most appropiate for your system.
echo.
echo Use ak2ifw_update_3ds21_DSi143_onDSi_NO44.nds if you are on a
echo DSi, DSi XL, or 3DS
echo.
echo Use ak2ifw_update_3ds21__DSi143_onDSL_NO44.nds if you are on a 
echo DS Phat or DS Lite
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card
echo Press any key to exit. 
pause > nul
:firmr4igold
cls
echo You chose R4i Gold Non-3DS version
echo Is this correct?
echo (y/n)
set /p firmr4i=
IF "%firmr4i%" == "n" goto exit
start /wait wget ftp://r4idsdown:r4idsdown@www.r4ids.co.cc/V143_Patch_R4iGold_Non3DS.rar
start /wait unrar x *.rar Put_This_In_SD_Card
cls
echo Please put the files 
echo V143_Update_R4iGold_Non3DS_NDSi.nds
echo V143_Update_R4iGold_Non3DS_NDSL.nds
echo to the ROOT of your SD Card
echo Then run the file that is most appropiate for your system.
echo.
echo Use V143_Update_R4iGold_Non3DS_NDSi.nds if you are on a
echo DSi, DSi XL, or 3DS
echo.
echo Use V143_Update_R4iGold_Non3DS_NDSL.nds if you are on a 
echo DS Phat or DS Lite
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card
echo Press any key to exit. 
:firmr4i3ds
cls
echo You chose R4i Gold 3DS version
echo Updating the R4i Gold 3DS version is not nessacary
echo If you do not wish to continue, press n
echo Only use this patch if you have a problem with your R4i Gold 3DS version
echo On DSi firmware 1.4.3
echo (y/n)
set /p firmr4i=
IF "%firmr4i%" == "n" goto exit
start /wait wget ftp://r4idsdown:r4idsdown@www.r4ids.co.cc/V143_Patch_R4iGold_3DS.rar
start /wait unrar x *.rar Put_This_In_SD_Card
cls
echo Please put the files 
echo V143_Patch_R4iGold3DS_NDSi.nds
echo V143_Patch_R4iGold3DS_NDSL.nds
echo to the ROOT of your SD Card
echo Then run the file that is most appropiate for your system.
echo.
echo Use V143_Patch_R4iGold3DS_NDSi.nds if you are on a
echo DSi, DSi XL, or 3DS
echo.
echo Use V143_Patch_R4iGold3DS_NDSL.nds if you are on a 
echo DS Phat or DS Lite
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card
echo Press any key to exit. 
:firmr4idsn
cls
echo You chose R4iDSN Non-3DS version
echo Is this correct?
echo (y/n)
set /p firmr4idsn=
IF "%firmr4idsn%" == "n" goto exit
start /wait wget http://r4idsn.com/admin/userimages/V143_Patch_R4iDSN_Non3DS.rar
start /wait unrar x *.rar Put_This_In_SD_Card
cls
echo Please put the files 
echo V143_Patch_R4iDSN_Non3DS_NDSi.nds
echo V143_Patch_R4iDSN_Non3DS_NDSL.nds
echo to the ROOT of your SD Card
echo Then run the file that is most appropiate for your system.
echo.
echo Use V143_Patch_R4iDSN_Non3DS_NDSi.nds if you are on a
echo DSi, DSi XL, or 3DS
echo.
echo Use V143_Patch_R4iDSN_Non3DS_NDSL.nds if you are on a 
echo DS Phat or DS Lite
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card

:firmr4idsn3ds
cls
echo You chose R4iDSN 3DS version
echo Updating the R4iDSN 3DS version is not nessacary
echo If you do not wish to continue, press n
echo Only use this patch if you have a problem with your R4i Gold 3DS version
echo On DSi firmware 1.4.3
echo (y/n)
set /p firmr4idsn3ds=
IF "%firmr4idsn3ds%" == "n" goto exit
start /wait wget http://r4idsn.com/admin/userimages/V143_Patch_R4iDSN_3DS.rar
start /wait unrar x *.rar Put_This_In_SD_Card
cls
echo Please put the files 
echo V143_Patch_R4iDSN_3ds_NDSi.nds
echo V143_Patch_R4iDSN_3DS_NDSL.nds
echo to the ROOT of your SD Card
echo Then run the file that is most appropiate for your system.
echo.
echo Use V143_Patch_R4iDSN_3ds_NDSi.nds if you are on a
echo DSi, DSi XL, or 3DS
echo.
echo Use V143_Patch_R4iDSN_3DS_NDSL.nds if you are on a 
echo DS Phat or DS Lite
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card
:firmez5i
cls
echo You chose EZ-Flash Vi (EZ5i)
echo Is this correct?
echo (y/n)
set /p firmez5i=
IF "%firmez5i%" == "n" goto exit
start /wait wget http://www.ezflash.cn/zip/EZ5F106A.rar
start /wait unrar x *.rar Put_This_In_SD_Card
cls
echo Please put the file EZ5F106A.nds 
echo to the ROOT of your SD Card.
echo DO NOT RENAME THE FILE
echo Make sure you are first on firmware v101 before updating
echo Run EZ5F106A.nds to update
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
echo If you rename the file your EZ5i will be BRICKED
pause
start explorer.exe %cd%\Put_This_In_SD_Card
:firmm30
cls
echo You chose M3i Zero
echo Is this correct?
echo (y/n)
set /p firmm3=
IF "%firmm3%" == "n" goto exit
start /wait wget http://filetrip.net/d25495-M3i-Zero-Core-2-0-2.html
start /wait 7za x *.rar -oPut_This_In_SD_Card
cls
echo Please put the file F_CORE.dat
echo to the ROOT of your SD Card.
echo DO NOT RENAME THE FILE
echo Then flash your M3i Zero with the flashing cable.
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card
:firmtti
cls
echo You chose DSTTi
echo Is this correct?
echo (y/n)
set /p firmdst=
IF "%firmdst%" == "n" goto exit
cls
start /wait wget http://goo.gl/qW9Pt
start /wait wget http://www.ndstt.com/download/os/v1.17/ttmenu_en.zip
start /wait 7za x *.zip -oPut_This_In_SD_Card
echo First, BACK UP YOUR SD CARD
echo This will overwrite your current kernel with an official version that is no longer supported
echo This update will only work on the official kernel.
echo After you updated the firmware, please replace the kernel with
echo RetroGameFan's updates.
echo Please put all the files in the folder that will pop up
echo to the ROOT of your MicroSD card
echo Including..
echo rom_pcb0.dat
echo rom_pcb1.dat
echo rom_pcb2.dat
echo TTi142UPGRADE.nds
echo to the ROOT of your SD Card
echo Then run TTi142UPGRADE.nds
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card

:exit
exit
 
:FlashcartHelperRobocopy
FlashcartHelperRobocopy





