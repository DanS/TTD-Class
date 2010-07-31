class Person < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_many :addresses
  has_many :orders, :foreign_key => :customer_id

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def all_purchases
    orders.collect {|o| o.items.collect }.flatten
  end

end