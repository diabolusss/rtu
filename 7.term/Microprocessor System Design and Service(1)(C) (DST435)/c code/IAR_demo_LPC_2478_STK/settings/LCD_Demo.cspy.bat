@REM This batch file has been generated by the IAR Embedded Workbench
@REM C-SPY Debugger, as an aid to preparing a command line for running
@REM the cspybat command line utility using the appropriate settings.
@REM
@REM You can launch cspybat by typing the name of this batch file followed
@REM by the name of the debug file (usually an ELF/DWARF or UBROF file).
@REM Note that this file is generated every time a new debug session
@REM is initialized, so you may want to move or rename the file before
@REM making changes.
@REM 


"Z:\IAR Systems\Embedded Workbench 6.0 ARM\common\bin\cspybat" "Z:\IAR Systems\Embedded Workbench 6.0 ARM\arm\bin\armproc.dll" "Z:\IAR Systems\Embedded Workbench 6.0 ARM\arm\bin\armjlink.dll"  %1 --plugin "Z:\IAR Systems\Embedded Workbench 6.0 ARM\arm\bin\armbat.dll" --flash_loader "Z:\IAR Systems\Embedded Workbench 6.0 ARM\arm\config\flashloader\NXP\FlashNXPLPC512k2.board" --backend -B "--endian=little" "--cpu=ARM7TDMI-S" "--fpu=None" "-p" "Z:\IAR Systems\Embedded Workbench 6.0 ARM\arm\config\debugger\NXP\iolpc2470.ddf" "--semihosting" "--device=LPC2478" "--drv_communication=USB0" "--jlink_speed=300" "--jlink_reset_strategy=0,5" 


