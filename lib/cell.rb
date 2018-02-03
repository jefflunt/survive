class Cell
  attr_accessor :creature
  attr_accessor :energy

  def initialize(creature, energy)
    @creature = creature
    @energy = energy
  end

  def add_energy(x, max)
    @energy = [@energy + x, max].min
  end

  def remove_energy(x, min)
    @energy = [@energy - x, min].max
  end
  
  def transfer_to(cell)
    cell.creature = @creature
    cell.energy = @energy
    @creature = Noop
    @energy = 0
  end
end
