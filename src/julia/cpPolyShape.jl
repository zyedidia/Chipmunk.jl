function PolyShape(body::Body, verts::Array{Vect}, radius::Real)
    shape_ptr = ccall(dlsym(libchipmunk, :cpPolyShapeAlloc), Ptr{Void}, ())
    PolyShape(ccall(dlsym(libchipmunk, :cpPolyShapeInitRaw), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Int32, Ptr{Vect}, Cdouble,),
                                                                        shape_ptr, body.ptr, length(verts), pointer(verts), radius))
end

function BoxShape(body::Body, width::Real, height::Real, radius::Real)
    PolyShape(ccall(dlsym(libchipmunk, :cpBoxShapeNew), Ptr{Void}, (Ptr{Void}, Cdouble, Cdouble, Cdouble,), body.ptr, width, height, radius))
end

function get_count(shape::PolyShape)
    ccall(dlsym(libchipmunk, :cpPolyShapeGetCount), Int32, (Ptr{Void},), shape.ptr)
end

function get_vert(shape::PolyShape, index::Integer)
    ccall(dlsym(libchipmunk, :cpPolyShapeGetVert), Vect, (Ptr{Void}, Int32,), shape.ptr, index)
end

function get_radius(shape::PolyShape)
    ccall(dlsym(libchipmunk, :cpPolyShapeGetRadius), Cdouble, (Ptr{Void},), shape.ptr)
end

export PolyShape, get_count, get_vert, get_radius
