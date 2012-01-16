@echo off
::Log Start message
echo --Start log FlashcartHelper %time% %date%-- >> fh.log
::Forces move, copy and other commands to suppress confirmation 
SET COPYCMD=/Y
::Determines if FlashcartHelper runs in the Desktop, Userprofile, Windows direcory, Documents folder, or root. If yes, FH will refuse to run.
IF "%cd%" EQU "%userprofile%\Desktop" goto invpath
IF "%cd%" EQU "%userprofile%" goto invpath
IF "%cd%" EQU "%windir%\*" goto invpath
IF "%cd%" EQU "C:" goto invpath
IF "%cd%" EQU "%userprofile%\Documents" goto invpath
::If "Put_This_In_SD_Card exists, will rename to "Put_This_In_SD_Card_OLD". If "Put_This_In_SD_Card_OLD" exists, will delete "Put_This_In_SD_Card_OLD"
IF EXIST "%cd%\Put_This_In_SD_Card_OLD\" rd Put_This_In_SD_Card_OLD /s /q
IF EXIST "%cd%\Put_This_In_SD_Card\" ren Put_This_In_SD_Card Put_This_In_SD_Card_OLD
IF NOT EXIST "%cd%\Put_This_In_SD_Card\" mkdir Put_This_In_SD_Card >>fh.log 2>&1
IF NOT EXIST "%cd%\Trashes\" mkdir Trashes >>fh.log 2>&1

::To translators
::Please do not change commented lines, (lines with :: in front of it)
::Also, only change lines with echo infront of it.
::Also, you may replace the GPL notice with translated versions from
::http://www.gnu.org/licenses/licenses.html#translations
::The license is GNU GPL v3.0

::date of compilation
set compiledate=1/12/2012
::file cleanup, invoke frec to delete guide.fhg and any text files
frec guide.fhg 2> nul
frec *.txt 2> nul
::currentver is version number
set currentver=0.9 RC3 r10
::Update routine, if fh.bat exists, will go directly to begin. If not, will continue.
:uptest
IF EXIST FHup.bat. (
goto begin
) ELSE (
goto gpl
)
:gpl
::GPL notice
cls
title FlashcartHelper %currentver% version: GPL notice
echo FlashcartHelper %currentver% Copyright (C) 2011  Punyman
echo    This program comes with ABSOLUTELY NO WARRANTY; neither express not implied
echo    This is free software, and you are welcome to redistribute it
echo    under certain conditions;read the license for details.
echo    FlashcartHelper is not responsible for any data loss resulting from
echo    improper use of this utility, including Data corruption, 
echo    or bricked flashcarts. FlashcartHelper is distributed in the hope that
echo    it will be useful, but this does not guarantee that it will be. 
echo    By continuing, it is assumed that you agree to the following terms
pause
cls
::sets title of the Window to "FlashcartHelper [version]"
title FlashcartHelper %currentver%
::tests if wget is present
:wgettest
IF EXIST wget.exe. (
goto unrartest
) ELSE (
echo wget.exe not found
echo Press any key to exit.
pause >nul
exit
)
::tests if unrar is present, if not, will download
:unrartest 
IF EXIST unrar.exe. (
goto 7ztest
) ELSE (
echo unrar.exe not found
echo Press any key to download.
pause >nul
start /wait wget http://flashcart-helper.googlecode.com/files/UnRAR.exe
goto 7ztest
)
::tests if 7za is present, if not will download
:7ztest
IF EXIST 7za.exe. (
goto frectest
) ELSE (
echo 7za.exe not found
echo Press any key to download.
pause >nul
start /wait wget http://flashcart-helper.googlecode.com/files/7za.exe
goto frectest
)
::tests if frec is present, if not, will download
:frectest
IF EXIST frec.exe. (
goto uptest
) ELSE (
echo frec.exe not found
echo Press any key to download
pause >nul
start /wait wget 
goto uptest
)
::required or it will go into an infinite loop.
:uptest
IF EXIST FHup.bat. (
goto begin
) ELSE (
goto up
)
::fetches update file, disabled in BAT versions , source
:up
::Fetch Update File
::wget -q http://flashcart-helper.googlecode.com/files/fhup.bat >nul
::call fhup.bat

::begin routine
:begin
::sets var workdir to current dir
set workdir=%cd%
::deletes fhup.bat. DO NOT frec!
del FHup.bat 2> nul
set FC=
set menuguide=
::file cleanup
frec *.zip 2> nul
frec *.7z 2> nul
frec *.rar 2> nul

