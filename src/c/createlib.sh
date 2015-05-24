gcc -I/usr/local/include/chipmunk -c chip.c
gcc -I/usr/local/include/chipmunk -L/usr/local/lib -lchipmunk -shared -o ../libchipmunkjl.dylib chip.o
