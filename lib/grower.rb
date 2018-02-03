# move/rest
# signal
# [:n/:e/:s/:w/:r, <n sig>, <e sig>, <s sig>, <w sig>]
# automatically kill if the return value is invalid:
# - not an array of length 4, with all symbols
# - time to run is longer than 1 millisecond
module Grower
  def self.tick(sigs=[])
    n, e, s, w = sigs
    [:copy, :nosig, :nosig, :nosig, :nosig]
  end
end
