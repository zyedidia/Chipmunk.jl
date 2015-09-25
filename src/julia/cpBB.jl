# Chipmunk's axis-aligned 2D bounding box type along with a few handy routines.

# Constructs a cpBB centered on a point with the given extents (half sizes).
function BB_for_extents(c::Vect, hw::Real, hh::Real)
    BB(ccall(dlsym(libchipmunk, :cpBBNewForExtents), Ptr{Void}, (Vect, Cdouble, Cdouble,), c, hw, hh))
end

# Constructs a cpBB for a circle with the given position and radius.
function BB_for_circle(p::Vect, r::Real)
    BB(ccall(dlsym(libchipmunk, :cpBBNewForCircle), Ptr{Void}, (Vect, Cdouble,), p, r))
end

# Returns true if a and b intersect.
function intersects(a::BB, b::BB)
    a.l <= b.r && b.l <= a.r && a.b <= b.t && b.b <= a.t
end

# Returns true if other lies completely within bb.
function containsBB(bb::BB, other::BB)
    bb.l <= other.l && bb.r >= other.r && bb.b <= other.b && bb.t >= other.t
end

# Returns true if bb contains v.
function contains_vect(bb::BB, v::Vect)
    bb.l <= v.x && bb.r >= v.x && bb.b <= v.y && bb.t >= v.y
end

# Returns a bounding box that holds both bounding boxes.
function merge(a::BB, b::BB)
    BB(min(a.l, b.l), min(a.b, b.b), max(a.r, b.r), max(a.t, b.t))
end

# Returns a bounding box that holds both bb and v.
function expand(bb::BB, v::Vect)
    BB(min(bb.l, v.x), min(bb.b, v.y), max(bb.r, v.x), max(bb.t, v.y))
end

# Returns the center of a bounding box.
function center(bb::BB)
    ccall(dlsym(libchipmunk, :cpBBCenter), Vect, (BB,), bb)
end

# Returns the area of the bounding box.
function area(bb::BB)
    (bb.r - bb.l)*(bb.t - bb.b)
end

# Merges a and b and returns the area of the merged bounding box.
function merged_area(a::BB, b::BB)
    (max(a.r, b.r) - min(a.l, b.l))*(max(a.t, b.t) - min(a.b, b.b))
end

# Returns the fraction along the segment query the cpBB is hit. Returns INFINITY if it doesn't hit.
function segment_query(bb::BB, a::Vect, b::Vect)
    ccall(dlsym(libchipmunk, :cpBBQuery), Cdouble, (BB, Vect, Vect,), bb, a, b)
end

# Return true if the bounding box intersects the line segment with ends a and b.
function intersects_segment(bb::BB, a::Vect, b::Vect)
    ccall(dlsym(libchipmunk, :cpBBIntersectsSegment), Bool, (BB, Vect, Vect,), bb, a, b)
end

# Clamp a vector to a bounding box.
function clamp_vect(bb::BB, v::Vect)
    Vect(clamp(v.x, bb.l, bb.r), clamp(v.y, bb.b, bb.t))
end

# Wrap a vector to a bounding box.
function wrap_vect(bb::BB, v::Vect)
    ccall(dlsym(libchipmunk, :cpBBWrapVect), Vect, (BB, Vect,), bb, v)
end

# Returns a bounding box offseted by v.
function offset(bb::BB, v::Vect)
    ccall(dlsym(libchipmunk, :cpBBOffset), Vect, (BB, Vect,), bb, v)
end

export BB_for_extents, BB_for_circle, intersects, containsBB, contains_vect, merge, expand,
center, area, merged_area, segment_query, intersects_segment, clamp_vect, wrap_vect, offset
