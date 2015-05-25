@enum BodyType dynamic kinematic static

function Body()
	Body(ccall(dlsym(libchipmunk, :cpBodyAlloc), Ptr{Void}, ()))
end

function Body(mass::Real, moment::Real)
	Body(ccall(dlsym(libchipmunk, :cpBodyNew), Ptr{Void}, (Cdouble, Cdouble,), mass, moment))
end

function KinematicBody()
	Body(ccall(dlsym(libchipmunk, :cpBodyNewKinematic), Ptr{Void}, ()))
end

function StaticBody()
	Body(ccall(dlsym(libchipmunk, :cpBodyNewStatic), Ptr{Void}, ()))
end

function init(body::Body, mass::Real, moment::Real)
	Body(ccall(dlsym(libchipmunk, :cpBodyInit), Ptr{Void}, (Ptr{Void}, Cdouble, Cdouble,), body.ptr, mass, moment))
end

function free(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyFree), Void, (Ptr{Void},), body.ptr)
end

function activate(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyActivate), Void, (Ptr{Void},), body.ptr)
end

function activate_static(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyActivateStatic), Void, (Ptr{Void},), body.ptr)
end

function sleep(body::Body)
	ccall(dlsym(libchipmunk, cpBodySleep), Void, (Ptr{Void},), body.ptr)
end

function is_sleeping(body::Body)
	Bool(ccall(dlsym(libchipmunk, :cpBodyIsSleeping), Int32, (Ptr{Void},), body.ptr))
end

function get_type(body::Body)
	BodyType(ccall(dlsym(libchipmunk, :cpBodyGetType), Int32, (Ptr{Void},), body.ptr))
end

function set_type(body::Body, body_type::BodyType)
	ccall(dlsym(libchipmunk, :cpBodySetType), Void, (Ptr{Void}, Int32,), body.ptr, body_type)
end

function accumulate_mass_from_shapes(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyAccumulateMassFromShapes), Void, (Ptr{Void},), body.ptr)
end

function get_space(body::Body)
	Space(ccall(dlsym(libchipmunk, :cpBodyGetSpace), Ptr{Void}, (Ptr{Void},), body.ptr))
end

function get_mass(body::Body)
	Real(ccall(dlsym(libchipmunk, :cpBodyGetMass), Cdouble, (Ptr{Void},), body.ptr))
end

function set_mass(body::Body, mass::Real)
	ccall(dlsym(libchipmunk, :cpBodySetMass), Void, (Ptr{Void}, Cdouble,), body.ptr, mass)
end

function get_moment(body::Body)
	Real(ccall(dlsym(libchipmunk, :cpBodyGetMoment), Cdouble, (Ptr{Void},), body.ptr))
end

function set_moment(body::Body, moment::Real)
	ccall(dlsym(libchipmunk, :cpBodySetMoment), Void, (Ptr{Void}, Cdouble,), body.ptr, moment)
end

function get_position(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetPosition), Vect, (Ptr{Void},), body.ptr)
end

function set_position(body::Body, pos::Vect)
	ccall(dlsym(libchipmunk, :cpBodySetPosition), Void, (Ptr{Void}, Vect,), body.ptr, pos)
end

function get_velocity(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetVelocity), Vect, (Ptr{Void},), body.ptr)
end

function set_velocity(body::Body, velocity::Vect)
	ccall(dlsym(libchipmunk, :cpBodySetVelocity), Void, (Ptr{Void}, Vect), body.ptr, velocity)
end

function get_angle(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetAngle), Cdouble, (Ptr{Void},), body.ptr)
end

function set_angle(body::Body, angle::Real)
	ccall(dlsym(libchipmunk, :cpBodySetAngle), Void, (Ptr{Void}, Cdouble), body.ptr, angle)
end

export Body, KinematicBody, StaticBody, BodyType, init, free, is_sleeping, get_type, set_type,
accumulate_mass_from_shapes, get_space, get_mass, set_mass, get_moment, set_moment,
set_position, get_position, get_velocity, set_velocity, activate, activate_static, sleep,
get_angle, set_angle
