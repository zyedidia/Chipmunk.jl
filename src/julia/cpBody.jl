# Chipmunk's rigid body type. Rigid bodies hold the physical properties of an object like
# it's mass, and position and velocity of it's center of gravity. They don't have an shape on their own.
# They are given a shape by creating collision shapes (cpShape) that point to the body.

@enum(BodyType,
	# A dynamic body is one that is affected by gravity, forces, and collisions.
	# This is the default body type.
dynamic,
	# A kinematic body is an infinite mass, user controlled body that is not affected by gravity, forces or collisions.
	# Instead the body only moves based on it's velocity.
	# Dynamic bodies collide normally with kinematic bodies, though the kinematic body will be unaffected.
	# Collisions between two kinematic bodies, or a kinematic body and a static body produce collision callbacks, but no collision response.
kinematic,
	# A static body is a body that never (or rarely) moves. If you move a static body, you must call one of the cpSpaceReindex*() functions.
	# Chipmunk uses this information to optimize the collision detection.
	# Static bodies do not produce collision callbacks when colliding with other static bodies.
static)

# Allocate a cpBody.
function Body()
	Body(ccall(dlsym(libchipmunk, :cpBodyAlloc), Ptr{Void}, ()))
end

# Allocate and initialize a cpBody.
function Body(mass::Real, moment::Real)
	Body(ccall(dlsym(libchipmunk, :cpBodyNew), Ptr{Void}, (Cdouble, Cdouble,), mass, moment))
end

# Allocate and initialize a cpBody, and set it as a kinematic body.
function KinematicBody()
	Body(ccall(dlsym(libchipmunk, :cpBodyNewKinematic), Ptr{Void}, ()))
end

# Allocate and initialize a cpBody, and set it as a static body.
function StaticBody()
	Body(ccall(dlsym(libchipmunk, :cpBodyNewStatic), Ptr{Void}, ()))
end

# Initialize a cpBody.
function init(body::Body, mass::Real, moment::Real)
	Body(ccall(dlsym(libchipmunk, :cpBodyInit), Ptr{Void}, (Ptr{Void}, Cdouble, Cdouble,), body.ptr, mass, moment))
end

# Destroy and free a cpBody.
function free(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyFree), Void, (Ptr{Void},), body.ptr)
end

# Wake up a sleeping or idle body.
function activate(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyActivate), Void, (Ptr{Void},), body.ptr)
end

# Wake up any sleeping or idle bodies touching a static body.
function activate_static(body::Body, filter::Shape)
	ccall(dlsym(libchipmunk, :cpBodyActivateStatic), Void, (Ptr{Void}, Ptr{Void},), body.ptr, filter.ptr)
end

# Force a body to fall asleep immediately.
function sleep(body::Body)
	ccall(dlsym(libchipmunk, cpBodySleep), Void, (Ptr{Void},), body.ptr)
end

# Force a body to fall asleep immediately along with other bodies in a group.
function sleep_with_group(body::Body, group::Body)
	ccall(dlsym(libchipmunk, :cpBodySleepWithGroup), Void, (Ptr{Void}, Ptr{Void},), body.ptr, group.ptr)
end

# Returns true if the body is sleeping.
function is_sleeping(body::Body)
	Bool(ccall(dlsym(libchipmunk, :cpBodyIsSleeping), Int32, (Ptr{Void},), body.ptr))
end

# Get the type of the body.
function get_type(body::Body)
	BodyType(ccall(dlsym(libchipmunk, :cpBodyGetType), Int32, (Ptr{Void},), body.ptr))
end

# Set the type of the body.
function set_type(body::Body, body_type::BodyType)
	ccall(dlsym(libchipmunk, :cpBodySetType), Void, (Ptr{Void}, Int32,), body.ptr, body_type)
end

# function accumulate_mass_from_shapes(body::Body)
# 	ccall(dlsym(libchipmunk, :cpBodyAccumulateMassFromShapes), Void, (Ptr{Void},), body.ptr)
# end

