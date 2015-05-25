import Chipmunk
Cp = Chipmunk
import SFML
Sf = SFML

function sf_vec(vect)
	Sf.Vector2f(vect.x, -vect.y)
end

settings = Sf.ContextSettings()
settings.antialiasing_level = 3
window = Sf.RenderWindow(Sf.VideoMode(800, 600), "Shapes", settings, Sf.window_defaultstyle)
Sf.set_framerate_limit(window, 60)

event = Sf.Event()

body = Cp.Body(1, Cp.momentforbox(1, 50, 50))
shape = Cp.PolyShape(body, 50, 50, 0)
Cp.set_position(body, Cp.Vect(400, 0))

gravity = Cp.Vect(0, -100)
space = Cp.Space()
Cp.set_gravity(space, gravity)

static = Cp.StaticBody()
groundshape = Cp.add_shape(space, Cp.SegmentShape(static, Cp.Vect(0, -600), Cp.Vect(800, -600), 10))
Cp.set_friction(groundshape, 1)
leftwallshape = Cp.add_shape(space, Cp.SegmentShape(static, Cp.Vect(0, 0), Cp.Vect(0, -600), 10))
Cp.set_friction(leftwallshape, 1)
rightwallshape = Cp.add_shape(space, Cp.SegmentShape(static, Cp.Vect(800, 0), Cp.Vect(800, -600), 10))
Cp.set_friction(rightwallshape, 1)

Cp.add_shape(space, shape)
Cp.add_body(space, body)

square = Sf.RectangleShape()
Sf.set_size(square, Sf.Vector2f(50, 50))
Sf.set_fillcolor(square, Sf.red)
Sf.set_origin(square, Sf.Vector2f(25, 25))

while Sf.isopen(window)
	while Sf.pollevent(window, event)
		if Sf.get_type(event) == Sf.EventType.CLOSED
			Sf.close(window)
		end
	end

	Cp.step(space, 1./60)

	Sf.set_position(square, sf_vec(Cp.get_position(body)))

	Sf.clear(window, Sf.white)
	Sf.draw(window, square)
	Sf.display(window)
end
