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

  def self.loyal_customers
    self.all(:joins => [:orders => :line_items],
             :conditions => [ "line_items.created_at >= ?", Time.now.midnight - 3.months ],
             :group =>"people.id",
             :having => "COUNT(people.id) > 1"
    )
  end

end

