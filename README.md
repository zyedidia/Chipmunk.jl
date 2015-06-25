# Chipmunk.jl

![logo smash](https://zyedidia.github.io/assets/logo_smash.gif)

[![Build Status](https://travis-ci.org/zyedidia/Test.jl.svg?branch=master)](https://travis-ci.org/zyedidia/Test.jl)

`Chipmunk.jl` is a Julia binding of the popular physics engine [Chipmunk] (https://chipmunk-physics.net/) ([Github page] (https://github.com/slembcke/Chipmunk2D)).
This is currently very much in progress.

Take a look at the `examples/` folder to see what you can do with `Chipmunk.jl`

`Chipmunk.jl` uses [SFML.jl] (https://github.com/zyedidia/SFML.jl) to render the world to the screen.

`Chipmunk.jl` also requires Julia 0.4.

# Installation

Installation is quite simple. The package will clone and install chipmunk from source to `deps/`.
Make sure that you have `cmake` installed so that it can build chipmunk.

I have not been able to get cmake to compile Chipmunk on Windows yet.

If you get an SFML build error about `follow_symlinks` you should update your version of Julia 0.4.

```
julia> Pkg.clone("https://github.com/zyedidia/Chipmunk.jl")
julia> Pkg.build("Chipmunk")
```

# [License] (LICENSE.md)