::sets error to 1, if not 1, will return Invalid choice
:start
cls
set error=1
:start2
::main menu
cls
mode con lines=50
IF %error% NEQ 1 echo Invalid Choice
title FlashcartHelper %currentver%
echo.
echo                          Welcome to FlashcartHelper.          v%currentver%
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
echo [8]DS-Scene Rom Helper (Download latest CMP cheat DB)
echo.
echo [9]Install MENUdo (ClouDS) for my Flashcart
echo.
echo [B]Backup/Restore MicroSD card
echo.
echo [R]Readme
echo.
echo [A]About FlashcartHelper
echo.
echo [L]Read License
echo.
echo [U]Update FlashcartHelper
echo.
echo [C]Clear log file
echo.
echo [F]File Cleanup and Clear Trashes file
echo.
echo [D]Download List BETA
echo.
echo [E]Exit
echo.
echo Please input your choice
::selection 
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
IF "%selection%" == "8" goto cmp
IF "%selection%" == "9" goto menudo
IF "%selection%" == "b" goto bak
IF "%selection%" == "B" goto bak
IF "%selection%" == "C" goto clrlog
IF "%selection%" == "c" goto clrlog
IF "%selection%" == "F" goto clrtrash
IF "%selection%" == "f" goto clrtrash
IF /i "%selection%" == "d" goto dlist
set error=0
goto start2
:setups
:: if ind NEQ 1, setup menu will return invalid choice
cls
set ind=1
:setup
::Displays invalid choice if invalid choice
cls
mode con lines=45
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
echo [4] DSTT/DSOnei
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
echo [14] Supercard DSOne
echo.
echo [15] Supercard DSOne SDHC
echo.
echo [16] Supercard DSonei
echo.
echo [17] iSmart Premuim
echo.
echo [18] EDGE
echo.
echo [19] iEDGE
echo.
echo [B] Go back
echo Please input your choice
::FC selection
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
IF "%FC%" == "14" goto ds1
IF "%FC%" == "15" goto ds1sdhc
IF "%FC%" == "16" goto ds1i
IF "%FC%" == "17" goto ispp
IF "%FC%" == "18" goto edge
IF "%FC%" == "19" goto iedge
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
frec *.rar
frec *.7z
frec *.zip
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
frec "%cd%\Put_This_In_SD_Card\ds2boot.dat"

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
frec *.zip
start /wait wget http://filetrip.net/h35130196-SCDS2Iplayer-GBA-EMU-%28game_conf-.html
start /wait 7za x *.7z -oPut_This_In_SD_card\NDSGBA\
frec *.7z
echo Downloading CATSFC
echo Please wait, this may take a while..
start /wait wget http://filetrip.net/h35131424-CATSFC.html
start /wait 7za x *.zip -x!version -x!source.txt -x!copyright -x!installation.txt
start /wait 7za a -tzip cat.zip "CATSFC"
start /wait 7za x cat.zip -oPut_This_In_SD_card
copy *.ini "%cd%\Put_This_In_SD_card\_dstwoplug\*.ini" >>fh.log 2>&1
copy *.bmp "%cd%\Put_This_In_SD_card\_dstwoplug\*.bmp" >>fh.log 2>&1
copy *.plg "%cd%\Put_This_In_SD_card\_dstwoplug\*.plg" >>fh.log 2>&1
frec cat*.*
frec CATSFC
frec *.zip
echo Downloading iPlayer
echo Please wait, this may take a while..
start /wait wget http://filetrip.net/h35130740-Supercard-DSTWO-iPlayer-Plugin.html
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y
frec *.zip
echo Downloading iReader, Please wait
start /wait wget http://filetrip.net/h35130143-DSTwo-iReader.html
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y
frec *.zip
echo Download Moonshell? (Yes is recommended)
echo (y/n)
set /p mshlplug=
IF "%mshlplug%" == "n" goto ds2end

echo Downloading Moonshell from Supercard server
start /wait wget http://down.supercard.cn/download/dstwo/plugin/moonshl2_for_DSTWO.zip
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y
frec *.zip

:ds2end
cls
echo A guide will now pop up
echo Please drag eveything in the folder that will pop up to the root of your MicroSD card. Follow the guide for further instructions
pause
ren *.guide.txt guide.fhg
start notepad guide.fhg
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
start /wait unrar x *.rar Put_This_In_SD_Card
frec *.rar
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl

:mshl
echo Downloading MoonShell
echo Please wait, this may take a while.
frec *.zip 2> nul
start /wait wget http://mdxonline.dyndns.org/201002161705_moonshell210stable.zip
set za=%cd%\7za.exe
start /wait %za% x 201002161705_moonshell210stable.zip
cd 201002161705_moonshell210stable
set moondir=%cd%
start /wait %za% a -tzip mshl.zip moonshl2.nds "moonshl2"
cd..
move %moondir%\mshl.zip %cd%
start /wait 7za x mshl.zip -oPut_This_In_SD_Card
rmdir 201002161705_moonshell210stable /S /Q
start /wait wget http://flashcart-helper.googlecode.com/svn/data/misc/moonshl2.ini
copy moonshl2.ini %cd%\Put_This_In_SD_card\moonshl2\moonshl2.ini
frec moonshl2.ini

:end
::depending on FC selection, will dl appropriate guide from server
IF "%FC%" == "2" wget http://flashcart-helper.googlecode.com/svn/data/guides/ak2.guide.txt
IF "%FC%" == "3" wget http://flashcart-helper.googlecode.com/svn/data/guides/r4.guide.txt
IF "%FC%" == "4" wget http://flashcart-helper.googlecode.com/svn/data/guides/tt.guide.txt
IF "%FC%" == "5" wget http://flashcart-helper.googlecode.com/svn/data/guides/r4i.guide.txt
IF "%FC%" == "6" wget http://flashcart-helper.googlecode.com/svn/data/guides/dsn.guide.txt
IF "%FC%" == "7" wget http://flashcart-helper.googlecode.com/svn/data/guides/cyclo.guide.txt
IF "%FC%" == "8" wget http://flashcart-helper.googlecode.com/svn/data/guides/ievo.guide.txt
IF "%FC%" == "9" wget http://flashcart-helper.googlecode.com/svn/data/guides/ismm.guide.txt
IF "%FC%" == "10" wget http://flashcart-helper.googlecode.com/svn/data/guides/ez5.guide.txt
IF "%FC%" == "11" wget http://flashcart-helper.googlecode.com/svn/data/guides/ez5.guide.txt
IF "%FC%" == "12" wget http://flashcart-helper.googlecode.com/svn/data/guides/m3.guide.txt
IF "%FC%" == "17" wget http://flashcart-helper.googlecode.com/svn/data/guides/isp.guide.txt
IF "%FC%" == "18" wget http://flashcart-helper.googlecode.com/svn/data/guides/edge.guide.txt
IF "%FC%" == "19" wget http://flashcart-helper.googlecode.com/svn/data/guides/iedge.guide.txt
cls
title FlashcartHelper %currentver% Flashcart Setup Complete
frec *.dat 2> nul
frec *.zip 2> nul
frec *.7z 2> nul
frec *.rar 2> nul
echo A guide will now pop up
echo Please drag eveything in the folder that will pop up to the root of your MicroSD card. 
echo Follow the guide for further instructions
pause
frec guide.txt 2> nul
ren *.guide.txt guide.fhg 2> nul
start notepad %cd%\guide.fhg
start explorer.exe %cd%\Put_This_In_SD_card
goto :eof

