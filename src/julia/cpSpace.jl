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
	Real(ccall(dlsym(libchipmunk, :cpSpaceGetDamping), Cdouble, (Ptr{Void},), space.ptr))
end

function add_body(space::Space, body::Body)
	Body(ccall(dlsym(libchipmunk, :cpSpaceAddBody), Ptr{Void}, (Ptr{Void}, Ptr{Void},), space.ptr, body.ptr))
end

function remove_body(space::Space, body::Body)
	ccall(dlsym(libchipmunk, :cpSpaceRemoveBody), Void, (Ptr{Void}, Ptr{Void},), space.ptr, body.ptr)
end

function step(space::Space, dt::Real)
	ccall(dlsym(libchipmunk, :cpSpaceStep), Void, (Ptr{Void}, Cdouble,), space.ptr, dt)
end

export Space, get_iterations, set_iterations, get_gravity, set_gravity, set_damping, get_damping, add_body,
remove_body, step
