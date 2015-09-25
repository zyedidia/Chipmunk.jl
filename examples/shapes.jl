import Chipmunk
Cp = Chipmunk
import SFML
Sf = SFML

settings = Sf.ContextSettings()
settings.antialiasing_level = 3
window = Sf.RenderWindow(Sf.VideoMode(800, 600), "Shapes", settings, Sf.window_defaultstyle)
Sf.set_framerate_limit(window, 60)

event = Sf.Event()

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

function make_ball(position, r)
    body = Cp.add_body(space, Cp.Body(1, 1))
    Cp.set_position(body, position)

    shape = Cp.add_shape(space, Cp.CircleShape(body, r, Cp.Vect(0, 0)))
    Cp.set_friction(shape, 0.8)
end

function make_rect(position, size)
    w = size.x
    h = size.y
    rect_body = Cp.add_body(space, Cp.Body(1, Cp.momentforbox(1, w, h)))
    Cp.set_position(rect_body, position)

    rect_shape = Cp.add_shape(space, Cp.BoxShape(rect_body, w, h, 0))
    Cp.set_friction(rect_shape, 0.8)
end

function main()
    timestep = 1./60
    while Sf.isopen(window)
        while Sf.pollevent(window, event)
            if Sf.get_type(event) == Sf.EventType.CLOSED
                Sf.close(window)
            end
        end

        if Sf.is_mouse_pressed(Sf.MouseButton.LEFT)
            mousepos = Sf.get_mousepos(window)
            make_ball(Cp.Vect(mousepos.x, -mousepos.y), rand(10:30))
        elseif Sf.is_mouse_pressed(Sf.MouseButton.RIGHT)
            mousepos = Sf.get_mousepos(window)
            make_rect(Cp.Vect(mousepos.x, -mousepos.y), Cp.Vect(rand(20:70), rand(20:70)))
        end

        Cp.step(space, timestep)

        Sf.clear(window, Sf.white)
        Cp.debug_draw(space, window)
        Sf.display(window)
    end
end

main()
