#Introduction

Using Visual Studio Compiler inside Wine (e.g. OSX) for x86 and x64 builds

#Creation

1) Have at hand Visual Studio 2015 free version and 
	- put VC folder under /VC
	- put Windows 8.1 SDK under /kit8.1
	- put Windows 10 SDK under /kit10
	- put tools under /tools
	- put mt under /mt

	About 7200 files for 2.51GB

2) replace the files .bat below
	VC/bin/vcvars32.bat
	VC/x86_amd64/vcvarsx86_amd64.bat
	VC/vcvarsall.bat

3) mount this folder on c:\VC (e.g. symbolic link to .wine/drive_c/VC)


#Usage

Use the following commands for creating the correct environment

Windows 10 - x86 over x86

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86 10.0.10150.0

Windows 10 - x64 over x86 (resulting binary does not work on wine)

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86 10.0.10150.0


Note: Windows 10 uses kit8.1 libraries for kernel
Note: the Windows 8.1 option is not available due to the lack of stdio.h in kit8.1

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86 8.1


#Next

More testing, addint Kinect 2.0 SDK example, more check with cmake