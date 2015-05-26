function SimpleMotor(a::Body, b::Body, rate::Real)
	SimpleMotor(ccall(dlsym(libchipmunk, :cpSimpleMotorNew), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Cdouble,), a.ptr, b.ptr, rate))
end

function get_rate(motor::SimpleMotor)
	ccall(dlsym(libchipmunk, :cpSimpleMotorGetRate), Cdouble, (Ptr{Void},), motor.ptr)
end

function set_rate(motor::SimpleMotor, rate::Real)
	ccall(dlsym(libchipmunk, :cpSimpleMotorSetRate), Void, (Ptr{Void}, Cdouble,), motor.ptr, rate)
end

export SimpleMotor, get_rate, set_rate
