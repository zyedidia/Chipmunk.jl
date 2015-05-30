# Color is from 0.0 to 1.0
type DebugColor
	r::Float32
	g::Float32
	b::Float32
	a::Float32
end

function sfColor(debugcolor)
	SFML.Color(Uint8(floor(debugcolor.r * 255)), Uint8(floor(debugcolor.g * 255)), Uint8(floor(debugcolor.b * 255)), Uint8(floor(debugcolor.a * 255)))
end

function debug_draw_circle(pos::Vect, angle::Cdouble, radius::Cdouble, outlinecolor::DebugColor, fillcolor::DebugColor, data::Ptr{Void})
	circle = SFML.CircleShape()
	SFML.set_radius(circle, radius)
	SFML.set_origin(circle, SFML.Vector2f(radius, radius))
	SFML.set_position(circle, SFML.Vector2f(pos.x, -pos.y))
	# SFML.set_outlinecolor(circle, sfColor(outlinecolor))
	SFML.set_fillcolor(circle, sfColor(fillcolor))
	# SFML.set_outline_thickness(circle, 0)

	line = SFML.Line(SFML.Vector2f(pos.x, -pos.y), SFML.Vector2f(pos.x + radius * sin(angle), -pos.y + radius * cos(angle)), 2)
	SFML.set_fillcolor(line, SFML.Color(128, 85, 85))

	window = SFML.RenderWindow(data)
	SFML.draw(window, circle)
	SFML.draw(window, line)
	return nothing
end

function debug_draw_segment(a::Vect, b::Vect, color::DebugColor, data::Ptr{Void})
	line = SFML.Line(SFML.Vector2f(a.x, -a.y), SFML.Vector2f(b.x, -b.y), 1)
	SFML.set_fillcolor(line, sfColor(color))

	window = SFML.RenderWindow(data)
	SFML.draw(window, line)
	return nothing
end

function debug_draw_fatsegment(a::Vect, b::Vect, radius::Cdouble, outlinecolor::DebugColor, data::Ptr{Void})
	fillcolor = color_for_shape(C_NULL, C_NULL)

	line = SFML.Line(SFML.Vector2f(a.x, -a.y), SFML.Vector2f(b.x, -b.y), radius*2)
	SFML.set_outlinecolor(line, sfColor(outlinecolor))
	SFML.set_outline_thickness(line, 0)
	SFML.set_fillcolor(line, sfColor(fillcolor))

	window = SFML.RenderWindow(data)
	SFML.draw(window, line)
	return nothing
end

function debug_draw_polygon(count::Int32, verts::Ptr{Vect}, radius::Cdouble, outlinecolor::DebugColor, fillcolor::DebugColor, data::Ptr{Void})
	polygon = SFML.ConvexShape()
	SFML.set_pointcount(polygon, count)

	for i = 0:count-1
		vert = unsafe_load(verts, i+1)
		SFML.set_point(polygon, i, SFML.Vector2f(vert.x, -vert.y))
	end

	SFML.set_fillcolor(polygon, sfColor(fillcolor))
	SFML.set_outlinecolor(polygon, sfColor(outlinecolor))
	SFML.set_outline_thickness(polygon, 0)

	window = SFML.RenderWindow(data)
	SFML.draw(window, polygon)

	return nothing
end

function debug_draw_dot(size::Cdouble, pos::Vect, color::DebugColor, data::Ptr{Void})
	dot = SFML.CircleShape()
	SFML.set_radius(dot, size)
	SFML.set_position(dot, SFML.Vector2f(pos.x, -pos.y))
	SFML.set_fillcolor(dot, sfColor(color.r * 255, color.g * 255, color.b * 255, color.a * 255))

	window = SFML.RenderWindow(data)
	SFML.draw(window, dot)
	return nothing
end

function color_for_shape(shape_ptr::Ptr{Void}, data::Ptr{Void})
	if shape_ptr != C_NULL
		shape = CircleShape(shape_ptr)
		body = get_body(shape)

		if is_sleeping(body)
			# Draw in gray
			return DebugColor(0.4, 0.4, 0.4, 0.6)
		else
			# Draw in red
			return DebugColor(0.8, 0.0, 0.0, 0.6)
		end
	else
		return DebugColor(0.8, 0.0, 0.0, 0.6)
	end
end

function DebugDrawOptions(window)
	c_draw_circle = cfunction(debug_draw_circle, Void, (Vect, Cdouble, Cdouble, DebugColor, DebugColor, Ptr{Void}))
	c_draw_segment = cfunction(debug_draw_segment, Void, (Vect, Vect, DebugColor, Ptr{Void}))
	c_draw_fatsegment = cfunction(debug_draw_fatsegment, Void, (Vect, Vect, Cdouble, DebugColor, Ptr{Void}))
	c_draw_polygon = cfunction(debug_draw_polygon, Void, (Int32, Ptr{Vect}, Cdouble, DebugColor, DebugColor, Ptr{Void}))
	c_draw_dot = cfunction(debug_draw_dot, Void, (Cdouble, Vect, DebugColor, Ptr{Void}))
	c_color_for_shape = cfunction(color_for_shape, DebugColor, (Ptr{Void}, Ptr{Void}))

	ccall(dlsym(libchipmunkjl, :cpjlDebugDrawOptions), Ptr{Void},
	(Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void},
	Cint, DebugColor, Ptr{Void}, DebugColor, DebugColor,
	Ptr{Void},),
	c_draw_circle,
	c_draw_segment,
	c_draw_fatsegment,
	c_draw_polygon,
	c_draw_dot,
	(1<<0) | (1<<1) | (1<<2),
	DebugColor(0.0, 0.0, 1.0, 1.0),
	c_color_for_shape,
	DebugColor(0.0, 1.0, 0.0, 1.0),
	DebugColor(1.0, 1.0, 0.0, 1.0),
	window.ptr)
end

function debug_draw(space::Space, window::SFML.RenderWindow; clear_and_display=false)
	event = SFML.Event()
	SFML.pollevent(window, event)
	options = DebugDrawOptions(window)

	if clear_and_display
		SFML.clear(window, SFML.white)
	end

	ccall(dlsym(libchipmunk, :cpSpaceDebugDraw), Void, (Ptr{Void}, Ptr{Void},), space.ptr, options)

	if clear_and_display
		SFML.display(window)
	end
end

export debug_draw