:r4
cls
echo You chose R4 Revolution
echo Is this correct?
echo (y/n)
set /p r4yn=
IF "%r4yn%" == "n" goto start
echo Downloading latest Wood R4
start /wait wget http://filetrip.net/h25123666-Wood-R4.html
7za x *.7z >>fh.log
::Allows 7za use outside of cd
set za="%cd%"\7za.exe
cd "Wood_R4_v*.*"
set wooddir=%cd%
::zips up Wood files
%za% a -tzip wood.zip _DS_MENU.DAT >>"%workdir%\fh.log"
%za% u -tzip wood.zip "__rpg" >>"%workdir%\fh.log"
cd ..
move "%wooddir%\wood.zip" "%cd%" >>fh.log
7za x wood.zip -oPut_This_In_SD_Card >>fh.log
rmdir "%wooddir%" /s /q
pause
::frec *.7z
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
start /wait 7za x *.7z -y
rd "DSONE_DSONEi YSMenu" /s /q
rd "DSTT_DSTTi TTMenu" /s /q
rd "Extras" /s /q
rd "M3Real_M3iZero YSMenu" /s /q
rd "R4-SDHC_R4i-SDHC TTMenu" /s /q
rd "R4_Orginal_R4_Clone YSMenu" /s /q
rd "R4SDHC" /s /q
frec *.txt
frec usrcheat.dat
rd Put_This_In_SD_Card /s /q
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
frec *.zip
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl
:ttmenu
cls
echo You chose TTmenu
echo Is this correct?
echo (y/n)
set /p ttme=
IF "%ttme%" == "n" goto tt
echo Downloading RetroGameFan's DSTT Updates (TTMenu)
start /wait wget http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html
start /wait 7za x *.7z -y
rd "DSONE_DSONEi YSMenu" /s /q
rd "DSTT_DSTTi YSMenu" /s /q
rd "Extras" /s /q
rd "M3Real_M3iZero YSMenu" /s /q
rd "R4-SDHC_R4i-SDHC TTMenu" /s /q
rd "R4_Orginal_R4_Clone YSMenu" /s /q
rd "R4SDHC" /s /q
frec *.txt
frec usrcheat.dat
rd Put_This_In_SD_Card /s /q
ren "DSTT_DSTTi TTmenu" "Put_This_In_SD_Card"
frec *.zip
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
echo Downloading latest Wood R4iDSN
start /wait wget http://filetrip.net/h35130793-Wood-R4iDSN.html
start /wait 7za x *.7z 
cd wood*
set wooddir=%cd%
cd %workdir%
rmdir "%cd%\Put_This_In_SD_Card\" /S /Q 2> nul
ren "%wooddir%" "Put_This_In_SD_Card"
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
echo Downloading latest STABLE iEvoloution Firmware
frec *.zip
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
frec *.zip
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
frec *.zip
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
IF EXIST "%cd%\formatter\"SDFormatter.exe. (
goto formatstart
) ELSE (
frec *.rar 2> nul
echo Will download Panasonic Formatter 
pause
start /wait wget http://filetrip.net/d6027-Panasonic-SD-FormatterPORTABLE.html
start /wait unrar e *.rar formatter
)

:formatstart
cd formatter
start sdformatter.exe
cd ..
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
frec *.zip 2> nul
start /wait wget http://filetrip.net/h35132061-iSmart-MM-kernel-update.html
start /wait 7za x *.zip -oPut_This_In_SD_Card
echo Download Moonshell?
echo (y/n)
set /p mshlmm=
IF "%mshlmm%" == "n" goto end
echo Downloading MoonShell
echo Please wait, this may take a while.
frec *.zip
start /wait wget http://mdxonline.dyndns.org/201002161705_moonshell210stable.zip
set za="%cd%"\7za.exe
%za% x 201002161705_moonshell210stable.zip
cd 201002161705_moonshell210stable
set moondir=%cd%
%za% a -tzip mshl.zip moonshl2.nds "moonshl2"
cd..
move %moondir%\mshl.zip %cd%
start /wait 7za x mshl.zip -oPut_This_In_SD_Card
rmdir 201002161705_moonshell210stable /S /Q
start /wait wget http://flashcart-helper.googlecode.com/svn/data/misc/moonshl2.ini
copy moonshl2.ini %cd%\Put_This_In_SD_card\moonshl2\moonshl2.ini
frec moonshl2.ini
rmdir 201002161705_moonshell210stable /S /Q
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
echo If you have not yet updated your EZ5i to v101, please run ez5firmwreUP_V101.nds
echo If your cart says "No need to update" you do not need to update to v101.
echo You need atleast 1 .NDS file to load your EZ Flash 5
frec %cd%\Put_This_In_SD_Card\ez5firmwreUP_V103.nds 2> nul
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
echo Download Moonshell?
echo (y/n)
set /p m3msh=
IF "%m3msh%" == "y" goto mshl
IF "%m3msh%" == "n" goto end

:edge
cls
echo You chose EDGE
echo Is this correct?
echo (y/n)
set /p edge=
IF "%edge%" == "n" goto start
echo Downloading latest EDGE OS
start /wait wget http://filetrip.net/h35129830-EDGE-OS.html
start /wait 7za x *.zip -oPut_This_In_SD_Card
ren Put_This_In_SD_Card\IEDGE.dat EDGE.dat
echo Download Moonshell?
echo (y/n)
set /p edgemsh=
IF "%edgemsh%" == "y" goto mshl
IF "%edgemsh%" == "n" goto end

:iedge
cls
echo You chose iEDGE
echo Is this correct?
echo (y/n)
set /p iedge=
IF "%iedge%" == "n" goto start
echo Downloading latest iEDGE OS
start /wait wget http://filetrip.net/h35129832-iEDGE-OS.html
start /wait 7za x *.zip -oPut_This_In_SD_card
cls
frec *.zip
echo Do you need to flash your iEDGE
echo (Choose Yes if you have not used your iEDGE before)
echo (y/n)
set /p iedgeflash=
IF "%iedgeflash%" == "n" goto iedgea
echo Downloading iEDGE Boot Update
start /wait wget http://filetrip.net/d26407-BootStrap-File-for-iEDGE-4.html
start /wait 7za x *.zip -oPut_This_In_SD_Card
:iedgea
echo Download Moonshell?
echo (y/n)
set /p iemshl=
IF "%iemshl%" == "y" goto mshl
IF "%iemshl%" == "n" goto end
goto end
:clone
cls
mode con lines=50
echo R4 Clones are separated into groups. 
echo Please select the group your clone belongs to.
echo This list is sorted by
echo (Name of cart) - (website)
:group1
echo.
echo A Guide for R4 clones is not availible at this time. Sorry for the inconvenience. > guide.fhg
echo Just put everything in the folder that pops up into your microSD. >> guide.fhg
echo    ----------------
echo [1]    Group 1 
echo Group 1 includes
echo DSOnei Gold - www.ndstti.cn
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
echo   -----------------
echo [9]   Group 9
echo Other flashcarts. Press "9" to see list.
set /p group1=
IF "%group1%" == "1" goto g1
IF "%group1%" == "2" goto g2
IF "%group1%" == "3" goto g3
IF "%group1%" == "4" goto g4
IF "%group1%" == "5" goto g5
IF "%group1%" == "6" goto g6
IF "%group1%" == "7" goto g7
IF "%group1%" == "8" goto g8
IF "%group1%" == "9" goto g9
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
frec *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
frec *.zip
frec *.rar
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
frec *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
ren Put_This_In_SD_card\TTmenu.dat R4.dat
frec *.zip
frec *.rar
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
frec *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
ren Put_This_In_SD_card\TTmenu.dat iLL.iL
frec *.zip
frec *.rar
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
frec *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
copy Put_This_In_SD_card\TTmenu.dat Put_This_In_SD_card\iLL.iL
ren Put_This_In_SD_card\TTmenu.dat R4i.TP
frec *.zip
frec *.rar
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
frec *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
copy Put_This_In_SD_card\TTmenu.dat Put_This_In_SD_card\R4i.dat
frec *.zip
frec *.rar
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
frec *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
ren Put_This_In_SD_card\TTmenu.dat R4i.TP
frec *.zip
frec *.rar
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
frec *.rar
start /wait 7za a -tzip ystt.zip "DSTT_DSTTi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSTT_DSTTi YSmenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
ren Put_This_In_SD_card\TTmenu.dat R4KING
frec *.zip
frec *.rar
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
frec *.rar
start /wait 7za a -tzip ystt.zip "R4SDHC"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "R4SDHC" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
frec *.zip
frec *.rar
echo Download Moonshell?
echo (y/n)
set /p g8mshl=
IF "%g8mshl%" == "n" goto end
IF "%g8mshl%" == "y" goto mshl
exit

