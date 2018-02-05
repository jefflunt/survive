class Cell
  attr_accessor :creature
  attr_accessor :energy
  attr_accessor :signals
  attr_accessor :next_creature
  attr_accessor :next_energy

  def initialize(creature, energy)
    @creature = creature
    @energy = energy
    @next_creature = Noop
    @next_energy = 0
  end

  def add_energy(x, max)
    @energy = [@energy + x, max].min
  end

  def remove_energy(x, min)
    @energy = [@energy - x, min].max
  end
  
  def transfer_to(cell)
    if cell.creature == Noop
      cell.next_creature = @creature
      cell.next_energy = @energy
      @next_creature = Noop
      @next_energy = 0
    else
      @next_creature = @creature
      @next_energy = @energy
    end
  end

  def copy_to(cell)
    if cell.creature == Noop
      cell.next_creature = @creature
      cell.next_energy = 2
      true
    else
      false
    end
  end

  def kill(c)
    c.next_creature = Noop
    c.next_energy = 0
  end

  def stay
    @next_creature = @creature
    @next_energy = energy
  end

  def resolve
    @creature = @next_creature
    @energy = @next_energy
    @next_creatue = Noop
    @next_energy = 0
  end
end
