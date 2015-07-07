cd("$(Pkg.dir("Chipmunk"))/deps")
println("Checking dependencies...")

try
    @unix_only run(`which cmake`)
catch exception
    error("You must install cmake to build this package.")
end

println("Good...")

if !isdir("Chipmunk2D")
    println("Cloning Chipmunk source...")

    cd(Pkg.dir("Chipmunk")*"/deps")
    run(`git clone https://github.com/slembcke/Chipmunk2D.git`)
end

cd("Chipmunk2D")
run(`git checkout Chipmunk-7.0.0`)

run(`cmake . -DBUILD_DEMOS=OFF`)
run(`make`)

ext = ""
@linux_only ext = "so"
@osx_only ext = "dylib"
@windows_only ext = "dll"

@linux_only begin
    cp("src/libchipmunk.so.7.0.0", "../libchipmunk.so", remove_destination=true)
end
@osx_only begin
    cp("src/libchipmunk.7.0.0.dylib", "../libchipmunk.dylib", remove_destination=true)
end
@windows_only begin
    cp("src/libchipmunk.7.0.0.dll", "../libchipmunk.dll", remove_destination=true)
end


cd("..")

run(`gcc -fPIC -I./Chipmunk2D/include/chipmunk -c $(Pkg.dir("Chipmunk"))/src/c/chipmunkjl.c`)
run(`gcc -I./Chipmunk2D/include/chipmunk -L. -lchipmunk -shared -o ./libchipmunkjl.$ext chipmunkjl.o`)
run(`rm chipmunkjl.o`)

# rm("Chipmunk2D", recursive=true)

println("Successfully built Chipmunk.jl!")
