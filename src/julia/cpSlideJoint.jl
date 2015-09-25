function SlideJoint(a::Body, b::Body, anchorA::Vect, anchorB::Vect, min::Real, max::Real)
    SlideJoint(ccall(dlsym(libchipmunk, :cpSlideJointNew), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Vect, Vect, Cdouble, Cdouble,), a.ptr, b.ptr, anchorA, anchorB, min, max))
end

function get_anchorA(joint::SlideJoint)
    ccall(dlsym(libchipmunk, :cpSlideJointGetAnchorA), Vect, (Ptr{Void},), joint.ptr)
end

function set_anchorA(joint::SlideJoint, anchor::Vect)
    ccall(dlsym(libchipmunk, :cpSlideJointSetAnchorA), Void, (Ptr{Void}, Vect,), joint.ptr, anchor)
end

function get_anchorB(joint::SlideJoint)
    ccall(dlsym(libchipmunk, :cpSlideJointGetAnchorB), Vect, (Ptr{Void},), joint.ptr)
end

function set_anchorB(joint::SlideJoint, anchor::Vect)
    ccall(dlsym(libchipmunk, :cpSlideJointSetAnchorB), Void, (Ptr{Void}, Vect,), joint.ptr, anchor)
end

function get_min(joint::SlideJoint)
    ccall(dlsym(libchipmunk, :cpSlideJointGetMin), Cdouble, (Ptr{Void},), joint.ptr)
end

function set_min(joint::SlideJoint, min::Real)
    ccall(dlsym(libchipmunk, :cpSlideJointSetMin), Void, (Ptr{Void}, Cdouble,), joint.ptr, min)
end

function get_max(joint::SlideJoint)
    ccall(dlsym(libchipmunk, :cpSlideJointGetMin), Cdouble, (Ptr{Void},), joint.ptr)
end

function set_max(joint::SlideJoint, max::Real)
    ccall(dlsym(libchipmunk, :cpSlideJointSetMin), Void, (Ptr{Void}, Cdouble,), joint.ptr, max)
end

export SlideJoint, get_anchorA, set_anchorA, get_anchorB, set_anchorB, get_min, set_min,
get_max, set_max