:g9
echo Group 9
echo Other R4 Clone cards.
echo [9A] Group 9-A
echo ---------------------
echo [9A1] N5 Revoloution (dsn5.com)
echo [9A2] N5i Revoloution (dsn5.com)
echo [9A3] R4-III Revolution Upgrade (r4dsl.net)
echo [9A4] R4-III Revolutoin Upgrade (r4iiinew.com)
echo [9A5] R4iNDSiXL (r4i-ndsill.com)
echo [9A6] R4-SDHC Revolution (r4-pro.com)
set /p g9sel=
IF "%g9sel%" == "9A1" goto 9A
IF "%g9sel%" == "9A2" goto 9A
IF "%g9sel%" == "9A3" goto 9A
IF "%g9sel%" == "9A4" goto 9A
IF "%g9sel%" == "9A5" goto 9A
IF "%g9sel%" == "9A6" goto 9A
IF "%g9sel%" == "9a1" goto 9A
IF "%g9sel%" == "9a2" goto 9A
IF "%g9sel%" == "9a3" goto 9A
IF "%g9sel%" == "9a4" goto 9A
IF "%g9sel%" == "9a5" goto 9A
IF "%g9sel%" == "9a6" goto 9A
goto start

:9A
cls
echo Setting up your cart, please wait.
echo Downloading RetroGameFan's DSTT Updates (TTMenu)
start /wait wget http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html
start /wait unrar x *.rar -y
frec *.rar
start /wait 7za a -tzip ystt.zip "R4_Orginal_R4_Clone YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "R4_Orginal_R4_Clone YSMenu" "Put_This_In_SD_Card"
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
frec *.zip
frec *.rar
IF "%g9sel%" == "9A1" goto 9A1
IF "%g9sel%" == "9A2" goto 9A2
IF "%g9sel%" == "9A3" goto 9A3
IF "%g9sel%" == "9A4" goto 9A4
IF "%g9sel%" == "9A5" goto 9A5
IF "%g9sel%" == "9A6" goto 9A6
IF "%g9sel%" == "9a1" goto 9A1
IF "%g9sel%" == "9a2" goto 9A2
IF "%g9sel%" == "9a3" goto 9A3
IF "%g9sel%" == "9a4" goto 9A4
IF "%g9sel%" == "9a5" goto 9A5
IF "%g9sel%" == "9a6" goto 9A6
:9A1
start /wait wget http://filetrip.net/d26367-N5-Firmware-1-32.html
start /wait 7za x *.zip -oPut_This_In_SD_Card -y
goto 9ms
:9A2
start /wait wget http://filetrip.net/d26383-N5i-2-03-ENG-LTE.html
start /wait 7za x *.zip -oPut_This_In_SD_Card -y
goto 9ms
:9A3
start /wait wget http://goo.gl/riOs0
start /wait 7za x *.zip -oPut_This_In_SD_Card -y
goto 9ms
:9A4
start /wait wget http://goo.gl/5W3w1
start /wait 7za *.zip -oPut_This_In_SD_Card -y
goto 9ms
:9A5
start /wait wget http://goo.gl/RQUxo
start /wait 7za *.zip -oPut_This_In_SD_Card -y
goto 9ms
:9A6
start /wait wget http://goo.gl/Fx22Q
start /wait 7za *.zip -oPut_This_In_SD_Card -y
goto 9ms
:9ms
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl
:ds1
::DSone
cls 
echo You chose Supercard DSOne (Original)
echo Is this correct?
echo (y/n)
set /p ds1=
IF "%ds1%" == "n" goto start
start /wait wget http://down.supercard.sc/download/evolution/DSONE_Evolution_V1.0_eng_sp6_20110427.zip
start /wait 7za x *.zip
rd Put_This_In_SD_Card /s /q
ren "DSONE_Evolution_V1.0_eng_sp6_0427" "Put_This_In_SD_Card"
goto sctt
:ds1i
::DSonei
cls 
echo You chose Supercard DSOnei (All DSonei Carts)
echo Is this correct?
echo (y/n)
set /p ds1i=
IF "%ds1i%" == "n" goto start
start /wait wget http://down.supercard.sc/download/evolution/DSONE_mini_SDHC_Evolution_V1.0_eng_sp6_20110427.zip
start /wait 7za x *.zip
rd Put_This_In_SD_Card /s /q
ren DSONE^&mini_SDHC_Evolution_V1.0_eng_sp6_0427 Put_This_In_SD_Card
cls 
goto ds1iflash
:ds1sdhc
::DSone SDHC
cls 
echo You chose Supercard DSOne SDHC 
echo Is this correct?
echo (y/n)
set /p ds1sdhc=
IF "%ds1sdhc%" == "n" goto start
rd Put_This_In_SD_Card /s /q
start /wait wget http://down.supercard.sc/download/evolution/DSONE_SDHC_Evolution_V1.0_eng_sp6_20110427.zip
start /wait 7za x *.zip
ren DSONE_SDHC_Evolution_V1.0_eng_sp6_0427 Put_This_In_SD_Card
goto sctt

