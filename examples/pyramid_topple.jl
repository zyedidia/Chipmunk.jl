import Chipmunk
Cp = Chipmunk
import SFML
Sf = SFML

function add_vect(vec1, vec2)
	Cp.Vect(vec1.x + vec2.x, vec1.y + vec2.y)
end

const height = 30
const width = 7

settings = Sf.ContextSettings()
settings.antialiasing_level = 3
window = Sf.RenderWindow(Sf.VideoMode(800, 600), "Pyramid Topple", settings, Sf.window_defaultstyle)
Sf.set_framerate_limit(window, 60)

event = Sf.Event()

gravity = Cp.Vect(0, -200)
space = Cp.Space()
Cp.set_gravity(space, gravity)

static = Cp.StaticBody()
groundshape = Cp.add_shape(space, Cp.SegmentShape(static, Cp.Vect(0, -600), Cp.Vect(800, -600), 10))
Cp.set_friction(groundshape, 1)
leftwallshape = Cp.add_shape(space, Cp.SegmentShape(static, Cp.Vect(0, 0), Cp.Vect(0, -600), 10))
Cp.set_friction(leftwallshape, 1)
rightwallshape = Cp.add_shape(space, Cp.SegmentShape(static, Cp.Vect(800, 0), Cp.Vect(800, -600), 10))
Cp.set_friction(rightwallshape, 1)

function add_domino(pos, flipped)
	mass = 1
	radius = 0.5
	moment = Cp.momentforbox(mass, width, height)

	body = Cp.add_body(space, Cp.Body(mass, moment))
	Cp.set_position(body, Cp.Vect(pos.x + 400, pos.y - 350))

	shape = !flipped ? Cp.BoxShape(body, width, height, 0) : Cp.BoxShape(body, height, width, 0)
	Cp.add_shape(space, shape)
	Cp.set_elasticity(shape, 0)
	Cp.set_friction(shape, 0.6)
end

n = 12;
for i = 0:n-1
	for j = 0:n-i-1
		offset = Cp.Vect((j - (n - 1 - i)*0.5)*1.5*height, (i + 0.5)*(height + 2*width) - width - 240);
		add_domino(offset, false);
		add_domino(add_vect(offset, Cp.Vect(0, (height + width)/2.0)), true);

		if j == 0
			add_domino(add_vect(offset, Cp.Vect(0.5*(width - height), height + width)), false);
		end

		if j != (n - i - 1)
			add_domino(add_vect(offset, Cp.Vect(height*0.75, (height + 3*width)/2.0)), true);
		else
			add_domino(add_vect(offset, Cp.Vect(0.5*(height - width), height + width)), false);
		end
	end
end

while Sf.isopen(window)
	while Sf.pollevent(window, event)
		if Sf.get_type(event) == Sf.EventType.CLOSED
			Sf.close(window)
		end
	end

	Cp.step(space, 1/60)

	Sf.clear(window, Sf.white)
	Cp.debug_draw(space, window)
	Sf.display(window)
end
