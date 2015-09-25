function CircleShape(body::Body, radius::Real, offset::Vect)
    CircleShape(ccall(dlsym(libchipmunk, :cpCircleShapeNew), Ptr{Void}, (Ptr{Void}, Cdouble, Vect,), body.ptr, radius, offset))
end

function get_offset(shape::CircleShape)
    ccall(dlsym(libchipmunk, :cpCircleShapeGetOffset), Vect, (Ptr{Void},), shape.ptr)
end

function get_radius(shape::CircleShape)
    ccall(dlsym(libchipmunk, :cpCircleShapeGetRadius), Cdouble, (Ptr{Void},), shape.ptr)
end

function SegmentShape(body::Body, a::Vect, b::Vect, radius::Real)
    SegmentShape(ccall(dlsym(libchipmunk, :cpSegmentShapeNew), Ptr{Void}, (Ptr{Void}, Vect, Vect, Cdouble,), body.ptr, a, b, radius))
end

function set_neighbors(shape::SegmentShape, prev::Vect, next::Vect)
    ccall(dlsym(libchipmunk, :cpSegmentShapeSetNeighbors), Void, (Ptr{Void}, Vect, Vect,), shape.ptr, prev, next)
end

function get_a(shape::SegmentShape)
    ccall(dlsym(libchipmunk, :cpSegmentShapeGetA), Vect, (Ptr{Void},), shape.ptr)
end

function get_b(shape::SegmentShape)
    ccall(dlsym(libchipmunk, :cpSegmentShapeGetB), Vect, (Ptr{Void},), shape.ptr)
end

function get_normal(shape::SegmentShape)
    ccall(dlsym(libchipmunk, :cpSegmentShapeGetNormal), Vect, (Ptr{Void},), shape.ptr)
end

function get_radius(shape::SegmentShape)
    ccall(dlsym(libchipmunk, :cpSegmentShapeGetRadius), Cdouble, (Ptr{Void},), shape.ptr)
end

function free(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeFree), Void, (Ptr{Void},), shape.ptr)
end

function get_space(shape::Shape)
    Space(ccall(dlsym(libchipmunk, :cpShapeGetSpace), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function get_body(shape::Shape)
    Body(ccall(dlsym(libchipmunk, :cpShapeGetBody), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function set_body(shape::Shape, body::Body)
    ccall(dlsym(libchipmunk, :cpShapeSetBody), Void, (Ptr{Void}, Ptr{Void},), shape.ptr, body.ptr)
end

function get_mass(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetMass), Cdouble, (Ptr{Void},), shape.ptr)
end

function set_mass(shape::Shape, mass::Real)
    ccall(dlsym(libchipmunk, :cpShapeSetMass), Void, (Ptr{Void}, Cdouble,), shape.ptr, mass)
end

function get_density(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetDensity), Cdouble, (Ptr{Void},), shape.ptr)
end

function set_density(shape::Shape, density::Real)
    ccall(dlsym(libchipmunk, :cpShapeSetDensity), Void, (Ptr{Void}, Cdouble,), shape.ptr, density)
end

function get_moment(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetMoment), Cdouble, (Ptr{Void},), shape.ptr)
end

function get_area(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetArea), Cdouble, (Ptr{Void},), shape.ptr)
end

function get_center_of_gravity(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetCenterOfGravity), Vect, (Ptr{Void},), shape.ptr)
end

function get_sensor(shape::Shape)
    Bool(ccall(libchipmunk, :cpShapeGetSensor), Uint8, (Ptr{Void},), shape.ptr)
end

function set_sensor(shape::Shape, sensor::Bool)
    ccall(dlsym(libchipmunk, :cpShapeSetSensor), Void, (Ptr{Void}, Int32,), shape.ptr, sensor)
end

function get_elasticity(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetElasticity), Cdouble, (Ptr{Void}, Int32,), shape.ptr)
end

function set_elasticity(shape::Shape, elasticity::Real)
    ccall(dlsym(libchipmunk, :cpShapeSetElasticity), Void, (Ptr{Void}, Cdouble,), shape.ptr, elasticity)
end

function get_friction(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetFriction), Cdouble, (Ptr{Void},), shape.ptr)
end

function set_friction(shape::Shape, friction::Real)
    ccall(dlsym(libchipmunk, :cpShapeSetFriction), Void, (Ptr{Void}, Cdouble,), shape.ptr, friction)
end

function get_surface_velocity(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetSurfaceVelocity), Vect, (Ptr{Void},), shape.ptr)
end

function set_surface_velocity(shape::Shape, velocity::Vect)
    ccall(dlsym(libchipmunk, :cpShapeSetSurfaceVelocity), Void, (Ptr{Void}, Vect,), shape.ptr, velocity)
end

function get_userdata(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetUserData), Ptr{Void}, (Ptr{Void},), shape.ptr)
end

function set_userdata(shape::Shape, userdata::Ptr{Void})
    ccall(dlsym(libchipmunk, :cpShapeSetUserData), Void, (Ptr{Void}, Ptr{Void},), shape.ptr, userdata)
end

function get_collision_type(shape::Shape)
    ccall(dlsym(libchipmunk, :cpShapeGetCollisionType), Uint32, (Ptr{Void},), shape.ptr)
end

function set_collision_type(shape::Shape, ctype::Integer)
    ccall(dlsym(libchipmunk, :cpShapeSetCollisionType), Void, (Ptr{Void}, Uint32,), shape.ptr, ctype)
end

export free, get_space, get_body, set_body, get_mass, set_mass, get_density, set_density, get_moment, get_area,
get_center_of_gravity, get_sensor, set_sensor, get_elasticity, set_elasticity, get_friction, set_friction,
CircleShape, SegmentShape, get_surface_velocity, set_surface_velocity, get_userdata, set_userdata,
get_collision_type, set_collision_type, get_offset, get_radius, get_a, get_b, get_normal
