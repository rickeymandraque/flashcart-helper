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
set compiledate=2/10/2012
::file cleanup, invoke frec to delete guide.fhg and any text files
frec guide.fhg 2> nul
frec *.txt 2> nul
::currentver is version number
set currentver=0.9
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
start /wait wget http://flashcart-helper.googlecode.com/files/frec.exe
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
wget -q http://flashcart-helper.googlecode.com/svn/data/update/fhup.bat 2>nul
call fhup.bat

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
::CMDLine
color F0
mode con lines=50
IF "%1" EQU "setup" goto cmdfirm 
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
echo [10]Download .ds2skin packs
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
echo [S]Save source
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
IF /i "%selection%" == "s" goto src
IF "%selection%" == "10" goto ds2skin
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
:cmdfirm
::cli selection
IF "%2" == "ak2" goto ak2
IF "%2" == "r4" goto r4
IF "%2" == "tt" goto tt
IF "%2" == "r4i" goto r4i
IF "%2" == "r4dsn" goto r4dsn
IF "%2" == "cyclo" goto cyclo
IF "%2" == "ievo" goto iEVO
IF "%2" == "ismm" goto mm
IF "%2" == "ez5" goto ez5
IF "%2" == "ez5i" goto ez5i
IF "%2" == "m3" goto m3
IF "%2" == "clone" goto clone
IF "%2" == "dsone" goto ds1
IF "%2" == "ds1sdhc" goto ds1sdhc
IF "%2" == "dsonei" goto ds1i
IF "%2" == "ismart" goto ispp
IF "%2" == "edge" goto edge
IF "%2" == "iedge" goto iedge
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
echo Unzipping files
start /wait unrar x *.rar Put_This_In_SD_card\ >>fh.log
start /wait 7za x *.7z  -oPut_This_In_SD_card\ >>fh.log
start /wait 7za x *.zip -oPut_This_In_SD_card\ >>fh.log
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
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y  >>fh.log
frec *.zip
start /wait wget http://filetrip.net/h35130196-SCDS2Iplayer-GBA-EMU-%28game_conf-.html
start /wait 7za x *.7z -oPut_This_In_SD_card\NDSGBA\ -y >>fh.log
frec *.7z
echo Downloading CATSFC
echo Please wait, this may take a while..
start /wait wget http://filetrip.net/h35131424-CATSFC.html
start /wait 7za x *.zip -x!version -x!source.txt -x!copyright -x!installation.txt -y >>fh.log
start /wait 7za a -tzip cat.zip "CATSFC" >>fh.log
start /wait 7za x cat.zip -oPut_This_In_SD_card >>fh.log
copy *.ini "%cd%\Put_This_In_SD_card\_dstwoplug\*.ini" >>fh.log 2>&1
copy *.bmp "%cd%\Put_This_In_SD_card\_dstwoplug\*.bmp" >>fh.log 2>&1
copy *.plg "%cd%\Put_This_In_SD_card\_dstwoplug\*.plg" >>fh.log 2>&1
frec cat*.*
frec CATSFC
frec *.zip
echo Downloading iPlayer
echo Please wait, this may take a while..
start /wait wget http://filetrip.net/h35130740-Supercard-DSTWO-iPlayer-Plugin.html
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y >>fh.log
frec *.zip
echo Downloading iReader, Please wait
start /wait wget http://filetrip.net/h35130143-DSTwo-iReader.html
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y >>fh.log
frec *.zip
echo Downloading DSTWO Skin installer, Please wait
start /wait wget http://filetrip.net/h25125220-DSTwo-Skin-Installer.html
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y >>fh.log
echo Download Moonshell? (Yes is recommended)
echo (y/n)
set /p mshlplug=
IF /i "%mshlplug%" == "n" goto ds2end

echo Downloading Moonshell from Supercard server
start /wait wget http://down.supercard.cn/download/dstwo/plugin/moonshl2_for_DSTWO.zip
start /wait 7za x *.zip -oPut_This_In_SD_card\ -y >>fh.log
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
echo Unzipping files
start /wait unrar x *.rar Put_This_In_SD_Card >>fh.log
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
%za% x 201002161705_moonshell210stable.zip >>fh.log
cd 201002161705_moonshell210stable
set moondir=%cd%
%za% a -tzip mshl.zip moonshl2.nds "moonshl2" >>fh.log
cd..
move %moondir%\mshl.zip %cd% >>fh.log
start /wait 7za x mshl.zip -oPut_This_In_SD_Card
rmdir 201002161705_moonshell210stable /S /Q
start /wait wget http://flashcart-helper.googlecode.com/svn/data/misc/moonshl2.ini
copy moonshl2.ini %cd%\Put_This_In_SD_card\moonshl2\moonshl2.ini >>fh.log
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
start /wait 7za x *.7z -y >>fh.log
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
echo By Punyman
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
echo Xflak for ModMii, ModMii is an excellent code example
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
echo [2] Acekard 2i
echo [3] R4i Gold (Non 3DS version) (r4ids.cn)
echo [4] R4i Gold (3DS version) (r4ids.cn)
echo [5] R4iDSN (Non 3DS version) (r4idsn.com)
echo [6] R4iDSN (3DS version) (r4idsn.com)
echo [7] EZ5i
echo The following patches are only compatible up to 3DS firmware 2.1-04
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
start /wait wget http://www.ezflash.cn/zip/V108a.rar
start /wait unrar x *.rar Put_This_In_SD_Card
cls
echo Please put the file ez5firmwreUP_V108a.nds
echo to the ROOT of your SD Card.
echo DO NOT RENAME THE FILE
echo Make sure you are first on firmware v101 before updating
echo Run ez5firmwreUP_V108a.nds to update
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
echo Are you sure you want to restore? You may loose data.
echo FlashcartHelper will not delete/format your card.
echo If you restore from backup without removing files from your cart
echo you make get duplicates.
echo If you want to restore, type "restore" without the quotes.
set /p restorecon=
IF %restorecon% NEQ restore goto start
IF %restorecon% EQU restore goto restorcont
exit
:restorcont
echo FlashcartHelper will now restore your flashcart's files to 
echo selected backup.
echo.
echo This may take a while
7za x %bakdrv%:\flashcartbak\%reslot%.flashcarthelperbak.fhbak -oPut_This_In_SD_Card
rd %drvlet%:\flashcartbak\
echo Restore Complete
start explorer.exe %cd%\Put_This_In_SD_card
pause
goto start

