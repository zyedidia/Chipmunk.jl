function PivotJoint(a::Body, b::Body, pivot::Vect)
    PivotJoint(ccall(dlsym(libchipmunk, :cpPivotJointNew), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Vect,), a.ptr, b.ptr, pivot))
end

function PivotJoint(a::Body, b::Body, anchorA::Vect, anchorB::Vect)
    PivotJoint(ccall(dlsym(libchipmunk, :cpPivotJointNew2), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Vect, Vect,), a.ptr, b.ptr, anchorA, anchorB))
end

function get_anchorA(joint::PivotJoint)
    ccall(dlsym(libchipmunk, :cpPivotJointGetAnchorA), Vect, (Ptr{Void},), joint.ptr)
end

function set_anchorA(joint::PivotJoint, anchorA::Vect)
    ccall(dlsym(libchipmunk, :cpPivotJointSetAnchorA), Void, (Ptr{Void}, Vect,), joint.ptr, anchorA)
end

function get_anchorB(joint::PivotJoint)
    ccall(dlsym(libchipmunk, :cpPivotJointGetAnchorB), Vect, (Ptr{Void},), joint.ptr)
end

function set_anchorB(joint::PivotJoint, anchorB::Vect)
    ccall(dlsym(libchipmunk, :cpPivotJointSetAnchorB), Void, (Ptr{Void}, Vect,), joint.ptr, anchorB)
end

export PivotJoint, get_anchorA, get_anchorB, set_anchorA, set_anchorB
