module Noop
  def self.tick(sigs=[])
    [:noop, :nosig, :nosig, :nosig, :nosig]
  end
end
