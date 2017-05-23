class Payment
  def order(token)
    @amount = 100
    customer = Stripe::Customer.create(
      :email => 'customer@example.com',
      :source  => token
    )  
    charge = Stripe::Charge.create(
      :amount      => @amount,
      :description => 'Sinatra Charge',
      :currency    => 'EUR',
      :customer    => customer.id
    )
  end
end