println("Checking dependencies...")

try
	run(`which cmake`)
catch exception
	error("You must install cmake to build this package.")
end

println("Good...")

println("Cloning Chipmunk source...")

cd(Pkg.dir("Chipmunk")*"/deps")
run(`git clone https://github.com/slembcke/Chipmunk2D.git`)

cd("Chipmunk2D")

run(`cmake . -DBUILD_DEMOS=OFF`)
run(`make`)

ext = ""
@linux_only ext = "so"
@osx_only ext = "dylib"
@windows_only ext = "dll"

cd("../../src/c") do
	run(`gcc -I$(Pkg.dir("Chipmunk"))/deps/Chipmunk2D/include/chipmunk -c chipmunkjl.c`)
	run(`gcc -I$(Pkg.dir("Chipmunk"))/deps/Chipmunk2D/include/chipmunk -L$(Pkg.dir("Chipmunk"))/deps/Chipmunk2D/src -lchipmunk -shared -o ../../deps/libchipmunkjl.$ext chipmunkjl.o`)
	run(`rm chipmunkjl.o`)
end

@linux_only begin
	mv("src/libchipmunk.so.7.0.0", "../libchipmunk.so")
end
@osx_only begin
	mv("src/libchipmunk.7.0.0.dylib", "../libchipmunk.dylib")
end
@windows_only begin
	mv("src/libchipmunk.7.0.0.dll", "../libchipmunk.dll")
end

cd("..")

rm("Chipmunk2D", recursive=true)

println("Successfully built Chipmunk.jl!")
