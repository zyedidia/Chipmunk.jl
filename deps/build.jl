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
