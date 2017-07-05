{% if flag?(:darwin) %}
  @[Link(framework: "OpenGL")]
{% else %}
  @[Link("GL")]
{% end %}

lib GL
  DEPTH_BUFFER_BIT = 0x00000100_u32
  COLOR_BUFFER_BIT = 0x00004000_u32
  FRAGMENT_SHADER = 0x8B30_u32
  VERTEX_SHADER = 0x8B31_u32
  COMPILE_STATUS = 0x8B81_u32
  LINK_STATUS = 0x8B82_u32

  fun clear = glClear(mask: UInt32) : Void
  fun clear_color = glClearColor(red: Float32, green: Float32, blue: Float32, alpha: Float32) : Void
  fun create_program = glCreateProgram() : UInt32
  fun create_shader = glCreateShader(type: UInt32) : UInt32
  fun shader_source = glShaderSource(shader: UInt32, count: Int32, string: UInt8**, length: Int32*) : Void
  fun compile_shader = glCompileShader(shader: UInt32) : Void
  fun get_shaderiv = glGetShaderiv(shader: UInt32, pname: UInt32, params: Int32*) : Void
  fun get_shader_info_log = glGetShaderInfoLog(shader: UInt32, bufSize: Int32, length: Int32*, infoLog: UInt8*) : Void
  fun delete_shader = glDeleteShader(shader: UInt32) : Void
  fun attach_shader = glAttachShader(program: UInt32, shader: UInt32) : Void
  fun link_program = glLinkProgram(program: UInt32) : Void
  fun get_programiv = glGetProgramiv(program: UInt32, pname: UInt32, params: Int32*) : Void
  fun get_program_info_log = glGetProgramInfoLog(program: UInt32, bufSize: Int32, length: Int32*, infoLog: UInt8*) : Void
end
