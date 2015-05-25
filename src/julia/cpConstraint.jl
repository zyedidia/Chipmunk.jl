function free(c::Constraint)
	ccall(dlsym(libchipmunk, :cpConstraintFree), Void, (Ptr{Void},), c.ptr)
end

function get_space(c::Constraint)
	Space(ccall(dlsym(libchipmunk, :cpConstraintGetSpace), Ptr{Void}, (Ptr{Void},), c.ptr))
end

function get_bodyA(c::Constraint)
	Body(ccall(dlsym(libchipmunk, :cpConstraintGetBodyA), Ptr{Void}, (Ptr{Void},), c.ptr))
end

function get_bodyB(c::Constraint)
	Body(ccall(dlsym(libchipmunk, :cpConstraintGetBodyB), Ptr{Void}, (Ptr{Void},), c.ptr))
end

function get_max_force(c::Constraint)
	ccall(dlsym(libchipmunk, :cpConstraintGetMaxForce), Cdouble, (Ptr{Void},), c.ptr)
end

function set_max_force(c::Constraint, max_force::Real)
	ccall(dlsym(libchipmunk, :cpConstraintSetMaxForce), Void, (Ptr{Void}, Cdouble,), c.ptr, max_force)
end

function get_error_bias(c::Constraint)
	ccall(dlsym(libchipmunk, :cpConstraintGetErrorBias), Cdouble, (Ptr{Void},), c.ptr)
end

function set_error_bias(c::Constraint, error_bias::Real)
	ccall(dlsym(libchipmunk, :cpConstraintSetErrorBias), Void, (Ptr{Void}, Cdouble,), c.ptr, error_bias)
end

function get_max_bias(c::Constraint)
	ccall(dlsym(libchipmunk, :cpConstraintGetMaxBias), Cdouble, (Ptr{Void},), c.ptr)
end

function set_max_bias(c::Constraint, max_bias::Real)
	ccall(dlsym(libchipmunk, :cpConstraintSetMaxBias), Void, (Ptr{Void}, Cdouble,), c.ptr, max_bias)
end

function get_collide_bodies(c::Constraint)
	ccall(dlsym(libchipmunk, :cpConstraintGetCollideBodies), Bool, (Ptr{Void},), c.ptr)
end

function set_collide_bodies(c::Constraint, collide_bodies::Bool)
	ccall(dlsym(libchipmunk, :cpConstraintSetCollideBodies), Void, (Ptr{Void}, Int32,), c.ptr, collide_bodies)
end

function get_userdata(c::Constraint)
	ccall(dlsym(libchipmunk, :cpConstraintGetUserData), Ptr{Void}, (Ptr{Void},), c.ptr)
end

function set_userdata(c::Constraint, userdata::Ptr{Void})
	ccall(dlsym(libchipmunk, :cpConstraintSetUserData), Void, (Ptr{Void}, Ptr{Void},), c.ptr, userdata)
end

function get_impulse(c::Constraint)
	ccall(dlsym(libchipmunk, :cpConstraintGetImpulse), Cdouble, (Ptr{Void},), c.ptr)
end

export free, get_space, get_bodyA, get_bodyB, get_max_force, set_max_force, get_error_bias,
set_error_bias, get_max_bias, set_max_bias, get_collide_bodies, set_collide_bodies, get_userdata,
set_userdata, get_impulse
