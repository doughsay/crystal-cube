class Cube
  VERTICES = [
     0.5_f32,  0.5_f32, 0.0_f32,  # top right
     0.5_f32, -0.5_f32, 0.0_f32,  # bottom right
    -0.5_f32, -0.5_f32, 0.0_f32,  # bottom left
    -0.5_f32,  0.5_f32, 0.0_f32   # top left
  ]
  NUM_VERTICES = VERTICES.size
  VERTEX_SIZE = sizeof(Float32)
  VERTICES_SIZE = VERTEX_SIZE * NUM_VERTICES
  STRIDE = 3 * VERTEX_SIZE
  VERTEX_OFFSET = Offset.new(0)

  INDICES = [
    0_u32, 1_u32, 3_u32,  # first Triangle
    1_u32, 2_u32, 3_u32   # second Triangle
  ]
  NUM_INDICES = INDICES.size
  INDEX_SIZE = sizeof(UInt32)
  INDICES_SIZE = INDEX_SIZE * NUM_INDICES

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

    GL.vertex_attrib_pointer(0, 3, GL::FLOAT, GL::FALSE, STRIDE, Offset.new(0))
    GL.enable_vertex_attrib_array(0)
  end

  def draw
    GL.bind_vertex_array(@vao)
    GL.draw_elements(GL::TRIANGLES, NUM_INDICES, GL::UNSIGNED_INT, Offset.new(0))
  end

  def delete
    GL.delete_vertex_arrays(1, pointerof(@vao))
    GL.delete_buffers(1, pointerof(@vbo))
    GL.delete_buffers(1, pointerof(@ebo))
  end
end