# Get the space this body is added to.
function get_space(body::Body)
	Space(ccall(dlsym(libchipmunk, :cpBodyGetSpace), Ptr{Void}, (Ptr{Void},), body.ptr))
end

# Get the mass of the body.
function get_mass(body::Body)
	Real(ccall(dlsym(libchipmunk, :cpBodyGetMass), Cdouble, (Ptr{Void},), body.ptr))
end

# Set the mass of the body.
function set_mass(body::Body, mass::Real)
	ccall(dlsym(libchipmunk, :cpBodySetMass), Void, (Ptr{Void}, Cdouble,), body.ptr, mass)
end

# Get the moment of inertia of the body.
function get_moment(body::Body)
	Real(ccall(dlsym(libchipmunk, :cpBodyGetMoment), Cdouble, (Ptr{Void},), body.ptr))
end

# Set the moment of inertia of the body.
function set_moment(body::Body, moment::Real)
	ccall(dlsym(libchipmunk, :cpBodySetMoment), Void, (Ptr{Void}, Cdouble,), body.ptr, moment)
end

# Get the position of a body.
function get_position(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetPosition), Vect, (Ptr{Void},), body.ptr)
end

# Set the position of a body.
function get_center_of_gravity(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetCenterOfGravity), Vect, (Ptr{Void},), body.ptr)
end

# Get the offset of the center of gravity in body local coordinates.
function set_center_of_gravity(body::Body, cog::Vect)
	ccall(dlsym(libchipmunk, :cpBodySetCenterOfGravity), Void, (Ptr{Void}, Vect,), body.ptr, cog)
end

# Set the offset of the center of gravity in body local coordinates.<F37>
function set_position(body::Body, pos::Vect)
	ccall(dlsym(libchipmunk, :cpBodySetPosition), Void, (Ptr{Void}, Vect,), body.ptr, pos)
end

# Get the velocity of the body.
function get_velocity(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetVelocity), Vect, (Ptr{Void},), body.ptr)
end

# Set the velocity of the body.
function set_velocity(body::Body, velocity::Vect)
	ccall(dlsym(libchipmunk, :cpBodySetVelocity), Void, (Ptr{Void}, Vect), body.ptr, velocity)
end

# Get the force applied to the body for the next time step.
function get_force(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetForce), Vect, (Ptr{Void},), body.ptr)
end

# Set the force applied to the body for the next time step.
function set_force(body::Body, force::Vect)
	ccall(dlsym(libchipmunk, :cpBodySetForce), Void, (Ptr{Void}, Vect,), body.ptr, force)
end

# Get the angle of the body.
function get_angle(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetAngle), Cdouble, (Ptr{Void},), body.ptr)
end

# Set the angle of a body.
function set_angle(body::Body, angle::Real)
	ccall(dlsym(libchipmunk, :cpBodySetAngle), Void, (Ptr{Void}, Cdouble), body.ptr, angle)
end

# Get the angular velocity of the body.
function get_angular_velocity(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetAngularVelocity), Cdouble, (Ptr{Void},), body.ptr)
end

# Set the angular velocity of the body.
function set_angular_velocity(body::Body, angular_velocity::Real)
	ccall(dlsym(libchipmunk, :cpBodySetAngularVelocity), Void, (Ptr{Void}, Cdouble,), body.ptr, angular_velocity)
end

# Get the torque applied to the body for the next time step.
function get_torque(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetTorque), Cdouble, (Ptr{Void},), body.ptr)
end

# Set the torque applied to the body for the next time step.
function set_torque(body::Body, torque::Real)
	ccall(dlsym(libchipmunk, :cpBodySetTorque), Void, (Ptr{Void}, Cdouble,), body.ptr)
end

# Get the rotation vector of the body. (The x basis vector of it's transform.)
function get_rotation(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetRotation), Vect, (Ptr{Void},), body.ptr)
end

