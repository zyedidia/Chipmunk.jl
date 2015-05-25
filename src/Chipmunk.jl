module Chipmunk

import Base: step, sleep

dlsym = Base.Libdl.dlsym

function __init__()
	try
		cd(Pkg.dir("Chipmunk")*"/deps") do
			global const libchipmunk = Libdl.dlopen("libchipmunk")
		end
	catch exception
		println("Error: Could not find libchipmunk")
	end
end

include("julia/chipmunk.jl")
include("julia/chipmunk_types.jl")
include("julia/cpBody.jl")
include("julia/cpSpace.jl")
include("julia/cpShape.jl")
include("julia/cpPolyShape.jl")

end
