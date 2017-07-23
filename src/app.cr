require "gl"
require "glfw"

require "./glm"
require "./window"
require "./shader_program"
require "./cube"

class App
  def initialize
    @window_size = { height: 800, width: 600 }
    @window = Window.new(@window_size[:height], @window_size[:width], "OMG! 3D!")
    @window.set_context_current
    @shader_program = ShaderProgram.new("./src/shaders/cube.vert", "./src/shaders/cube.frag")
    @scene = Cube.new
    @rotation_speed = 1
    @angle = 0.0_f32
  end

  def run
    setup

    @window.open do |delta_time|
      render(delta_time)
    end

    teardown
  end

  private def setup
    GL.clear_color(GL::Color.new(0.2, 0.3, 0.5, 1.0))
    GL.enable(GL::Capability::DepthTest)
    GL.enable(GL::Capability::CullFace)
    GL.enable(GL::Capability::Multisample)

    projection = GLM.perspective(45.0_f32, (@window_size[:height].to_f / @window_size[:width].to_f).to_f32, 0.1_f32, 100.0_f32)
    @shader_program.set_uniform_matrix_4f("projection", projection)
  end

  private def clear
    GL.clear(GL::BufferBit::Color | GL::BufferBit::Depth)
  end

  private def render(delta_time)
    clear
    @shader_program.use do
      @angle += delta_time * @rotation_speed
      model = GLM.rotate(@angle, GLM.vec3(0.5, 1.0, 0.0))
      view = GLM.translate(GLM.vec3(0.0, 0.0, -6.0))

      @shader_program.set_uniform_matrix_4f("model", model)
      @shader_program.set_uniform_matrix_4f("view", view)

      @scene.draw
    end
  end

  private def teardown
    @scene.delete
  end
end
