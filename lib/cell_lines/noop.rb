module Noop
  SYMBOL = ' '

  def self.tick(sigs=[])
    [:noop, :nosig, :nosig, :nosig, :nosig]
  end
end
