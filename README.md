# Introduction

Using Visual Studio Compiler inside Wine (e.g. OSX) for x86 and x64 builds

Status: 
* simple manual builds work
* /Zi requires patch to wine (below)

Blocker: 
* nmake uses special flags and wine has problems
* cmake has performance hits during compiler checks

## Requirements

In addition to wine it is necessary to install samba3 to compile debug information with PDB. 

Visual Studio 2015 free edition.

Update: Microsoft is now providing Visual Studio 2015 C++ compiler as standalone package: http://landinghub.visualstudio.com/visual-cpp-build-tools

## Creation

1) Have at hand Visual Studio 2015 free version and 

	- put VC folder under /VC
	- put Windows 8.1 SDK under /kit8.1
	- put Windows 10 SDK under /kit10
	- put tools under /tools
	- put mt under /mt

About 7200 files for 2.51GB. Note that the pure x86 should be able to stay in 1GB. 
To make pure x86 remove all the folders named as follows: arm arm64 x64 amd64 amd64_arm amd64_x86 x86_arm x86_amd64

2) replace the files .bat below with the ones provided in this repository

* VC/bin/vcvars32.bat
* VC/bin/x86_amd64/vcvarsx86_amd64.bat
* VC/vcvarsall.bat

3) inside wine mount this folder on c:\VC (e.g. using symbolic link to .wine/drive_c/VC)

## Patching

api-ms-win-crt-string-l1-1-0.dll

Under wine 1.8.x the function memcmpi_l is not implemented and PDB stuff of cl is not working. We need to replace it with a stub calling memcmpi. 

Go into patch and do make. It is configured to generate that DLL using one recent spec file from Wine, for x86. 

# Usage
Note: Visual Studio 2015 comes with the following 6 variants: two hosting platforms amd64,x86 and three target platforms amd64,x86,arm. Under OSX it is necessary to use 32bit (x86) hosting, while under Linux it is also possible to use 64bit hosting.

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
  
# CMake
There are two options: the first is to run cmake outside wine, the second inside wine. In the former we define a toolchain that uses wine+cl as compiler, in the latter we use cmake for Windows.

Cross compilation with cmake can be achieved in two ways: from outside Wine using a toolchain that invokes Wine at every step, or inside Wine using cmake for windows.

## Crosscompilation

This employs two helper scripts (winecl and winelink) that call wine

## Outside Wine

Fails due to lack of rc.exe in compiler testing. Compiler testing can be avoided using the variable CMAKE_C_COMPILER_WORKS=1:

## Outside Wine

From outside wine we have a missing source file


## Inside Wine
TODO for compiler MSVC 19.0.24215.1

We provide a toolchain file but the recognition of the compiler is very slow, although it improved from Wine 1.8 to 

	  cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake ..

## Errors

CMake, after solving the missing memcmpi_l function, fails due to lack of rc.exe in compiler testing. ompiler testing can be avoided using the variable CMAKE_C_COMPILER_WORKS=1:

         cmake -DCMAKE_CXX_COMPILER_WORKS=1 -DCMAKE_C_COMPILER_WORKS=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake  ..

and then make CMAKE_RC_COMPILER point to the alternative implementation from mingw (windres):

         CMAKE_RC_COMPILER:FILEPATH=...
  
Windres can be found on: https://sourceforge.net/projects/mingw/files/MinGW/Base/binutils/binutils-2.25.1/binutils-2.25.1-1-mingw32-bin.tar.xz/download

We cannot use: -G "Visual Studio 14 2015" 

#Next

Solve CMake issue and test with Kinect 2 SDK

# TODO

Solve CMake issue and test with: Kinect 2 SDK and pre-compiled OpenCV 3.3

# Related

Kudos to http://ooo-imath.sourceforge.net/wiki/index.php/Cross-compiling_for_Windows#Visual_Studio_2015

