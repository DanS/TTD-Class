class Order < ActiveRecord::Base
  belongs_to :customer, :class_name => "Person"
end