:rembak
echo Are you sure you want to delete all backups?
echo If you want to frecete all backups, type "Delete" without the quotes.
set /p frecbak=
IF %frecbak% NEQ Delete goto start
IF %frecbak% EQU Delete goto rembakcont
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
cls
title FlashcartHelper Advanced Download Queue
echo Welcome to the FlashcartHelper Download List
echo Use this at your own descretion
echo This will merely download your selected items
echo There will be no guide, and it will not be prepared for you neatly in a folder
echo Your downloads will be in the "DOWNLOAD_QUEUE" folder
echo Do not do anything you are unsure of.
pause
del fh.dq 2>fh.log
set validq=
set df1=
set df2=
set df3=
set df4=
set df5=
set df6=
set df7=
set df8=
set df9=
set df10=
set df11=
set df12=
set gd1=
set gd2=
set gd3=
set gd4=
set gd5=
set gd6=
set gd7=
set gd8=
set gd9=
set gd10=
set gd11=
set gd12=
set gd13=
set gd14=
set gd15=
set gd16=
set gd17=
set gd18=
set gd19=
set dp1=
set dp2=
set dp3=
set dp4=
set dp5=
set dp6=
set dp7=
set mc1=
set mc2=
set mc3=
set mc4=
set mc5=
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
set f1=
set f2=
set f3=
set f4=
set f5=
set f6=
set f7=
set f8=
set f9=
set f10=
set f11=
set f12=
set f13=
set f14=
set f15=
set f16=
set f17=
set f18=
set f19=
set f20=
del dlque.bat 2>nul
:dbegin
mode con lines=50
mode con cols=130
set list=
cls
echo.
echo                                      FlashcartHelper Advance Download list BETA    %currentver%
echo        [S] Save Current Download Queue [C] Clear Current Download Queue [D] Process Download Queue [E] Exit [I]Import Saved Queue
echo.
echo -------Utitlities-------            -------MenuDO-------                        -----DSi/3DS Fixes-----
echo %u1%[U1] DS-Scene Rom Tool             %m1%[M1]MenuDO AceKard              %df1%[DF1]DSonei mini DSi1.43 3DS3.0.0-6
echo %u2%[U2] Panasonic Formatter           %m2%[M2]MenuDO DSTT                 %df2%[DF2]R4iDSN Non3DS DSi1.43
echo %u3%[U3] eNDryptS Advance              %m3%[M3]MenuDO Generic              %df3%[DF3]R4iDSN 3DS 2.2.0-4 to 3.0.0-6
echo %u4%[U4] NDSTokyoTrim                  %m4%[M4]MenuDO R4                   %df4%[DF4]R4iDSN 3DS Special patch "DORASU" 3.0.0-6
echo                                    %m5%[M5]MenuDO Wood Donor ini file  %df5%[DF5]Acekard 2i DSi 1.43 3DS 3.0.0-6
echo                                    %m6%[M6]MenuDO AK Donor ini file    %df6%[DF6]DSTWO Firmware DSi 1.43 3DS 3.0.0-6
echo -----Firmwares/Kernel-----                                         %df7%[DF7]R4iGold 3DS 2.2.0-4 to 3.0.0-6
echo %f1%[F1]DSTWO EOS                       ----Miscellaneous----          %df8%[DF8]R4iGold Non3DS DSi 1.43
echo %f2%[F2]AKAIO                          %mc1%[MC1]CycloDS iEvo Moonshell     %df9%[DF9]R4iGold 3DS Special patch "DORASU" 3.0.0-6
echo %f3%[F3]Wood R4                        %mc2%[MC2]MoonShell 2.10             %df10%[DF10]EZFlash Vi 705/805 3.0.0-6
echo %f4%[F4]Wood R4iGold                   %mc3%[MC3]iEDGE BootStrap            %df11%[DF11]M3i Zero Core 2.0.2 DSi 1.4.2
echo %f5%[F5]Wood R4iDSN                    %mc4%[MC4]iEvo BootStrap Creator USA %df12%[DF12]DSTT Core firmware update 1.4.3
echo %f6%[F6]CycloDS Evolution Firmware     %mc5%[MC5]iEvo BootStrap Creator EUR
echo %f7%[F7]CycloDS iEvolution Firmware                                            -----Guides-----
echo %f8%[F8]iSmart MM Kernel               -----DSTWO Plugins-----         %gd1%[GD1]Acekard Guide
echo %f9%[F9]EZV Kernel                     %dp1%[DP1]NDSGBA 1.21                %gd2%[GD2]R4 Guide
echo %f10%[F10]EZVi Kernel                   %dp2%[DP2]gameconfig.txt for NDSGBA  %gd3%[GD3]DSTT Guide
echo %f11%[F11]M3 Quad-Boot                  %dp3%[DP3]CATSFC                     %gd4%[GD4]R4iGold Guide
echo %f12%[F12]EDGE OS                       %dp4%[DP4]iPlayer                    %gd5%[GD5]R4iDSN Guide
echo %f13%[F13]iEDGE OS                      %dp5%[DP5]iReader                    %gd6%[GD6]CycloDS Guide
echo %f14%[F14]N5 Firmware                   %dp6%[DP6]MoonShell2 for DS2         %gd7%[GD7]CycloDSi Guide
echo %f15%[F15]N5i Firmware                  %dp7%[DP7]DSTWO Skin Installer       %gd8%[GD8]iSmartMM Guide
echo %f16%[F16]DSONE EOS                                                     %gd9%[GD9]EZV/Vi Guide
echo %f17%[F17]DSONE mini SDHC EOS                                           %gd10%[GD10]M3 Guide
echo %f18%[F18]DSONE SDHC EOS                                                %gd11%[GD11]iSmartPP Guide
echo %f19%[F19]RetroGameFan's Multi-Cart                                     %gd12%[GD12]EDGE Guide
echo %f20%[F20]iSmart Premuim Kernel                                         %gd13%[GD13]iEDGE Guide
echo %f21%[F21]TTMenu 1.17                                                   %gd14%[GD14]DSTWO Guide
echo                                                                    %gd15%[GD15]DSOne TTMenu Guide
echo                                                                    %gd16%[GD16]DSOne EOSMenu Guide
echo                                                                    %gd17%[GD17]eNDryptS Advance Guide
echo                                                                    %gd18%[GD18]DS-Scene Rom Tool Guide
echo                                                                    %gd19%[GD19]Menudo Guide
set /p list=
if /i "%list%" EQU "s" goto savequeue
if /i "%list%" EQU "u1" goto dlu1
if /i "%list%" EQU "u2" goto dlu2
if /i "%list%" EQU "u3" goto dlu3
if /i "%list%" EQU "u4" goto dlu4
if /i "%list%" EQU "d" goto dlque
if /i "%list%" EQU "c" goto clque
if /i "%list%" EQU "i" goto imque
if /i "%list%" EQU "e" goto begin
if /i "%list%" EQU "m1" goto dlm1
if /i "%list%" EQU "m2" goto dlm2
if /i "%list%" EQU "m3" goto dlm3
if /i "%list%" EQU "m4" goto dlm4
if /i "%list%" EQU "m5" goto dlm5
if /i "%list%" EQU "m6" goto dlm6
if /i "%list%" EQU "f1" goto dlf1
if /i "%list%" EQU "f2" goto dlf2
if /i "%list%" EQU "f3" goto dlf3
if /i "%list%" EQU "f4" goto dlf4
if /i "%list%" EQU "f5" goto dlf5
if /i "%list%" EQU "f6" goto dlf6
if /i "%list%" EQU "f7" goto dlf7
if /i "%list%" EQU "f8" goto dlf8
if /i "%list%" EQU "f9" goto dlf9
if /i "%list%" EQU "f10" goto dlf10
if /i "%list%" EQU "f11" goto dlf11
if /i "%list%" EQU "f12" goto dlf12
if /i "%list%" EQU "f13" goto dlf13
if /i "%list%" EQU "f14" goto dlf14
if /i "%list%" EQU "f15" goto dlf15
if /i "%list%" EQU "f16" goto dlf16
if /i "%list%" EQU "f17" goto dlf17
if /i "%list%" EQU "f18" goto dlf18
if /i "%list%" EQU "f19" goto dlf19
if /i "%list%" EQU "f20" goto dlf20
if /i "%list%" EQU "F20" goto dlF20
if /i "%list%" EQU "F21" goto dlF21
if /i "%list%" EQU "mc1" goto dlmc1
if /i "%list%" EQU "mc2" goto dlmc2
if /i "%list%" EQU "mc3" goto dlmc3
if /i "%list%" EQU "mc4" goto dlmc4
if /i "%list%" EQU "mc5" goto dlmc5
if /i "%list%" EQU "dp1" goto dldp1
if /i "%list%" EQU "dp2" goto dldp2
if /i "%list%" EQU "dp3" goto dldp3
if /i "%list%" EQU "dp4" goto dldp4
if /i "%list%" EQU "dp5" goto dldp5
if /i "%list%" EQU "dp6" goto dldp6
if /i "%list%" EQU "dp7" goto dldp7
if /i "%list%" EQU "df1" goto dldf1
if /i "%list%" EQU "df2" goto dldf2
if /i "%list%" EQU "df3" goto dldf3
if /i "%list%" EQU "df4" goto dldf4
if /i "%list%" EQU "df5" goto dldf5
if /i "%list%" EQU "df6" goto dldf6
if /i "%list%" EQU "df7" goto dldf7
if /i "%list%" EQU "df8" goto dldf8
if /i "%list%" EQU "df9" goto dldf9
if /i "%list%" EQU "df10" goto dldf10
if /i "%list%" EQU "df11" goto dldf11
if /i "%list%" EQU "df12" goto dldf12
if /i "%list%" EQU "gd1" goto dlgd1
if /i "%list%" EQU "gd2" goto dlgd2
if /i "%list%" EQU "gd3" goto dlgd3
if /i "%list%" EQU "gd4" goto dlgd4
if /i "%list%" EQU "gd5" goto dlgd5
if /i "%list%" EQU "gd6" goto dlgd6
if /i "%list%" EQU "gd7" goto dlgd7
if /i "%list%" EQU "gd8" goto dlgd8
if /i "%list%" EQU "gd9" goto dlgd9
if /i "%list%" EQU "gd10" goto dlgd10
if /i "%list%" EQU "gd11" goto dlgd11
if /i "%list%" EQU "gd12" goto dlgd12
if /i "%list%" EQU "gd13" goto dlgd13
if /i "%list%" EQU "gd14" goto dlgd14
if /i "%list%" EQU "gd15" goto dlgd15
if /i "%list%" EQU "gd16" goto dlgd16
if /i "%list%" EQU "gd17" goto dlgd17
if /i "%list%" EQU "gd18" goto dlgd18
if /i "%list%" EQU "gd19" goto dlgd19
if /i "%list%" EQU "gd20" goto dlgd20
goto dbegin
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
::Firmwares
:dlf1
if /i "%f1%" EQU "*" (set f1=) else (set f1=*)
goto dbegin
:dlf2
if /i "%f2%" EQU "*" (set f2=) else (set f2=*)
goto dbegin
:dlf3
if /i "%f3%" EQU "*" (set f3=) else (set f3=*)
goto dbegin
:dlf4
if /i "%f4%" EQU "*" (set f4=) else (set f4=*)
goto dbegin
:dlf5
if /i "%f5%" EQU "*" (set f5=) else (set f5=*)
goto dbegin
:dlf6
if /i "%f6%" EQU "*" (set f6=) else (set f6=*)
goto dbegin
:dlf7
if /i "%f7%" EQU "*" (set f7=) else (set f7=*)
goto dbegin
:dlf8
if /i "%f8%" EQU "*" (set f8=) else (set f8=*)
goto dbegin
:dlf9
if /i "%f9%" EQU "*" (set f9=) else (set f9=*)
goto dbegin
:dlf10
if /i "%f10%" EQU "*" (set f10=) else (set f10=*)
goto dbegin
:dlf11
if /i "%f11%" EQU "*" (set f11=) else (set f11=*)
goto dbegin
:dlf12
if /i "%f12%" EQU "*" (set f12=) else (set f12=*)
goto dbegin
:dlf13
if /i "%f13%" EQU "*" (set f13=) else (set f13=*)
goto dbegin
:dlf14
if /i "%f14%" EQU "*" (set f14=) else (set f14=*)
goto dbegin
:dlf15
if /i "%f15%" EQU "*" (set f15=) else (set f15=*)
goto dbegin
:dlf16
if /i "%f16%" EQU "*" (set f16=) else (set f16=*)
goto dbegin
:dlf17
if /i "%f17%" EQU "*" (set f17=) else (set f17=*)
goto dbegin
:dlf18
if /i "%f18%" EQU "*" (set f18=) else (set f18=*)
goto dbegin
:dlf19
if /i "%f19%" EQU "*" (set f19=) else (set f19=*)
goto dbegin
:dlf20
if /i "%f20%" EQU "*" (set f20=) else (set f20=*)
goto dbegin
:dlf20
if /i "%f20%" EQU "*" (set f20=) else (set f20=*)
goto dbegin
:dlf21
if /i "%f21%" EQU "*" (set f21=) else (set f21=*)
goto dbegin
:dlmc1
if /i "%mc1%" EQU "*" (set mc1=) else (set mc1=*)
goto dbegin
:dlmc2
if /i "%mc2%" EQU "*" (set mc2=) else (set mc2=*)
goto dbegin
:dlmc3
if /i "%mc3%" EQU "*" (set mc3=) else (set mc3=*)
goto dbegin
:dlmc4
if /i "%mc4%" EQU "*" (set mc4=) else (set mc4=*)
goto dbegin
:dlmc5
if /i "%mc5%" EQU "*" (set mc5=) else (set mc5=*)
goto dbegin
::DSTWOPlugs
:dldp1
if /i "%dp1%" EQU "*" (set dp1=) else (set dp1=*)
goto dbegin
:dldp2
if /i "%dp2%" EQU "*" (set dp2=) else (set dp2=*)
goto dbegin
:dldp3
if /i "%dp3%" EQU "*" (set dp3=) else (set dp3=*)
goto dbegin
:dldp4
if /i "%dp4%" EQU "*" (set dp4=) else (set dp4=*)
goto dbegin
:dldp5
if /i "%dp5%" EQU "*" (set dp5=) else (set dp5=*)
goto dbegin
:dldp6
if /i "%dp6%" EQU "*" (set dp6=) else (set dp6=*)
goto dbegin
:dldp7
if /i "%dp7%" EQU "*" (set dp7=) else (set dp7=*)
goto dbegin
:dldf1
if /i "%df1%" EQU "*" (set df1=) else (set df1=*)
goto dbegin
:dldf2
if /i "%df2%" EQU "*" (set df2=) else (set df2=*)
goto dbegin
:dldf3
if /i "%df3%" EQU "*" (set df3=) else (set df3=*)
goto dbegin
:dldf4
if /i "%df4%" EQU "*" (set df4=) else (set df4=*)
goto dbegin
:dldf5
if /i "%df5%" EQU "*" (set df5=) else (set df5=*)
goto dbegin
:dldf6
if /i "%df6%" EQU "*" (set df6=) else (set df6=*)
goto dbegin
:dldf7
if /i "%df7%" EQU "*" (set df7=) else (set df7=*)
goto dbegin
:dldf8
if /i "%df8%" EQU "*" (set df8=) else (set df8=*)
goto dbegin
:dldf9
if /i "%df9%" EQU "*" (set df9=) else (set df9=*)
goto dbegin
:dldf10
if /i "%df10%" EQU "*" (set df10=) else (set df10=*)
goto dbegin
:dldf11
if /i "%df11%" EQU "*" (set df11=) else (set df11=*)
goto dbegin
:dldf12
if /i "%df12%" EQU "*" (set df12=) else (set df12=*)
goto dbegin
:dlgd1
if /i "%gd1%" EQU "*" (set gd1=) else (set gd1=*)
goto dbegin
:dlgd2
if /i "%gd2%" EQU "*" (set gd2=) else (set gd2=*)
goto dbegin
:dlgd3
if /i "%gd3%" EQU "*" (set gd3=) else (set gd3=*)
goto dbegin
:dlgd4
if /i "%gd4%" EQU "*" (set gd4=) else (set gd4=*)
goto dbegin
:dlgd5
if /i "%gd5%" EQU "*" (set gd5=) else (set gd5=*)
goto dbegin
:dlgd6
if /i "%gd6%" EQU "*" (set gd6=) else (set gd6=*)
goto dbegin
:dlgd7
if /i "%gd7%" EQU "*" (set gd7=) else (set gd7=*)
goto dbegin
:dlgd8
if /i "%gd8%" EQU "*" (set gd8=) else (set gd8=*)
goto dbegin
:dlgd9
if /i "%gd9%" EQU "*" (set gd9=) else (set gd9=*)
goto dbegin
:dlgd10
if /i "%gd10%" EQU "*" (set gd10=) else (set gd10=*)
goto dbegin
:dlgd11
if /i "%gd11%" EQU "*" (set gd11=) else (set gd11=*)
goto dbegin
:dlgd12
if /i "%gd12%" EQU "*" (set gd12=) else (set gd12=*)
goto dbegin
:dlgd13
if /i "%gd13%" EQU "*" (set gd13=) else (set gd13=*)
goto dbegin
:dlgd14
if /i "%gd14%" EQU "*" (set gd14=) else (set gd14=*)
goto dbegin
:dlgd15
if /i "%gd15%" EQU "*" (set gd15=) else (set gd15=*)
goto dbegin
:dlgd16
if /i "%gd16%" EQU "*" (set gd16=) else (set gd16=*)
goto dbegin
:dlgd17
if /i "%gd17%" EQU "*" (set gd17=) else (set gd17=*)
goto dbegin
:dlgd18
if /i "%gd18%" EQU "*" (set gd18=) else (set gd18=*)
goto dbegin
:dlgd19
if /i "%gd19%" EQU "*" (set gd19=) else (set gd19=*)
goto dbegin


