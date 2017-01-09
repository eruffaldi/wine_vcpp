set(CMAKE_SYSTEM_NAME Windows)
#set(MSYS 1)
set(BUILD_SHARED_LIBS ON)
set(LIBTYPE SHARED)
set(CMAKE_CXX_COMPILER_ID MSVC)
set(CMAKE_CXX_PLATFORM_ID Windows)
set(CMAKE_C_COMPILER_ID MSVC)
#set(CMAKE_PREFIX_PATH /Applications/mxe/usr/x86_64-w64-mingw32.shared.posix)
#set(CMAKE_FIND_ROOT_PATH /Applications/mxe/usr/x86_64-w64-mingw32.shared.posix)
#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(BASE /Volumes/BigData/metaVS2015)
set(CMAKE_C_COMPILER ${BASE}/winecl.sh)
set(CMAKE_CXX_COMPILER ${BASE}/winecl.sh)
set(CMAKE_CXX_LINK_EXECUTABLE ${BASE}/winelink.sh)
#set(CMAKE_Fortran_COMPILER /Applications/mxe/usr/bin/x86_64-w64-mingw32.shared.posix-gfortran)
#set(CMAKE_RC_COMPILER /Applications/mxe/usr/bin/x86_64-w64-mingw32.shared.posix-windres)
#set(CMAKE_MODULE_PATH "/Applications/mxe/usr/share/cmake/modules" ${CMAKE_MODULE_PATH}) # For mxe FindPackage scripts
#set(CMAKE_INSTALL_PREFIX /Applications/mxe/usr/x86_64-w64-mingw32.shared.posix CACHE PATH "Installation Prefix")
set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug|Release|RelWithDebInfo|MinSizeRel")
set(CMAKE_CROSS_COMPILING ON) # Workaround for http://www.cmake.org/Bug/view.php?id=14075
#set(CMAKE_RC_COMPILE_OBJECT "<CMAKE_RC_COMPILER> -O coff <FLAGS> <DEFINES> -o <OBJECT> <SOURCE>") # Workaround for buggy windres rules

#file(GLOB mxe_cmake_files
#    "/Applications/mxe/usr/x86_64-w64-mingw32.shared.posix/share/cmake/mxe-conf.d/*.cmake"
#)
#foreach(mxe_cmake_file ${mxe_cmake_files})
#    include(${mxe_cmake_file})
#endforeach()