$LOAD_PATH.unshift './lib'

require 'colorize'
require 'io/console'
require 'm'
require 'cell'
require 'grower'
require 'noop'

ENERGY_COLORS = [
  :black,
  :blue,
  :red,
  :light_red,
  :yellow,
  :light_yellow,
  :white,
  :light_white
]
MAX_ENERGY = ENERGY_COLORS.length - 1

def show(c)
  print '█'.send(ENERGY_COLORS[c.energy.to_i] || ENERGY_COLORS[0]) if c
end

def processing(request)
  return :kill unless request.is_a?(Array)
  return :kill unless request.length == 5
  return :kill unless request.all?{|i| i.is_a? Symbol }
  
  request[0]
end

def find(i, dir, w, h)
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

##
# main
puts M.hide_cursor
puts M.clear
h, w = IO.console.winsize
h = h - 1
size = w * h

cells = size.times.collect do
  rand(1000) == 0 ? Cell.new(Grower, MAX_ENERGY) : Cell.new(Noop, 0)
end

loop do
  sleep(0.2)
  puts "#{M.up(h)}\r"
  cells.each_slice(w) do |row|
    row.each do |cell|
      show(cell)
    end
  end

  cells.each_with_index do |c, i|
    unless c.creature == Noop
      request = c.creature.tick
      action = processing(request)
      case action
      when :kill
        c.remove_energy(MAX_ENERGY, 0)
        c.creature = Noop
      when :rest
        c.add_energy(0.1, MAX_ENERGY)
      when :north, :east, :south, :west
        c.remove_energy(0.2, 0)
        c.transfer_to(cells[find(i, action, w, h)])
      else
        # no-op
      end
    end
  end

  cells.each{|c| c.resolve}
end