:sctt
cls
echo Install RetroGameFan's YSmenu? (Recommended, gives better compatability)
echo (y/n)
set /p sctt=
IF "%sctt%" == "n" goto ds1guide
start /wait 7za a -tzip ds1.zip "Put_This_In_SD_Card"
rd Put_This_In_SD_Card /s /q
echo Downloading RetroGameFan's YSmenu updates
start /wait wget http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html
start /wait unrar x *.rar -y
frec *.rar
start /wait 7za a -tzip ystt.zip "DSONE_DSONEi YSMenu"
For /D %%a in ("%cd%\*") do RD /S/Q "%%a"
start /wait 7za x ystt.zip 
ren "DSONE_DSONEi YSMenu" "Put_This_In_SD_Card"
start /wait 7za x ds1.zip -y
echo Downloading RetroGameFan's latest DAT updates
start /wait wget http://filetrip.net/h35132218-RetroGameFan-DAT-Update.html
start /wait unrar x *.rar  Put_This_In_SD_Card\TTMenu -y
frec *.zip
frec *.rar
goto scttguide
:scttguide
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/sctt.guide.txt
goto ds1mshl
:ds1guide
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/ds1.guide.txt
goto ds1mshl
:ds1mshl
echo Download Moonshell?
echo (y/n)
set /p mshl=
IF "%mshl%" == "n" goto end
IF "%mshl%" == "y" goto mshl
goto end

:ds1iflash
echo Is your DSOnei Flashed? (Choose NO if you have not used your DSOnei Before)
echo (y/n)
set /p ds13=
IF "%ds13%" == "n" goto ds1flasha
IF "%ds13%" == "y" goto sctt
:ds1flasha
cls
echo Your DSOnei has not been flashed yet, is this correct?
echo (y/n)
set /p checkds1i=
IF "%checkds1i%" == "y" goto ds1iflashs
goto sctt
exit
:ds1iflashs
echo Downloading DSOnei Internal Firmware
start /wait wget http://down.supercard.cn/download/evolution/dsonei_update_1.43^&1.44c.zip
start /wait 7za x dsonei_update_1.43^&1.44c.zip -oPut_This_In_SD_Card -x!updatecn.bin
echo Please follow the instructions that will come up after you have completed setup of your DSonei.
goto sctt
exit

:ispp
cls
echo You chose iSmart Premuim
echo Is this correct? (y/n)
set /p ismartp=
IF "%ismartp%" == "n" goto start
echo Downloading iSmart Premuim Kernel Latest
start /wait wget http://filetrip.net/h35131650-iSmart-Premium-kernel.html
start /wait 7za x *.zip -oPut_This_In_SD_Card
frec *.zip 2> nul
frec *.rar 2> nul
echo Download Moonshell?
echo (y/n)
set /p ipmshl=
IF "%ipmshl%" == "n" goto end
IF "%ipmshl%" == "y" goto mshl

:hb
mode con lines=10
echo.
echo Search Query? (No Spaces)
set /p ftq=
start http://filetrip.net/%ftq%^&id=75
goto start

:redown
echo Redownloading start /wait unrar and 7z.exe
start /wait wget http://flashcart-helper.googlecode.com/files/UnRAR.exe
start /wait wget http://flashcart-helper.googlecode.com/files/7za.exe
goto begin

:readmii
start notepad.exe Readme
goto start

:about
echo About FlashcartHelper
echo FlashcartHelper %currentver%
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
frec *.zip
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
frec *.zip
"eNDryptS\eNDryptS Advanced.exe"

:trim
IF EXIST "%cd%\ndstokyotrim\NDSTokyoTrim.exe". (
goto trim2
) ELSE (
goto trimdl
exit
)
:trimdl
mkdir ndstokyotrim
start /wait wget http://eden.fm/apps/NDSTokyoTrim/NDSTokyoTrim25Beta2.exe
move "%cd%\NDSTokyoTrim25Beta2.exe" "%cd%\ndstokyotrim\NDSTokyoTrim.exe"
:trim2
cd ndstokyotrim
start NDSTokyoTrim.exe
cd ..
goto start


:dsi
cls
echo This option is for updating your flashcart for the latest 3DS/DSi firmware
echo The latest DSi firmware is 1.4.3, 1.4.4C
echo The latest 3DS firmware is 2.2-04
echo This option is up to date as of August 29th 2011
echo.
echo FlashcartHelper is not responsible for bricked flashcarts resulting from 
echo improper use of this option.
echo.
echo DSi Firmware fixes are availible for...
echo [1] Supercard DSTWO

echo The following patches are only compatible up to 3DS firmware 2.1-04
echo [2] Acekard 2i
echo [3] R4i Gold (Non 3DS version) (r4ids.cn)
echo [4] R4i Gold (3DS version) (r4ids.cn)
echo [5] R4iDSN (Non 3DS version) (r4idsn.com)
echo [6] R4iDSN (3DS version) (r4idsn.com)
echo [7] EZ5i
echo [8] Supercard DSonei
echo [9] DSTTi
echo.
echo All other carts do not have a DSi 1.4.3 compatible patch.


echo The following patches are only compatible to up to DSi firmware 1.4.2 
echo and/or 3DS 2.1.0-4
echo.
echo [10] M3i Zero

echo [B] Go back to the main menu
set /p dsifirm=
IF "%dsifirm%" == "1" goto firmdstwo
IF "%dsifirm%" == "2" goto firmak2
IF "%dsifirm%" == "3" goto firmr4igold
IF "%dsifirm%" == "4" goto firmr4i3ds
IF "%dsifirm%" == "5" goto firmr4idsn
IF "%dsifirm%" == "6" goto firmr4idsn3ds
IF "%dsifirm%" == "7" goto firmez5i
IF "%dsifirm%" == "8" goto firmds1
IF "%dsifirm%" == "10" goto firmm30
IF "%dsifirm%" == "9" goto firmtti
IF "%dsifirm%" == "B" goto start
:firmdstwo
cls
echo You chose DSTWO
echo Is this correct?
echo (y/n)
set /p firmdstwo=
IF "%firmdstwo%" == "n" goto exit

