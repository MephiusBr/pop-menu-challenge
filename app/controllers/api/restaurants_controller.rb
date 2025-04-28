class Api::RestaurantsController < ApplicationController
  def index
    restaurants = Restaurant.with_menus_and_items.as_json(
      only: [:id, :name],
      include: { menus: { only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } } } }
    )

    render json: restaurants
  end

  def show
    unless Restaurant.exists?(params[:id]) then
      return render json: { message: "restaurant doesn't exist" }, status: :bad_request
    end

    restaurant = Restaurant.with_menus_and_items.where(id: params[:id]).first.as_json(
      only: [:id, :name],
      include: { menus: { only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } } } }
    )

    render json: restaurant
  end
end
