module Noop
  SYMBOL = ' '

  def self.tick(sigs=[])
    [:rest, :nosig, :nosig, :nosig, :nosig]
  end
end
