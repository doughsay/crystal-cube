require "./gl"
require "./window"
require "./shader_program"
require "./cube"

class App
  def initialize
    @window = Window.new(800, 600, "OMG! 3D!")
    @shader_program = ShaderProgram.new("./src/shaders/vertex_shader.glsl", "./src/shaders/fragment_shader.glsl")
    @scene = Cube.new
  end

  def run
    setup

    @window.open do
      render
    end

    teardown
  end

  private def setup
    @window.set_context_current
    GL.clear_color(0.2_f32, 0.3_f32, 0.5_f32, 1.0_f32)
  end

  private def clear
    GL.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
  end

  private def render
    clear
    @scene.draw
  end

  private def teardown
    @scene.delete
  end
end
