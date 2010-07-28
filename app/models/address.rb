class Address < ActiveRecord::Base
  belongs_to :person
  validates_presence_of :street, :city, :state, :zip

end