# Get the user data pointer assigned to the body.
function get_userdata(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyGetUserData), Ptr{Void}, (Ptr{Void},), body.ptr)
end

# Set the user data pointer assigned to the body.
function set_userdata(body::Body, userdata::Ptr{Void})
	ccall(dlsym(libchipmunk, :cpBodySetUserData), Void, (Ptr{Void}, Ptr{Void},), body.ptr, userdata)
end

# Default velocity integration function.
function update_velocity(body::Body, gravity::Vect, damping::Real, dt::Real)
	ccall(dlsym(libchipmunk, :cpBodyUpdateVelocity), Void, (Ptr{Void}, Vect, Cdouble, Cdouble,), body.ptr, gravity, damping, dt)
end

# Default position integration function.
function update_position(body::Body, dt::Real)
	ccall(dlsym(libchipmunk, :cpBodyUpdatePosition), Void, (Ptr{Void}, Cdouble,), body.ptr, dt)
end

# Convert body relative/local coordinates to absolute/world coordinates.
function local_to_world(body::Body, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyLocalToWorld), Vect, (Ptr{Void}, Vect,), body.ptr, point)
end

# Convert body absolute/world coordinates to  relative/local coordinates.
function world_to_local(body::Body, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyWorldToLocal), Vect, (Ptr{Void}, Vect,), body.ptr, point)
end

# Apply a force to a body. Both the force and point are expressed in world coordinates.
function apply_force_at_world_point(body::Body, force::Vect, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyApplyForceAtWorldPoint), Void, (Ptr{Void}, Vect, Vect,), body.ptr, force, point)
end

# Apply a force to a body. Both the force and point are expressed in body local coordinates.
function apply_force_at_local_point(body::Body, force::Vect, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyApplyForceAtLocalPoint), Void, (Ptr{Void}, Vect, Vect,), body.ptr, force, point)
end

# Apply an impulse to a body. Both the impulse and point are expressed in world coordinates.
function apply_impulse_at_world_point(body::Body, impulse::Vect, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyApplyImpulseAtWorldPoint), Void, (Ptr{Void}, Vect, Vect,), body.ptr, impulse, point)
end

# Apply an impulse to a body. Both the impulse and point are expressed in body local coordinates.
function apply_impulse_at_local_point(body::Body, impulse::Vect, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyApplyImpulseAtLocalPoint), Void, (Ptr{Void}, Vect, Vect,), body.ptr, impulse, point)
end

# Get the velocity on a body (in world units) at a point on the body in world coordinates.
function get_velocity_at_world_point(body::Body, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyGetVelocityAtWorldPoint), Vect, (Ptr{Void}, Vect,), body.ptr, point)
end

# Get the velocity on a body (in local units) at a point on the body in local coordinates.
function get_velocity_at_local_point(body::Body, point::Vect)
	ccall(dlsym(libchipmunk, :cpBodyGetVelocityAtLocalPoint), Vect, (Ptr{Void}, Vect,), body.ptr, point)
end

# Get the amount of kinetic energy contained by the body.
function kinetic_energy(body::Body)
	ccall(dlsym(libchipmunk, :cpBodyKineticEnergy), Cdouble, (Ptr{Void},), body.ptr)
end

export Body, KinematicBody, StaticBody, BodyType, init, free, is_sleeping, get_type, set_type,
get_space, get_mass, set_mass, get_moment, set_moment, set_position, get_position, get_velocity,
set_velocity, activate, activate_static, sleep, get_angle, set_angle, get_center_of_gravity,
set_center_of_gravity, get_force, set_force, get_angular_velocity, set_angular_velocity, 
get_torque, set_torque, get_rotation, get_userdata, set_userdata, update_velocity, update_position,
local_to_world, world_to_local, apply_impulse_at_world_point, apply_force_at_local_point,
apply_impulse_at_world_point, apply_impulse_at_local_point, get_velocity_at_world_point,
get_velocity_at_local_point, kinetic_energy