start /wait wget http://down.supercard.sc/download/dstwo/Firmware/Firmware_v1.13_eng.zip
start /wait 7za x *.zip 
frec *.zip
rmdir Put_This_In_SD_Card /S /Q
ren en Put_This_In_SD_Card
cls
echo.
echo Please put the file dstwoupdate.dat in the ROOT of your SD card
echo Then boot your DSTWO and it will prompt you to update.
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
start explorer.exe "%cd%\Put_This_In_SD_Card"
echo Press any key to exit. 
pause > nul
:firmak2
cls
echo You chose Acekard 2i
echo Is this correct?
echo (y/n)
set /p firmak2=
IF "%firmak2%" == "n" goto exit
start /wait wget http://www.acekard.com/download/ak2/ak2ifw_update_3ds3.0_DSi143.zip
rd Put_This_In_SD_Card /s /q
start /wait 7za x *.zip
ren ak2ifw_update_3ds3.0_DSi143 Put_This_In_SD_Card
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
exit
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
start /wait wget ftp://r4idsdown:r4idsdown@www.r4ids.co.cc/R4iGold_3DS2.2_Patch.rar
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
start /wait wget http://filetrip.net/d26365-DSTT-Core-Firmware-Update-DSi-1---1.html
start /wait wget http://www.ndstt.com/download/os/v1.17/ttmenu_en.zip
start /wait 7za x *.zip -oPut_This_In_SD_Card
echo First, BACK UP YOUR SD CARD
echo This will overwrite your current kernel with an official version that is no longer supported
echo This update will only work on the official kernel.
echo After you updated the firmware, please replace the kernel with
echo RetroGameFan's updates. Use FlashcartHelper to re-setup your DSTT after you have
echo updated your DSTTi's firmware to go back to RetroGameFan's Updates.
echo Please put all the files in the folder that will pop up
echo to the ROOT of your MicroSD card
echo Including..
echo rom_pcb0.dat
echo rom_pcb1.dat
echo rom_pcb2.dat
echo TTi143UPGRADE.nds
echo to the ROOT of your SD Card
echo Check if your DSTTi is real with TTiCheck5.0.nds
echo If not, DO NOT RUN PATCH.
echo If it is real, run TTi142UPGRADE.nds
echo FlashcartHelper is not responsible for bricked flashcarts resulting from improper use of this option.
echo Make sure your DS is plugged in before you attempt to update
pause
start explorer.exe %cd%\Put_This_In_SD_Card

:firmds1
cls
echo You chose DSonei
echo Is this correct?
echo (y/n)
set /p firmdst=
IF "%firmdst%" == "n" goto exit
cls
echo Downloading DSOnei Internal Firmware
start /wait wget http://down.supercard.cn/download/evolution/dsonei_update_1.43^&1.44c.zip
start /wait 7za x dsonei_update_1.43^&1.44c.zip -oPut_This_In_SD_Card -x!updatecn.bin
echo Once you have copied the contents of the folder that will pop up into your DSonei's MicroSD, 
echo please insert your DSonei's MicroSD into your DSonei. 
echo Then, insert your DSonei into the firmware flasher, then plug it into your computer.
echo Wait until the light turns GREEN before removing.
pause
start explorer.exe %cd%\Put_This_In_SD_Card
goto start
:cmp
IF EXIST "%cd%\DS-Scene\DS-SCE~1.exe." (
goto cmpstart
) ELSE (
frec *.rar 2> nul
cls
echo Download DS-Scene Rom tool?
echo {y/n}
set /p dscne=
IF "%dscne%" == "n" goto start
start /wait wget http://filetrip.net/h35132042-RetroGameFan-DS-Scene-Rom-Tool-.html
start /wait unrar x *.rar
ren "DS-Scene_Rom_Tool_v1.0_build_1205_Pack" "DS-Scene"
)

:cmpstart
cls
echo The DS-Scene Rom tool will prompt you for updates if nescassary.
echo View guide for DS-Scene Rom Tool?
echo (y/n)
set /p cmpguide=
IF "%cmpguide%" == "y" goto cmpguide
:cmpb
cd DS-Scene
start DS-SCE~1.exe
cd ..
goto begin 
:cmpguide
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/dsc.guide.txt
ren *.guide.txt guide.fhg
start notepad guide.fhg
goto cmpb

:menudo
cls
echo                                  ~~MENUdo~~
echo MENUdo with ROMLoading is supported on these flashcarts
echo There are more, but FlashcartHelper cannot install those at this time.
echo [1] Acekard 2i/2.1
echo [2] R4 Revoloution
echo [3] DSTT
echo [4] Goto MENUdo download page (Manual Install)
echo You can run MENUdo in any other flashcart, but their will be no ROMLoading.
echo If the above options do not load roms for you, on that flashcart,
echo Try the generic install. It may just load roms for your cart, maybe, maybe not.
echo [5] Generic flashcart (No ROMLoading!)
set /p menuchs=

IF "%menuchs%" == "1" goto mak2
IF "%menuchs%" == "2" goto mr4
IF "%menuchs%" == "3" goto mtt
IF "%menuchs%" == "4" goto mweb
IF "%menuchs%" == "5" goto mgen
:mak2
echo Installing MENUdo for Acekard 2i/2.1
start /wait wget http://menudo.yolasite.com/resources/menudo-files/localizations/12311/acekard.zip
start /wait 7za x acekard.zip
rd Put_This_In_SD_Card
ren acekard Put_This_In_SD_Card
rd Put_This_In_SD_Card\__aio /s /q
frec Put_This_In_SD_Card\*.dat
frec Put_This_In_SD_Card\akaio.nds
frec Put_This_In_SD_Card\akmenu4.nds
start /wait wget http://flashcart-helper.googlecode.com/files/ak.nds.ini
frec Put_This_In_SD_Card\_menudo\donors\nds.ini
copy ak.nds.ini Put_This_In_SD_Card\_menudo\donors\nds.ini
goto menuend
:mr4
echo Install MENUdo for R4 Revoloution 
start /wait wget http://menudo.yolasite.com/resources/menudo-files/localizations/12311/r4.zip
start /wait wget http://filetrip.net/h25123666-Wood-R4.html
start /wait 7za x *.7z
set za="%cd%"\7za.exe
cd "Wood_R4_v*.*"
set wooddir=%cd%
%za% a -tzip wood.zip _DS_MENU.DAT >>"%workdir%\fh.log"
%za% u -tzip wood.zip "__rpg" >>"%workdir%\fh.log"
cd ..
move "%wooddir%\wood.zip" "%cd%"
start /wait 7za x wood.zip -oPut_This_In_SD_Card -y
copy "%cd%\Put_This_In_SD_Card\_DS_MENU.DAT" "%cd%\Put_This_In_SD_Card\__rpg\woodr4.nds"
rd "%wooddir%" /S /Q
7za x r4.zip -aos >>fh.log
move "%cd%\r4\_menudo" "%cd%\Put_This_In_SD_Card"
move "%cd%\r4\menudo.nds" "%cd%\Put_This_In_SD_Card"
move "%cd%\r4\TTMENU" "%cd%\Put_This_In_SD_Card"
frec "%cd%\Put_This_In_SD_Card\_menudo\donors\nds.ini"
start /wait wget http://flashcart-helper.googlecode.com/files/wood.nds.ini
move wood.nds.ini "%cd%\Put_This_In_SD_Card\_menudo\donors\nds.ini"
frec *.zip
frec *.7z
rd r4
goto menuend

