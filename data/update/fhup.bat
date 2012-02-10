::FlashcartHelper updater
@echo off
color 9f
set newver=0.9
echo FlashcartHelper is currently at %currentver%
pause
IF %newver% GTR %currentver% goto update
IF %newver% EQU %currentver% goto noup
IF %newver% LSS %currentver% goto beta

:noup
echo Latest FlashcartHelper is at %newver%
echo There are no new updates at this time
pause
call FlashcartHelper

:beta
echo WARNING! You are running a beta version of FlashcartHelper.
pause
call FlashcartHelper
:update
cls
echo There is an update from %currentber% to %newver%
echo Press any key to update.
pause 2>nul
echo FlashcartHelper is updating to %newver%
start /wait wget http://flashcart-helper.googlecode.com/svn/data/update/FlashcartHelper.up
del FlashcartHelper.exe
ren FlashcartHelper.up FlashcartHelper.exe
call FlashcartHelper
