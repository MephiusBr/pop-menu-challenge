class Api::MenuItemsController < ApplicationController
  def index
    unless Restaurant.exists?(params[:restaurant_id]) then
      return render json: { message: "restaurant doesn't exist" }, status: :bad_request
    end

    unless Menu.exists?(params[:menu_id]) then
      return render json: { message: "menu doesn't exist" }, status: :bad_request
    end

    render json: Menu.with_menu_items
      .where(restaurant_id: params[:restaurant_id], id: params[:menu_id])
      .find(params[:menu_id]).as_json(only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } })
  end

  def show
    unless Restaurant.exists?(params[:restaurant_id]) then
      return render json: { message: "restaurant doesn't exist" }, status: :bad_request
    end

    unless Menu.exists?(params[:menu_id]) then
      return render json: { message: "menu doesn't exist" }, status: :bad_request
    end

    unless MenuItem.exists?(params[:id]) then
      return render json: { message: "item doesn't exist" }, status: :bad_request
    end

    render json: Menu.with_menu_items.where(id: params[:id]).first
      .as_json(only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } })
  end
end
