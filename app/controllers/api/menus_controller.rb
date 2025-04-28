class Api::MenusController < ApplicationController
  def index
    unless Restaurant.exists?(params[:restaurant_id]) then
      return render json: { message: "restaurant doesn't exist" }, status: :bad_request
    end

    restaurant = Restaurant.with_menus_and_items.where(id: params[:restaurant_id]).first.as_json(
      only: [:id, :name],
      include: { menus: { only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } } } }
    )

    render json: restaurant
  end

  def show
    unless Menu.exists?(params[:id]) then
      return render json: { message: "menu doesn't exist" }, status: :bad_request
    end

    unless Restaurant.exists?(params[:restaurant_id]) then
      return render json: { message: "restaurant doesn't exist" }, status: :bad_request
    end

    render json: Menu.with_menu_items.find(params[:id])
      .as_json(only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } })
  end
end
