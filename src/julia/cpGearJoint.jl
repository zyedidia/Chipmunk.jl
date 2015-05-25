function GearJoint(a::Body, b::Body, phase::Cdouble, ratio::Cdouble)
	GearJoint(ccall(dlsym(libchipmunk, :cpGearJointNew), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Cdouble, Cdouble,), a.ptr, b.ptr, phase, ratio))
end

function get_phase(joint::GearJoint)
	ccall(dlsym(libchipmunk, :cpGearJointGetPhase), Cdouble, (Ptr{Void},), joint.ptr)
end

function set_phase(joint::GearJoint, phase::Cdouble)
	ccall(dlsym(libchipmunk, :cpGearJointSetPhase), Void, (Ptr{Void}, Cdouble,), joint.ptr, phase)
end

function get_ratio(joint::GearJoint)
	ccall(dlsym(libchipmunk, :cpGearJointGetRatio), Cdouble, (Ptr{Void},), joint.ptr)
end

function set_ratio(joint::GearJoint, ratio::Cdouble)
	ccall(dlsym(libchipmunk, :cpGearJointSetRatio), Void, (Ptr{Void}, Cdouble,), joint.ptr, ratio)
end

export GearJoint, get_phase, set_phase, get_ratio, set_ratio
