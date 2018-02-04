module Mover
  SYMBOL = 'M'

  def self.tick(energy, sigs=[])
    [[:north, :east, :south, :west].sample, :nosig, :nosig, :nosig, :nosig]
  end
end
