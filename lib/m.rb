module M
  def self.hide_cursor
    "\033[?25l"
  end

  def self.show_cursor
    "\033[?25h"
  end

  def self.esc
    "\e"
  end

  def self.up(n=1)
    "#{esc}[#{n}A"
  end

  def self.down(n=1)
    "#{esc}[#{n}B"
  end

  def self.left(n=1)
    "#{esc}[#{n}D"
  end

  def self.right(n=1)
    "#{esc}[#{n}C"
  end

  def self.clear
    "#{esc}[2J"
  end

  def self.clear_line
    "#{esc}[2K"
  end
end
