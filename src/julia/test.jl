using Chipmunk

gravity = Vect(0, -9.8)
body = Body(10, 5)
set_velocity(body, Vect(2, 2))

space = Space()
set_gravity(space, gravity)

add_body(space, body)

timestep = 1/60
while true
	step(space, timestep)
	println("Body position: $(get_position(body))")
	sleep(timestep)
end
