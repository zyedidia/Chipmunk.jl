function Space()
	Space(ccall(dlsym(libchipmunk, :cpSpaceNew), Ptr{Void}, ()))
end

function free(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceFree), Void, (Ptr{Void},), space.ptr)
end

function get_iterations(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetIterations), Int32, (Ptr{Void},), space.ptr)
end

function set_iterations(space::Space, iterations::Integer)
	ccall(dlsym(libchipmunk, :cpSpaceSetIterations), Void, (Ptr{Void}, Int32,), space.ptr, iterations)
end

function get_gravity(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetGravity), Vect, (Ptr{Void},), space.ptr)
end

function set_gravity(space::Space, gravity::Vect)
	ccall(dlsym(libchipmunk, :cpSpaceSetGravity), Void, (Ptr{Void}, Vect,), space.ptr, gravity)
end

function set_damping(space::Space, damping::Real)
	ccall(dlsym(libchipmunk, :cpSpaceSetDamping), Void, (Ptr{Void}, Cdouble,), space.ptr, damping)
end

function get_damping(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetDamping), Cdouble, (Ptr{Void},), space.ptr)
end

function get_idle_sleep_threshold(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetIdleSleepThreshold), Cdouble, (Ptr{Void},), space.ptr)
end

function set_idle_sleep_threshold(space::Space, threshold::Real)
	ccall(dlsym(libchipmunk, :cpSpaceSetIdleSleepThreshold), Void, (Ptr{Void}, Cdouble,), space.ptr, threshold)
end

function get_sleep_time_threshold(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetSleepTimeThreshold), Cdouble, (Ptr{Void},), space.ptr)
end

function set_sleep_time_threshold(space::Space, threshold::Real)
	ccall(dlsym(libchipmunk, :cpSpaceSetSleepTimeThreshold), Void, (Ptr{Void}, Cdouble,), space.ptr, threshold)
end

function get_collision_slop(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetCollisionSlop), Cdouble, (Ptr{Void},), space.ptr)
end

function set_collision_slop(space::Space, slop::Real)
	ccall(dlsym(libchipmunk, :cpSpaceSetCollisionSlop), Void, (Ptr{Void}, Cdouble,), space.ptr, slop)
end

function get_collision_bias(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetCollisionBias), Cdouble, (Ptr{Void},), space.ptr)
end

function set_collision_bias(space::Space, bias::Real)
	ccall(dlsym(libchipmunk, :cpSpaceSetCollisionBias), Void, (Ptr{Void}, Cdouble,), space.ptr, bias)
end

function get_collision_persistence(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetCollisionPersistence), Cdouble, (Ptr{Void},), space.ptr)
end

function set_collision_persistence(space::Space, persistence::Real)
	ccall(dlsym(libchipmunk, :cpSpaceSetCollisionPersistence), Void, (Ptr{Void}, Cdouble,), space.ptr, persistence)
end

function get_userdata(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetUserData), Ptr{Void}, (Ptr{Void},), space.ptr)
end

function set_userdata(space::Space, userdata::Ptr{Void})
	ccall(dlsym(libchipmunk, :cpSpaceSetUserData), Void, (Ptr{Void}, Ptr{Void},), space.ptr, userdata)
end

function get_current_timestep(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceGetCurrentTimeStep), Cdouble, (Ptr{Void},), space.ptr)
end

function is_locked(space::Space)
	ccall(dlsym(libchipmunk, :cpSpaceIsLocked), Bool, (Ptr{Void},), space.ptr)
end

function add_shape(space::Space, shape::Shape)
	shape_type = typeof(shape)
	shape_type(ccall(dlsym(libchipmunk, :cpSpaceAddShape), Ptr{Void}, (Ptr{Void}, Ptr{Void},), space.ptr, shape.ptr))
end

function add_body(space::Space, body::Body)
	Body(ccall(dlsym(libchipmunk, :cpSpaceAddBody), Ptr{Void}, (Ptr{Void}, Ptr{Void},), space.ptr, body.ptr))
end

function add_constraint(space::Space, constraint::Constraint)
	constraint_type = typeof(constraint)
	constraint_type(ccall(dlsym(libchipmunk, :cpSpaceAddConstraint), Ptr{Void}, (Ptr{Void}, Ptr{Void},), space.ptr, constraint.ptr))
end

function remove_shape(space::Space, shape::Shape)
	ccall(dlsym(libchipmunk, :cpSpaceRemoveShape), Void, (Ptr{Void}, Ptr{Void},), space.ptr, shape.ptr)
end

function remove_body(space::Space, body::Body)
	ccall(dlsym(libchipmunk, :cpSpaceRemoveBody), Void, (Ptr{Void}, Ptr{Void},), space.ptr, body.ptr)
end

function remove_constraint(space::Space, constraint::Constraint)
	ccall(dlsym(libchipmunk, :cpSpaceRemoveConstraint), Void, (Ptr{Void}, Ptr{Void},), space.ptr, constraint.ptr)
end

function use_spatial_hash(space::Space, dim::Real, count::Integer)
	ccall(dlsym(libchipmunk, :cpSpaceUseSpatialHash), Void, (Ptr{Void}, Cdouble, Cint,), space.ptr, dim, count)
end

function step(space::Space, dt::Real)
	ccall(dlsym(libchipmunk, :cpSpaceStep), Void, (Ptr{Void}, Cdouble,), space.ptr, dt)
end

export Space, get_iterations, set_iterations, get_gravity, set_gravity, set_damping, get_damping, add_body,
remove_body, step, add_shape, add_constraint, remove_constraint, remove_shape, is_locked, get_current_timestep,
get_userdata, set_userdata, set_collision_persistence, get_collision_persistence, set_collision_bias,
get_collision_bias, get_collision_slop, set_collision_slop, set_idle_sleep_threshold, get_idle_sleep_threshold,
set_sleep_time_threshold, get_sleep_time_threshold, use_spatial_hash
