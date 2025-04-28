class MenuItem < ApplicationRecord
  has_many :menu_listings
  has_many :menus, through: :menu_listings

  validates :name,  presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :with_menu, -> { includes(:menu).references(:menu) }
end
