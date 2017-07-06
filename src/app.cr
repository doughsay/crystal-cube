require "./gl"
require "./glm"
require "./window"
require "./shader_program"
require "./cube"

class App
  def initialize
    @window = Window.new(800, 600, "OMG! 3D!")
    @window.set_context_current
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
    GL.clear_color(0.2_f32, 0.3_f32, 0.5_f32, 1.0_f32)
    GL.enable(GL::DEPTH_TEST)

    projection = GLM.perspective(45.0_f32, (800.0 / 600.0).to_f32, 0.1_f32, 100.0_f32)
    @shader_program.set_uniform_matrix_4f("projection", projection)
  end

  private def clear
    GL.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
  end

  private def render
    clear
    @shader_program.use do
      model = GLM.rotate(LibGLFW.get_time, GLM.vec3(0.5, 1.0, 0.0))
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
