# Chipmunk.jl

`Chipmunk.jl` is a Julia binding of the popular physics engine [Chipmunk] (https://chipmunk-physics.net/) ([Github page] (https://github.com/slembcke/Chipmunk2D)).
This is currently very much in progress.

Take a look at the `examples/` folder to see what you can do with `Chipmunk.jl`

`Chipmunk.jl` uses [SFML.jl] (https://github.com/zyedidia/SFML.jl) to render the world to the screen. You may want to get that package in order to run the graphical examples.

# Installation

To install, you must first have Chipmunk 7 installed.

#### Mac

You can install Chipmunk 7 with Homebrew:

```
$ brew install chipmunk
```

Then you can install with Julia

```
julia> Pkg.clone("https://github.com/zyedidia/Chipmunk.jl")
```

# [License] (LICENSE.md)
