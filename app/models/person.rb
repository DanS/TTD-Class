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
    _addresses = addresses.collect do |a|
      #remove unwanted keys
      hash_with_wanted_keys = a.attributes.delete_if { |k, v| k =~ /^id$|_id$|_at$/ }

      #convert keys to symbols
      hash_with_keys_as_symbols = {}
      hash_with_wanted_keys.each_pair {|k,v| hash_with_keys_as_symbols[k.to_sym] = v}
      hash_with_keys_as_symbols
    end
    {:first_name => first_name, :middle_name=>middle_name, :last_name=>last_name, :addresses=>_addresses}
  end

end

