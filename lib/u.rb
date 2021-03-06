module U
  COLORS = [
    :light_black,
    :red,
    :light_red,
    :yellow,
    :light_yellow,
    :green,
    :light_green,
    :blue,
    :light_blue,
    :cyan,
    :white,
    :light_white
  ]
  MAX_ENERGY = COLORS.length - 1
  CELL_LINES = [BlindCopy, Mover]

  def self.init_field(size)
    size.times.collect do
      rand(1000) == 0 ? Cell.new(CELL_LINES.sample, MAX_ENERGY) : Cell.new(Noop, 0)
    end
  end

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

  def self.show(c)
    print c.creature::SYMBOL.send(COLORS[c.energy.to_i.ceil] || COLORS[0])
  end

  def self.step_filter(step)
    return :kill unless step.is_a?(Array)
    return :kill unless step.length == 5
    return :kill unless step.all?{|i| i.is_a? Symbol }
    
    step[0]
  end

end
