class ShaderProgram
  @program : GL::ShaderProgram

  def initialize(vertex_shader_filename, fragment_shader_filename)
    @program = GL.create_program

    vertex_shader = VertexShader.new(vertex_shader_filename)
    fragment_shader = FragmentShader.new(fragment_shader_filename)

    GL.attach_shader(@program, vertex_shader.shader)
    GL.attach_shader(@program, fragment_shader.shader)
    GL.link_program(@program)

    raise "Shader program linking error!" unless GL.get_program_link_status(@program)

    vertex_shader.delete
    fragment_shader.delete
  end

  def use(&block)
    GL.use_program(@program)
    yield
  end

  def set_uniform_matrix_4f(name, value)
    use do
      uniform = GL.get_uniform_location(@program, name)
      GL.uniform_matrix4fv(uniform, 1, false, value.buffer)
    end
  end

  private abstract class Shader
    getter :shader

    def initialize(filename)
      @shader = GL.create_shader(shader_type)

      load(filename)
    end

    def delete
      GL.delete_shader(@shader)
    end

    private abstract def shader_type

    private def load(filename)
      source = File.read(filename)
      GL.shader_source(@shader, source)
      GL.compile_shader(@shader)
      raise "Shader compile error!" unless GL.get_shader_compile_status(@shader)
    end
  end

  private class VertexShader < Shader
    def shader_type
      GL::ShaderType::VertexShader
    end
  end

  private class FragmentShader < Shader
    def shader_type
      GL::ShaderType::FragmentShader
    end
  end
end
