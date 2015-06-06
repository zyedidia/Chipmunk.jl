function rbegin_func(arbiter_ptr::Ptr{Void}, space_ptr::Ptr{Void}, data::Ptr{Void})
	data = unsafe_pointer_to_objref(data)
	begin_func = data[1][1]
	userdata = data[2]
	arbiter = Arbiter(arbiter_ptr)
	space = Space(space_ptr)

	begin_func(arbiter, space, userdata)
end
function rpresolve_func(arbiter_ptr::Ptr{Void}, space_ptr::Ptr{Void}, data::Ptr{Void})
	data = unsafe_pointer_to_objref(data)
	presolve_func = data[1][2]
	userdata = data[2]
	arbiter = Arbiter(arbiter_ptr)
	space = Space(space_ptr)

	presolve_func(arbiter, space, userdata)
end
function rpostsolve_func(arbiter_ptr::Ptr{Void}, space_ptr::Ptr{Void}, data::Ptr{Void})
	data = unsafe_pointer_to_objref(data)
	postsolve_func = data[1][3]
	userdata = data[2]
	arbiter = Arbiter(arbiter_ptr)
	space = Space(space_ptr)

	postsolve_func(arbiter, space, userdata)
	return nothing
end
function rseparate_func(arbiter_ptr::Ptr{Void}, space_ptr::Ptr{Void}, data::Ptr{Void})
	data = unsafe_pointer_to_objref(data)
	separate_func = data[1][4]
	userdata = data[2]
	arbiter = Arbiter(arbiter_ptr)
	space = Space(space_ptr)

	separate_func(arbiter, space, userdata)
	return nothing
end

function CollisionHandler(typeA::Integer, typeB::Integer, begin_func::Function, presolve_func::Function,
	                      postsolve_func::Function, separate_func::Function, userdata::Array{Any})

	callbacks = [begin_func, presolve_func, postsolve_func, separate_func]
	real_data = pointer_from_objref([callbacks, userdata])
	c_begin = cfunction(rbegin_func, Bool, (Ptr{Void}, Ptr{Void}, Ptr{Void}))
	c_presolve = cfunction(rpresolve_func, Bool, (Ptr{Void}, Ptr{Void}, Ptr{Void}))
	c_postsolve = cfunction(rpostsolve_func, Void, (Ptr{Void}, Ptr{Void}, Ptr{Void}))
	c_separate = cfunction(rseparate_func, Void, (Ptr{Void}, Ptr{Void}, Ptr{Void}))
	ccall(dlsym(libchipmunkjl, :cpCollisionHandler_create), Ptr{Void}, (Uint32, Uint32, Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void}),
	                    												typeA, typeB, c_begin, c_presolve, c_postsolve, c_separate, real_data)
end
