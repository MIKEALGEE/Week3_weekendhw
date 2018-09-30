require_relative("../db/sql_runner")

class Ticket


  attr_accessor :customer_id, :film_id
  attr_reader :id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets(
    customer_id,
    film_id
      )
    VALUES (
    $1, $2 )
    RETURNING id"
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql,values)[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE tickets SET
    customer_id  = $1,
    film_id  = $2,
    WHERE id  = $4"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(ticket_data)
    result = ticket_data.map { |ticket| Ticket.new( ticket ) }
    return result
  end


end
