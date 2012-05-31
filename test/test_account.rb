require 'test/unit'
require 'shoulda'

require 'account'

class TestAccount < Test::Unit::TestCase
  
  context "Transfer" do 

    should "money should be transferred from source to target" do 
      
      src = Account.new 100
      target = Account.new 100
      
      TransferContext.call(src, target, 40)

      assert_equal 60, src.balance
      assert_equal 140, target.balance
      
      # this is available outside the context, not exactly what I wanted
      #assert_equal false, src.respond_to?(:withdraw)
    end
  
  end

end
