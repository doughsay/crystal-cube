Crystal OpenGL Rotating Cube
============================

A rotating colorful cube in Crystal.

Dependencies
------------

1. A working Crystal instalation (`brew install crystal-lang`)
2. GLFW3 (`brew install glfw3`)

How To Run
----------

```
# install dependencies
shards

# run
crystal src/main.cr

# or build
crystal build src/main.cr -o cube
./cube
```

`esc` in the window, or `ctrl-c` in the terminal to quit.

Screenshot
----------

![screenshot](screenshot.png "Screenshot")
