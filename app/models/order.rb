class Order < ActiveRecord::Base
  belongs_to :customer, :class_name => "Person"
  has_many :line_items
  has_many :items, :through => :line_items

  validates_presence_of :customer
end
