gcc -I/usr/local/include/chipmunk -c chipmunkjl.c
gcc -I/usr/local/include/chipmunk -L/usr/local/lib -lchipmunk -shared -o ../../deps/libchipmunkjl.dylib chipmunkjl.o
