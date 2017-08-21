#!/bin/bash
echo "Invoking linker $*"
WINEDEBUG=-all wine cmd /K "c:\\VC\\VC\\vcvarsall.bat x86 10.0.10150.0 && link $* && exit"
