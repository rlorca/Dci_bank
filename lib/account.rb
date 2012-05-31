#data class
class Account
  attr_reader :balance

  def initialize(initial_balance)
    @balance = initial_balance
  end

  def increase_balance(amount)
    @balance += amount
  end
  
  #what if there are different types of accounts? should this be in a role account?
  def reduce_balance(amount)
    @balance -= amount
  end
end


#role 
module Transfer

  module TargetAccount
    def deposit(amount)
      self.increase_balance(amount)
    end
  end

  module SourceAccount
    def withdraw(amount)
      self.reduce_balance amount
    end
  end
end

#context
class TransferContext

  def self.call(src, target, amount)
     TransferContext.new(src, target).call(amount)
  end
 
  def initialize(src, target)
    @src = src.extend Transfer::SourceAccount
    @target = target.extend Transfer::TargetAccount          
  end

  def call(amount)
    @src.withdraw amount
    @target.deposit amount
  end
end


#what shouuld go in a controller
src = Account.new 100
target = Account.new 100

TransferContext.call(src, target, 40)

puts "Source balance #{src.balance}"
puts "Target balance #{target.balance}"
