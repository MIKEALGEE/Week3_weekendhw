require_relative("../db/sql_runner")

class Customer


  attr_accessor :name, :funds
  attr_reader :id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name= options['name']
    @funds = options['funds']
  end


  def save()
    sql = "INSERT INTO customers(
    name,
    funds
      )
    VALUES (
      $1, $2
      )
    RETURNING id"
    values = [@name, @funds]
    @id = SqlRunner.run(sql,values)[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE customers SET name = $1, funds = $2 WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def buy_ticket(film)
    value = film.price
    customer_funds = @funds
    remaining = customer_funds -= value
    @funds = remaining
    update()
  end

  def films()
  sql = "SELECT films.*
  FROM films
  INNER JOIN tickets
  ON tickets.film_id = films.id
  WHERE tickets.customer_id = $1"
  values = [@id]
  film_data = SqlRunner.run(sql, values)
  return Film.map_items(film_data)
  end

  def tickets_bought
    return films().count
  end


  def self.map_items(customer_data)
    result = customer_data.map { |customer| Customer.new( customer ) }
    return result
  end


end
