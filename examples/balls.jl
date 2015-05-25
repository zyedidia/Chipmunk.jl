import Chipmunk
Cp = Chipmunk
import SFML
Sf = SFML

function sf_vec(vect)
	Sf.Vector2f(vect.x, -vect.y)
end

settings = Sf.ContextSettings()
settings.antialiasing_level = 3
window = Sf.RenderWindow(Sf.VideoMode(800, 600), "Physics", settings, Sf.window_defaultstyle)
Sf.set_framerate_limit(window, 60)

event = Sf.Event()

circles = Sf.CircleShape[]
bodies = Cp.Body[]

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

smiley_texture = Sf.Texture("smiley.png")
Sf.set_smooth(smiley_texture, true)

function make_particle(position)
	body = Cp.Body(1, 1)
	shape = Cp.CircleShape(body, 25, Cp.Vect(0, 0))
	Cp.set_position(body, position)
	Cp.set_friction(shape, 0.8)

	Cp.add_body(space, body)
	Cp.add_shape(space, shape)
	push!(bodies, body)

	circle = Sf.CircleShape()
	Sf.set_radius(circle, 25)
	Sf.set_texture(circle, smiley_texture)
	Sf.set_origin(circle, Sf.Vector2f(25, 25))
	push!(circles, circle)
end

timestep = 1./60
while Sf.isopen(window)
	while Sf.pollevent(window, event)
		if Sf.get_type(event) == Sf.EventType.CLOSED
			Sf.close(window)
		end
	end

	if Sf.is_mouse_pressed(0)
		mousepos = Sf.get_mousepos(window)
		make_particle(Cp.Vect(mousepos.x, -mousepos.y))
	end

	Cp.step(space, timestep)

	Sf.clear(window, Sf.white)
	for i = 1:length(circles)
		circle = circles[i]
		Sf.set_rotation(circle, -rad2deg(Cp.get_angle(bodies[i])))
		Sf.set_position(circle, sf_vec(Cp.get_position(bodies[i])))
		Sf.draw(window, circle)
	end
	Sf.display(window)
end
