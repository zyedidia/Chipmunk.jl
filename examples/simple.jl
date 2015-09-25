using Chipmunk
# Using Debug draw requires SFML.jl
import SFML

window = SFML.RenderWindow("Debug draw!", 800, 600)
SFML.set_framerate_limit(window, 60)

gravity = Vect(0, -100)
body = Body(1, 1)
set_position(body, Vect(400, 0))
shape = CircleShape(body, 40, Vect(0, 0))

space = Space()
set_gravity(space, gravity)

add_body(space, body)
add_shape(space, shape)

timestep = 1./60
while true
    step(space, timestep)
    # Debug draw
    debug_draw(space, window, clear_and_display=true)
    println("Body position: $(get_position(body))")
end
