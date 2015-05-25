using Chipmunk
using Base.Test

# write your own tests here
@test begin
	try
		gravity = Vect(0, -100)
		body = Body(1, 1)

		space = Space()
		set_gravity(space, gravity)

		add_body(space, body)

		timestep = 1./60
		for i = 1:100
			step(space, timestep)
			sleep(timestep)
		end
		true
	catch exception
		false
	end
end