:mtt
echo Installing MENUdo for DSTT
start /wait wget http://menudo.yolasite.com/resources/menudo-files/localizations/12311/dstt.zip
start /wait 7za x dstt.zip
rd Put_This_In_SD_Card
ren dstt Put_This_In_SD_Card
rd Put_This_In_SD_Card\TTMENU /s /q
frec Put_This_In_SD_Card\*.dat 2>nul
frec Put_This_In_SD_Card\akaio.nds >nul
frec Put_This_In_SD_Card\akmenu4.nds >nul

goto menuend

:mweb
start http://menudo.yolasite.com/download.php
goto start

:mgen
echo Installing MENUdo
echo This will load Homebrew as long as your cart supports auto-DLDI. 
start /wait wget http://menudo.yolasite.com/resources/menudo-files/localizations/12311/generic.zip
start /wait 7za x generic.zip
rd Put_This_In_SD_Card
ren generic Put_This_In_SD_Card
frec Put_This_In_SD_Card\*.dat
frec Put_This_In_SD_Card\akmenu4.nds
goto menuend
:menuend
echo MenuDO Installed successfully.
start /wait wget http://flashcart-helper.googlecode.com/svn/data/guides/menudo.guide.txt
ren *.guide.txt guide.fhg
start notepad guide.fhg
pause
exit
:bak
cls
set bakdrv=c
IF EXIST c:\flashcartbak\. (
goto bakstart
) ELSE (
mkdir c:\flashcartbak\
)
:bakstart
cls
echo                          ~~FlashcartHelper Backup/Restore~~
echo FlashcartHelper Backup/Restore wizard.
echo Backups will be saved in %bakdrv%:\flashcartbak\
echo [1] Backup my MicroSD
echo [2] Restore my backup
echo [3] Remove all backups
echo [4] Change backup location
set /p backop=
IF "%backop%" == "1" goto backup
IF "%backop%" == "2" goto restore
IF "%backop%" == "3" goto rembak
IF "%backop%" == "4" goto chngbak
exit
:backup
echo Which drive letter is your MicroSD? 
echo DO NOT ENTER THE COLON (:)
set /p drvlet=
dir %bakdrv%:\flashcartbak\ /a:-d
echo Which slot do you want this backup to occupy?
echo 1-9001 (Will overwrite if exists)
set /p slot=
IF EXIST %bakdrv%:\flashcartbak\%slot%.flashcarthelperbak.fhbak. (
echo File Exists, Are you sure you want to overwrite backup in
echo Slot %slot%?
echo {y/n}
set /p backow=
IF "%backow%" == "y" goto backupcon
IF "%backow%" == "n" goto bakstart
) ELSE (
goto backupcon
)
:backupcon
echo Backing up your MicroSD. This will take a while.
start /wait 7za a -tzip %bakdrv%:\flashcartbak\%slot%.flashcarthelperbak.fhbak %drvlet%: -o%bakdrv%:\flashcartbak\ -y
cls
echo Backup Complete
pause
goto start

:restore
echo Scanning backup location for backups
IF EXIST %bakdrv%:\flashcartbak\*.fhbak (
goto rescontd
) ELSE (
echo No backups found
pause
goto bakstart
)
goto bakstart
:rescontd
dir %bakdrv%:\flashcartbak\ /a:-d
echo Which slot do you want to restore?
echo (The number beside the backup file)
set /p reslot=
echo.
echo Which drive letter is your MicroSD? 
echo DO NOT ENTER THE COLON (:)
set /p drvlet=
echo Are you sure you want to restore? You may loose data.
echo FlashcartHelper will not frecete/format your card.
echo If you restore from backup without removing files from your cart
echo you make get duplicates.
echo If you want to restore, type "restore" without the quotes.
set /p restorecon=
IF %restorecon% NEQ restore goto start
IF %restorecon% EQU restore goto restorcont
exit
:restorcont
echo FlashcartHelper will now restore your flashcart with your 
echo selected backup.
echo.
echo This may take a while
7za x %bakdrv%:\flashcartbak\%reslot%.flashcarthelperbak.fhbak -o%drvlet%:\
rd %drvlet%:\flashcartbak\
echo Restore Complete
pause
goto start

:rembak
echo Are you sure you want to frecete all backups?
echo If you want to frecete all backups, type "frecete" without the quotes.
set /p frecbak=
IF %frecbak% NEQ frecete goto start
IF %frecbak% EQU frecete goto rembakcont
goto start
:rembakcont
rd %bakdrv%:\flashcartbak\ /s /q
echo Removed all backups
pause
goto start

:chngbak
echo Change backup location's drive to?
echo Default is C
echo DO NOT ENTER THE COLON (:)
set /p bakdrv=
goto bakstart
:exit
exit
 

:invpath
echo Error 102
echo Invalid Path
echo Please do not run FlashcartHelper in your User Profile folder, Documents folder, or Desktop
echo Please do not run FlashcartHelper in a system folder.
echo Please do not run FlashcartHelper in your Hard Drive Root.
pause
exit

:clrlog
echo Are you sure you want to clear the log file?
echo (y/n)
echo FlashcartHelper will close after log file has been cleared
set /p clrlog=
IF "%clrlog%" == "y" del fh.log
IF "%clrlog%" == "n" exit

