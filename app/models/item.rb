class Item < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items

  validates_presence_of :name, :price
  validates_numericality_of :price

  def self.by_popularity
#    self.find_by_sql("
#    SELECT  i.name, i.description, COUNT(li.item_id) as count
#    FROM items i, line_items li
#    WHERE i.id = li.item_id
#    GROUP BY li.item_id
#    ORDER BY count DESC
#    ")

    self.all(
          :select=>"*, COUNT(line_items.item_id) as count",
          :joins=>[:line_items],
          :group=>"line_items.item_id",
          :order=>"count DESC"
    )
  end

end
