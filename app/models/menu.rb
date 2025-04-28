class Menu < ApplicationRecord
  belongs_to :restaurant

  has_many :menu_listings
  has_many :menu_items, through: :menu_listings

  validates :name, presence: true

  scope :with_menu_items, -> { includes(:menu_items).references(:menu_items) }
end
