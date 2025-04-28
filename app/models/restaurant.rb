class Restaurant < ApplicationRecord
  has_many :menus, dependent: :destroy
  has_many :menu_items, through: :menus

  validates :name, presence: true

  scope :with_menus_and_items, -> { includes(menus: :menu_items) }
end
