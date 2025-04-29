class Api::JsonImporterController < ApplicationController
  def import
    unless params[:file].present? && params[:file].respond_to?(:read) then
      return render json: { message: "no file uploaded" }, status: :bad_request
    end

    JsonImporterService.new(params[:file]).call
    head :ok
  rescue => e
    byebug
    render json: { message: e.message }, status: :bad_request
  end
end
