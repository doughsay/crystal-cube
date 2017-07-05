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
  ARRAY_BUFFER = 0x8892_u32
  STATIC_DRAW = 0x88E4_u32
  ELEMENT_ARRAY_BUFFER = 0x8893_u32
  FLOAT = 0x1406_u32
  FALSE = 0
  TRUE = 1
  UNSIGNED_INT = 0x1405_u32
  TRIANGLES = 0x0004_u32

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
  fun use_program = glUseProgram(program: UInt32) : Void
  fun gen_vertex_arrays = glGenVertexArrays(n: Int32, arrays: UInt32*) : Void
  fun gen_buffers = glGenBuffers(n: Int32, buffers: UInt32*) : Void
  fun bind_vertex_array = glBindVertexArray(array: UInt32) : Void
  fun bind_buffer = glBindBuffer(target: UInt32, buffer: UInt32) : Void
  fun buffer_data = glBufferData(target: UInt32, size: Int32, data: Void*, usage: UInt32) : Void
  fun vertex_attrib_pointer = glVertexAttribPointer(index: UInt32, size: Int32, type: UInt32, normalized: UInt8, stride: Int32, pointer: Void*) : Void
  fun enable_vertex_attrib_array = glEnableVertexAttribArray(index: UInt32) : Void
  fun draw_elements = glDrawElements(mode: UInt32, count: Int32, type: UInt32, indices: Void*) : Void
  fun delete_vertex_arrays = glDeleteVertexArrays(n: Int32, arrays: UInt32*) : Void
  fun delete_buffers = glDeleteBuffers(n: Int32, buffers: UInt32*) : Void
end
