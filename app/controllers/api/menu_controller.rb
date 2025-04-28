class Api::MenuController < ApplicationController
  def index
    menus = Menu.with_menu_items.as_json(only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } })
    render json: menus
  end

  def show
    unless Menu.exists?(params[:id]) then
      return render json: { message: "menu doesn't exist" }, status: :bad_request
    end

    render json: Menu.with_menu_items.find(params[:id])
      .as_json(only: [:id, :name], include: { menu_items: { only: [:id, :name, :price] } })
  end
end
