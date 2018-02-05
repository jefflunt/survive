module A
  def self.kill(_cells, c, _i, _w, _h)
    c.kill
  end

  def self.rest(_cells, c, _i, _w, _h)
    c.add_energy(0.1, U::MAX_ENERGY)
    c.stay
  end

  def self.copy(cells, c, i, w, h)
    if c.energy >= 2
      dir = [:north, :east, :south, :west].sample
      successful_copy = c.copy_to(cells[U.neighbor(i, dir, w, h)])
      c.remove_energy(2, 0) if successful_copy
      c.add_energy(0.1, U::MAX_ENERGY) if !successful_copy
      c.stay
    else
      c.add_energy(0.1, U::MAX_ENERGY)
      c.stay
    end
  end

  def self.move(cells, dir, c, i, w, h)
    c.remove_energy(0.2, 0)
    c.transfer_to(cells[U.neighbor(i, dir, w, h)])
  end
end
