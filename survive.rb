require 'colorize'
require 'io/console'

$LOAD_PATH.unshift './lib'
$LOAD_PATH.unshift './lib/cell_lines'

Dir.glob('lib/cell_lines/*.rb') { |f| require_relative f }
Dir.glob('lib/*.rb') { |f| require_relative f }

M.setup_screen
h, w = IO.console.winsize
h = h - 1
size = w * h

cells = U.init_field(size)

loop do
  # sense and signal, choose action (tick)
  cells.each_with_index do |c, i|
    unless c.creature == Noop
      step = c.creature.tick(c.energy)
      action = U.step_filter(step)
      case action
      when :north, :east, :south, :west
        A::move(cells, action, c, i, w, h)
      else
        A::send(action, cells, c, i, w, h)
      end
    end
  end

  # apply signals and take action (tock)
  cells.each{|c| c.tock}

  # print current state
  # sleep
  puts "#{M.up(h)}\r"
  cells.each_slice(w) do |row|
    row.each do |cell|
      U.show(cell)
    end
  end
  sleep(0.1)
end
