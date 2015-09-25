function momentforbox(mass::Real, width::Real, height::Real)
    ccall(dlsym(libchipmunk, :cpMomentForBox), Cdouble, (Cdouble, Cdouble, Cdouble,), mass, width, height)
end

export momentforbox
