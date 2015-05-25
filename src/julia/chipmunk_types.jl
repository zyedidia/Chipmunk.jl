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

type BB
	l::Cdouble
	b::Cdouble
	r::Cdouble
	t::Cdouble
end

type Vect
	x::Cdouble
	y::Cdouble
end

type Transform
	a::Cdouble
	b::Cdouble
	c::Cdouble
	d::Cdouble
	tx::Cdouble
	ty::Cdouble
end

type Mat2x2
	a::Cdouble
	b::Cdouble
	c::Cdouble
	d::Cdouble
end

export Vect, Body, Space, Shape, CircleShape, SegmentShape, PolyShape, Transform, Mat2x2, BB
