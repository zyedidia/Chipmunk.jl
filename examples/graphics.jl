using Chipmunk
import SFML
sf = SFML

window = sf.RenderWindow("Physics", 800, 600)
sf.set_framerate_limit(window, 60)

event = sf.Event()

square = sf.RectangleShape()
sf.set_size(square, sf.Vector2f(30, 30))
sf.set_fillcolor(square, sf.blue)

gravity = Vect(0, -100)
body = Body(1, 1)

space = Space()
set_gravity(space, gravity)

add_body(space, body)

timestep = 1./60
while sf.isopen(window)

	while sf.pollevent(window, event)
		if sf.get_type(event) == sf.EventType.CLOSED
			sf.close(window)
		end
	end

	step(space, timestep)
	bodypos = get_position(body)

	sf.set_position(square, sf.Vector2f(bodypos.x + 400, -bodypos.y))

	sf.clear(window, sf.white)
	sf.draw(window, square)
	sf.display(window)
end
