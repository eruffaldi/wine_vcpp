#Introduction

Using Visual Studio Compiler inside Wine (e.g. OSX) for x86 and x64 builds

##Requirements

Install samba3 with macport or brew for PDB support

#Creation

1) Have at hand Visual Studio 2015 free version and 
	- put VC folder under /VC
	- put Windows 8.1 SDK under /kit8.1
	- put Windows 10 SDK under /kit10
	- put tools under /tools
	- put mt under /mt

	About 7200 files for 2.51GB. Note that the pure x86 should be able to stay in 1GB. Just remove all the folders named: arm arm64 x64 amd64 amd64_arm amd64_x86 x86_arm x86_amd64

2) replace the files .bat below
	VC/bin/vcvars32.bat
	VC/x86_amd64/vcvarsx86_amd64.bat
	VC/vcvarsall.bat

3) mount this folder on c:\VC (e.g. symbolic link to .wine/drive_c/VC)

#Usage
Note: Visual Studio 2015 comes with the following 6 variants: amd64,x86 -> amd64,x86,arm

Use the following commands for creating the correct environment

Windows 10 - x86 over x86 (pure)

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86 10.0.10150.0

Windows 10 - x64 over x86 (x86_amd64)

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86_amd64 10.0.10150.0

Note: the version number at the end of the string depends on your SDK installation

Note: Windows 10 uses kit8.1 libraries for kernel
Note: the Windows 8.1 option is not available due to the lack of stdio.h in kit8.1

	WINEDEBUG=-all wine cmd /K c:\\VC\\VC\\vcvarsall.bat x86 8.1

Two bash aliases can be created

	alias vc64="WINEDEBUG=-all wine cmd /K \"c:\\VC\\VC\\vcvarsall.bat x86_amd64 10.0.10150.0\""
	alias vc86="WINEDEBUG=-all wine cmd /K \"c:\\VC\\VC\\vcvarsall.bat x86 10.0.10150.0\""

Alternatively it is possible to create vc64.sh shell script that invokes the command on the command line and then exits

	WINEDEBUG=-all wine cmd /K "c:\\VC\\VC\\vcvarsall.bat x86_amd64 10.0.10150.0 && $1 && exit"
  
#CMake

CMake recognizes the compiler set-up by the vcvarsall script above. But then there is a problem with "C1902: Program database manager mismatch; please check your installation". This problem can occur also if cl is invoked with /Zi. It gives the related error "LNK1101: incorrect MSPDB140.DLL version; recheck installation of this product"

These messages are caused by some limitations of Wine (as of 1.8.2): that is after installing samba3 that provides ntlm_auth there is an issue with the following missing function:

	wine: Call from 0x7b8291e5 to unimplemented function api-ms-win-crt-string-l1-1-0.dll._memicmp_l, aborting

#Next

Solve CMake issue and test with Kinect 2 SDK

Support for pure x86 and x86_amd64: note that Wine in Linux supports 64bit executables, while this is not a case of OSX due to a major incompatibility between OSX and Win64 in terms of ABI: https://www.winehq.org/wwn/364#Wine64%20on%20Mac%20OS%20X

#Related

Kudos to http://ooo-imath.sourceforge.net/wiki/index.php/Cross-compiling_for_Windows#Visual_Studio_2015