:dlque
echo echo FlashcartHelper Download Queue>>dlque.bat
echo echo Issued %date% %time% for FlashcartHelper %currentver%>>dlque.bat
echo IF NOT EXIST "%cd%\DOWNLOAD_QUEUE\" mkdir DOWNLOAD_QUEUE >>dlque.bat
echo COPY wget.exe DOWNLOAD_QUEUE >>dlque.bat
echo copy fh.dq DOWNLOAD_QUEUE >>dlque.bat
echo CD DOWNLOAD_QUEUE >>dlque.bat
echo echo Downloading queue >>dlque.bat
echo start /wait wget -i fh.dq >>dlque.bat
echo cls >>dlque.bat
echo echo. >>dlque.bat
echo echo Download complete >>dlque.bat
echo del fh.dq >>dlque.bat
echo del wget.exe >>dlque.bat
echo pause >>dlque.bat
echo exit >>dlque.
goto queueconfirm
cls
:savequeue
cls
echo Save download queue?
echo (y/n)
set /p savq=
if /i "%savq%" NEQ "y" goto dbegin
set savequeue=1
:queueconfirm
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
if /i "%f1%" EQU "*" echo *DSTWO EOS
if /i "%f2%" EQU "*" echo *AKAIO
if /i "%f3%" EQU "*" echo *Wood R4
if /i "%f4%" EQU "*" echo *Wood R4iGold
if /i "%f5%" EQU "*" echo *Wood R4iDSN
if /i "%f6%" EQU "*" echo *CycloDS Evolution Firmware
if /i "%f7%" EQU "*" echo *CycloDS iEvolution Firmware
if /i "%f8%" EQU "*" echo *iSmart MM Kernel
if /i "%f9%" EQU "*" echo *EZV Kernel
if /i "%f10%" EQU "*" echo *EZVi Kernel
if /i "%f11%" EQU "*" echo *M3 Quad-Boot
if /i "%f12%" EQU "*" echo *EDGE OS
if /i "%f13%" EQU "*" echo *iEDGE OS
if /i "%f14%" EQU "*" echo *N5 Firmware
if /i "%f15%" EQU "*" echo *N5i Firmware
if /i "%f16%" EQU "*" echo *DSONE EOS
if /i "%f17%" EQU "*" echo *DSONE mini SDHC EOS
if /i "%f18%" EQU "*" echo *DSONE SDHC EOS
if /i "%f19%" EQU "*" echo *RetroGameFan's Multi-Cart
if /i "%f20%" EQU "*" echo *iSmart Premuim Kernel
if /i "%f21%" EQU "*" echo *TTMenu 1.17
if /i "%mc1%" EQU "*" echo *CycloDS iEvo Moonshell
if /i "%mc2%" EQU "*" echo *Moonshell 2.10
if /i "%mc3%" EQU "*" echo *iEDGE BootStrap
if /i "%mc4%" EQU "*" echo *CycloDS iEvo BootStrap maker USA
if /i "%mc5%" EQU "*" echo *CycloDS iEvo BootStrap maker EUR
if /i "%dp1%" EQU "*" echo *NDSGBA 1.21
if /i "%dp2%" EQU "*" echo *gameconfig.txt for NDSGBA
if /i "%dp3%" EQU "*" echo *CATSFC
if /i "%dp4%" EQU "*" echo *iPlayer
if /i "%dp5%" EQU "*" echo *iReader
if /i "%dp6%" EQU "*" echo *Moonshell2 for DSTWO
if /i "%dp7%" EQU "*" echo *DSTWO Skin installer
if /i "%df1%" EQU "*" echo *DSonei mini DSi1.43 3DS3.0.0-6
if /i "%df2%" EQU "*" echo *R4iDSN Non3DS DSi1.43
if /i "%df3%" EQU "*" echo *R4iDSN 3DS 2.2.0-4 to 3.0.0-6
if /i "%df4%" EQU "*" echo *R4iDSN 3DS Special patch "DORASU" 3.0.0-6
if /i "%df5%" EQU "*" echo *Acekard 2i DSi 1.43 3DS 3.0.0-6
if /i "%df6%" EQU "*" echo *DSTWO Firmware DSi 1.43 3DS 3.0.0-6
if /i "%df7%" EQU "*" echo *R4iGold 3DS 2.2.0-4 to 3.0.0-6
if /i "%df8%" EQU "*" echo *R4iGold Non3DS DSi 1.43
if /i "%df9%" EQU "*" echo *R4iGold 3DS Special patch "DORASU" 3.0.0-6
if /i "%df10%" EQU "*" echo *EZFlash Vi 705/805 3.0.0-6
if /i "%df11%" EQU "*" echo *M3i Zero Core 2.0.2 DSi 1.4.2
if /i "%df12%" EQU "*" echo *DSTT Core firmware update 1.4.3
if /i "%gd1%" EQU "*" echo *Acekard Guide
if /i "%gd2%" EQU "*" echo *R4 Guide
if /i "%gd3%" EQU "*" echo *DSTT Guide
if /i "%gd4%" EQU "*" echo *R4iGold Guide
if /i "%gd5%" EQU "*" echo *R4iDSN Guide
if /i "%gd6%" EQU "*" echo *CycloDS Guide
if /i "%gd7%" EQU "*" echo *CycloDSi Guide
if /i "%gd8%" EQU "*" echo *iSmartMM Guide
if /i "%gd9%" EQU "*" echo *EZV/Vi Guide
if /i "%gd10%" EQU "*" echo *M3 Guide
if /i "%gd11%" EQU "*" echo *iSmartPP Guide
if /i "%gd12%" EQU "*" echo *EDGE Guide
if /i "%gd13%" EQU "*" echo *iEDGE Guide
if /i "%gd14%" EQU "*" echo *DSTWO Guide
if /i "%gd15%" EQU "*" echo *DSOne TTMenu Guide
if /i "%gd16%" EQU "*" echo *DSOne EOSMenu Guide
if /i "%gd17%" EQU "*" echo *eNDryptS Advance Guide
if /i "%gd18%" EQU "*" echo *DS-Scene Rom Tool Guide
if /i "%gd19%" EQU "*" echo *Menudo Guide
echo.
echo Is this correct?
echo (y/n)
set /p queueyn=
if /i "%queueyn%" EQU "y" goto downst
goto dbegin
:downst
if "%savequeue%" EQU "1" goto savqueue
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
if /i "%f1%" EQU "*" echo http://filetrip.net/h35130066-Supercard-DSTWO-EOS.html >>fh.dq
if /i "%f2%" EQU "*" echo http://filetrip.net/h7853-AKAIO.html >>fh.dq
if /i "%f3%" EQU "*" echo http://filetrip.net/h25123666-Wood-R4.html >>fh.dq
if /i "%f4%" EQU "*" echo http://filetrip.net/h35130127-Wood-R4-for-R4i-Gold-%28R4iDS%29.html >>fh.dq
if /i "%f5%" EQU "*" echo http://filetrip.net/h35130793-Wood-R4iDSN.html >>fh.dq
if /i "%f6%" EQU "*" echo http://filetrip.net/h35130821-CycloDS-Evolution-Firmware-Stable.html >>fh.dq
if /i "%f7%" EQU "*" echo http://filetrip.net/h35131267-CycloDS-iEvolution-Firmware-Stable.html >>fh.dq
if /i "%f8%" EQU "*" echo http://filetrip.net/h35132061-iSmart-MM-kernel-update.html >>fh.dq
if /i "%f9%" EQU "*" echo http://filetrip.net/h25124137-EZ5-Kernel.html >>fh.dq
if /i "%f10%" EQU "*" echo http://filetrip.net/h25124710-EZ5i-Kernel.html >>fh.dq
if /i "%f11%" EQU "*" echo http://filetrip.net/h25123141-The-M3-Quad-Boot.html >>fh.dq
if /i "%f12%" EQU "*" echo http://filetrip.net/h35129830-EDGE-OS.html >>fh.dq
if /i "%f13%" EQU "*" echo http://filetrip.net/h35129832-iEDGE-OS.html >>fh.dq
if /i "%f14%" EQU "*" echo http://filetrip.net/d26367-N5-Firmware-1-32.html >>fh.dq
if /i "%f15%" EQU "*" echo http://filetrip.net/d26383-N5i-2-03-ENG-LTE.html >>fh.dq
if /i "%f16%" EQU "*" echo http://down.supercard.sc/download/evolution/DSONE_Evolution_V1.0_eng_sp6_20110427.zip >>fh.dq
if /i "%f17%" EQU "*" echo http://down.supercard.sc/download/evolution/DSONE_mini_SDHC_Evolution_V1.0_eng_sp6_20110427.zip >>fh.dq
if /i "%f18%" EQU "*" echo http://down.supercard.sc/download/evolution/DSONE_SDHC_Evolution_V1.0_eng_sp6_20110427.zip >>fh.dq
if /i "%f19%" EQU "*" echo http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html >>fh.dq
if /i "%f20%" EQU "*" echo http://filetrip.net/h35131650-iSmart-Premium-kernel.html >>fh.dq
if /i "%f21%" EQU "*" echo http://www.ndstt.com/download/os/v1.17/ttmenu_en.zip >>fh.dq
if /i "%mc1%" EQU "*" echo http://filetrip.net/h35131285-CycloDS-iEvolution-Moonshell.html >>fh.dq
if /i "%mc2%" EQU "*" echo http://mdxonline.dyndns.org/201002161705_moonshell210stable.zip >>fh.dq
if /i "%mc3%" EQU "*" echo http://filetrip.net/d26407-BootStrap-File-for-iEDGE-4.html >>fh.dq
if /i "%mc4%" EQU "*" echo http://filetrip.net/h35131269-CycloDS-iEvolution-Bootstrap-%28US-.html >>fh.dq
if /i "%mc5%" EQU "*" echo http://filetrip.net/h35131270-CycloDS-iEvolution-Bootstrap-%28Eu-.html >>fh.dq
if /i "%dp1%" EQU "*" echo http://filetrip.net/d11694-SuperCard-DSTWO-GBA-EMU-Plug-in-1-21.html >>fh.dq
if /i "%dp2%" EQU "*" echo http://filetrip.net/h35130196-SCDS2Iplayer-GBA-EMU-%28game_conf-.html >>fh.dq
if /i "%dp3%" EQU "*" echo http://filetrip.net/h35131424-CATSFC.html >>fh.dq
if /i "%dp4%" EQU "*" echo http://filetrip.net/h35130740-Supercard-DSTWO-iPlayer-Plugin.html >>fh.dq
if /i "%dp5%" EQU "*" echo http://filetrip.net/h35130143-DSTwo-iReader.html >>fh.dq
if /i "%dp6%" EQU "*" echo http://down.supercard.cn/download/dstwo/plugin/moonshl2_for_DSTWO.zip >>fh.dq
if /i "%df1%" EQU "*" echo http://down.supercard.sc/download/evolution/dsoneimini_update_eng_3dsv2204.zip >>fh.dq
if /i "%df2%" EQU "*" echo http://r4idsn.com/admin/userimages/V143_Patch_R4iDSN_Non3DS.rar >>fh.dq
if /i "%df3%" EQU "*" echo http://www.r4idsn.com/admin/userimages/R4iDSN_3DS22_Patch.rar >>fh.dq
if /i "%df4%" EQU "*" echo http://www.r4idsn.com/admin/userimages/Patch_3DS30.rar >>fh.dq
if /i "%df5%" EQU "*" echo http://www.acekard.com/download/ak2/ak2ifw_update_3ds3.0_DSi143.zip >>fh.dq
if /i "%df6%" EQU "*" echo http://down.supercard.sc/download/dstwo/Firmware/Firmware_v1.13_eng.zip >>fh.dq
if /i "%df7%" EQU "*" echo ftp://r4idsdown:r4idsdown@www.r4ids.co.cc/R4iGold_3DS2.2_Patch.rar >>fh.dq
if /i "%df8%" EQU "*" echo ftp://r4idsdown:r4idsdown@www.r4ids.co.cc/V143_Patch_R4iGold_Non3DS.rar >>fh.dq
if /i "%df9%" EQU "*" echo ftp://r4idsdown:r4idsdown@www.r4ids.co.cc/Special_Patch.rar >>fh.dq
if /i "%df10%" EQU "*" echo http://www.ezflash.cn/zip/V108a.rar >>fh.dq
if /i "%df11%" EQU "*" echo http://filetrip.net/d25495-M3i-Zero-Core-2-0-2.html >>fh.dq
if /i "%df12%" EQU "*" echo http://filetrip.net/d26365-DSTT-Core-Firmware-Update-DSi-1---1.html >>fh.dq
if /i "%gd1%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/ak2.guide.txt >>fh.dq
if /i "%gd2%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/r4.guide.txt >>fh.dq
if /i "%gd3%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/tt.guide.txt >>fh.dq
if /i "%gd4%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/r4i.guide.txt >>fh.dq
if /i "%gd5%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/dsn.guide.txt >>fh.dq
if /i "%gd6%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/cyclo.guide.txt >>fh.dq
if /i "%gd7%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/ievo.guide.txt >>fh.dq
if /i "%gd8%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/ismm.guide.txt >>fh.dq
if /i "%gd9%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/ez5.guide.txt >>fh.dq
if /i "%gd10%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/m3.guide.txt >>fh.dq
if /i "%gd11%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/isp.guide.txt >>fh.dq
if /i "%gd12%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/edge.guide.txt >>fh.dq
if /i "%gd13%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/iedge.guide.txt >>fh.dq
if /i "%gd14%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/ds2.guide.txt >>fh.dq
if /i "%gd15%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/sctt.guide.txt >>fh.dq
if /i "%gd16%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/ds1.guide.txt >>fh.dq
if /i "%gd17%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/enderyptguide.txt >>fh.dq
if /i "%gd18%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/dsc.guide.txt >>fh.dq
if /i "%gd19%" EQU "*" echo http://flashcart-helper.googlecode.com/svn/data/guides/menudo.guide.txt >>fh.dq
IF NOT EXIST fh.dq (echo Error 404 Queue Empty && pause && exit)
goto callqueue

