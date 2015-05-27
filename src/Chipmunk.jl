module Chipmunk

import Base: step, sleep

dlsym = Base.Libdl.dlsym

function __init__()
	try
		cd(Pkg.dir("Chipmunk")*"/deps") do
			global const libchipmunk = Libdl.dlopen("libchipmunk")
			global const libchipmunkjl = Libdl.dlopen("libchipmunkjl")
		end
	catch exception
		println("Error: Could not find libchipmunk")
		println("Please rebuild")
	end
end

include("julia/chipmunk.jl")
include("julia/chipmunk_types.jl")
include("julia/cpBody.jl")
include("julia/cpSpace.jl")
include("julia/cpShape.jl")
include("julia/cpPolyShape.jl")
include("julia/cpConstraint.jl")
include("julia/cpSimpleMotor.jl")
include("julia/cpPivotJoint.jl")
include("julia/cpPinJoint.jl")

try
	# Only include this if SFML.jl is installed
	Pkg.installed("SFML")
	include("julia/cpDebugDraw.jl")
catch exception
end

end
