require_relative( 'models/customer.rb' )
require_relative( 'models/film.rb')
require_relative( 'models/ticket.rb')

require( 'pry' )

Customer.delete_all
Film.delete_all
Ticket.delete_all


customer1 = Customer.new({
  'name' => 'Wee Dave',
  'funds' => 50
  })
  customer1.save()
  customer2 = Customer.new({
  'name' => 'Mike',
  'funds' => 25
    })
  customer2.save()

  customer3 = Customer.new({
  'name' => 'Batman',
  'funds' => 50
  })
  customer3.save()

  film1 = Film.new({
  'title' => 'Harry Potter',
  'price' => 9
      })
      film1.save()

  film2 = Film.new({
    'title' => 'Star Wars',
    'price' => 5
    })
    film2.save()
    film3 = Film.new({
      'title' => 'Die Hard',
      'price' => 3
      })
      film3.save()

      ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
      ticket1.save()
      ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
      ticket2.save()
      ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id})
      ticket3.save()

      customer1.buy_ticket(film1)
      customer1.films()
      binding.pry
      nil
