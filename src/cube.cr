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
  NUM_VERTICES = VERTICES.size
  VERTEX_SIZE = sizeof(Float32)
  VERTICES_SIZE = VERTEX_SIZE * NUM_VERTICES
  STRIDE = 6 * VERTEX_SIZE
  VERTEX_OFFSET = Offset.new(0)
  COLOR_OFFSET = Offset.new(3)

  INDICES = [
    4, 5, 1,
    4, 1, 0,
    5, 7, 3,
    5, 3, 1,
    7, 6, 2,
    7, 2, 3,
    6, 4, 0,
    6, 0, 2,
    0, 1, 3,
    0, 3, 2,
    6, 7, 5,
    6, 5, 4
  ]
  NUM_INDICES = INDICES.size
  INDEX_SIZE = sizeof(UInt32)
  INDICES_SIZE = INDEX_SIZE * NUM_INDICES
  INDEX_OFFSET = Offset.new(0)

  alias Offset = Pointer(Void)

  def initialize
    GL.gen_vertex_arrays(1, out @vao)
    GL.gen_buffers(1, out @vbo)
    GL.gen_buffers(1, out @ebo)
    GL.bind_vertex_array(@vao)

    GL.bind_buffer(GL::ARRAY_BUFFER, @vbo)
    GL.buffer_data(GL::ARRAY_BUFFER, VERTICES_SIZE, VERTICES, GL::STATIC_DRAW)

    GL.bind_buffer(GL::ELEMENT_ARRAY_BUFFER, @ebo)
    GL.buffer_data(GL::ELEMENT_ARRAY_BUFFER, INDICES_SIZE, INDICES, GL::STATIC_DRAW)

    GL.vertex_attrib_pointer(0, 3, GL::FLOAT, GL::FALSE, STRIDE, VERTEX_OFFSET)
    GL.enable_vertex_attrib_array(0)

    GL.vertex_attrib_pointer(1, 3, GL::FLOAT, GL::FALSE, STRIDE, COLOR_OFFSET)
    GL.enable_vertex_attrib_array(1)
  end

  def draw
    GL.bind_vertex_array(@vao)
    GL.draw_elements(GL::TRIANGLES, NUM_INDICES, GL::UNSIGNED_INT, INDEX_OFFSET)
  end

  def delete
    GL.delete_vertex_arrays(1, pointerof(@vao))
    GL.delete_buffers(1, pointerof(@vbo))
    GL.delete_buffers(1, pointerof(@ebo))
  end
end
