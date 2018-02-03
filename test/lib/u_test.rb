require 'minitest/autorun'

class TestU < MiniTest::Spec
  describe '::find' do
    it { assert_equal(2, U.find(7, :north, 5, 5)) }
    it { assert_equal(-4, U.find(1, :north, 5, 5)) }

    it { assert_equal(2, U.find(1, :east, 5, 5)) }
    it { assert_equal(0, U.find(4, :east, 5, 5)) }

    it { assert_equal(8, U.find(3, :south, 5, 5)) }
    it { assert_equal(3, U.find(23, :south, 5, 5)) }

    it { assert_equal(6, U.find(7, :west, 5, 5)) }
    it { assert_equal(4, U.find(0, :west, 5, 5)) }
  end
end
