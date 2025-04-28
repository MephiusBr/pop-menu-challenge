class Api::MenuItemsController < ApplicationController
  def index
    unless Menu.exists?(params[:menu_id]) then
      return render json: { message: "menu doesn't exist" }, status: :bad_request
    end

    render json: Menu.with_menu_items.find(params[:menu_id])
      .as_json(only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } })
  end

  def show
    unless Menu.exists?(params[:menu_id]) then
      return render json: { message: "menu doesn't exist" }, status: :bad_request
    end

    unless MenuItem.exists?(params[:id]) then
      return render json: { message: "item doesn't exist" }, status: :bad_request
    end

    render json: MenuItem.with_menu.where(id: params[:id]).first
      .as_json(only: [:id, :name, :price])
  end
end