:savqueue
echo set validq=*>>savequeue.bat
if /i "%u1%" EQU "*" echo set u1=*>>savequeue.bat
if /i "%u2%" EQU "*" echo set u2=*>>savequeue.bat
if /i "%u3%" EQU "*" echo set u3=*>>savequeue.bat
if /i "%u4%" EQU "*" echo set u4=*>>savequeue.bat
if /i "%m1%" EQU "*" echo set m1=*>>savequeue.bat
if /i "%m2%" EQU "*" echo set m2=*>>savequeue.bat
if /i "%m3%" EQU "*" echo set m3=*>>savequeue.bat
if /i "%m4%" EQU "*" echo set m4=*>>savequeue.bat
if /i "%m5%" EQU "*" echo set m5=*>>savequeue.bat
if /i "%m6%" EQU "*" echo set m6=*>>savequeue.bat
if /i "%f1%" EQU "*" echo set f1=*>>savequeue.bat
if /i "%f2%" EQU "*" echo set f2=*>>savequeue.bat
if /i "%f3%" EQU "*" echo set f3=*>>savequeue.bat
if /i "%f4%" EQU "*" echo set f4=*>>savequeue.bat
if /i "%f5%" EQU "*" echo set f5=*>>savequeue.bat
if /i "%f6%" EQU "*" echo set f6=*>>savequeue.bat
if /i "%f7%" EQU "*" echo set f7=*>>savequeue.bat
if /i "%f8%" EQU "*" echo set f8=*>>savequeue.bat
if /i "%f9%" EQU "*" echo set f9=*>>savequeue.bat
if /i "%f10%" EQU "*" echo set f10=*>>savequeue.bat
if /i "%f11%" EQU "*" echo set f11=*>>savequeue.bat
if /i "%f12%" EQU "*" echo set f12=*>>savequeue.bat
if /i "%f13%" EQU "*" echo set f13=*>>savequeue.bat
if /i "%f14%" EQU "*" echo set f14=*>>savequeue.bat
if /i "%f15%" EQU "*" echo set f15=*>>savequeue.bat
if /i "%f16%" EQU "*" echo set f16=*>>savequeue.bat
if /i "%f17%" EQU "*" echo set f17=*>>savequeue.bat
if /i "%f18%" EQU "*" echo set f18=*>>savequeue.bat
if /i "%f19%" EQU "*" echo set f19=*>>savequeue.bat
if /i "%f20%" EQU "*" echo set f20=*>>savequeue.bat
if /i "%f21%" EQU "*" echo set f21=*>>savequeue.bat
if /i "%mc1%" EQU "*" echo set mc1=*>>savequeue.bat
if /i "%mc2%" EQU "*" echo set mc2=*>>savequeue.bat
if /i "%mc3%" EQU "*" echo set mc3=*>>savequeue.bat
if /i "%mc4%" EQU "*" echo set mc4=*>>savequeue.bat
if /i "%mc5%" EQU "*" echo set mc5=*>>savequeue.bat
if /i "%dp1%" EQU "*" echo set dp1=*>>savequeue.bat
if /i "%dp2%" EQU "*" echo set dp2=*>>savequeue.bat
if /i "%dp3%" EQU "*" echo set dp3=*>>savequeue.bat
if /i "%dp4%" EQU "*" echo set dp4=*>>savequeue.bat
if /i "%dp5%" EQU "*" echo set dp5=*>>savequeue.bat
if /i "%dp6%" EQU "*" echo set dp6=*>>savequeue.bat
if /i "%dp7%" EQU "*" echo set dp7=*>>savequeue.bat
if /i "%df1%" EQU "*" echo set df1=*>>savequeue.bat
if /i "%df2%" EQU "*" echo set df2=*>>savequeue.bat
if /i "%df3%" EQU "*" echo set df3=*>>savequeue.bat
if /i "%df4%" EQU "*" echo set df4=*>>savequeue.bat
if /i "%df5%" EQU "*" echo set df5=*>>savequeue.bat
if /i "%df6%" EQU "*" echo set df6=*>>savequeue.bat
if /i "%df7%" EQU "*" echo set df7=*>>savequeue.bat
if /i "%df8%" EQU "*" echo set df8=*>>savequeue.bat
if /i "%df9%" EQU "*" echo set df9=*>>savequeue.bat
if /i "%df10%" EQU "*" echo set df10=*>>savequeue.bat
if /i "%df11%" EQU "*" echo set df11=*>>savequeue.bat
if /i "%df12%" EQU "*" echo set df12=*>>savequeue.bat
if /i "%gd1%" EQU "*" echo set gd1=*>>savequeue.bat
if /i "%gd2%" EQU "*" echo set gd2=*>>savequeue.bat
if /i "%gd3%" EQU "*" echo set gd3=*>>savequeue.bat
if /i "%gd4%" EQU "*" echo set gd4=*>>savequeue.bat
if /i "%gd5%" EQU "*" echo set gd5=*>>savequeue.bat
if /i "%gd6%" EQU "*" echo set gd6=*>>savequeue.bat
if /i "%gd7%" EQU "*" echo set gd7=*>>savequeue.bat
if /i "%gd8%" EQU "*" echo set gd8=*>>savequeue.bat
if /i "%gd9%" EQU "*" echo set gd9=*>>savequeue.bat
if /i "%gd10%" EQU "*" echo set gd10=*>>savequeue.bat
if /i "%gd11%" EQU "*" echo set gd11=*>>savequeue.bat
if /i "%gd12%" EQU "*" echo set gd12=*>>savequeue.bat
if /i "%gd13%" EQU "*" echo set gd13=*>>savequeue.bat
if /i "%gd14%" EQU "*" echo set gd14=*>>savequeue.bat
if /i "%gd15%" EQU "*" echo set gd15=*>>savequeue.bat
if /i "%gd16%" EQU "*" echo set gd16=*>>savequeue.bat
if /i "%gd17%" EQU "*" echo set gd17=*>>savequeue.bat
if /i "%gd18%" EQU "*" echo set gd18=*>>savequeue.bat
if /i "%gd19%" EQU "*" echo set gd19=*>>savequeue.bat
::Rename Saveque to savren
:renamesav
echo What would you like to name your Saved Queue?
echo The name cannot contain the characters " > ? < / \ * : ; 
echo It also cannot be empty space(s)
set /p savren=
ren "savequeue.bat" "%savren%.fhq.bat"
IF NOT EXIST "%savren%.fhq.bat" (echo Queue not saved properly, [Invalid file name?]) ELSE (echo Queue saved sucessfully to %cd%\%savren%.fhq.bat\)
pause
exit
:callqueue
call dlque.bat
:clque
cls
echo Clear Current Download Queue?
echo (y/n)
set /p clq=
IF /i "%clq%" EQU "y" (goto dlist) else (goto dbegin)
goto dlist

:imque
cls
echo Please drag the queue file (*.fhq.bat) to the FlashcartHelper window
set /p iqueue=
call %iqueue%
if "%validq%" NEQ "*" (echo Invalid queue file) else (echo Queue imported successfully)
pause
goto dbegin
:ds2skin
start http://wiki.gbatemp.net/wiki/SuperCard_DSTWO_ds2skin_packs

:src
start /wait flashcarthelper.exe -d
echo FlashcartHelper decomplied successfully. Source has been saved
pause
goto begin
