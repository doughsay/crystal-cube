class ShaderProgram
  def initialize(vertex_shader_filename, fragment_shader_filename)
    @handle = GL.create_program

    vertex_shader = VertexShader.new(vertex_shader_filename)
    fragment_shader = FragmentShader.new(fragment_shader_filename)

    GL.attach_shader(@handle, vertex_shader.handle)
    GL.attach_shader(@handle, fragment_shader.handle)
    GL.link_program(@handle)

    check_for_linking_errors

    vertex_shader.delete
    fragment_shader.delete
  end

  def use(&block)
    GL.use_program(@handle)
    yield
  end

  def set_uniform_matrix_4f(uniform, value)
    use do
      location = GL.get_uniform_location(@handle, uniform)
      GL.uniform_matrix4fv(location, 1, GL::FALSE, value)
    end
  end

  private def check_for_linking_errors
    GL.get_programiv(@handle, GL::LINK_STATUS, out success)

    if !success
      GL.get_program_info_log(@handle, 512, nil, out info_log)
      raise "Shader program linking error\n#{info_log}"
    end

    true
  end

  private abstract class Shader
    getter :handle

    def initialize(filename)
      @handle = GL.create_shader(shader_type)

      load(filename)
    end

    def delete
      GL.delete_shader(@handle)
    end

    private abstract def shader_type

    private def load(filename)
      source = File.read(filename)
      GL.shader_source(@handle, 1, [source.to_unsafe], nil)
      GL.compile_shader(@handle)
      check_for_compile_errors
    end

    private def check_for_compile_errors
      GL.get_shaderiv(@handle, GL::COMPILE_STATUS, out success)

      if !success
        GL.get_shader_info_log(@handle, 512, nil, out info_log)
        raise "Shader compile error\n#{info_log}"
      end
    end
  end

  private class VertexShader < Shader
    def shader_type
      GL::VERTEX_SHADER
    end
  end

  private class FragmentShader < Shader
    def shader_type
      GL::FRAGMENT_SHADER
    end
  end
end
