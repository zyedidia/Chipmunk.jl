type Space
	ptr::Ptr{Void}
end

type Body
	ptr::Ptr{Void}
end

abstract Shape
type CircleShape <: Shape
	ptr::Ptr{Void}
end

type SegmentShape <: Shape
	ptr::Ptr{Void}
end

type PolyShape <: Shape
	ptr::Ptr{Void}
end

type Vect
	x::Cdouble
	y::Cdouble
end

export Vect, Body, Space, Shape, CircleShape, SegmentShape, PolyShape
