function PinJoint(a::Body, b::Body, anchorA::Vect, anchorB::Vect)
	PinJoint(ccall(dlsym(libchipmunk, :cpPinJointNew2), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Vect, Vect,), a.ptr, b.ptr, anchorA, anchorB))
end

function get_anchorA(joint::PinJoint)
	ccall(dlsym(libchipmunk, :cpPinJointGetAnchorA), Vect, (Ptr{Void},), joint.ptr)
end

function set_anchorA(joint::PinJoint, anchorA::Vect)
	ccall(dlsym(libchipmunk, :cpPinJointSetAnchorA), Void, (Ptr{Void}, Vect,), joint.ptr, anchorA)
end

function get_anchorB(joint::PinJoint)
	ccall(dlsym(libchipmunk, :cpPinJointGetAnchorB), Vect, (Ptr{Void},), joint.ptr)
end

function set_anchorB(joint::PinJoint, anchorB::Vect)
	ccall(dlsym(libchipmunk, :cpPinJointSetAnchorB), Void, (Ptr{Void}, Vect,), joint.ptr, anchorB)
end

function get_dist(joint::PinJoint)
	ccall(dlsym(libchipmunk, :cpPinJointGetDist), Cdouble, (Ptr{Void},), joint.ptr)
end

function set_dist(joint::PinJoint, dist::Cdouble)
	ccall(dlsym(libchipmunk, :cpPinJointSetDist), Void, (Ptr{Void}, Cdouble,), joint.ptr, dist)
end

export PinJoint, get_anchorA, get_anchorB, set_anchorA, set_anchorB, get_dist, set_dist
