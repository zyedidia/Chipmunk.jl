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
@osx_only ext = "dylib"
@linux_only ext = "so"
@windows_only ext = "dll"

mv("src/libchipmunk.7.0.0.$ext", "../libchipmunk.$ext")
cd("..")

rm("Chipmunk2D", recursive=true)

println("Successfully built Chipmunk.jl!")
