# Chipmunk.jl

`Chipmunk.jl` is a Julia binding of the popular physics engine [Chipmunk] (https://chipmunk-physics.net/) ([Github page] (https://github.com/slembcke/Chipmunk2D)).
This is currently very much in progress.

Take a look at the `examples/` folder to see what you can do with `Chipmunk.jl`

`Chipmunk.jl` uses [SFML.jl] (https://github.com/zyedidia/SFML.jl) to render the world to the screen. You may want to get that package in order to run the graphical examples.

# Installation

Installation is quite simple. The package will clone and install chipmunk from source to `deps/`.
Make sure that you have `cmake` installed so that it can build chipmunk.

```
julia> Pkg.clone("https://github.com/zyedidia/Chipmunk.jl")
julia> Pkg.build("Chipmunk")
```

# [License] (LICENSE.md)
