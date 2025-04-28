class Menu < ApplicationRecord
  has_many :menu_items, dependent: :destroy

  validates :name, presence: true

  scope :with_menu_items, -> { includes(:menu_items).references(:menu_items) }
end
