function DampedSpring(a::Body, b::Body, anchorA::Vect, anchorB::Vect, restlength::Real, stiffness::Real, damping::Real)
    ccall(dlsym(libchipmunk, :cpDampedSpringNew), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Vect, Vect, Cdouble, Cdouble, Cdouble,), a.ptr, b.ptr, anchorA, anchorB, restlength, stiffness, damping)
end

function get_anchorA(spring::DampedSpring)
    ccall(dlsym(libchipmunk, :cpDampedSpringGetAnchorA), Vect, (Ptr{Void},), spring.ptr)
end

function set_anchorA(spring::DampedSpring, anchor::Vect)
    ccall(dlsym(libchipmunk, :cpDampedSpringSetAnchorA), Void, (Ptr{Void}, Vect,), spring.ptr, anchor)
end

function get_anchorB(spring::DampedSpring)
    ccall(dlsym(libchipmunk, :cpDampedSpringGetAnchorB), Vect, (Ptr{Void},), spring.ptr)
end

function set_anchorB(spring::DampedSpring, anchor::Vect)
    ccall(dlsym(libchipmunk, :cpDampedSpringSetAnchorB), Void, (Ptr{Void}, Vect,), spring.ptr, anchor)
end

function get_restlength(spring::DampedSpring)
    ccall(dlsym(libchipmunk, :cpDampedSpringGetRestLength), Cdouble, (Ptr{Void},), spring.ptr)
end

function set_restlength(spring::DampedSpring, restlength::Real)
    ccall(dlsym(libchipmunk, :cpDampedSpringSetRestLength), Void, (Ptr{Void}, Cdouble,), spring.ptr, restlength)
end

function get_stiffness(spring::DampedSpring)
    ccall(dlsym(libchipmunk, :cpDampedSpringGetStiffness), Cdouble, (Ptr{Void},), spring.ptr)
end

function set_stiffness(spring::DampedSpring, stiffness::Real)
    ccall(dlsym(libchipmunk, :cpDampedSpringSetStiffness), Void, (Ptr{Void}, Cdouble,), spring.ptr, stiffness)
end

function get_damping(spring::DampedSpring)
    ccall(dlsym(libchipmunk, :cpDampedSpringGetDamping), Cdouble, (Ptr{Void},), spring.ptr)
end

function set_damping(spring::DampedSpring, damping::Real)
    ccall(dlsym(libchipmunk, :cpDampedSpringSetDamping), Void, (Ptr{Void}, Cdouble,), spring.ptr, damping)
end

export DampedSpring, get_anchorA, set_anchorA, get_anchorB, set_anchorB, get_restlength, set_restlength,
get_stiffness, set_stiffness, get_damping, set_damping
