$LOAD_PATH.unshift './lib'

require 'colorize'
require 'io/console'
require 'm'
require 'u'
require 'cell'
require 'grower'
require 'noop'

ENERGY_COLORS = [
  :light_black,
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
  #puts c.energy if c.energy > 0
    print c.creature::SYMBOL.send(ENERGY_COLORS[c.energy.to_i.ceil] || ENERGY_COLORS[0])
#  print c.energy.to_s[-1]
end

def processing(request)
  return :kill unless request.is_a?(Array)
  return :kill unless request.length == 5
  return :kill unless request.all?{|i| i.is_a? Symbol }
  
  request[0]
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
  sleep(0.1)
  puts "#{M.up(h)}\r"
  cells.each_slice(w) do |row|
    row.each do |cell|
      show(cell)
    end
  end

  cells.each_with_index do |c, i|
    unless c.creature == Noop
      request = c.creature.tick(c.energy)
      action = processing(request)
      case action
      when :kill
        c.creature = Noop
        c.energy = 0
      when :rest
        c.add_energy(1, MAX_ENERGY)
      when :copy
        c.remove_energy(2, 0)
        dir = [:north, :east, :south, :west].sample
        c.copy_to(cells[U.find(i, dir, w, h)])
      when :north, :east, :south, :west
        c.remove_energy(0.2, 0)
        c.transfer_to(cells[U.find(i, action, w, h)])
      else
        # no-op
      end
    end
  end

  cells.each{|c| c.resolve}
end
