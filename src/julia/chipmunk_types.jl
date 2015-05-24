type Space
	ptr::Ptr{Void}

	# function Space(ptr::Ptr{Void})
	# 	s = new(ptr)
	# 	finalizer(s, free)
	# 	s
	# end
end

type Body
	ptr::Ptr{Void}

	# function Body(ptr::Ptr{Void})
	# 	b = new(ptr)
	# 	finalizer(b, free)
	# 	b
	# end
end

type Vect
	x::Cdouble
	y::Cdouble
end

export Vect, Body, Space
