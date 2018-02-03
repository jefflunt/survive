module U
  def self.find(i, dir, w, h)
    case dir
    when :north
      i - w
    when :east
      r = i / w
      c = i % w

      c = c == w - 1 ? 0 : c + 1
      (r * w) + c
    when :south
      (i + w) % (w * h)
    when :west
      r = i / w
      c = i % w

      c = c == 0 ? w - 1 : c - 1
      (r * w) + c
    end
  end
end
