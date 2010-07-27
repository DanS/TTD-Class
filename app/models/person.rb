class Person < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_many :addresses

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

end