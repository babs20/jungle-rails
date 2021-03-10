class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :lower_quantity

  private

  def lower_quantity
    @items = LineItem.where('order_id = ?', [self.id])
    @items.each do |item|
      @product = Product.find item[:product_id]
      @product.update(quantity: @product[:quantity] - item[:quantity])
      @product.save!
    end
  end
end
