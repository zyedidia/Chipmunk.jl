function BB_for_extents(c::Vect, hw::Real, hh::Real)
	BB(ccall(dlsym(libchipmunk, :cpBBNewForExtents), Ptr{Void}, (Vect, Cdouble, Cdouble,), c, hw, hh))
end

function BB_for_circle(p::Vect, r::Real)
	BB(ccall(dlsym(libchipmunk, :cpBBNewForCircle), Ptr{Void}, (Vect, Cdouble,), p, r))
end

function intersects(a::BB, b::BB)
	a.l <= b.r && b.l <= a.r && a.b <= b.t && b.b <= a.t
end

function containsBB(bb::BB, other::BB)
	bb.l <= other.l && bb.r >= other.r && bb.b <= other.b && bb.t >= other.t
end

function contains_vect(bb::BB, v::Vect)
	bb.l <= v.x && bb.r >= v.x && bb.b <= v.y && bb.t >= v.y
end

function merge(a::BB, b::BB)
	BB(min(a.l, b.l), min(a.b, b.b), max(a.r, b.r), max(a.t, b.t))
end

function expand(bb::BB, v::Vect)
	BB(min(bb.l, v.x), min(bb.b, v.y), max(bb.r, v.x), max(bb.t, v.y))
end

export BB_for_extents, BB_for_circle, intersects, containsBB, contains_vect, merge, expand
