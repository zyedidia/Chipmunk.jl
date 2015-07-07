module Chipmunk

import Base: step, sleep
import SFML

dlsym = Base.Libdl.dlsym

function __init__()
    try
        deps = Pkg.dir("Chipmunk")*"/deps"
        global const libchipmunk = Libdl.dlopen("$deps/libchipmunk", Libdl.RTLD_GLOBAL)
        global const libchipmunkjl = Libdl.dlopen("$deps/libchipmunkjl", Libdl.RTLD_GLOBAL)
    catch exception
        println("Error: Could not find libchipmunk")
        println("Please rebuild")
    end
end

use_debug_draw = true
try
    global const debug_circle = SFML.CircleShape()
    global debug_line = SFML.Line(SFML.Vector2f(0, 0), SFML.Vector2f(0, 0), 0)
    global const debug_polygon = SFML.ConvexShape()
    global const debug_dot = SFML.CircleShape()
catch exception
    warn("SFML could not be loaded.")
    warn("Debug draw will be unavailable")
    use_debug_draw = false
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
include("julia/cpDebugDraw.jl")
include("julia/cpCollisionHandler.jl")

end
