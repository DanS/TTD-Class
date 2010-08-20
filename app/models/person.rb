class Person < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_many :addresses
  has_many :orders, :foreign_key => :customer_id

  accepts_nested_attributes_for :addresses

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

  def with_addresses
    #return person as a symbol keyed hash including a array of addresses which are also symbol keyed hashes
    addrs = addresses.collect do |a|
      #remove unwanted keys
      h1 = a.attributes.delete_if { |k, v| k =~ /^id$|_id$|_at$/ }

      #convert keys to symbols
      h2 = {}
      h1.each_pair {|k,v| h2[k.to_sym] = v}
      h2
    end
    {:first_name => first_name, :middle_name=>middle_name, :last_name=>last_name, :addresses=>addrs}
  end

end

