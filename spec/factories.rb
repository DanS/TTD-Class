Factory.define :person do |p|
  p.first_name 'Joe'
  p.last_name 'Blow'
end

Factory.define :address do |a|
  a.street '123 Easy Street'
  a.city 'San Francisco'
  a.state 'CA'
  a.zip '98765'
  a.association :person, :factory => :person
end

Factory.define :order do |o|
  o.association :customer, :factory => :person
end

Factory.define :item do |i|
  i.name 'item name'
  i.description 'item description'
  i.price 9.99
end

Factory.define :line_item do |f|
  f.association :order, :factory => :order
  f.association :item, :factory => :item
end