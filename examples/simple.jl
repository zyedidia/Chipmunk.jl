using Chipmunk

gravity = Vect(0, -100)
body = Body(1, 1)

space = Space()
set_gravity(space, gravity)

add_body(space, body)

timestep = 1./60
while true
	step(space, timestep)
	println("Body position: $(get_position(body))")
	sleep(timestep)
end
