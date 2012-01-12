@echo off
echo --frecop %time% %date% FlashcartHelper %currentver% -- >> fh.log
move %1 Trashes >> fh.log 2>&1 