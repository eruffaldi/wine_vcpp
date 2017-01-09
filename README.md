
Creation
--------

- use Visual Studio 2015 installation with Windows 10 SDK /VC
- find Windows 8.1 SDK => /kit8.1
- find Windows 10 SDK  => /kit10
- find tools /tools
- find mt => /mt/mt.*

Install/build cmake for windows

Then replace the files: vcvars32.bat and vcvarsall.bat 

VC/bin/vcvars32.bat
VC/vcvarsall.bat


Mount file for WINE
-------------------

The following structure is needed inside WINE under c:\\VC (e.g. via symoblic link)

VC\
kit8.1\
kit10\
tools\

Usage
-----

Use the following commands for creating the correct environment

Windows 8.1: missing stdio.h!!!!

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86 8.1

Windows 10: uses lib kernel from Windows 8.1

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86 10.0.10150.0

Next
----
- 64bit 
- clearer instruction where to find things

Note: using cmake in crosscompilation mode to wine is not currently possible / aka slow