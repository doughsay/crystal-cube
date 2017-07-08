class Cube
  # 4_______5
  # |\      |\
  # | \_____|_\
  # | |6    | |7
  # |_|_____| |
  # \0|     \1|
  #  \|______\|
  #   2       3

  CUBE_SIZE = 0.8_f32
  VERTICES = [
    # positions                          # colors
    -CUBE_SIZE, -CUBE_SIZE, -CUBE_SIZE,  0.0_f32, 0.0_f32, 0.0_f32,  # 0
     CUBE_SIZE, -CUBE_SIZE, -CUBE_SIZE,  0.0_f32, 0.0_f32, 1.0_f32,  # 1
    -CUBE_SIZE, -CUBE_SIZE,  CUBE_SIZE,  0.0_f32, 1.0_f32, 0.0_f32,  # 2
     CUBE_SIZE, -CUBE_SIZE,  CUBE_SIZE,  0.0_f32, 1.0_f32, 1.0_f32,  # 3
    -CUBE_SIZE,  CUBE_SIZE, -CUBE_SIZE,  1.0_f32, 0.0_f32, 0.0_f32,  # 4
     CUBE_SIZE,  CUBE_SIZE, -CUBE_SIZE,  1.0_f32, 0.0_f32, 1.0_f32,  # 5
    -CUBE_SIZE,  CUBE_SIZE,  CUBE_SIZE,  1.0_f32, 1.0_f32, 0.0_f32,  # 6
     CUBE_SIZE,  CUBE_SIZE,  CUBE_SIZE,  1.0_f32, 1.0_f32, 1.0_f32   # 7
  ]

  INDICES = [
    4_u32, 5_u32, 1_u32,
    4_u32, 1_u32, 0_u32,
    5_u32, 7_u32, 3_u32,
    5_u32, 3_u32, 1_u32,
    7_u32, 6_u32, 2_u32,
    7_u32, 2_u32, 3_u32,
    6_u32, 4_u32, 0_u32,
    6_u32, 0_u32, 2_u32,
    0_u32, 1_u32, 3_u32,
    0_u32, 3_u32, 2_u32,
    6_u32, 7_u32, 5_u32,
    6_u32, 5_u32, 4_u32
  ]

  @vao : GL::VertexArray
  @vbo : GL::Buffer
  @ebo : GL::Buffer

  def initialize
    @vao = GL.gen_vertex_array
    @vbo, @ebo = GL.gen_buffers(2)
    GL.bind_vertex_array(@vao)

    GL.bind_buffer(GL::BufferBindingTarget::ArrayBuffer, @vbo)
    GL.buffer_data(GL::BufferBindingTarget::ArrayBuffer, VERTICES.size * sizeof(Float32), VERTICES, GL::BufferUsage::StaticDraw)

    GL.vertex_attrib_pointer(0, 3, GL::Type::Float, false, 6 * sizeof(Float32), 0)
    GL.enable_vertex_attrib_array(0)

    GL.vertex_attrib_pointer(1, 3, GL::Type::Float, false, 6 * sizeof(Float32), 3 * sizeof(Float32))
    GL.enable_vertex_attrib_array(1)

    GL.bind_buffer(GL::BufferBindingTarget::ElementArrayBuffer, @ebo)
    GL.buffer_data(GL::BufferBindingTarget::ElementArrayBuffer, INDICES.size * sizeof(UInt32), INDICES, GL::BufferUsage::StaticDraw)
  end

  def draw
    GL.bind_vertex_array(@vao)
    GL.draw_elements(GL::Primitive::Triangles, INDICES.size, GL::Type::UnsignedInt, 0)
  end

  def delete
    GL.delete_vertex_array(@vao)
    GL.delete_buffers([@vbo, @ebo])
  end
end
