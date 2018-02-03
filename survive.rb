$LOAD_PATH.unshift './lib'

require 'colorize'
require 'io/console'
require 'm'
require 'u'
require 'cell'
require 'grower'
require 'noop'

M.setup_screen
h, w = IO.console.winsize
h = h - 1
size = w * h

cells = size.times.collect do
  rand(1000) == 0 ? Cell.new(Grower, U::MAX_ENERGY) : Cell.new(Noop, 0)
end

loop do
  sleep(0.1)
  puts "#{M.up(h)}\r"
  cells.each_slice(w) do |row|
    row.each do |cell|
      U.show(cell)
    end
  end

  cells.each_with_index do |c, i|
    unless c.creature == Noop
      step = c.creature.tick(c.energy)
      action = U.step_filter(step)
      case action
      when :kill
        c.creature = Noop
        c.energy = 0
      when :rest
        c.add_energy(1, U::MAX_ENERGY)
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
