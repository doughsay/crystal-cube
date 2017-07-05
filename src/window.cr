require "lib_glfw"

class Window
  def initialize(@width = 1024, @height = 768, @title = "")
    raise "Failed to initialize GLFW" unless LibGLFW.init

    LibGLFW.window_hint LibGLFW::CONTEXT_VERSION_MAJOR, 3
    LibGLFW.window_hint LibGLFW::CONTEXT_VERSION_MINOR, 3
    LibGLFW.window_hint LibGLFW::OPENGL_FORWARD_COMPAT, 1
    LibGLFW.window_hint LibGLFW::OPENGL_PROFILE, LibGLFW::OPENGL_CORE_PROFILE
    @handle = LibGLFW.create_window @width, @height, @title, nil, nil

    raise "Failed to open GLFW window" if @handle.is_a?(Nil)
  end

  def set_context_current
    LibGLFW.set_current_context(@handle)
  end

  def open(&block)
    while true
      LibGLFW.poll_events
      break if LibGLFW.get_key(@handle, LibGLFW::KEY_ESCAPE) == LibGLFW::PRESS && LibGLFW.window_should_close(@handle)
      yield
      LibGLFW.swap_buffers(@handle)
    end

    LibGLFW.terminate
  end
end
