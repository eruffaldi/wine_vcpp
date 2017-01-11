#otool -TV api-ms-win-crt-string-l1-1-0.dll.so.orig
#nm -ga api-ms-win-crt-string-l1-1-0.dll.so.orig
ARCH=i386
WINEARCH=32

all: api-ms-win-crt-string-l1-1-0.dll.so

api-ms-win-crt-string-l1-1-0.as: api-ms-win-crt-string-l1-1-0.spec
	winebuild --dll -E $< -m${WINEARCH} --external-symbols > $@ 

api-ms-win-crt-string-l1-1-0.o: api-ms-win-crt-string-l1-1-0.as
	as -arch i386 $< -o $@

_mymemicmp_l.o: _mymemicmp_l.c
	gcc -arch ${ARCH} -c $< -o $@

api-ms-win-crt-string-l1-1-0.dll.so: api-ms-win-crt-string-l1-1-0.o _mymemicmp_l.o
	ld -dylib -arch ${ARCH} -L/opt/local/lib/wine -lwinecrt0 -o $@ -L/opt/local/lib -lwine -undefined dynamic_lookup -read_only_relocs suppress $?
