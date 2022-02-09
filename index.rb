class Bank
  attr_accessor :name, :collected_fees

  def initialize(name)
    @name = name
    @collected_fees = 0
  end

  def check_collected_fees
    "#{self.name} - collected fees are #{collected_fees.round(5)}€"
  end
end

class BankAccount
  attr_accessor :name, :type, :balance, :transactions, :transfer_fee

  def initialize(name, type = "private", balance = 0)
    @name = name
    @type = type
    @balance = balance
    @transactions = []
    @transfer_fee = @type == "business" ? 0.10 : 0.01
  end

  def send_money(recipient, amount, bank, reason)
    bank.collected_fees += transfer_fee
    transaction_send = {type: "transfer", recipient: recipient.name, amount: amount, reason: reason, transfer_fee: transfer_fee}
    @transactions << transaction_send
  end

  def receive_money(sender, amount, reason)
    transaction_receive = {type: "recieve", sender: sender.name, amount: amount, reason: reason}
    @transactions << transaction_receive
  end

  def deposit_money(amount)
    transaction_deposit = {type: "deposit", amount: amount}
    @transactions << transaction_deposit
  end

  def show_transactions
    puts "#{self.name} has the following transactions:"
    puts @transactions
  end

  def check_balance
    transactions.each do |transaction|
      @balance -= transaction[:amount] + transaction[:transfer_fee] if transaction[:type] == "transfer"
      @balance += transaction[:amount] if transaction[:type] == "recieve" or transaction[:type] == "deposit"
    end
    "#{self.name} - remaining balance is #{balance}€"
  end
end

# CREATING BANK
sparkasse = Bank.new("Sparkasse")

# CREATING BANK ACCOUNTS
arty = BankAccount.new("Arty")
jan = BankAccount.new("Jan")
sebastian = BankAccount.new("Sebastian")
nine_elements = BankAccount.new("9elements", "business")

# DEPOSITING CASH MONEY
arty.deposit_money(1000)
jan.deposit_money(1000)
sebastian.deposit_money(1000)
nine_elements.deposit_money(10000)

# SENDING MONEY
sebastian.send_money(arty, 10, sparkasse, "pizza")
arty.send_money(jan, 3, sparkasse, "beer")
nine_elements.send_money(arty, 2000, sparkasse, "salary")

# RECIEVING MONEY
arty.receive_money(sebastian, 10, "pizza")
jan.receive_money(arty, 3, "beer")
arty.receive_money(nine_elements, 2000, "salary")

# SHOWING TRANSACTIONS
puts arty.show_transactions
puts jan.show_transactions
puts sebastian.show_transactions
puts nine_elements.show_transactions

# CHECK BALANCE FOR ALL
puts arty.check_balance
puts jan.check_balance
puts sebastian.check_balance
puts nine_elements.check_balance
puts sparkasse.check_collected_fees