:clrtrash
echo Are you sure you want to clear the Trash folder and 
echo (y/n)
echo FlashcartHelper will close after Trashes has been cleared
set /p clrt=
IF "%clrt%" == "y" goto clrfile
IF "%clrt%" == "n" exit
exit
exit
goto eof
:clrfile
rmdir Trashes /S /Q
del *.zip
del *.7z
del *.rar
del *.log
del *.txt

:dlist
@echo off
title FlashcartHelper DownloadQueue Beta Test
set currentver=r9
del fh.dq
set u1=
set u2=
set u3=
set u4=
set m1=
set m2=
set m3=
set m4=
set m5=
set m6=
del dlque.bat 2>nul
:dbegin
mode con lines=50
set list=
cls
echo.
echo                  FlashcartHelper download list BETA    %currentver%
echo                      [D] Process Download Queue
echo.
echo -------Utitlities-------       -------MenuDO-------
echo %u1%[U1] DS-Scene Rom Tool     %m1%[M1]MenuDO AceKard
echo %u2%[U2] Panasonic Formatter   %m2%[M2]MenuDO DSTT
echo %u3%[U3] eNDryptS Advance      %m3%[M3]MenuDO Generic
echo %u4%[U4] NDSTokyoTrim          %m4%[M4]MenuDO R4
echo                            %m5%[M5]MenuDO Wood Donor ini file
echo                            %m6%[M6]MenuDO AK Donor ini file
set /p list=
if /i "%list%" EQU "u1" goto dlu1
if /i "%list%" EQU "u2" goto dlu2
if /i "%list%" EQU "u3" goto dlu3
if /i "%list%" EQU "u4" goto dlu4
if /i "%list%" EQU "d" goto dlque
if /i "%list%" EQU "m1" goto dlm1
if /i "%list%" EQU "m2" goto dlm2
if /i "%list%" EQU "m3" goto dlm3
if /i "%list%" EQU "m4" goto dlm4
if /i "%list%" EQU "m5" goto dlm5
if /i "%list%" EQU "m6" goto dlm6
goto begin
::ultilities
:dlu1
if /i "%u1%" EQU "*" (set u1=) else (set u1=*)
goto dbegin
:dlu2
if /i "%u2%" EQU "*" (set u2=) else (set u2=*)
goto dbegin
:dlu3
if /i "%u3%" EQU "*" (set u3=) else (set u3=*)
goto dbegin
:dlu4
if /i "%u4%" EQU "*" (set u4=) else (set u4=*)
goto dbegin
::MenuDO
:dlm1
if /i "%m1%" EQU "*" (set m1=) else (set m1=*)
goto dbegin

:dlm2
if /i "%m2%" EQU "*" (set m2=) else (set m2=*)
goto dbegin

:dlm3
if /i "%m3%" EQU "*" (set m3=) else (set m3=*)
goto dbegin

:dlm4
if /i "%m4%" EQU "*" (set m4=) else (set m4=*)
goto dbegin

:dlm5
if /i "%m5%" EQU "*" (set m5=) else (set m5=*)
goto dbegin

:dlm6
if /i "%m6%" EQU "*" (set m6=) else (set m6=*)
goto dbegin
:dlque
echo echo FlashcartHelper Download Queue TEST >>dlque.bat
echo echo %date% %time% >>dlque.bat
echo IF NOT EXIST "%cd%\DOWNLOAD_QUEUE\" mkdir DOWNLOAD_QUEUE >>dlque.bat
echo COPY wget.exe DOWNLOAD_QUEUE >>dlque.bat
echo copy fh.dq DOWNLOAD_QUEUE >>dlque.bat
echo CD DOWNLOAD_QUEUE >>dlque.bat
echo echo Downloading queue >>dlque.bat
echo start /wait wget -i fh.dq >>dlque.bat
echo echo The download completed >>dlque.bat
echo del fh.dq >>dlque.bat
echo del wget.exe >>dlque.bat
echo pause >>dlque.bat
echo exit >>dlque.bat
cls
echo Please confirm your download queue.
echo.
::queue 
if /i "%u1%" EQU "*" echo *DS-Scene Rom Tool
if /i "%u2%" EQU "*" echo *Panasonic Formatter
if /i "%u3%" EQU "*" echo *eNDryptS Advance
if /i "%u4%" EQU "*" echo *NDSTokyoTrim
if /i "%m1%" EQU "*" echo *MenuDO Acekard
if /i "%m2%" EQU "*" echo *MenuDO DSTT
if /i "%m3%" EQU "*" echo *MenuDO Generic
if /i "%m4%" EQU "*" echo *MenuDO R4
if /i "%m5%" EQU "*" echo *MenuDO Wood Donor ini file
if /i "%m6%" EQU "*" echo *MenuDO AK Donor ini file
echo.
echo Is this correct?
echo (y/n)
set /p queueyn=
if /i "%queueyn%" EQU "y" goto downst
goto begin
:downst
pause
if /i "%u1%" EQU "*" echo http://filetrip.net/h35132042-RetroGameFan-DS-Scene-Rom-Tool-.html >>fh.dq
if /i "%u2%" EQU "*" echo http://filetrip.net/d6027-Panasonic-SD-FormatterPORTABLE.html >>fh.dq
if /i "%u3%" EQU "*" echo http://filetrip.net/d219-eNDryptS-Advanced-v1-2.html >>fh.dq
if /i "%u4%" EQU "*" echo http://eden.fm/apps/NDSTokyoTrim/NDSTokyoTrim25Beta2.exe >>fh.dq
if /i "%m1%" EQU "*" echo http://menudo.yolasite.com/resources/menudo-files/localizations/12311/acekard.zip >>fh.dq
if /i "%m2%" EQU "*" echo http://menudo.yolasite.com/resources/menudo-files/localizations/12311/dstt.zip >>fh.dq
if /i "%m3%" EQU "*" echo http://menudo.yolasite.com/resources/menudo-files/localizations/12311/generic.zip >>fh.dq
if /i "%m4%" EQU "*" echo http://menudo.yolasite.com/resources/menudo-files/localizations/12311/r4.zip >>fh.dq
if /i "%m5%" EQU "*" echo http://flashcart-helper.googlecode.com/files/wood.nds.ini >>fh.dq
if /i "%m6%" EQU "*" echo http://flashcart-helper.googlecode.com/files/ak.nds.ini >>fh.dq
IF NOT EXIST fh.dq (echo Error 404 Queue Empty && pause && exit)
call dlque.bat
exit