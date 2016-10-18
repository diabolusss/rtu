@echo off
echo ================================================================
echo ##                                                            ##
echo ## Place bach file with 7za.exe in the folder you want backup ##
echo ##                                                            ##
echo ================================================================

SET Today=%Date: =0%
SET Year=%Today:~-4%
:: Include 1 extra character, which will be either a leading zero or a trailing separator
SET Month=%Today:~-10,3%
:: Remove separator
SET Month=%Month:-=%
SET Month=%Month:/=%
:: Clear leading zeroes
SET /A Month = 100%Month% %% 100
:: And add one again, if necessary
SET /A Month = 100 + %Month%
SET Month=%Month:~-2%
SET Day=%Today:~-7,2%
:: Remove separator
SET Day=%Day:-=%
SET Day=%Day:/=%
:: Clear leading zeroes, as there may be 2 leading zeroes
SET /A Day = 100%Day% %% 100
:: And add one again, if necessary
SET /A Day = 100 + %Day%
SET Day=%Day:~-2%

set hour=%time:~0,2%
if "%hour:~0,1%"==" " set hour=0%time:~1,1%
set folder="backup_"%Year%%Month%%Day%_%hour%%time:~3,2%_%time:~6,2%
for /r %%f in *.pde do echo %%f 
::7za a -t7z -mx9 %folder%.7z "%%f" -r
@pause